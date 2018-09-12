package com.silverfox.finance.aop;

import java.io.IOException;
import java.io.StringWriter;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.LocalVariableTableParameterNameDiscoverer;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.silverfox.finance.config.AplicationResourceProperties;
import com.silverfox.finance.domain.Activity;
import com.silverfox.finance.domain.Admin;
import com.silverfox.finance.domain.Bonus;
import com.silverfox.finance.domain.CellphoneLog;
import com.silverfox.finance.domain.CouponActivity;
import com.silverfox.finance.domain.DispatchingBonusLog;
import com.silverfox.finance.domain.Faq;
import com.silverfox.finance.domain.Goods;
import com.silverfox.finance.domain.LogOperation;
import com.silverfox.finance.domain.Lottery;
import com.silverfox.finance.domain.Merchant;
import com.silverfox.finance.domain.NewsBulletin;
import com.silverfox.finance.domain.NewsMaterial;
import com.silverfox.finance.domain.PayBank;
import com.silverfox.finance.domain.PictrueLibrary;
import com.silverfox.finance.domain.Product;
import com.silverfox.finance.domain.ProductCategory;
import com.silverfox.finance.domain.PushMessage;
import com.silverfox.finance.domain.Role;
import com.silverfox.finance.domain.SignIn;
import com.silverfox.finance.domain.SmsChannel;
import com.silverfox.finance.domain.SmsTemplate;
import com.silverfox.finance.entity.SecurityEntity;
import com.silverfox.finance.enumeration.ProductCategoryPropertyEnum;
import com.silverfox.finance.service.ActivityService;
import com.silverfox.finance.service.BonusService;
import com.silverfox.finance.service.ClientService;
import com.silverfox.finance.service.CouponService;
import com.silverfox.finance.service.LotteryService;
import com.silverfox.finance.service.MessageService;
import com.silverfox.finance.service.PayBankService;
import com.silverfox.finance.service.PictrueLibraryService;
import com.silverfox.finance.service.PostmarketingService;
import com.silverfox.finance.service.ProductService;
import com.silverfox.finance.service.SilverService;
import com.silverfox.finance.service.SystemService;
import com.silverfox.finance.util.ConstantUtil;
import com.silverfox.finance.util.LogRecord;
import com.silverfox.finance.util.StringTemplateLoader;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

@Aspect
@Component
public class SystemLogAspect {
	private static final Logger logger = LoggerFactory.getLogger(SystemLogAspect.class);
	private static final String ID = "ID为[";
	private static final String GIVEDATE = "赠送日期为[";
	private static final String EXCHANGEDATE = "兑换日期为[";
	private static final String NAME = "信息为[";
	private static final String DATE = "]的数据";
	private static final String SILVERFOX_CODE = "银狐令";
	
	@Autowired
	protected AplicationResourceProperties properties;
	@Autowired
	private PictrueLibraryService pictrueLibraryService;

	@Autowired
	private SystemService systemService;
	@Autowired
	private ActivityService activityService;
	@Autowired
	private BonusService bonusService;
	@Autowired
	private ClientService clientService;
	@Autowired
	private CouponService couponService;
	@Autowired
	private LotteryService lotteryService;
	@Autowired
	private MessageService messageService;
	@Autowired
	private PostmarketingService postmarketingService;
	@Autowired
	private ProductService productService;
	@Autowired
	private PayBankService payBankService;
	@Autowired
	private SilverService silverService;
	@Autowired
	private FreeMarkerConfigurer freeMarkerConfigurer;

	private static LocalVariableTableParameterNameDiscoverer parameterNameDiscoverer = new LocalVariableTableParameterNameDiscoverer();

	@Pointcut("@annotation(com.silverfox.finance.util.LogRecord)")
	public void serviceAspect() {

	}

