package com.silverfox.finance.interceptor;

import static com.silverfox.finance.util.ConstantUtil.SEMICOLON;
import static com.silverfox.finance.util.ConstantUtil.SLASH;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.silverfox.finance.config.AplicationResourceProperties;
import com.silverfox.finance.domain.AbnormalOrder;
import com.silverfox.finance.domain.Admin;
import com.silverfox.finance.domain.BaobaoOrder;
import com.silverfox.finance.domain.ChannelOrder;
import com.silverfox.finance.domain.CouponCardLog;
import com.silverfox.finance.domain.Customer;
import com.silverfox.finance.domain.CustomerBalanceLog;
import com.silverfox.finance.domain.CustomerCoupon;
import com.silverfox.finance.domain.CustomerGoodsOrder;
import com.silverfox.finance.domain.CustomerLotteryLog;
import com.silverfox.finance.domain.CustomerOrder;
import com.silverfox.finance.domain.DispatchingBonusLog;
import com.silverfox.finance.domain.DispatchingLog;
import com.silverfox.finance.domain.EBankLog;
import com.silverfox.finance.domain.InviteActivityLog;
import com.silverfox.finance.domain.Lender;
import com.silverfox.finance.domain.Merchant;
import com.silverfox.finance.domain.Resource;
import com.silverfox.finance.domain.User;
import com.silverfox.finance.domain.UserBank;
import com.silverfox.finance.entity.BonusRecordEntity;
import com.silverfox.finance.entity.CouponStatisticsEntity;
import com.silverfox.finance.entity.InviteesEntity;
import com.silverfox.finance.entity.InviterEntity;
import com.silverfox.finance.entity.InviterRecordEntity;
import com.silverfox.finance.entity.InviterRewardEntity;
import com.silverfox.finance.entity.SecurityEntity;
import com.silverfox.finance.entity.UserEntity;
import com.silverfox.finance.service.SystemService;
import com.silverfox.finance.util.ConstantUtil;

public class SecurityHandlerInterceptor extends HandlerInterceptorAdapter {
	private final AplicationResourceProperties properties;
	
	@Autowired
	private SystemService systemService;
	
	public SecurityHandlerInterceptor(AplicationResourceProperties properties) {
		this.properties = properties;
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		boolean match = properties.getIgnoreUri().stream().anyMatch(s->{
			String requestURI = request.getRequestURI();
			return  requestURI.equals(SLASH) || requestURI.startsWith(s);
		});
		if(!match) {
			String requestURI = request.getRequestURI();
			if(StringUtils.isNotBlank(requestURI) && !StringUtils.startsWith(requestURI, SLASH)) {
				requestURI = SLASH+requestURI;
			}
			
			Object security = request.getSession().getAttribute(ConstantUtil.SESSION_KEY);
			if (security == null) {
				request.setAttribute("message", properties.getSessionLess());
				request.getRequestDispatcher(SLASH).forward(request, response);
				return false;
			}
		}
		return super.preHandle(request, response, handler);
	}
	
