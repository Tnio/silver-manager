package com.silverfox.finance.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.TimeUnit;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.silverfox.finance.domain.Coupon;
import com.silverfox.finance.domain.CouponCardLog;
import com.silverfox.finance.domain.CouponExchange;
import com.silverfox.finance.domain.CouponVip;
import com.silverfox.finance.domain.CustomerCoupon;
import com.silverfox.finance.domain.CustomerMessage;
import com.silverfox.finance.domain.DispatchingBonusLog;
import com.silverfox.finance.domain.DispatchingCouponRule;
import com.silverfox.finance.domain.DispatchingLog;
import com.silverfox.finance.domain.GoodsCouponCode;
import com.silverfox.finance.domain.InviteActivity;
import com.silverfox.finance.domain.InviteActivityLog;
import com.silverfox.finance.domain.InviteActivityRule;
import com.silverfox.finance.domain.RuleCoupon;
import com.silverfox.finance.domain.SmsTemplate;
import com.silverfox.finance.domain.User;
import com.silverfox.finance.entity.BonusRecordEntity;
import com.silverfox.finance.entity.CouponStatisticsEntity;
import com.silverfox.finance.entity.CouponVipEntity;
import com.silverfox.finance.entity.CouponVipExclusive;
import com.silverfox.finance.entity.InviterRecordEntity;
import com.silverfox.finance.enumeration.DispatchingBonusCategoryEnum;
import com.silverfox.finance.enumeration.MessageSceneEnum;
import com.silverfox.finance.enumeration.SmsPatternEnum;
import com.silverfox.finance.orm.CouponCardLogDao;
import com.silverfox.finance.orm.CouponDao;
import com.silverfox.finance.orm.CouponExchangeDao;
import com.silverfox.finance.orm.CouponVipDao;
import com.silverfox.finance.orm.CustomerCouponDao;
import com.silverfox.finance.orm.CustomerDao;
import com.silverfox.finance.orm.CustomerMessageDao;
import com.silverfox.finance.orm.DispatchingBonusLogDao;
import com.silverfox.finance.orm.DispatchingCouponRuleDao;
import com.silverfox.finance.orm.DispatchingLogDao;
import com.silverfox.finance.orm.GoodsCouponCodeDao;
import com.silverfox.finance.orm.InviteActivityDao;
import com.silverfox.finance.orm.InviteActivityRuleDao;
import com.silverfox.finance.orm.RuleCouponDao;
import com.silverfox.finance.orm.SmsTemplateDao;
import com.silverfox.finance.orm.UserDao;
import com.silverfox.finance.service.CouponService;
import com.silverfox.finance.util.ConstantUtil;
import com.silverfox.finance.util.LogRecord;

@Service
public class CouponServiceImpl  implements CouponService{
	@Autowired
	private UserDao userDao;
	@Autowired
	private CouponDao couponDao;
	@Autowired
	private DispatchingCouponRuleDao dispatchingCouponRuleDao;
	@Autowired
	private DispatchingLogDao dispatchingLogDao;
	@Autowired
	private CustomerCouponDao customerCouponDao;
	@Autowired
	private DispatchingBonusLogDao dispatchingBonusLogDao;
	@Autowired
	private SmsTemplateDao smsTemplateDao;
	@Autowired
	private RuleCouponDao ruleCouponDao;
	@Autowired
	private CustomerDao customerDao;
	@Autowired
	private InviteActivityDao inviteActivityDao;
	@Autowired
	private InviteActivityRuleDao inviteActivityRuleDao;
	@Autowired
	private GoodsCouponCodeDao goodsCouponCodeDao;
	@Autowired
	private CouponCardLogDao couponCardLogDao;
	@Autowired
	private CouponExchangeDao couponExchangeDao;
	@Autowired
	private CouponVipDao couponVipDao;
	@Autowired
	private CustomerMessageDao customerMessageDao;

	private static String[] chars = new String[] { "a", "b", "c", "d", "e", "f",
	        "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s",
	        "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5",
	        "6", "7", "8", "9", "a", "b", "c", "d", "e", "f",
	        "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s",
	        "t", "u", "v", "w", "x", "y", "z"};
	
	private static final ScheduledExecutorService EXECUTOR = Executors.newScheduledThreadPool(1, new ThreadFactory() {
		@Override
		public Thread newThread(Runnable r) {
			Thread t = new Thread(r);
			t.setDaemon(true);
			return t;
		}
	});
	