	@Around("serviceAspect()")
	public Object doBefore(ProceedingJoinPoint joinPoint) throws Throwable {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();
		SecurityEntity security = (SecurityEntity) request.getSession()
				.getAttribute(ConstantUtil.SESSION_KEY);
		String admin = "";
		if (security != null && security.getAdmin() != null) {
			admin = security.getAdmin().getName();
		}

		LogRecord systemLogAnnotation = getMethod(joinPoint).getAnnotation(LogRecord.class);
		String methodName = getMethod(joinPoint).getName();
		if (systemLogAnnotation != null) {
			String module = systemLogAnnotation.module().toString();
			String menu = systemLogAnnotation.module().name();
			String operation = executeTemplateFreeMarker(systemLogAnnotation.operation().toString(), joinPoint, request);
			String id = executeTemplateFreeMarker(systemLogAnnotation.id(),	joinPoint, request);
			String name = executeTemplateFreeMarker(systemLogAnnotation.name(),	joinPoint, request);
			String remark = executeTemplateFreeMarker(systemLogAnnotation.remark(), joinPoint, request);

			if (menu.equals(LogRecord.Module.PRODUCT.name())) {
				if (StringUtils.isNotBlank(remark)) {
					StringBuffer sb = new StringBuffer();
					if (remark.equals(ProductCategoryPropertyEnum.TREASURE
							.name())) {
						sb.append("活期");
					} else {
						sb.append("定期");
					}
					module = sb.append(module).toString();
				}
			}

			if (menu.equals(LogRecord.Module.COUPON.name())) {
				if (StringUtils.isNotBlank(remark)) {
					StringBuffer sb = new StringBuffer();
					if (Integer.parseInt(remark) == 2) {
						sb.append("累计红包管理");
						module = "";
					}
					module = sb.append(module).toString();
				}
			}

			if (menu.equals(LogRecord.Module.DISPATCHINGBONUSLOG.name())) {
				if (StringUtils.isNotBlank(remark) && name != null) {
					StringBuffer sb = new StringBuffer();
					String[] names = name.split(ConstantUtil.COMMA);
					if (names.length == 2) {
						if (Integer.parseInt(remark) == 0) {
							sb.append("红包");
							name = names[0];
						} else {
							sb.append("银子");
							name = names[1];
						}
					}
					module = sb.append(module).toString();
				}
			}
			
			if (StringUtils.isBlank(name) && StringUtils.isNotBlank(id)) {
				id = id.replaceAll(",", "").trim();
				name = this.getName(systemLogAnnotation.module().name(), id);
			}
			if (name.length() > 20) {
				name = name.substring(0, 20) + ConstantUtil.ELLIPSIS;
			}
			Object result = joinPoint.proceed();
			try {
				LogOperation logOperation = new LogOperation();
				if (StringUtils.equals("totp", methodName)
						&& StringUtils.isNotBlank(id)) {
					int adminId = 0;
					try {
						adminId = Integer.parseInt(id);
					} catch (Exception e) {
						adminId = 0;
					}
					Admin sysAdmin = systemService.getAdmin(adminId);
					if (sysAdmin != null) {
						admin = sysAdmin.getName();
					}
					logOperation.setOperateContent(module + admin + operation
							+ SILVERFOX_CODE);
				} else {
					logOperation.setOperateContent(module + operation + NAME
							+ name + DATE);
				}
				if (menu.equals(LogRecord.Module.PROJECT_MANAGEMENT.name())) {
					if (operation.equals(LogRecord.Operation.AUDIT.toString())) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
				}
				if (menu.equals(LogRecord.Module.USERMANAGEMENT.name())) {
					if (operation.equals(LogRecord.Operation.SETVIP.toString())) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
				}
				if (menu.equals(LogRecord.Module.COUPONRULE.name())) {
					if (operation.equals(LogRecord.Operation.EDIT.toString())) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
					if (operation.equals("启用") || operation.equals("禁用")) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
				}
				if (menu.equals(LogRecord.Module.DISPATCHINGBONUSLOG.name())) {
					if (operation.equals("新增")) {
						logOperation.setOperateContent(module + operation
								+ GIVEDATE + remark + DATE);
					}
					if (operation.equals("编辑")) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
					if (operation.equals(LogRecord.Operation.AUDIT.toString())) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
				}
				if (menu.equals(LogRecord.Module.EXCHANGE_VOUCHER.name())) {
					if (operation.equals("新增")) {
						logOperation.setOperateContent(module + operation
								+ EXCHANGEDATE + remark + DATE);
					}
					if (operation.equals("编辑")) {
						logOperation.setOperateContent(module + operation
								+ EXCHANGEDATE + remark + DATE);
					}
					if (operation.equals(LogRecord.Operation.AUDIT.toString())) {
						logOperation.setOperateContent(module + operation
								+ EXCHANGEDATE + remark + DATE);
					}
				}
				if (menu.equals(LogRecord.Module.INVITEMANAGEMENT.name())) {
					if (operation.equals(LogRecord.Operation.AUDIT.toString())) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
				}
				
				if (menu.equals(LogRecord.Module.EARNMONEY.name())) {
					if (operation.equals("禁用")) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
					if (operation.equals("启用")) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
					if (operation.equals(LogRecord.Operation.EDIT.toString())) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
				}
				if (menu.equals(LogRecord.Module.IMAGE.name())) {
					if (operation.equals("禁用")) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
					if (operation.equals("启用")) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
					if (operation.equals(LogRecord.Operation.REMOVE.toString())) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
				}
				if (menu.equals(LogRecord.Module.WEB_IMAGE.name())) {
					if (operation.equals("编辑")) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
					if (operation.equals("禁用")) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
					if (operation.equals("启用")) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
				}
				if (menu.equals(LogRecord.Module.PRODUCT_AD.name())) {
					if (operation.equals("编辑")) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
					if (operation.equals("禁用")) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
					if (operation.equals("启用")) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
				}
				if (menu.equals(LogRecord.Module.NEWS_BULLETIN.name())) {
					if (operation.equals(LogRecord.Operation.REMOVE)) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
				}
				if (menu.equals(LogRecord.Module.APPMESSAGE.name())) {
					if (operation.equals("编辑")) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
					if (operation.equals("审核")) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
				}
				if (menu.equals(LogRecord.Module.BANK_LIMIT.name())) {
					if (operation.equals("启用")) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
					if (operation.equals("禁用")) {
						logOperation.setOperateContent(module + operation + ID
								+ id + DATE);
					}
				}
				if(menu.equals(LogRecord.Module.SILVERGIVE.name())){
					if(operation.equals(LogRecord.Operation.AUDIT.toString())){
						logOperation.setOperateContent(module + operation + ID + id + DATE);
					}
					if(operation.equals("新增")){
						logOperation.setOperateContent(module + operation
								+ GIVEDATE + remark + DATE);
					}
					if(operation.equals("编辑")){
						logOperation.setOperateContent(module + operation
								+ GIVEDATE + remark + DATE);
						
					}
				}
				if(menu.equals(LogRecord.Module.THIRD_PARTY_CARD.name())){
					if(operation.equals(LogRecord.Operation.GIVE_CARD.toString())){
						logOperation.setOperateContent(module + operation + ID + id+ DATE);
					}
				}
				logOperation.setAdminName(admin);
				logOperation.setOperateTime(new Date());
				systemService.saveLogOperation(logOperation);
			} catch (Exception e) {
				logger.error("异常信息:{}", e.getMessage());
			}
			return result;
		}
		return joinPoint.proceed();
	}