	@Override  
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception { 
		if(modelAndView != null && modelAndView.getViewName() != null){
			SecurityEntity security = (SecurityEntity) request.getSession().getAttribute(ConstantUtil.SESSION_KEY);
			if (systemService == null) {
				BeanFactory factory = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getServletContext()); 
				systemService = (SystemService) factory.getBean("systemService"); 
			}
			if(security != null && security.getRole()!= null){
				List<Resource> functions = systemService.getByRoleId(security.getRole().getId());
				int flag = 0;
				for(Resource r : functions){
					if(r.getId() == 115){
						flag ++;
					}
				}
				if(flag <= 0){
					modelAndView.addAllObjects(parse(modelAndView.getModel(),modelAndView.getViewName()));
				}
			}
		}
	}

	@SuppressWarnings("unchecked")
	private  Map<String, Object> parse(Map<String, Object> model, String ViewName){
		Map<String, Object> params = new HashMap<String, Object>();
		for(Map.Entry<String, Object> entry : model.entrySet()){
			if(entry.getValue() != null && entry.getValue().getClass().equals(ArrayList.class)){
				params.put(entry.getKey(), privacys((List<Serializable>) entry.getValue()));
			}
			if(ViewName.endsWith("user/detail")){
				if(entry.getValue() != null && entry.getValue().getClass().equals(User.class)){
					params.put(entry.getKey(), privacy((Serializable) entry.getValue()));
				}
				if(entry.getValue() != null && entry.getValue().getClass().equals(UserBank.class)){
					params.put(entry.getKey(), privacy((Serializable) entry.getValue()));
				}
			}
			if(ViewName.endsWith("client/merchant/edit")){
				if(entry.getValue() != null && entry.getValue().getClass().equals(Merchant.class)){
					if(model.get("operation") != null && model.get("operation").equals("detail")){
						params.put(entry.getKey(), privacy((Serializable) entry.getValue()));
					}
				}
			}
			if(ViewName.endsWith("client/merchant/payment-detail")){
				if(entry.getValue() != null && entry.getValue().getClass().equals(Merchant.class)){
					params.put(entry.getKey(), privacy((Serializable) entry.getValue()));
				}
			}
			if(ViewName.endsWith("client/merchant/payment-detail")){
				if(entry.getValue() != null && entry.getValue().getClass().equals(Merchant.class)){
					params.put(entry.getKey(), privacy((Serializable) entry.getValue()));
				}
			}
			
			if(ViewName.endsWith("/customer/order/detail")){
				if(entry.getValue() != null && entry.getValue().getClass().equals(CustomerOrder.class)){
					params.put(entry.getKey(), privacy((Serializable) entry.getValue()));
				}	 
			}
			params.put(entry.getKey(), entry.getValue());
		}
		return model;  
	}

	private List<Serializable> privacys(List<Serializable> list) {
		List<Serializable> li = new ArrayList<Serializable>();
		for (Serializable serialize : list) {
			if (serialize instanceof Admin) {
				Admin admin = (Admin) serialize;
				if(admin != null && admin.getCellphone() != null){
					admin.setCellphone(cut(admin.getCellphone()));
				}
				li.add(admin);
			}
			if(serialize instanceof Customer){
				Customer customer = (Customer) serialize;
				if(customer != null){
					customer.setCellphone(cut(customer.getCellphone()));
					customer.setIdcard(cut(customer.getIdcard()));
				}
				li.add(customer);
			}
			if(serialize instanceof Lender){
				Lender lender = (Lender) serialize;
				if(lender != null){
					lender.setCellphone(cut(lender.getCellphone()));
				}
				li.add(lender);
			}
			if(serialize instanceof UserEntity){
				UserEntity entity = (UserEntity) serialize;
				if(entity != null){
					entity.setCellphone(cut(entity.getCellphone()));
					entity.setIdcard(cut(entity.getIdcard()));
					if(entity.getRegisterCellphone() != null){
						entity.setCellphone(cut(entity.getRegisterCellphone()));
					}
					if (StringUtils.isNotBlank(entity.getInviterPhone())) {
						entity.setInviterPhone(cut(entity.getInviterPhone()));
					}
				}
				li.add(entity);
			}
			if(serialize instanceof User){
				User user = (User) serialize;
				if(user != null){
					user.setCellphone(cut(user.getCellphone()));
					user.setIdcard(cut(user.getIdcard()));
					if(user.getRegisterCellphone() != null){
						user.setCellphone(cut(user.getRegisterCellphone()));
					}
					if (StringUtils.isNotBlank(user.getInviterPhone())) {
						user.setInviterPhone(cut(user.getInviterPhone()));
					}
				}
				li.add(user);
			}
			
			if(serialize instanceof Merchant){
				Merchant merchant = (Merchant) serialize;
				if(merchant != null && merchant.getCellphone() != null){
					merchant.setCellphone(cut(merchant.getCellphone()));
					//merchant.setTelephone(cut(merchant.getTelephone()));
				}
				li.add(merchant);
			}
			
			if(serialize instanceof EBankLog){
				EBankLog log = (EBankLog) serialize;
				if(log != null && log.getOldBank() != null && log.getOldBank().getCustomer() != null && StringUtils.isNotBlank(log.getOldBank().getCustomer().getCellphone())){
					log.getOldBank().getCustomer().setCellphone(cut(log.getOldBank().getCustomer().getCellphone()));
				}
				li.add(log);
			}
			
			if(serialize instanceof CustomerBalanceLog){
				CustomerBalanceLog log = (CustomerBalanceLog) serialize;
				if(log != null && log.getUser() != null && StringUtils.isNotBlank(log.getUser().getCellphone())){
					log.getUser().setCellphone(cut(log.getUser().getCellphone()));
				}
				li.add(log);
			}
			
			if(serialize instanceof ChannelOrder){
				ChannelOrder channelOrder = (ChannelOrder) serialize;
				if(channelOrder != null && channelOrder.getCellphone() != null){
					channelOrder.setCellphone(cut(channelOrder.getCellphone()));
				}
				li.add(channelOrder);
			}
			
			if(serialize instanceof BaobaoOrder){
				BaobaoOrder baobaoOrder = (BaobaoOrder) serialize;
				if(baobaoOrder != null && baobaoOrder.getCellphone() != null){
					if(baobaoOrder.getCellphone() != null){
						baobaoOrder.setCellphone(cut(baobaoOrder.getCellphone()));
					}
				}
				li.add(baobaoOrder);
			}
			
			if(serialize instanceof CustomerOrder){
				CustomerOrder customerOrder = (CustomerOrder) serialize;
				if(customerOrder != null && customerOrder.getCustomer() != null){
					if(customerOrder.getCustomer().getCellphone() != null){
						Customer customer = new Customer();
						customer = customerOrder.getCustomer();
						customer.setCellphone(cut(customerOrder.getCustomer().getCellphone()));
						customerOrder.setCustomer(customer);
					}
				}
				li.add(customerOrder);
			}
			
			if(serialize instanceof CustomerGoodsOrder){
				CustomerGoodsOrder goodsOrder = (CustomerGoodsOrder) serialize;
				if(goodsOrder != null && goodsOrder.getCellphone() != null){
					goodsOrder.setCellphone(cut(goodsOrder.getCellphone()));
				}
				li.add(goodsOrder);
			}
			
			if(serialize instanceof CustomerCoupon){
				CustomerCoupon customerCoupon = (CustomerCoupon) serialize;
				if(customerCoupon != null && customerCoupon.getUser() != null && customerCoupon.getUser().getCellphone() != null){
					User user = new User();
					user.setCellphone(cut(customerCoupon.getUser().getCellphone()));
					customerCoupon.setUser(user);
				}
				if(customerCoupon.getCellphone() != null){
					customerCoupon.setCellphone(cut(customerCoupon.getCellphone()));
				}
				li.add(customerCoupon);
			}
			
			if(serialize instanceof DispatchingLog){
				DispatchingLog dispatchingLog = (DispatchingLog) serialize;
				if(dispatchingLog != null && dispatchingLog.getCellphone() != null){
					dispatchingLog.setCellphone(cut(dispatchingLog.getCellphone()));
				}
				li.add(dispatchingLog);
			}
			
			if(serialize instanceof BonusRecordEntity){
				BonusRecordEntity recordEntity = (BonusRecordEntity) serialize;
				if(recordEntity != null && recordEntity.getCellphone() != null){
					recordEntity.setCellphone(cut(recordEntity.getCellphone()));
				}
				li.add(recordEntity);
			}
			
			if(serialize instanceof InviterRecordEntity){
				InviterRecordEntity recordEntity = (InviterRecordEntity) serialize;
				if(recordEntity != null && recordEntity.getCellphone() != null){
					recordEntity.setCellphone(cut(recordEntity.getCellphone()));
				}
				li.add(recordEntity);
			}
			
			if(serialize instanceof CouponStatisticsEntity){
				CouponStatisticsEntity couponStatistics = (CouponStatisticsEntity) serialize;
				if(couponStatistics != null && couponStatistics.getCellphone() != null){
					couponStatistics.setCellphone(cut(couponStatistics.getCellphone()));
				}
				li.add(couponStatistics);
			}
			
			if(serialize instanceof DispatchingBonusLog){
				DispatchingBonusLog dispatchingBonusLog = (DispatchingBonusLog) serialize;
				if(dispatchingBonusLog != null && dispatchingBonusLog.getCellphones() != null){
					String cellphones[] = dispatchingBonusLog.getCellphones().split(SEMICOLON);
					if(cellphones.length > 0){
						if(cellphones[0].length() > 10){
							dispatchingBonusLog.setCellphones(cut(cellphones[0]) + dispatchingBonusLog.getCellphones().substring(11));
						}
					}
				}
				li.add(dispatchingBonusLog);
			}
			
			if(serialize instanceof CustomerLotteryLog){
				CustomerLotteryLog lotteryLog = (CustomerLotteryLog) serialize;
				if(lotteryLog != null && lotteryLog.getUser() != null && lotteryLog.getUser().getCellphone() != null){
					User user = lotteryLog.getUser();
					user.setCellphone(cut(lotteryLog.getUser().getCellphone()));
					lotteryLog.setUser(user);
				}
				li.add(lotteryLog);
			}

			if(serialize instanceof AbnormalOrder){
				AbnormalOrder order = (AbnormalOrder) serialize;
				if(order != null && order.getUser() != null && order.getUser().getCellphone() != null){
					User user = order.getUser();
					user.setCellphone(cut(order.getUser().getCellphone()));
					order.setUser(user);
				}
				li.add(order);
			}
			
			if(serialize instanceof CouponCardLog){
				CouponCardLog couponCardLog = (CouponCardLog) serialize;
				if(couponCardLog != null && couponCardLog.getCellphone() != null){
					couponCardLog.setCellphone(cut(couponCardLog.getCellphone()));
				}
				li.add(couponCardLog);
			}
			
			if(serialize instanceof InviteActivityLog){
				InviteActivityLog inviteActivityLog = (InviteActivityLog) serialize;
				if(inviteActivityLog != null && inviteActivityLog.getUser() != null){
					if(inviteActivityLog.getUser().getCellphone() != null){
						inviteActivityLog.getUser().setCellphone(cut(inviteActivityLog.getUser().getCellphone()));
					}
				}
				if(inviteActivityLog != null && inviteActivityLog.getCustomer() != null){
					if(inviteActivityLog.getCustomer().getCellphone() != null){
						inviteActivityLog.getCustomer().setCellphone(cut(inviteActivityLog.getCustomer().getCellphone()));
					}
				}
				li.add(inviteActivityLog);
			}
			
			if(serialize instanceof InviterEntity){
				InviterEntity inviterEntity = (InviterEntity) serialize;
				if(inviterEntity != null && inviterEntity.getCustomerPhone() != null){
					inviterEntity.setCustomerPhone(cut(inviterEntity.getCustomerPhone()));
				}
				li.add(inviterEntity);
			}
			
			if(serialize instanceof InviterEntity){
				InviterEntity inviterEntity = (InviterEntity) serialize;
				if(inviterEntity != null && inviterEntity.getCustomerPhone() != null){
					inviterEntity.setCustomerPhone(cut(inviterEntity.getCustomerPhone()));
				}
				li.add(inviterEntity);
			}
			
			if(serialize instanceof InviterRewardEntity){
				InviterRewardEntity inviterRewardEntity = (InviterRewardEntity) serialize;
				if(inviterRewardEntity != null && inviterRewardEntity.getCellphone() != null){
					inviterRewardEntity.setCellphone(cut(inviterRewardEntity.getCellphone()));
				}
				li.add(inviterRewardEntity);
			}
			
			if(serialize instanceof InviteesEntity){
				InviteesEntity inviteesEntity = (InviteesEntity) serialize;
				if(inviteesEntity != null && inviteesEntity.getCellphone() != null){
					inviteesEntity.setCellphone(cut(inviteesEntity.getCellphone()));
				}
				li.add(inviteesEntity);
			}
		}
		return li;
	}
	
	private Serializable privacy(Serializable serializable) {
		if(serializable instanceof Customer){
			Customer customer = new Customer();
			customer = (Customer) serializable;
			if(customer != null){
				if(customer.getCellphone() != null){
					customer.setCellphone(cut(customer.getCellphone()));
				}
				if(customer.getIdcard() != null){
					customer.setIdcard(cut(customer.getIdcard()));
				}
			}
			serializable = customer;
		}
		
		if(serializable instanceof DispatchingLog){
			DispatchingLog dispatchingLog = new DispatchingLog();
			dispatchingLog = (DispatchingLog) serializable;
			if(dispatchingLog != null){
				if(dispatchingLog.getCellphone() != null){
					dispatchingLog.setCellphone(cut(dispatchingLog.getCellphone()));
				}
			}
			serializable = dispatchingLog;
		}
		
		if(serializable instanceof UserBank){
			UserBank userBank = new UserBank();
			userBank = (UserBank) serializable;
			if(userBank != null){
				if(userBank.getCardNo() != null){
					userBank.setCardNo(cut(userBank.getCardNo()));
				}
			}
			serializable = userBank;
		}
		
		if(serializable instanceof User){
			User user = new User();
			user = (User) serializable;
			if(user != null){
				if(user.getRegisterCellphone() != null){
					user.setRegisterCellphone(cut(user.getRegisterCellphone()));
				}
				if(user.getCellphone() != null){
					user.setCellphone(cut(user.getCellphone()));
				}
				if(user.getIdcard() != null){
					user.setIdcard(cut(user.getIdcard()));
				}
				if(user.getAccountId() != null){
					user.setAccountId(cut(user.getAccountId()));
				}
				if (StringUtils.isNotBlank(user.getInviterPhone())) {
					user.setInviterPhone(cut(user.getInviterPhone()));
				}
				if(user.getAccountId() != null){
					user.setIdcard(cut(user.getIdcard()));
				}
			}
			serializable = user;
		}
		
		if(serializable instanceof Merchant){
			Merchant merchant = new Merchant();
			merchant = (Merchant) serializable;
			if(merchant != null){
				if(merchant.getCellphone() != null){
					merchant.setCellphone(cut(merchant.getCellphone()));
				}
			}
			serializable = merchant;
		}
		
		if(serializable instanceof DispatchingBonusLog){
			DispatchingBonusLog dispatchingBonusLog = new DispatchingBonusLog();
			dispatchingBonusLog = (DispatchingBonusLog) serializable;
			if(dispatchingBonusLog != null && dispatchingBonusLog.getCellphones()!= null){
				String cellphones[] = dispatchingBonusLog.getCellphones().split(SEMICOLON);
				StringBuffer sb = new StringBuffer();
				for(int i = 0; i< cellphones.length;i++){
					sb.append(cut(cellphones[i]));
					if(i < cellphones.length -1){
						sb.append(SEMICOLON);
					}
				}
				dispatchingBonusLog.setCellphones(sb.toString());
			}
		}
		if(serializable instanceof CustomerOrder){
			CustomerOrder order = (CustomerOrder) serializable;
			if(order != null && order.getCustomer() != null && order.getCustomer().getCellphone() != null){
				order.getCustomer().setCellphone(cut(order.getCustomer().getCellphone()));
			}
			serializable = order;
		}
		return serializable;
	}
	
	private String cut(String param){  
		if (StringUtils.isBlank(param)) {
			return null;
		}
		return param.substring(0,param.length() - (param.substring(3)).length()) +"****"+param.substring(param.length()-4, param.length());
	}
}