	@Override
	public int count(int type, int category,String name, int status, int isTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("category", category);
		params.put("status", status);
		params.put("type", type);
		params.put("name", name);
		params.put("isTime", isTime);
		return couponDao.queryForCount(params);
	}
	@Override
	public List<Coupon> list(int type, int category,String name, int status, int isTime, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("category", category);
		params.put("name", name);
		params.put("type", type);
		params.put("status", status);
		params.put("isTime", isTime);
		params.put("offset", offset);
		params.put("size", size);
		return couponDao.queryForList(params);
	}
	@Override
	@LogRecord(module=LogRecord.Module.SECURITIES, operation=LogRecord.Operation.SECURITIESOPERATION, id="${coupon.id}", name="${coupon.amount}", remark="")
	public boolean save(Coupon coupon) {
		if(coupon != null){
			if (coupon.getFinancePeriod() == null) {
				coupon.setFinancePeriod(0);
			}
			if(coupon.getId() > 0){
				return couponDao.update(coupon) > 0 ? true : false;
			}else{
				return couponDao.insert(coupon) > 0 ? true : false;
			}
		}
		return false;
	}
	@Override
	public Coupon get(int id) {
		return couponDao.select(id);
	}
	@Override
	public List<DispatchingCouponRule> ruleList() {
		return dispatchingCouponRuleDao.selectAll();
	}
	@Override
	public List<RuleCoupon> list(int ruleId) {
		return ruleCouponDao.queryForList(ruleId);
	}
	@Override
	public DispatchingCouponRule getRule(int id)  {
		return dispatchingCouponRuleDao.selectById(id);
	}
	@Override
	@LogRecord(module=LogRecord.Module.COUPONRULE, operation=LogRecord.Operation.COUPONRULEENABLE, id="${ruleId}", name="")
	public boolean enable(Integer ruleId, int status) {
		return dispatchingCouponRuleDao.enable(ruleId, status) > 0 ? true : false;
	}
	@Override
	@LogRecord(module=LogRecord.Module.COUPONRULE, operation=LogRecord.Operation.EDIT, id="${rule.id}", name="")
	public boolean saveRule(DispatchingCouponRule rule) {
		if (rule != null && rule.getId() > 0) {
			boolean result = dispatchingCouponRuleDao.update(rule) > 0 ? true : false;
			if (result && rule.getRules() != null && rule.getRules().size() > 0) {
				ruleCouponDao.delete(rule.getId());
				for (RuleCoupon ruleCoupon : rule.getRules()) {
					ruleCoupon.setRuleId(rule.getId());
					result = result && (ruleCouponDao.insert(ruleCoupon) > 0 ? true : false);
				}
			}
			return result;
		} 
		return false;
	}
	@Override
	public int countSmsTemplate(int status) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("status", status);
		return smsTemplateDao.queryForCount(params);
	}
	@Override
	public List<SmsTemplate> listSmsTemplate(int status, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("size", size);
		params.put("status", status);
		return smsTemplateDao.queryForList(params);
	}
	@Override
	public int countInviteActivity() {
		return inviteActivityDao.queryForCount();
	}
	@Override
	public List<InviteActivity> listInviteActivity(int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("size", size);
		return inviteActivityDao.queryForList(params);
	}
	@Override
	@LogRecord(module=LogRecord.Module.INVITEMANAGEMENT, operation=LogRecord.Operation.INVITEACTIVITYSAVE, id="", name="${inviteActivity.name}")
	public boolean saveInviteActivity(InviteActivity inviteActivity, String ruleStr) {
		boolean result = false;
		if(inviteActivity == null){
			return result;
		}
		if(inviteActivity.getId() > 0){
			inviteActivityDao.update(inviteActivity);
		}else{
			inviteActivityDao.insert(inviteActivity);
		}
		if(inviteActivity.getId() > 0){
			result = true;
		}
		int activityId = inviteActivity.getId();
		
		if (StringUtils.isNotBlank(ruleStr)) {
			List<InviteActivityRule> rules = new ArrayList<InviteActivityRule>();
			String[] ruleArr = ruleStr.split(";");
			if(ruleArr.length > 0){
				for (int i = 0; i < ruleArr.length; i++) {
					InviteActivityRule rule = new InviteActivityRule();
					String[] ruleArrj = new String[5];
					ruleArrj = ruleArr[i].split(",");
					rule.setInviteActivityId(activityId);
					rule.setId(Integer.parseInt(ruleArrj[0]));
					rule.setStartPeriod(Integer.parseInt(ruleArrj[1]));
					rule.setEndPeriod(Integer.parseInt(ruleArrj[2]));
					rule.setInterest(Double.parseDouble(ruleArrj[3]));
					rule.setBudgetAmount(Integer.parseInt(ruleArrj[4]));
					rules.add(rule);
				}
			}
			if(rules != null && rules.size() >0){
				if (rules.get(0) != null && rules.get(0).getId() > 0) {
					for (InviteActivityRule rule : rules) {
						inviteActivityRuleDao.updateInviteRule(rule);
					}
				} else {
					inviteActivityRuleDao.insertInviteRuleBatch(rules);	
				}
			}
		}
		
		return result; 
	}
	@Override
	public List<InviteActivityRule> selectRuleById(int activityId) {
		return inviteActivityRuleDao.selectRuleByActivityId(activityId);
	}
	@Override
	public InviteActivity getInviteActivity(int id) {
		return inviteActivityDao.selectById(id);
	}
	@Override
	public int countInviteActivityLogs(int activityId, String inviteCellphone, String cellphone, String type, int period, String beginTime, String endTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("activityId", activityId);
		params.put("inviteCellphone", inviteCellphone);
		params.put("cellphone", cellphone);
		params.put("type", type);
		params.put("period", period);
		if (StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(endTime)) {
			params.put("beginTime", beginTime+ConstantUtil.MIN_TIME);
			params.put("endTime", endTime+ConstantUtil.MAX_TIME);
		}
		return inviteActivityRuleDao.queryForLogCount(params);
	}
	@Override
	public List<InviteActivityLog> getInviteActivityLogs(int activityId, String inviteCellphone, String cellphone, String type, int period, String beginTime, String endTime, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("activityId", activityId);
		params.put("inviteCellphone", inviteCellphone);
		params.put("cellphone", cellphone);
		params.put("type", type);
		params.put("period", period);
		if (StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(endTime)) {
			params.put("beginTime", beginTime+ConstantUtil.MIN_TIME);
			params.put("endTime", endTime+ConstantUtil.MAX_TIME);
		}
		params.put("offset", offset);
		params.put("size", size);
		return inviteActivityRuleDao.queryForLogList(params);
	}
	@Override
	public boolean validateTime(int id) {
		InviteActivity inviteActivity = inviteActivityDao.selectById(id);
		if(inviteActivity != null && inviteActivity.getId() > 0){
			return inviteActivityDao.selectOverlapDate(inviteActivity.getBeginDate(), inviteActivity.getEndDate()) > 0 ? false : true;
		}
		return false;
	}
	@Override
	@LogRecord(module=LogRecord.Module.INVITEMANAGEMENT, operation=LogRecord.Operation.AUDIT, id="${id}", name="")
	public boolean auditActivity(int id, int status) {
		if(id > 0){
			return inviteActivityDao.audit(id, status) > 0 ? true : false;
		}
		return false;
	}
	@Override
	public int countCustomerAggregate(int category, int source, String cellphone) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(category >= 0){
			params.put("category", category);
		}
		if(StringUtils.isNotBlank(cellphone)){
			params.put("cellphone", cellphone);
		}
		params.put("source", source);
		return couponDao.queryForCountCustomerAggregate(params);
	}
	@Override
	public List<CouponStatisticsEntity> listCustomerAggregate(int category,int source, String cellphone, String sort, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(category >= 0){
			params.put("category", category);
		}
		if(StringUtils.isNotBlank(cellphone)){
			params.put("cellphone", cellphone);
		}
		params.put("source", source);
		params.put("sort", sort);
		params.put("offset", offset);
		params.put("size", size);
		return couponDao.queryForListCustomerAggregate(params);
	}
	@Override
	public int countBonusRecord(int customerId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("customerId", customerId);
		return couponDao.queryForCountBonusRecord(params);
	}
	@Override
	public List<BonusRecordEntity> listBonusRecord(int customerId, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("customerId", customerId);
		params.put("offset", offset);
		params.put("size", size);
		return couponDao.queryForListBonusRecord(params);
	}
	@Override
	public int countInviterRecord(String cellphone) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(cellphone)){
			params.put("cellphone", cellphone);
		}
		return couponDao.queryForCountInviterRecord(params);
	}
	@Override
	public List<InviterRecordEntity> listInviterRecord(String cellphone,int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(cellphone)){
			params.put("cellphone", cellphone);
		}
		params.put("offset", offset);
		params.put("size", size);
		return couponDao.queryForListInviterRecord(params);
	}
	@Override
	public User getUser(int id) {
		return userDao.selectByUserId(id);
	}
	
	@Override
	public int count(String cellphone, int category) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(cellphone)){
			params.put("cellphone", cellphone);
		}
		params.put("category", category);
		return dispatchingBonusLogDao.queryForCount(params);
	}
	@Override
	public List<DispatchingBonusLog> list(String cellphone, int category, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(cellphone)){
			params.put("cellphone", cellphone);
		}
		params.put("category", category);
		params.put("offset", offset);
		params.put("size", size);
		return dispatchingBonusLogDao.queryForList(params);
	}
	@Override
	@LogRecord(module=LogRecord.Module.DISPATCHINGBONUSLOG, operation=LogRecord.Operation.DISPATCHINGBONUSLOGSAVE, id="${dispatchingBonusLog.id}", name="", remark="${dispatchingBonusLog.giveDate}")
	public boolean saveDispatchingBonusLog(DispatchingBonusLog dispatchingBonusLog) {
		
		if(dispatchingBonusLog != null){
			if(dispatchingBonusLog.getChoiceType() == 1){
				dispatchingBonusLog.setUserNum(dispatchingBonusLog.getCellphones().split(ConstantUtil.SEMICOLON).length);
			}else{
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("beginDate", dispatchingBonusLog.getBeginDate()+ConstantUtil.MIN_TIME);
				params.put("endDate", dispatchingBonusLog.getEndDate()+ConstantUtil.MAX_TIME);
				params.put("satisfyType", dispatchingBonusLog.getSatisfyType());
				params.put("satisfyInitialAmount", dispatchingBonusLog.getSatisfyInitialAmount());
				params.put("satisfyEndAmount", dispatchingBonusLog.getSatisfyEndAmount());
				//System.out.println("用户数量:"+customerDao.countGiveUser(params)+"开始日期:"+ params.get("beginDate")+"结束日期:"+params.get("endDate")+"类型:"+params.get("satisfyType")+"开始数量:"+params.get("satisfyInitialAmount")+"结束数量:"+params.get("satisfyEndAmount"));
				dispatchingBonusLog.setUserNum(customerDao.countGiveUser(params));
			}
			if(dispatchingBonusLog.getId()> 0){
				if(dispatchingBonusLog.getCategory() == DispatchingBonusCategoryEnum.SILVER.getCategory()){					
					dispatchingLogDao.delete(dispatchingBonusLog.getId());
					List<DispatchingLog> dispatchingLogs = new ArrayList<DispatchingLog>();
					for(String cellphone : dispatchingBonusLog.getCellphones().split(ConstantUtil.SEMICOLON)){
						if(StringUtils.isNotBlank(cellphone)){
							DispatchingLog dispatchingLog = new DispatchingLog();
							dispatchingLog.setCellphone(cellphone);
							dispatchingLogs.add(dispatchingLog);
						}
					}
					if(dispatchingBonusLog.getStatus() != 1 && dispatchingLogs.size() > 0){
						dispatchingLogDao.insertDispatchingLogBatch(dispatchingBonusLog.getId(), dispatchingLogs);
					}
				}
				return dispatchingBonusLogDao.update(dispatchingBonusLog) > 0 ? true : false;
			}else{
				int result = dispatchingBonusLogDao.insert(dispatchingBonusLog);
				if(dispatchingBonusLog.getCategory() == DispatchingBonusCategoryEnum.SILVER.getCategory()){
					if(result > 0 && StringUtils.isNotBlank(dispatchingBonusLog.getCellphones())){
						List<DispatchingLog> dispatchingLogs = new ArrayList<DispatchingLog>();
						for(String cellphone : dispatchingBonusLog.getCellphones().split(ConstantUtil.SEMICOLON)){
							DispatchingLog dispatchingLog = new DispatchingLog();
							dispatchingLog.setCellphone(cellphone);
							dispatchingLogs.add(dispatchingLog);
						}
						return dispatchingLogDao.insertDispatchingLogBatch(dispatchingBonusLog.getId(), dispatchingLogs) > 0 ? true : false;
					}
				}
			}
		}
		return false;
		
	}
	
	@Override
	public DispatchingBonusLog getDispatchingBonusLog(int dispatchingBonusLogId) {
		
		return dispatchingBonusLogDao.selectById(dispatchingBonusLogId);
	}
	
	@Override
	public List<Coupon> getDispatchingBonusLogCoupon(Integer dispatchingBonusLogId) {
		return couponDao.selectDispatchingBonusLogCoupon(dispatchingBonusLogId);
	}
	@Override
	@LogRecord(module=LogRecord.Module.DISPATCHINGBONUSLOG, operation=LogRecord.Operation.AUDIT, id="${dispatchingBonusLog.id}", name="", remark="")
	public boolean saveDispatchingBonusLogs(DispatchingBonusLog dispatchingBonusLog) {
		if(dispatchingBonusLog != null){
			if(dispatchingBonusLog.getChoiceType() == 1){
				dispatchingBonusLog.setUserNum(dispatchingBonusLog.getCellphones().split(ConstantUtil.SEMICOLON).length);
			}else{
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("beginDate", dispatchingBonusLog.getBeginDate()+ConstantUtil.MIN_TIME);
				params.put("endDate", dispatchingBonusLog.getEndDate()+ConstantUtil.MAX_TIME);
				params.put("satisfyType", dispatchingBonusLog.getSatisfyType());
				params.put("satisfyInitialAmount", dispatchingBonusLog.getSatisfyInitialAmount());
				params.put("satisfyEndAmount", dispatchingBonusLog.getSatisfyEndAmount());
				//System.out.println("用户数量:"+customerDao.countGiveUser(params)+"开始日期:"+ params.get("beginDate")+"结束日期:"+params.get("endDate")+"类型:"+params.get("satisfyType")+"开始数量:"+params.get("satisfyInitialAmount")+"结束数量:"+params.get("satisfyEndAmount"));
				dispatchingBonusLog.setUserNum(customerDao.countGiveUser(params));
			}
			if(dispatchingBonusLog.getId()> 0){
				if(dispatchingBonusLog.getCategory() == DispatchingBonusCategoryEnum.SILVER.getCategory()){					
					dispatchingLogDao.delete(dispatchingBonusLog.getId());
					List<DispatchingLog> dispatchingLogs = new ArrayList<DispatchingLog>();
					for(String cellphone : dispatchingBonusLog.getCellphones().split(ConstantUtil.SEMICOLON)){
						if(StringUtils.isNotBlank(cellphone)){
							DispatchingLog dispatchingLog = new DispatchingLog();
							dispatchingLog.setCellphone(cellphone);
							dispatchingLogs.add(dispatchingLog);
						}
					}
					if(dispatchingBonusLog.getStatus() != 1 && dispatchingLogs.size() > 0){
						dispatchingLogDao.insertDispatchingLogBatch(dispatchingBonusLog.getId(), dispatchingLogs);
					}
				}
				return dispatchingBonusLogDao.update(dispatchingBonusLog) > 0 ? true : false;
			}else{
				int result = dispatchingBonusLogDao.insert(dispatchingBonusLog);
				if(dispatchingBonusLog.getCategory() == DispatchingBonusCategoryEnum.SILVER.getCategory()){
					if(result > 0 && StringUtils.isNotBlank(dispatchingBonusLog.getCellphones())){
						List<DispatchingLog> dispatchingLogs = new ArrayList<DispatchingLog>();
						for(String cellphone : dispatchingBonusLog.getCellphones().split(ConstantUtil.SEMICOLON)){
							DispatchingLog dispatchingLog = new DispatchingLog();
							dispatchingLog.setCellphone(cellphone);
							dispatchingLogs.add(dispatchingLog);
						}
						return dispatchingLogDao.insertDispatchingLogBatch(dispatchingBonusLog.getId(), dispatchingLogs) > 0 ? true : false;
					}
				}
			}
		}
		return false;
	}
	
	@Override
	public int countByDispatchingBonusLogId(int category, String cellphone, int used, int dispatchingBonusLogId) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(cellphone)){			
			params.put("cellphone", cellphone);
		}
		params.put("category", category);			
		params.put("used", used);			
		params.put("dispatchingBonusLogId", dispatchingBonusLogId);			
		return customerCouponDao.countByDispatchingBonusLogId(params);
	}
	@Override
	public List<CustomerCoupon> getByDispatchingBonusLogId(int category, String cellphone, int used, int dispatchingBonusLogId, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(cellphone)){			
			params.put("cellphone", cellphone);
		}
		params.put("category", category);			
		params.put("used", used);			
		params.put("dispatchingBonusLogId", dispatchingBonusLogId);			
		params.put("offset", offset);
		params.put("size", size);
		List<CustomerCoupon> coupons = customerCouponDao.selectByDispatchingBonusLogId(params);
		if (coupons != null && coupons.size() > 0) {
			List<Integer> ids = new ArrayList<Integer>();
			for(int i = 0; i< coupons.size(); i++){
				if(coupons.get(i) != null && coupons.get(i).getUser() != null){
					ids.add(coupons.get(i).getUser().getId());
				}
			}
			List<User> users = userDao.selectUsers(ids);
			for(int i = 0; i< coupons.size(); i++){
				if(coupons.get(i) != null && coupons.get(i).getUser() != null){
					for(int j = 0; j< users.size(); j++){
						if(coupons.get(i).getUser().getId().equals(users.get(j).getId())){
							coupons.get(i).setCellphone(users.get(j).getCellphone());
						}
					}
				}
			}
		}
		return coupons;
	}
	

	@Override
	public int countExchange() {
		Map<String, Object> params = new HashMap<String, Object>();
		return couponExchangeDao.queryForCount(params);
	}
	@Override
	public List<CouponExchange> listExchange(int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("size", size);
		return couponExchangeDao.queryForList(params);
	}
	@Override
	@LogRecord(module=LogRecord.Module.EXCHANGE_VOUCHER, operation=LogRecord.Operation.EXCHANGEVOUCHEROPERATION, id="${couponExchange.id}", name="", remark="${couponExchange.beginTime+'至'+couponExchange.endTime}")
	public boolean saveCouponExchange(CouponExchange couponExchange, String code) {
		return saveCouponExchanges(couponExchange, code);
	}
	public boolean saveCouponExchanges(final CouponExchange couponExchange, final String code) {
		if(couponExchange != null){
			int result = 0;
			if(couponExchange.getId() <= 0){
				result = couponExchangeDao.insert(couponExchange);
			}else{
				result = couponExchangeDao.update(couponExchange);
				if(result > 0){
					goodsCouponCodeDao.deleteByCouponExchangeId(couponExchange.getId());
				}	
			}    
			if(result > 0){
				if(Integer.parseInt(couponExchange.getQuantity()) > 0){
					Thread thread = new Thread(new Runnable() {
						int quantity = Integer.parseInt(couponExchange.getQuantity());
						int count = (int)(Math.ceil((float) quantity / 1000));
						@Override
						public void run() {
							int j = 1;
							while(j <= count){
								List<GoodsCouponCode> codes = new ArrayList<GoodsCouponCode>();
								if(j < count){
									for(int i = 0; i< 1000;i++){
										GoodsCouponCode gCCode = new GoodsCouponCode();
										if(couponExchange.getMakeMode() == 0){
											gCCode.setCode(getShortUuid());
										}else{
											gCCode.setCode(code);
										}
										codes.add(gCCode);
									}
								}
								if(j == count){
									for(int i = 0; i< (quantity -((count - 1) * 1000));i++){
										GoodsCouponCode gCCode = new GoodsCouponCode();
										if(couponExchange.getMakeMode() == 0){
											gCCode.setCode(getShortUuid());
										}else{
											gCCode.setCode(code);
										}
										codes.add(gCCode);
									}
								}
								int result = goodsCouponCodeDao.insertGoodsCouponCodes(codes, 0, couponExchange.getId());
								j++;
								if(result > 0){
									try {
										if(count - j > 0){
											Thread.sleep(5000);
										}
									} catch (InterruptedException e) {
										continue;
									}
								}	
							}
						}
					});
					EXECUTOR.schedule(thread, 0, TimeUnit.MINUTES);
				}
			}	
		}
		return true;
	}
	private String getShortUuid() {
		StringBuffer shortBuffer = new StringBuffer();
		String uuid = UUID.randomUUID().toString().replace("-", "");
		for (int i = 0; i < 8; i++) {
		    String str = uuid.substring(i * 4, i * 4 + 4);
		    int x = Integer.parseInt(str, 16);
		    shortBuffer.append(chars[x % 0x3E]);
		}
		return shortBuffer.toString();
	}
	@Override
	public CouponExchange getCouponExchange(int couponExchangeCodeId) {
		return couponExchangeDao.selectById(couponExchangeCodeId);
	}
	@Override
	@LogRecord(module=LogRecord.Module.EXCHANGE_VOUCHER, operation=LogRecord.Operation.AUDIT, id="${couponExchange.id}", name="", remark="${couponExchange.beginTime+'至'+couponExchange.endTime}")
	public boolean changeStatus(CouponExchange couponExchange) {
		return couponExchangeDao.update(couponExchange) > 0 ? true : false;
	}
	
	@Override
	public int countCouponExchange(int couponExchangeId, String beginTime, String endTime, int type, int used) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(couponExchangeId > 0){
			params.put("couponExchangeId", couponExchangeId);
		}
		if(StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(endTime)){
			params.put("beginTime", beginTime);
			params.put("endTime", endTime);
		}
		params.put("type", type);
		params.put("used", used);
		return customerCouponDao.queryForCountCouponExchange(params);
	}
	@Override
	public List<CustomerCoupon> listCouponExchange(int couponExchangeId, String beginTime, String endTime, int type, int used, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(couponExchangeId > 0){
			params.put("couponExchangeId", couponExchangeId);
		}
		if(StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(endTime)){
			params.put("beginTime", beginTime);
			params.put("endTime", endTime);
		}
		params.put("type", type);
		params.put("used", used);
		params.put("offset", offset);
		params.put("size", size);
		return customerCouponDao.queryForListCouponExchange(params);
	}
	
	@Override
	public int countCouponCard(String cardNO, String cellphone, int used) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(cardNO)){			
			params.put("cardNO", cardNO);
		}
		if(StringUtils.isNotBlank(cellphone)){			
			params.put("cellphone", cellphone);
		}
		params.put("used", used);
		return couponCardLogDao.queryForCount(params);
	}
	@Override
	public List<CouponCardLog> listCouponCard(String cardNO, String cellphone, int used, int offset, int pageSize) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(cardNO)){			
			params.put("cardNO", cardNO);
		}
		if(StringUtils.isNotBlank(cellphone)){			
			params.put("cellphone", cellphone);
		}
		params.put("used", used);
		params.put("offset", offset);
		params.put("size", pageSize);
		return couponCardLogDao.queryForList(params);
	}
	@Override
	public JSONObject saveCouponCards(List<CouponCardLog> couponCardLogs){
		JSONObject result = new JSONObject();
		try {
			if(couponCardLogDao.insertCouponCardLogs(couponCardLogs) > 0){
				result.put("code", 200);
				result.put("msg", null);
				return result;
			}
		} catch (Exception e) {
			result.put("code", 500);
			result.put("msg", e.getMessage());
			return result;
		}
		return result;
	}
	@Override
	public int countCouponCardRecord(String cardNO, String cellphone, String name, float amount, int used, String beginTime, String endTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(cardNO)){			
			params.put("cardNO", cardNO);
		}
		if(StringUtils.isNotBlank(cellphone)){			
			params.put("cellphone", cellphone);
		}
		if(StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(endTime)){			
			params.put("beginTime", beginTime +ConstantUtil.MIN_TIME);
			params.put("endTime", endTime + ConstantUtil.MAX_TIME);
		}
		params.put("name", name);
		params.put("amount", amount);
		params.put("used", used);
		return couponCardLogDao.queryForRecordCount(params);
	}
	@Override
	public List<CouponCardLog> listCouponCardRecord(String cardNO, String cellphone, String name, float amount,int used, String beginTime, String endTime,int offset, int pageSize) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(cardNO)){			
			params.put("cardNO", cardNO);
		}
		if(StringUtils.isNotBlank(cellphone)){			
			params.put("cellphone", cellphone);
		}
		if(StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(endTime)){			
			params.put("beginTime", beginTime +ConstantUtil.MIN_TIME);
			params.put("endTime", endTime +ConstantUtil.MAX_TIME);
		}
		params.put("name", name);
		params.put("amount", amount);
		params.put("offset", offset);
		params.put("size", pageSize);
		params.put("used", used);
		return couponCardLogDao.queryForRecordList(params);
	}
	@Override
	@LogRecord(module=LogRecord.Module.THIRD_PARTY_CARD, operation=LogRecord.Operation.GIVE_CARD, id="${id}", remark="${cellphone}")
	public boolean grantCard(int id, String cellphone) {
		return grantCards(id, cellphone);
	}
	private boolean grantCards(int id, String cellphone) {
		CouponCardLog couponCardLog = couponCardLogDao.selectById(id);
		if(couponCardLog != null && StringUtils.isBlank(couponCardLog.getCellphone())){
			User user = userDao.selectByCellphone(cellphone);
			if(user != null && user.getId() > 0){
				couponCardLog.setCellphone(cellphone);
				couponCardLog.setCreateTime(new Date());
				boolean result = couponCardLogDao.update(couponCardLog) > 0 ? true : false;
				if(result){
					financialRebateMessage(user.getId(),couponCardLog);
				}
				return result;
			}
		}
		return false;
	}
	

	@Override
	public int countCouponActivityRecord(String cellphone, Integer used, int couponActivityId) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(cellphone)){
			params.put("cellphone", cellphone);
		}
		params.put("used", used);
		params.put("couponActivityId", couponActivityId);
		return customerCouponDao.countCouponActivityRecord(params);
	}

	@Override
	public List<CustomerCoupon> listCouponActivityRecord(String cellphone, Integer used, int couponActivityId, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(cellphone)){
			params.put("cellphone", cellphone);
		}
		params.put("used", used);
		params.put("couponActivityId", couponActivityId);
		params.put("offset", offset);
		params.put("size", size);
		return customerCouponDao.selectCouponActivityRecord(params);
	}

	@Override
	public boolean duplicateInviteActivityName(int id, String name) {
		return inviteActivityDao.duplicateInviteActivityName(id, name) > 0 ? true : false;
	}
	
	@Override
	public boolean canDisable(int couponId) {
		List<Integer> datas = couponDao.canDisable(couponId);
		int couponData = 0;
		for (int data : datas) {
			couponData += data;
		}
		if (couponData > 0) {
			return false;
		}
		return true;
	}
	@Override
	public int countCustomerCoupons(int couponId, String cellphone, int status) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(cellphone)){
			params.put("cellphone", cellphone);
		}
		params.put("couponId", couponId);
		params.put("status", status);
		return customerCouponDao.queryForCountCustomerCoupons(params);
	}
	@Override
	public List<CustomerCoupon> listCustomerCoupons(int couponId, String cellphone, int status, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(cellphone)){
			params.put("cellphone", cellphone);
		}
		params.put("couponId", couponId);
		params.put("status", status);
		params.put("offset", offset);
		params.put("size", size);
		return customerCouponDao.queryForListCustomerCoupons(params);
	}

	@Override
	public int countCoupons(int customerId, int status) {
		return customerCouponDao.countCouponsByCustomerId(customerId, status);
	}

	@Override
	public List<CustomerCoupon> listCoupons(int customerId, int status, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("customerId", customerId);
		params.put("status", status);
		params.put("offset", offset);
		params.put("size", size);
		return customerCouponDao.queryCouponsByCustomerId(params);
	}

	@Override
	public int countCustomerCouponsByUse(int userId, int used) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("used", used);
		return customerCouponDao.queryForCountCustomerCouponsByUserId(params);
	}
	
	@Override
	public boolean  save(List<CouponVip> couponVips ,int couponType) {
		Map<String, Integer>params=new HashMap<String, Integer>();
		for (CouponVip couponVip : couponVips) {
			params.put("couponId",couponVip.getId());
			params.put("vipLevel", couponVip.getVipLevel());
			params.put("couponType", couponType);
			if (couponVipDao.selectByVipLevel(params)!=null){
				 couponVipDao.updatecouponVip(couponVip);
			} else {
				 couponVipDao.savecouponVip(couponVip) ;
			}
		}
		return true;
		
	}
	@Override
	public boolean save( int couponType ,List<CouponVipExclusive> couponVipMap) {
		List<CouponVip> couponVips=new ArrayList<CouponVip>();
		List<CouponVip> list = couponVipDao.selectByType(couponType);
		if(list.size()==0){
			for (CouponVipExclusive couponVipExclusive : couponVipMap) {
				String[] couponids = couponVipExclusive.getCouponId().split(",");
				for (String couponid: couponids) {
					CouponVip couponVip=new CouponVip();
					couponVip.setCouponId(Integer.parseInt(couponid));
					couponVip.setCouponType(couponType);
					couponVip.setVipLevel(couponVipExclusive.getVipLevel());
					couponVips.add(couponVip);
				}
			}
		}
		if (couponVipDao.deleteByCouponType(couponType)>0){
			for (CouponVipExclusive couponVipExclusive : couponVipMap) {
				String[] couponids = couponVipExclusive.getCouponId().split(",");
				for (String couponid: couponids) {
					CouponVip couponVip=new CouponVip();
					couponVip.setCouponId(Integer.parseInt(couponid));
					couponVip.setCouponType(couponType);
					couponVip.setVipLevel(couponVipExclusive.getVipLevel());
					couponVips.add(couponVip);
				}
			}
		
		}
		 return couponVipDao.insertcouponVips(couponVips)> 0 ?true :false;
		}
	@Override
	public List<CouponVipEntity> selectByCouponType(int couponType) {
		 return couponVipDao.selectByCouponType(couponType);
	}		
	
	private boolean financialRebateMessage(int userId, CouponCardLog couponCardLog){
		CustomerMessage message = new CustomerMessage();
		message.setUserId(userId);
		message.setEffectTime(couponCardLog.getCreateTime());
		message.setCreateTime(new Date());
		String amount = String.valueOf(couponCardLog.getAmount());
		if(amount.indexOf(".") > 0){  
			amount = amount.replaceAll("0+?$", "");
			amount = amount.replaceAll("[.]$", "");
        }
		String text = String.format(SmsPatternEnum.FINANCIAL_REBATE.getPattern(), couponCardLog.getName(),couponCardLog.getCardNO(), couponCardLog.getPassword(), amount+ConstantUtil.YUAN);
		message.setScene(MessageSceneEnum.FINANCIALREBATE.toInt());
		message.setMessage(text);
		return customerMessageDao.insert(message) > 0 ? true : false;
	}
	@Override
	public CouponCardLog getCouponCardLog(int couponCardLogId) {
		return couponCardLogDao.selectById(couponCardLogId);
	}
}