	private String getName(String method, String id){ 
		String name="";
		if(StringUtils.equals(method, LogRecord.Module.REBATE.name())){ 
		  Bonus rebate = bonusService.get(Integer.parseInt(id)); 
		  name = rebate.getName(); 
		  }
		else if(StringUtils.equals(method,LogRecord.Module.LOTTERY.name())){ 
			  Lottery lottery = lotteryService.get(Integer.parseInt(id)); 
			  name = lottery.getName();
			  }
		else if(StringUtils.equals(method, LogRecord.Module.IMAGE.name())){
			PictrueLibrary imageApp =pictrueLibraryService.get(Integer.parseInt(id)); 
	        name =imageApp.getName(); 
	        }
		else if(StringUtils.equals(method, LogRecord.Module.MERCHANT.name())){
		  Merchant merchant =clientService.getMerchant(Integer.parseInt(id)); 
		  name = merchant.getName(); 
		  }else if(StringUtils.equals(method,LogRecord.Module.FAQ.name())){ 
			  Faq faq = postmarketingService.getFaq(Integer.parseInt(id)); name = faq.getAsk();
			  }else if(StringUtils.equals(method,LogRecord.Module.PUSHMESSAGE.name())){ 
				  PushMessage pushMessage =messageService.getPushMessage(Integer.parseInt(id)); 
				  name = pushMessage.getTitle(); 
				  }else if(StringUtils.equals(method, LogRecord.Module.PRODUCTCATEGORY.name())){ 
					  ProductCategory productCategory = productService.getCategory(Integer.parseInt(id)); 
					  name = productCategory.getName(); 
					  }else if(StringUtils.equals(method,LogRecord.Module.ADMIN.name())){ 
						  Admin admin =systemService.getAdmin(Integer.parseInt(id)); 
						  name = admin.getName();
	  }else if(StringUtils.equals(method, LogRecord.Module.BANK_LIMIT.name())){
	  PayBank unionPayBank = payBankService.get(Integer.parseInt(id));
	  name =unionPayBank.getBankName(); 
	  }else if(StringUtils.equals(method,LogRecord.Module.ROLE.name())){
		  Role role = systemService.getRole(Integer.parseInt(id)); 
		  name = role.getName(); 
		  }else if(StringUtils.equals(method, LogRecord.Module.NEWS_BULLETIN.name())){
	  NewsBulletin newsBulletin = postmarketingService.getNewsBulletin(Integer.parseInt(id)); 
	  name =newsBulletin.getNews().getTitle(); 
	  }else if(StringUtils.equals(method,LogRecord.Module.ACTIVITY.name())){
		  Activity activity = activityService.get(Integer.parseInt(id)); 
		  name = activity.getTitle();
	  }else if(StringUtils.equals(method, LogRecord.Module.PHOTOALBUM.name())|| StringUtils.equals(method, LogRecord.Module.WEB_IMAGE.name())){
	  PictrueLibrary imageApp = pictrueLibraryService.get(Integer.parseInt(id)); 
	  name = imageApp.getName(); 
	  }else if(StringUtils.equals(method,LogRecord.Module.CELLPHONE_LOG.name())){ 
		  CellphoneLog cellphoneLog = postmarketingService.getCellphoneLog(Integer.parseInt(id)); 
		  name = cellphoneLog.getOldCellphone(); 
		  }else if(StringUtils.equals(method, LogRecord.Module.GOODS.name())){ 
			  Goods goods =  silverService.getGoods(Integer.parseInt(id)); 
			  name = goods.getName();
	  }else if (StringUtils.equals(method,LogRecord.Module.SMSTEMPLATE.name())) {
	  SmsTemplate smsTemplate =messageService.getSmsTemplate(Integer.parseInt(id)); 
	  name = smsTemplate.getContent(); 
	  }else if (StringUtils.equals(method,LogRecord.Module.PRODUCT_AD.name())) {
		  PictrueLibrary imageApp = pictrueLibraryService.get(Integer.parseInt(id)); 
		  name = imageApp.getName();
		  }else if (StringUtils.equals(method, LogRecord.Module.COUPONACTIVITY.name())) {
			  CouponActivity couponActivity= activityService.getCouponActivity(Integer.parseInt(id)); 
			  name =couponActivity.getName(); 
			  }else if (StringUtils.equals(method, LogRecord.Module.APPMESSAGE.name())){
				  NewsMaterial news = messageService.getNews(Integer.parseInt(id));
				  name = news.getTitle();
	  }else if(StringUtils.equals(method, LogRecord.Module.SIGNIN.name())){
	  SignIn signIn = silverService.getSignIn(Integer.parseInt(id)); 
	  name =""; }else if(StringUtils.equals(method,LogRecord.Module.DISPATCHINGBONUSLOG.name())){ 
		  DispatchingBonusLog dispatchingBonusLog = couponService.getDispatchingBonusLog(Integer.parseInt(id));
	  if(dispatchingBonusLog != null){ 
		  if(dispatchingBonusLog.getCategory() == 0){ 
			 /* if(dispatchingBonusLog.getCoupon() != null &&dispatchingBonusLog.getCoupon().getName() != null){
				  name = dispatchingBonusLog.getCoupon().getName();
				  }*/ 
			  }else
	  if(dispatchingBonusLog.getCategory() == 1){ 
		  name =dispatchingBonusLog.getQuantity().toString();
		  } 
		  } 
	  }else
	  if(StringUtils.equals(method, LogRecord.Module.SMSCHANNEL.name())){
	  SmsChannel smsChannel = clientService.getSmsChannel(Integer.parseInt(id));
	  if(smsChannel != null){ 
		  name = smsChannel.getName(); 
		  } 
	  }else if(StringUtils.equals(method, LogRecord.Module.PRODUCT.name())) {
		String productName =  productService.queryProductName(Integer.parseInt(id));
		if(productName != null) {
			name = productName;
		}
	  }else if(StringUtils.equals(method, LogRecord.Module.PROJECT_MANAGEMENT.name())){
		  	Product product = productService.get(Integer.parseInt(id));
		  	if(product != null) {
		  		name= product.getName();
		  	}
	  }else{
	  logger.info("New modules need to configure LogRecord.java ");
	  } 
	  return name;
	  }

	private Method getMethod(ProceedingJoinPoint joinPoint) {
		String methodName = joinPoint.getSignature().getName();
		Method[] methods = joinPoint.getTarget().getClass().getMethods();
		Method resultMethod = null;
		for (Method method : methods) {
			if (method.getName().equals(methodName)) {
				resultMethod = method;
				break;
			}
		}
		return resultMethod;
	}

	private String executeTemplateFreeMarker(String template,ProceedingJoinPoint joinPoint, HttpServletRequest request) {
		if (StringUtils.isBlank(template)) {
			return "";
		}
		Method method = getMethod(joinPoint);
		String[] parameterNames = parameterNameDiscoverer.getParameterNames(method);
		Object[] args = joinPoint.getArgs();
		
		if (freeMarkerConfigurer == null) {
			BeanFactory factory = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getServletContext()); 
			freeMarkerConfigurer = (FreeMarkerConfigurer) factory.getBean("freeMarkerConfigurer"); 
		}
		
		 Configuration configuration = freeMarkerConfigurer.getConfiguration();
	     configuration.setTemplateLoader(new StringTemplateLoader(template));
		StringWriter writer = new StringWriter();
		try {
			Template freeMarkerTemplate = configuration.getTemplate("");
			Map<String, Object> context = new HashMap<String, Object>();
			for (int i = 0; i < parameterNames.length; i++) {
				context.put(parameterNames[i], args[i]);
			}
			freeMarkerTemplate.process(context, writer);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		}
		return writer.toString();
	}

	/*private FreeMarkerConfigurer freeMarkerConfigurer;

	public FreeMarkerConfigurer getFreeMarkerConfigurer() {
		return freeMarkerConfigurer;
	}

	public void setFreeMarkerConfigurer(
			FreeMarkerConfigurer freeMarkerConfigurer) {
		this.freeMarkerConfigurer = freeMarkerConfigurer;
	}*/
}