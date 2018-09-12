package com.silverfox.finance.controller;
import static com.silverfox.finance.util.ConstantUtil.BACK_SLASH;
import static com.silverfox.finance.util.ConstantUtil.COLON;
import static com.silverfox.finance.util.ConstantUtil.COMMA;
import static com.silverfox.finance.util.ConstantUtil.EMPTY;
import static com.silverfox.finance.util.ConstantUtil.NORMAL_DATETIME_FORMAT;
import static com.silverfox.finance.util.ConstantUtil.NORMAL_DATE_FORMAT;
import static com.silverfox.finance.util.ConstantUtil.SLASH;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.silverfox.finance.domain.Attachment;
import com.silverfox.finance.domain.Bonus;
import com.silverfox.finance.domain.Guarantee;
import com.silverfox.finance.domain.Lender;
import com.silverfox.finance.domain.Merchant;
import com.silverfox.finance.domain.MerchantOrder;
import com.silverfox.finance.domain.Product;
import com.silverfox.finance.domain.ProductCategory;
import com.silverfox.finance.domain.ProductContract;
import com.silverfox.finance.domain.ProductProtocol;
import com.silverfox.finance.domain.Project;
import com.silverfox.finance.domain.Role;
import com.silverfox.finance.domain.RoleResource;
import com.silverfox.finance.entity.ArrayObjectEntity;
import com.silverfox.finance.entity.LoanEntity;
import com.silverfox.finance.entity.ProductEntity;
import com.silverfox.finance.entity.SecurityEntity;
import com.silverfox.finance.enumeration.GenericAuditStatusEnum;
import com.silverfox.finance.enumeration.GenericEnableEnum;
import com.silverfox.finance.enumeration.GenericStatusEnum;
import com.silverfox.finance.enumeration.OrderNOPrefixEnum;
import com.silverfox.finance.enumeration.PayChannelEnum;
import com.silverfox.finance.enumeration.PlatformEnum;
import com.silverfox.finance.enumeration.ProductCategoryPropertyEnum;
import com.silverfox.finance.enumeration.ProductPeriodEnum;
import com.silverfox.finance.enumeration.ProductRecommendationEnum;
import com.silverfox.finance.enumeration.ProductStatusEnum;
import com.silverfox.finance.service.BonusService;
import com.silverfox.finance.service.ClientService;
import com.silverfox.finance.service.PayBankService;
import com.silverfox.finance.service.ProductService;
import com.silverfox.finance.service.TradeService;
import com.silverfox.finance.util.ConstantUtil;

@Controller
@RequestMapping("/product")
public class ProductController extends BaseController {
	@Autowired
	private TradeService tradeService;
	@Autowired
	private PayBankService payBankService;
    @Autowired
	private BonusService bonusService;
    @Autowired
	private ProductService productService;
    @Autowired
	private ClientService clientService;
    
    protected String getResourcePath(HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("");
		realPath = StringUtils.replace(realPath, BACK_SLASH, SLASH);
		String resourcePath = properties.getUploadPath();
		
		return realPath+resourcePath;
	}
    
    @RequestMapping("/lender/list/{page:\\d+}")
	public String list(Integer productId, String name, String cellphone, Integer startNum, Integer endNum, Integer status, Integer type, Integer size, @PathVariable("page")Integer page, Model model) {
		name = StringUtils.trimToEmpty(name);
		cellphone = StringUtils.trimToEmpty(cellphone);
		startNum = startNum == null ? -1 : startNum;
		endNum = endNum == null ? -1 : endNum;
		status = status == null ? -1 : status;
		int categoryId = 0;
		type = type == null ? 2: type;
		productId = productId == null ? -1 : productId;
    	int total = clientService.countLender(productId, type, name, cellphone, startNum, endNum, status, categoryId);
		if (total > 0) {
			model.addAttribute("total", total);
			model.addAttribute("lenders", clientService.listLender(productId, type, name, cellphone, startNum, endNum, status, categoryId, this.getOffset(page, size), this.getPageSize(size)));
		} else {
			model.addAttribute("total", 0);
			model.addAttribute("lenders", new Lender[0]);
		}
		List<String> categorysName = new ArrayList<String>(Arrays.asList("\u94f6\u4fe1\u8d37", "\u94f6\u5546\u8d37"));
		Map<Integer, String> categorys = new LinkedHashMap<Integer, String>();
		for(ProductCategory productCategory : productService.list(-1)){
			if (categorysName.contains(productCategory.getName())) {
				categorys.put(productCategory.getId(), productCategory.getName());
			}
    	}
		model.addAttribute("name", name);
		model.addAttribute("cellphone", cellphone);
		if (startNum > -1) {
			model.addAttribute("startNum", startNum);
		}
		if (endNum > -1) {
			model.addAttribute("endNum", endNum);
		}
		model.addAttribute("status", status);
		model.addAttribute("type", type);
		model.addAttribute("productId", productId);
		model.addAttribute("categoryId", categoryId);
		model.addAttribute("categorys", categorys);
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "product/lender/list";
	}
    
    @RequestMapping("/lender/add")
	public String addLender(Model model ,Integer lenderId) {
    	Lender lender = clientService.selectByLenderId(lenderId);
    	model.addAttribute("lender",lender);
		return "product/lender/add";
	}
    
    @RequestMapping(value="/lender/edit/{id:\\d+}")
	public String forwardToModification(@PathVariable("id")Integer id, HttpServletRequest request) {
		request.setAttribute("lender", clientService.getLender(id));
		request.setAttribute("operation", EDIT);
		return "product/lender/edit";
	}
    
    @RequestMapping(value="/lender/{id:\\d+}")
    @ResponseBody
	public Lender getLender(@PathVariable("id")Integer id, HttpServletRequest request) {
		return clientService.getLender(id);
	}
	
	@RequestMapping(value="/lender/detail/{id:\\d+}")
	public String forwardToDetail(@PathVariable("id")Integer id, Model model, HttpServletRequest request) {
		request.setAttribute("lender", clientService.getLender(id));
		model.addAttribute("operation", DETAIL);
		return "product/lender/edit";
	}
    
    @RequestMapping(value="/lender/save", method=RequestMethod.POST)
	public String saveLender(Lender lender,String idcardPhoto, Integer page, Integer size, HttpServletRequest request, RedirectAttributesModelMap redirectAttributesModelMap, Model model) {
    	Map<String, String> result = upload(request);
		List<Attachment> attachments = new ArrayList<Attachment>();
		for(String key : result.keySet()) {
			if (StringUtils.contains(key, "commitment")) {
				Attachment attachment = new Attachment();
				attachment.setCategory(11);
				attachment.setProductId(0);
				attachment.setGuaranteeId(0);
				attachment.setUrl(result.get(key));
				attachments.add(attachment);
			}
			if(StringUtils.isNotBlank(idcardPhoto)){
				lender.setIdcardUrl(idcardPhoto);
			}else{
				if (StringUtils.contains(key, "idcardImg")) {
					lender.setIdcardUrl(result.get(key));
				}
			}
			
		}
		lender.setType(2);
		lender.setAttachments(attachments);
		lender.setName(StringUtils.trim(lender.getName()));
		clientService.saveLender(lender);
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/product/lender/list/"+this.getPage(page);
	}
    
    @RequestMapping("/{page:\\d+}")
    public String productView(String projectTimeType,String productName, String productStatue, String productRisk, Integer periodStart, Integer periodEnd, Integer productCategoryId, Integer merchantId, Integer projectType, String merchantName, String beginTime, String endTime, Integer payChannel, Integer size, @PathVariable("page")int page, HttpServletRequest request){
    	
    	SimpleDateFormat sdf = new SimpleDateFormat(NORMAL_DATETIME_FORMAT);
    	productStatue = StringUtils.isNotBlank(productStatue) ? productStatue : "INTHESALE";
    	projectType = projectType == null ? -1 : projectType;
    	payChannel = payChannel == null ? -1 : payChannel;
    	projectTimeType = projectTimeType == null ? "1" : projectTimeType;
    	
    	int total = 0;
    	if(productStatue.equals("INTHESALE") || productStatue.equals("WAITAUDIT") || productStatue.equals("NOTSTARTED")){
    		total = productService.count(StringUtils.trim(productName), productStatue, productRisk, periodStart != null ? periodStart : 0, periodEnd != null ? periodEnd : 0, getIntValue(productCategoryId), getIntValue(merchantId), sdf.format(new Date()));
    	}
    	if(productStatue.equals("WAITPAYMENT")){
    		total  = clientService.count(projectType, productStatue, payChannel, StringUtils.trimToEmpty(merchantName), StringUtils.trimToEmpty(productName), -1, beginTime, endTime);
    	}
    	if(productStatue.equals("PAYMENTING") || productStatue.equals("PAYMENTED") || productStatue.equals("PAYBACKING")|| productStatue.equals("PAYBACKED")){
    		int orderType = -1;
			if(productStatue.equals("PAYMENTING") || productStatue.equals("PAYMENTED")){
				orderType = 1;
			}else{
				orderType = 0;
			}
			int orderStatus = -1;
			if(productStatue.equals("PAYMENTED") || productStatue.equals("PAYBACKED")){
				orderStatus = 2;
			}
    		total  = clientService.count(projectTimeType,projectType, orderStatus, payChannel, StringUtils.trimToEmpty(merchantName), StringUtils.trimToEmpty(productName), orderType, beginTime, endTime);
    	}
    	size = 15;
    	if(productStatue != null && productStatue.equals("INTHESALE")){
    		size = total;
    	}
    	if(total > 0) {
			request.setAttribute("total", total);
			//List<Product> products = new ArrayList<Product>();
			if(productStatue.equals("INTHESALE") || productStatue.equals("WAITAUDIT") || productStatue.equals("NOTSTARTED")){
				List<Product> products = productService.list(StringUtils.trim(productName), productStatue, productRisk, periodStart != null ? periodStart : 0, periodEnd != null ? periodEnd : 0, getIntValue(productCategoryId), getIntValue(merchantId), sdf.format(new Date()), this.getOffset(page, size), this.getPageSize(size));
				request.setAttribute("products",JSONObject.toJSON(products));
			}
			
			if(productStatue.equals("PAYMENTING") || productStatue.equals("PAYMENTED") || productStatue.equals("PAYBACKING")|| productStatue.equals("PAYBACKED")){
				List<ProductEntity> products = new ArrayList<ProductEntity>();
				int orderType = -1;
				if(productStatue.equals("PAYMENTING") || productStatue.equals("PAYMENTED")){
					orderType = 1;
				}else{
					orderType = 0;
				}
				int orderStatus = -1;
				if(productStatue.equals("PAYMENTED") || productStatue.equals("PAYBACKED")){
					orderStatus = 2;
				}else{
					orderStatus = 1;
				}
				products  = clientService.list(projectTimeType,projectType, orderStatus, payChannel, StringUtils.trimToEmpty(merchantName), StringUtils.trimToEmpty(productName), orderType, beginTime, endTime, this.getOffset(page, size), this.getPageSize(size));
				request.setAttribute("products", JSONObject.toJSON(products));
			}
			if(productStatue.equals("WAITPAYMENT")){
				List<ProductEntity> products = new ArrayList<ProductEntity>();
				products  = clientService.list(projectType, productStatue, payChannel, StringUtils.trimToEmpty(merchantName), StringUtils.trimToEmpty(productName), -1, beginTime, endTime, this.getOffset(page, size), this.getPageSize(size));
				request.setAttribute("products",JSONObject.toJSON(products));
				double waitpaymentMoney = clientService.sumWaitpaymentMoney(projectType, productStatue, StringUtils.trimToEmpty(merchantName), StringUtils.trimToEmpty(productName), -1, beginTime, endTime);
				request.setAttribute("waitpaymentMoney",waitpaymentMoney);
			}
			if(productStatue.equals("PAYMENTED")){
				Double paymentMoney = clientService.sumPaymentMoney(projectTimeType,projectType, productStatue, StringUtils.trimToEmpty(merchantName), StringUtils.trimToEmpty(productName), 1, beginTime, endTime);
				Double sumShouldPaybackmentMoney = clientService.sumShouldPaybackmentMoney(projectTimeType,projectType, productStatue, StringUtils.trimToEmpty(merchantName), StringUtils.trimToEmpty(productName), 1, beginTime, endTime);
				if(StringUtils.isNotBlank(paymentMoney+"")){
					request.setAttribute("paymentMoney",paymentMoney);
				}else{
					request.setAttribute("paymentMoney","0");
				}
				if(StringUtils.isNotBlank(sumShouldPaybackmentMoney+"")){
					request.setAttribute("shouldPaybackmentMoney",sumShouldPaybackmentMoney);
				}else{
					request.setAttribute("shouldPaybackmentMoney","0");
				}
			}
			if(productStatue.equals("PAYBACKED")){
				Double shouldPaybackmentMoney = clientService.sumShouldPaybackmentMoney("1",projectType, productStatue, StringUtils.trimToEmpty(merchantName), StringUtils.trimToEmpty(productName), 0, beginTime, endTime);
				double tradeAmount = clientService.sumTradeAmount(projectType, productStatue, StringUtils.trimToEmpty(merchantName), StringUtils.trimToEmpty(productName), beginTime, endTime);
				double serviceCharge = 	clientService.sumServiceCharge(projectType, productStatue, StringUtils.trimToEmpty(merchantName), StringUtils.trimToEmpty(productName), -1, beginTime, endTime);
				request.setAttribute("shouldPaybackmentMoney",shouldPaybackmentMoney);
				request.setAttribute("tradeAmount", tradeAmount);
				request.setAttribute("serviceCharge", serviceCharge);
			}
			
		} else {
			request.setAttribute("total", 0);
			request.setAttribute("products", new Product[0]);
		}
		request.setAttribute("pages", this.getTotalPage(total, size));
		getSearchParam(productName, productStatue, periodStart, periodEnd, productCategoryId, merchantId, this.getPageSize(size), this.getPage(page), request);
		getProductParam(request);
		Map<Integer, String> categorys = new LinkedHashMap<Integer, String>();
    	for(ProductCategory productCategory : productService.list(-1)){
    		if(productCategory.getProperty().equals(ProductCategoryPropertyEnum.TREASURE.name())){
    			continue;
    		}
    		categorys.put(productCategory.getId(), productCategory.getName());
    	}
    	request.setAttribute("categorys", categorys);
    	List<Merchant> merchants = new ArrayList<Merchant>();
 	    for(Merchant  me: clientService.list(null, 1, 0, 0)){
 	   		if(me.getStatus() > 0){
 	   			merchants.add(me);
 	   		}
 	    }
    	request.setAttribute("merchants", merchants);
    	request.setAttribute("projectType", projectType);
    	request.setAttribute("merchantName", merchantName);
    	request.setAttribute("beginTime", beginTime);
    	request.setAttribute("endTime", endTime);
    	request.setAttribute("payChannel", payChannel);
    	request.setAttribute("projectTimeType", projectTimeType);
    	request.setAttribute("productStatue", productStatue);
    	request.setAttribute("movePermit",getAddFunctionPermit(request));
    	return "product/list";
    }
    
    /*@RequestMapping("/merchant/order/{category:\\d+}/{page:\\d+}")
	public String orderList(String merchantName, String productName, Integer timeCategory, String fromDate, String toDate, Integer size, Integer backType, Integer backChannel, @PathVariable("category")int category, @PathVariable("page")Integer page, Map<String, Object> model) {
		double totalAmount = 0;
		int totalPrincipal = 0;
		int total = 0;
		timeCategory = timeCategory == null ? 0 : timeCategory;
		if (OrderCategoryEnum.WAITING_PAYMENT.getCategory() == category) {
			total = clientService.count(StringUtils.trimToEmpty(merchantName), StringUtils.trimToEmpty(productName), timeCategory, fromDate, toDate);
			if (total > 0) {
				List<Product> products = clientService.list(StringUtils.trimToEmpty(merchantName), StringUtils.trimToEmpty(productName), timeCategory, fromDate, toDate, this.getOffset(page, size), this.getPageSize(size));
				totalPrincipal = clientService.sumPrincipal(category, StringUtils.trimToEmpty(merchantName), StringUtils.trimToEmpty(productName), timeCategory, fromDate, toDate);
				totalAmount = clientService.sum(StringUtils.trimToEmpty(merchantName), StringUtils.trimToEmpty(productName), timeCategory, fromDate, toDate);
				model.put("total", total);
				model.put("orders", products);
			}else{
				model.put("total", 0);
				model.put("orders", new Product[0]);
			}
		} else {
			backType = backType == null ? -1 : backType; 
			backChannel = backChannel == null ? 0 : backChannel; 
			total = clientService.count(category, StringUtils.trimToEmpty(merchantName), StringUtils.trimToEmpty(productName), timeCategory, fromDate, toDate, backType, backChannel);
			if (total > 0) {
				List<MerchantOrder> orders = clientService.list(category, StringUtils.trimToEmpty(merchantName), StringUtils.trimToEmpty(productName), timeCategory, fromDate, toDate, backType, backChannel, this.getOffset(page, size), this.getPageSize(size));
				totalAmount = clientService.sum(category, StringUtils.trimToEmpty(merchantName), StringUtils.trimToEmpty(productName), timeCategory, fromDate, toDate, backType, backChannel);
				totalPrincipal = clientService.sumPrincipal(category, StringUtils.trimToEmpty(merchantName), StringUtils.trimToEmpty(productName), timeCategory, fromDate, toDate, backType, backChannel);
				model.put("total", total);
				model.put("orders", orders);
			}else{
				model.put("total", 0);
				model.put("orders", new MerchantOrder[0]);
			}
		}
		model.put("now", new Date());
		model.put("backType", backType);
		model.put("backChannel", backChannel);
		model.put("merchants", clientService.list(null, 1, 0, 0));
		model.put("totalAmount", totalAmount);
		model.put("totalPrincipal", totalPrincipal);
		model.put("timeCategory", timeCategory);
		model.put("category", category);
		model.put("merchantName", StringUtils.trimToEmpty(merchantName));
		model.put("productName", StringUtils.trimToEmpty(productName));
		model.put("fromDate", StringUtils.trimToEmpty(fromDate));
		model.put("toDate", StringUtils.trimToEmpty(toDate));
		model.put("size", this.getPageSize(size));
		model.put("page", this.getPage(page));
		model.put("pages", this.getTotalPage(total, size));
		return "client/merchant/order";
	}*/
    
    @RequestMapping("/project/list/{page:\\d+}")
    public String productProjectView(Integer size, @PathVariable("page")int page, HttpServletRequest request){
    	int total = productService.count();
		if(total > 0) {
			request.setAttribute("total", total);
			request.setAttribute("projects",productService.list(this.getOffset(page, size), this.getPageSize(size)));
		} else {
			request.setAttribute("total", 0);
			request.setAttribute("projects", new Product[0]);
		}
		request.setAttribute("pages", this.getTotalPage(total, size));
		request.setAttribute("size", this.getPageSize(size));
		request.setAttribute("page",this.getPage(page));
    	return "product/project/list";
    }
    
    @RequestMapping("/project/add")
    public String productProjectView(HttpServletRequest request){
    	request.setAttribute("guarantees", productService.listGuarantee(1));
    	request.setAttribute("unionPayBanks", payBankService.getBankList(PayChannelEnum.UNION_PAY, GenericEnableEnum.ENABLE.value()));
    	request.setAttribute("provinces", payBankService.getProvinceList());
    	return "product/project/add";
    }
    
    @RequestMapping("/project/edit/{projectId:\\d+}")
    public String editProductProjectView(@PathVariable("projectId")int projectId, HttpServletRequest request){
    	Project project = productService.getProject(projectId);
    	request.setAttribute("project", project);
    	request.setAttribute("unionPayBanks", payBankService.getBankList(PayChannelEnum.UNION_PAY, GenericEnableEnum.ENABLE.value()));
    	request.setAttribute("provinces", payBankService.getProvinceList());
    	request.setAttribute("operation", "edit");
    	request.setAttribute("guarantees", productService.listGuarantee(1));
    	return "product/project/edit";
    }
    
    @RequestMapping("/project/audit/{projectId:\\d+}/{status:\\d+}")
    public String audit(@PathVariable("projectId")int projectId, @PathVariable("status")int status, HttpServletRequest request){
    	productService.audit(projectId, status);  
    	return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/product/project/list/1";
    }
    
    @RequestMapping("/project/detail/{projectId:\\d+}")
    public String detailProductProjectView(@PathVariable("projectId")int projectId, HttpServletRequest request){
    	request.setAttribute("project", productService.getProject(projectId));
    	request.setAttribute("operation", "detail");
    	request.setAttribute("guarantees", productService.listGuarantee(1));
    	request.setAttribute("unionPayBanks", payBankService.getBankList(PayChannelEnum.UNION_PAY, GenericEnableEnum.ENABLE.value()));
    	request.setAttribute("provinces", payBankService.getProvinceList());
    	return "product/project/edit";
    }
    
    @RequestMapping(value="/project/save", method=RequestMethod.POST)
	public String save(Project project, Integer page, Integer size, HttpServletRequest request, RedirectAttributesModelMap redirectAttributesModelMap, Model model) {
    	Map<String, String> result = upload(request);
		List<Attachment> attachments = new ArrayList<Attachment>();
		List<Attachment> guaranteeAttachments = new ArrayList<Attachment>();
		for(String key : result.keySet()) {
			if (StringUtils.contains(key, "otherData")) {
				Attachment attachment = new Attachment();
				attachment.setCategory(11);
				attachment.setProductId(0);
				attachment.setGuaranteeId(0);
				attachment.setUrl(result.get(key));
				attachments.add(attachment);
			} else if (StringUtils.contains(key, "guarantee")) {
				Attachment attachment = new Attachment();
				attachment.setCategory(5);
				attachment.setProductId(0);
				attachment.setGuaranteeId(0);
				attachment.setUrl(result.get(key));
				guaranteeAttachments.add(attachment);
			} 
		}
		project.setAttachments(attachments);
		project.setGuaranteeAttachments(guaranteeAttachments);
		productService.saveProject(project);
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/product/project/list/"+this.getPage(page);
	}
    
   @RequestMapping("/list/{page:\\d+}/{size:\\d+}")
   @ResponseBody
   public  Map<String, Object> productList(String productName,@PathVariable("page")int page,@PathVariable("size")Integer size,HttpServletRequest request) {
	   int total = productService.count(productName,GenericAuditStatusEnum.INTHESALE.name(), null,0,0, 0, 0,null);
	   Map<String, Object> result = new HashMap<String, Object>();
	   if (total > 0) {
		   result.put("productTotal", total);
		   result.put("products", productService.list(productName, GenericAuditStatusEnum.INTHESALE.name(), null,0,0, 0, 0, null, this.getOffset(page, size), this.getPageSize(size)));
	   } else {
		   result.put("productTotal", 0);
		   result.put("products", new Product[0]);
	   }
	   result.put("productName", StringUtils.trimToEmpty(productName));
	   result.put("size", this.getPageSize(size));
	   result.put("page", this.getPage(page));
	   result.put("pages", this.getTotalPage(total, size));
	   return result;
   }
   
   
    
   @RequestMapping("/contract/list/{page:\\d+}")
   public String listContract(String name, Integer status, Integer size, @PathVariable("page")int page, HttpServletRequest request){
      int total = productService.countContract(name, status != null ? status : -1);
 	   if(total > 0) {
 		   request.setAttribute("total", total);
 		   request.setAttribute("contracts",productService.listContract(name, status != null ? status : -1, this.getOffset(page, size), this.getPageSize(size)));
 	   } else {
 		   request.setAttribute("total", 0);
 		   request.setAttribute("contracts", new ProductContract[0]);
 	   }
 	   request.setAttribute("size", this.getPageSize(size));
	   request.setAttribute("page", this.getPage(page));
	   request.setAttribute("pages", this.getTotalPage(total, size));
	   return "product/contract/list";
	}
   
   @RequestMapping("/protocol/list")
   public String listProtocol(Integer status, HttpServletRequest request){
      int total = productService.countProtocol(status != null ? status : -1);
 	   if(total > 0) {
 		   request.setAttribute("total", total);
 		   request.setAttribute("protocols",productService.listProtocol(status != null ? status : -1));
 	   } else {
 		   request.setAttribute("total", 0);
 		   request.setAttribute("protocols", new ProductContract[0]);
 	   }
	   return "product/protocol/list";
	}
   
   @RequestMapping("/guarantee/list")
   public String listGuarantee(Integer status, HttpServletRequest request){
      int total = productService.countGuarantee(status != null ? status : -1);
 	   if(total > 0) {
 		   request.setAttribute("total", total);
 		   request.setAttribute("guarantees",productService.listGuarantee(status != null ? status : -1));
 	   } else {
 		   request.setAttribute("total", 0);
 		   request.setAttribute("guarantees", new Guarantee[0]);
 	   }
	   return "product/guarantee/list";
	}
   
   @RequestMapping("/treasure/list/{page:\\d+}")
   public String producTreasuretView(String productName, String productStatue, Integer auditStatue, Integer merchantId, Integer size, @PathVariable("page")int page, HttpServletRequest request){
	   SimpleDateFormat sdf = new SimpleDateFormat(NORMAL_DATETIME_FORMAT);
	   int total = productService.count(productName, productStatue, auditStatue != null ? auditStatue : -1, getIntValue(merchantId), sdf.format(new Date()));
	   if(total > 0) {
		   request.setAttribute("total", total);
		   request.setAttribute("products",productService.list(productName, productStatue, auditStatue != null ? auditStatue : -1, getIntValue(merchantId), sdf.format(new Date()), this.getOffset(page, size), this.getPageSize(size)));
	   } else {
		   request.setAttribute("total", 0);
		   request.setAttribute("products", new Product[0]);
	   }
	   getProductParam(request);
	   Map<Integer, String> categorys = new LinkedHashMap<Integer, String>();
	   for(ProductCategory productCategory : productService.list(-1)){
		   if(productCategory.getName().equals(ProductCategoryPropertyEnum.TREASURE.name())){
			   categorys.put(productCategory.getId(), productCategory.getName());
		   }else{
			   continue;
		   }
	   }
	   List<Merchant> merchants = new ArrayList<Merchant>();
	   for(Merchant  me: clientService.list(null, 1, 0, 0)){
	   		if(me.getStatus() > 0){
	   			merchants.add(me);
	   		}
	   }
	   request.setAttribute("merchants", merchants);
	   request.setAttribute("categorys", categorys);
	   request.setAttribute("systemTime", sdf.format(new Date()));
	   request.setAttribute("productName", StringUtils.trimToEmpty(productName));
	   request.setAttribute("productStatue",  StringUtils.trimToEmpty(productStatue));
	   request.setAttribute("auditStatue", auditStatue != null ? auditStatue : -1);
	   request.setAttribute("merchantId", merchantId);
	   request.setAttribute("count",productService.count(null, null, auditStatue != null ? auditStatue : -1, 0, sdf.format(new Date())) );
	   request.setAttribute("size", this.getPageSize(size));
	   request.setAttribute("page", this.getPage(page));
	   request.setAttribute("pages", this.getTotalPage(total, size));
	   return "product/treasure/list";
   }
   
   @RequestMapping("/category/list")
   public String list(HttpServletRequest request){
	   List<ProductCategory> list = productService.list(-1);
	   if(list.size() > 0){
		   request.setAttribute("categories", list);
	   }else{
		   request.setAttribute("categories", new ProductCategory[0]);
	   }
	   Map<String, String> propertys = new LinkedHashMap<String, String>();
	   int experienceCount = productService.countCategory(ProductCategoryPropertyEnum.EXPERIENCE.name());
	   int noviceCount = productService.countCategory(ProductCategoryPropertyEnum.NOVICE.name());
	   int activityCount = productService.countCategory(ProductCategoryPropertyEnum.ACTIVITY.name());
	   int treasureCount = productService.countCategory(ProductCategoryPropertyEnum.TREASURE.name());
	   for(ProductCategoryPropertyEnum property : ProductCategoryPropertyEnum.values()){
		   propertys.put(property.name(), property.toString());
		   if(experienceCount > 0){
			   if(property.name().equals(ProductCategoryPropertyEnum.EXPERIENCE.name())){
				   continue;
			   }
		   }
		   if(noviceCount > 0){
			   if(property.name().equals(ProductCategoryPropertyEnum.NOVICE.name())){
				   continue;
			   }
		   }
		   if(activityCount > 0){
			   if(property.name().equals(ProductCategoryPropertyEnum.ACTIVITY.name())){
				   continue;
			   }
		   }
		   if(treasureCount > 0){
			   if(property.name().equals(ProductCategoryPropertyEnum.TREASURE.name())){
				   continue;
			   }
		   }
		  // propertys.put(property.name(), property.toString());	
	   }
	   request.setAttribute("propertys", propertys);
	   return "product/category";
	}
    
    @RequestMapping(value = "/category/enable/{id:\\d+}/{value:\\d+}", method = RequestMethod.POST)
	@ResponseBody
	public boolean enable(@PathVariable("id")int id, @PathVariable("value")int value, HttpServletRequest request) {
    	return productService.enable(id, value);
	}
    
    @RequestMapping(value="/validate/bonus", method=RequestMethod.POST)
	@ResponseBody
	public boolean getProductByBonusId(int id){
		if (id > 0) {
			List<Product> products = productService.getProductByBonusId(id);
			int flag = 0;
			if(products != null){
				for(Product product : products){
					if(product.getStatus() == 1){
						if(product.getActualAmount() < product.getTotalAmount()){
							flag ++;
						}
					}
				}
			}
			if(flag > 0){
				return false;
			}
		}
		return true;
	}
    
    @RequestMapping(value = "/category/save", method = RequestMethod.POST)
	public String save(@Valid ProductCategory productCategory, BindingResult result, HttpServletRequest request) {
    	if (!result.hasErrors()) {
    		if (productService.duplicate(0, productCategory.getName())) {
    			if(productCategory.getProperty().equals(ProductCategoryPropertyEnum.TREASURE.name())){
    				productCategory.setStatus(1);
    			}
    			productService.saveProductCategory(productCategory);
    		}
    	}
    	return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/product/category/list";
  	}
    
    @RequestMapping(value="/category/duplicate/name", method=RequestMethod.GET)
	@ResponseBody
	public String duplicate(int id, String fieldId, String fieldValue) {
		ArrayObjectEntity json = new ArrayObjectEntity();
		boolean result = productService.duplicate(id, StringUtils.trim(fieldValue));
		json.setObject(fieldId);
		json.setSuccess(result);
		if (result) {
			json.setMessage(properties.getAppNamePass());
		} else {
			json.setMessage(properties.getAppNameNoPass()); 
		}
		return json.toString(); 
	}
    
    @RequestMapping(value="/category/duplicate/property", method=RequestMethod.GET)
    @ResponseBody
    public boolean checkProperty(String property){
    	if(property != null){
    		return productService.count(property) > 0 ? false: true;
    	}
    	return false;
    }
    
    @RequestMapping("/contract/{id:\\d+}/{status:\\d+}")
	public String changeContractStatus(Integer page, @PathVariable("id") int id, @PathVariable("status") int status, HttpServletRequest request) {
    	if (id > 0) {
    		ProductContract contract = productService.getContract(id);
    		if(contract != null){
    			contract.setStatus(status);
    		}
    		productService.saveProductContract(contract, null);
    	}
    	return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+this.properties.getHttpsUrl()+"/product/contract/list/"+ this.getPage(page); 
	}
    
    @RequestMapping("/protocol/{protocolId:\\d+}/{status:\\d+}")
	public String changeProtocolStatus(Integer page, @PathVariable("protocolId") int protocolId, @PathVariable("status") int status, HttpServletRequest request) {
    	if (protocolId > 0) {
    		ProductProtocol protocol = productService.getProtocol(protocolId);
    		if(protocol != null){
    			protocol.setStatus(status);
    		}
    		productService.saveProductProtocol(protocol);
    	}
    	return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/product/protocol/list"; 
	}
    
    @RequestMapping("/guarantee/{guaranteeId:\\d+}/{status:\\d+}")
   	public String changeGuaranteeStatus(Integer page, @PathVariable("guaranteeId") int guaranteeId, @PathVariable("status") int status, HttpServletRequest request) {
       	if (guaranteeId > 0) {
       		Guarantee guarantee = productService.getGuarantee(guaranteeId);
       		if(guarantee != null){
       			guarantee.setStatus(status);
       		}
       		productService.saveGuarantee(guarantee, null);;
       	}
       	return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/product/guarantee/list"; 
   	}
    
    @RequestMapping("/contract/add")
   	public String forwardToCreation(HttpServletRequest request) { 
       	return "product/contract/add";
   	}
    
    @RequestMapping("/protocol/add")
   	public String addProtocol(HttpServletRequest request) { 
       	return "product/protocol/add";
   	}
    
    @RequestMapping("/guarantee/add")
   	public String addGuarantee(HttpServletRequest request) { 
       	return "product/guarantee/add";
   	}
    
    @RequestMapping(value="/contract/save", method=RequestMethod.POST)
   	public String saveContract(ProductContract contract, Integer page, HttpServletRequest request) {
       	if(contract != null){
       		productService.saveProductContract(contract, upload(request));
       	}
       	return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/product/contract/list/"+ this.getPage(page); 
   	}
    
    @RequestMapping(value="/protocol/save", method=RequestMethod.POST)
   	public String saveProtocol(ProductProtocol protocol, HttpServletRequest request) {
       	if(protocol != null){
       		productService.saveProductProtocol(protocol);
       	}
       	return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/product/protocol/list"; 
   	}
    
    @RequestMapping(value="/guarantee/save", method=RequestMethod.POST)
   	public String saveGuarantee(Guarantee guarantee, HttpServletRequest request) {
       	if(guarantee != null){
       		Map<String, String> attachmentsMap = this.upload(request);
       		productService.saveGuarantee(guarantee, attachmentsMap);
       	}
       	return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/product/guarantee/list"; 
   	}
    
    @RequestMapping("/protocol/edit/{protocolId:\\d+}")
	public String editProtocol(@PathVariable("protocolId")int protocolId, Model model){
		if(protocolId > 0){
			model.addAttribute("protocol", productService.getProtocol(protocolId));
		}
		model.addAttribute("operation",EDIT);
		return "product/protocol/edit";
	}
    
    @RequestMapping("/guarantee/edit/{guaranteeId:\\d+}")
	public String editGuaranteeId(@PathVariable("guaranteeId")int guaranteeId, Model model){
		if(guaranteeId > 0){
			Guarantee guarantee = productService.getGuarantee(guaranteeId);
			model.addAttribute("guarantee", guarantee);
		}
		model.addAttribute("operation",EDIT);
		return "product/guarantee/edit";
	}
    
    @RequestMapping("/protocol/detail/{protocolId:\\d+}")
   	public String detailProtocol(@PathVariable("protocolId")int protocolId, Model model){
   		if(protocolId > 0){
   			model.addAttribute("protocol", productService.getProtocol(protocolId));
   		}
   		model.addAttribute("operation",DETAIL);
   		return "product/protocol/edit";
   	}
    
    @RequestMapping("/contract/detail/{id:\\d+}")
   	public String detailContract(@PathVariable("id") int id, HttpServletRequest request) {
       	if (id > 0) {
       		ProductContract productContract = productService.getContract(id);
       		request.setAttribute("productContract", productContract);
       	}
       	return "product/contract/detail";
   	}
    
    @RequestMapping("/guarantee/detail/{guaranteeId:\\d+}")
	public String detailGuaranteeId(@PathVariable("guaranteeId")int guaranteeId, Model model){
		if(guaranteeId > 0){
			Guarantee guarantee = productService.getGuarantee(guaranteeId);
			model.addAttribute("guarantee", guarantee);
		}
		model.addAttribute("operation",DETAIL);
		return "product/guarantee/edit";
	}
    
    @RequestMapping("/get/contract/{id:\\d+}")
    @ResponseBody
   	public ProductContract getContract(@PathVariable("id") int id, HttpServletRequest request) {
       	if (id > 0) {
       		return productService.getContract(id);
       	} 
       	return null;
   	}
    
    @RequestMapping("/get/merchant/info/{merchantId:\\d+}")
    @ResponseBody
   	public Merchant getMerchantInfo(@PathVariable("merchantId") int merchantId, HttpServletRequest request) {
       	if (merchantId > 0) {
       		return clientService.getMerchant(merchantId);
       	} 
       	return null;
   	}
    
    @RequestMapping("/get/project/info/{projectId:\\d+}")
    @ResponseBody
   	public JSONObject getProjectInfo(@PathVariable("projectId") int projectId, HttpServletRequest request) {
    	JSONObject result = new JSONObject(); 
       	if (projectId > 0) {
       		Project project = productService.getProject(projectId);
       		result.put("project", project);
       		/*if(project != null && project.getGuarantee() != null){
       			result.put("guarantee", productService.getGuarantee(project.getGuarantee().getId()));
       		}*/
       	} 
       	return result;
   	}
    
    @RequestMapping("/get/guarantee/info/{guaranteeId:\\d+}")
    @ResponseBody
   	public Guarantee getGuaranteeIdInfo(@PathVariable("guaranteeId") int guaranteeId, HttpServletRequest request) {
       	if (guaranteeId > 0) {
       		return productService.getGuarantee(guaranteeId);
       	} 
       	return null;
   	}
    
    @RequestMapping(value="/save", method=RequestMethod.POST)
    public String saveProduct(Product product, int[] lenderIds, String productName, String removeAttachmentIds, String productStatue, String productRisk, Integer periodStart, Integer periodEnd, Integer productCategoryId, Integer merchantId, String attachmentIdList, Integer page,Integer size, String backView, HttpServletRequest request, RedirectAttributesModelMap redirectAttributesmap)throws IOException{
    	Map<String, String> attachmentsMap = new LinkedHashMap<String, String>();
    	if(product != null){
    		if(product.getCategory() != null){
    			if(product.getCategory().getProperty() != null){
    				if(product.getCategory().getProperty().equals(ProductCategoryPropertyEnum.EXPERIENCE.name()) || product.getCategory().getProperty().equals(ProductCategoryPropertyEnum.NOVICE.name())){
        				product.setRaisePeriod(10); 
        				product.setStatus(0);
    				}
    				if(product.getCategory().getProperty().equals(ProductCategoryPropertyEnum.COMMON.name())){
    					product.setHighestMoney(product.getTotalAmount());
    				}
    				if((product.getCategory().getProperty().equals(ProductCategoryPropertyEnum.ACTIVITY.name()))){
    					Bonus rebate = new Bonus();
    					rebate.setId(0);
    					product.setBonus(rebate);
    				}
    			}
    		}
    		
    		if(product.getId() > 0){
    			List<String> attachmentIds = new LinkedList<String>();
    	    	if(StringUtils.isNotBlank(attachmentIdList)){
    	    		CollectionUtils.addAll(attachmentIds, attachmentIdList.split(COMMA));
    	    		
    	    	}
    	    	if (StringUtils.isNotBlank(removeAttachmentIds)) {
    	    		CollectionUtils.addAll(attachmentIds, StringUtils.split(removeAttachmentIds, COMMA));
    	    	}
    	    	if(attachmentIds.size() >0){
    	    		List<Integer> Ids = JSON.parseArray(attachmentIds.toString(), Integer.class);
    	    		productService.removeAttachment(Ids);
    	    	}
    		}
    		
    		attachmentsMap = this.upload(request);
    	}
    	if(product.getInterestType() == null){
    		product.setInterestType(0);
    	}
    	if(product.getInterestType() == 1){
    		product.setInterestDate("");
    	}
    	
    	product.setInitialTotalAmount(product.getTotalAmount());
    	product.setDisplayPlatform("0");
    	productService.save(product, attachmentsMap, lenderIds);
    	setRedirectAttributes(productName, productStatue, periodStart, periodEnd, productCategoryId, merchantId, EDIT, redirectAttributesmap);
    	return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/product/"+ this.getPage(page); 
    }
    

	@RequestMapping(value=("/add/{page:\\d+}"), method=RequestMethod.POST)
	public String forwardToCreation(String productName, String productStatue, String productRisk, Integer periodStart, Integer periodEnd, Integer productCategoryId, Integer merchantId, Integer size, @PathVariable("page")int page, HttpServletRequest request) {
    	getProductParam(request);
    	getSearchParam(productName, productStatue, periodStart, periodEnd, productCategoryId,  merchantId, this.getPageSize(size), this.getPage(page), request);
    	Map<Integer, String> bonus = new LinkedHashMap<Integer, String>();
    	SimpleDateFormat sdf = new SimpleDateFormat(NORMAL_DATE_FORMAT);
		for(Bonus b : bonusService.list(sdf.format(new Date().getTime()),1,1)){
			bonus.put(b.getId(), b.getName());
		}
		request.setAttribute("bonus", bonus);
    	List<ProductCategory> categorys = new ArrayList<ProductCategory>();
    	for(ProductCategory productCategory : productService.list(1)){
    		if(productCategory.getProperty().equals(ProductCategoryPropertyEnum.TREASURE.name())){
    			continue;
    		}
    		if(productCategory.getProperty().equals(ProductCategoryPropertyEnum.EXPERIENCE.name())){
    			continue;
    		}
    		categorys.add(productCategory);
    	}
    	request.setAttribute("categorys", categorys);
    	List<Merchant> merchants = new ArrayList<Merchant>();
    	for(Merchant  me: clientService.list(null, 1, 0, 0)){
    		if(me.getStatus() > 0){
    			merchants.add(me);
    		}
    	}
    	List<Project> projects = new ArrayList<Project>();
    	for(Project project : productService.list(0, productService.count())){
    		if(project.getStatus() == 1){
    			projects.add(project);
    		}
    	}
    	request.setAttribute("merchants", merchants);
    	request.setAttribute("projects", projects);
    	request.setAttribute("protocols", productService.listProtocol(1));
    	request.setAttribute("contracts", productService.listContract(null, 1, 0, 0));
    	request.setAttribute("guarantees", productService.listGuarantee(1));
    	return "product/add";
	}
    
    @RequestMapping(value=("/treasure/add/{page:\\d+}"), method=RequestMethod.POST)
   	public String forwardToCreation(String productName, String productStatue, Integer auditStatue, Integer size, @PathVariable("page")int page, HttpServletRequest request) {
       	getProductParam(request);
       //	getSearchParam(productName, productStatue, productRisk, productFinancePeriod, getIntValue(productCategoryId),  this.getPageSize(size), this.getPage(page), request);
       	Map<Integer, String> bonus = new LinkedHashMap<Integer, String>();
    	SimpleDateFormat sdf = new SimpleDateFormat(NORMAL_DATE_FORMAT);
		for(Bonus b : bonusService.list(sdf.format(new Date().getTime()),1,1)){
			bonus.put(b.getId(), b.getName());
		}
		request.setAttribute("bonus", bonus);
       	List<ProductCategory> categorys = new ArrayList<ProductCategory>();
    	for(ProductCategory productCategory : productService.list(1)){
    		if(productCategory.getProperty().equals(ProductCategoryPropertyEnum.TREASURE.name())){
    			categorys.add(productCategory);
    		}
    	}
    	request.setAttribute("categorys", categorys);
    	List<Merchant> merchants = new ArrayList<Merchant>();
    	for(Merchant  me: clientService.list(null, 1, 0, 0)){
    		if(me.getStatus() > 0){
    			merchants.add(me);
    		}
    	}
    	request.setAttribute("merchants", merchants);
    	request.setAttribute("contracts", productService.listContract(null, 1, 0, 0));
    	
       	return "product/treasure/add";
   	}
    
    @RequestMapping(value=("/treasure/child/add/{id:\\d+}/{page:\\d+}"), method=RequestMethod.POST)
   	public String forwardToCreation(String productName, String productStatue, Integer auditStatue, Integer size, @PathVariable("id") int id, @PathVariable("page")int page, HttpServletRequest request) {
       	getProductParam(request);
       	Product product = productService.get(id);
    	request.setAttribute("product", product);
    	List<Merchant> merchants = new ArrayList<Merchant>();
    	for(Merchant  me: clientService.list(null, 1, 0, 0)){
    		if(me.getStatus() > 0){
    			merchants.add(me);
    		}
    	}
    	request.setAttribute("merchants", merchants);
    	request.setAttribute("contracts", productService.listContract(null, 1, 0, 0));
       	return "product/treasure/child_add";
   	}
    
    @RequestMapping(value=("/edit/{id:\\d+}/{page:\\d+}"), method=RequestMethod.POST)
	public String forwardToModification(String productName, String productStatue, String productRisk, Integer periodStart, Integer periodEnd, Integer productCategoryId, Integer merchantId, Integer size, @PathVariable("id") int id, @PathVariable("page")int page, HttpServletRequest request) {
    	Product product = productService.get(id);
    	request.setAttribute("product", product);
    	
    	getSearchParam(productName, productStatue, periodStart, periodEnd, productCategoryId,  merchantId, this.getPageSize(size), this.getPage(page), request);
		getProductParam(request); 
		request.setAttribute("directory", properties.getUploadPath());
		request.setAttribute("operation",EDIT);
		List<Merchant> merchants = new ArrayList<Merchant>();
		for(Merchant  me: clientService.list(null, 1, 0, 0)){
    		if(me.getStatus() > 0){
    			merchants.add(me);
    		}
    	}
		List<Project> projects = new ArrayList<Project>();
    	for(Project project : productService.list(0, productService.count())){
    		if(project.getStatus() == 1){
    			projects.add(project);
    		}
    	}
    	int projectType = 0;
    	if(product != null && product.getProductDetail() != null && product.getProductDetail().getProject() != null){
    		projectType = product.getProductDetail().getProject().getType();
    	}
    	List<Lender> lenders = clientService.listLenders(id, projectType);
    	int totleLoanAmount = 0;
    	if(lenders.size() > 0){
    		if (projectType == 2) {
    			request.setAttribute("lender", lenders.get(0));
    		}
    		for(Lender lender : lenders){
    			totleLoanAmount += lender.getLoanAmount();
    		}
    	}
    	request.setAttribute("totleLoanAmount", totleLoanAmount);
    	request.setAttribute("lenders", JSON.toJSON(lenders));
    	request.setAttribute("merchants", merchants);
    	request.setAttribute("projects", projects);
    	request.setAttribute("contracts", productService.listContract(null, 1, 0, 0));
    	request.setAttribute("attachments", JSON.toJSON(productService.listAttachments(id)));
    	request.setAttribute("protocols", productService.listProtocol(1));
    	request.setAttribute("guarantees", productService.listGuarantee(1));
		List<ProductCategory> categorys = new ArrayList<ProductCategory>();
		Map<Integer, String> bonus = new LinkedHashMap<Integer, String>();
    	SimpleDateFormat sdf = new SimpleDateFormat(NORMAL_DATE_FORMAT);
    	for(Bonus b : bonusService.list(sdf.format(new Date().getTime()),1,1)){
			bonus.put(b.getId(), b.getName());
		}
		request.setAttribute("bonus", bonus);
		for(ProductCategory productCategory : productService.list(1)){
    		if(productCategory.getProperty().equals(ProductCategoryPropertyEnum.TREASURE.name())){
    			continue;
    		}
    		if(productCategory.getProperty().equals(ProductCategoryPropertyEnum.EXPERIENCE.name())){
    			continue;
    		}
    		categorys.add(productCategory);
    	}
		request.setAttribute("categorys", categorys);
		request.setAttribute("buttonType",EDIT);
		return "product/edit";
		   
	}
    
    @RequestMapping(value=("/detail/{id:\\d+}/{page:\\d+}"))
   	public String forwardToDetail(String productName, String productStatue, String productRisk, Integer periodStart, Integer periodEnd, Integer productCategoryId, Integer merchantId, Integer size, String registerMsg, @PathVariable("id") int id, @PathVariable("page")int page, HttpServletRequest request) {
    	Product product  = productService.get(id);
    	request.setAttribute("product",product);
       	getSearchParam(productName, productStatue, periodStart, periodEnd, productCategoryId,  merchantId, this.getPageSize(size), this.getPage(page), request);
   		getProductParam(request);
   		int projectType = 0;
    	if(product != null && product.getProductDetail() != null && product.getProductDetail().getProject() != null){
    		projectType = product.getProductDetail().getProject().getType();
    	}
   		List<Lender> lenders = clientService.listLenders(id, projectType);
    	int totleLoanAmount = 0;
    	if(lenders.size() > 0){
    		if (projectType == 2) {
    			request.setAttribute("lender", lenders.get(0));
    		}
    		for(Lender lender : lenders){
    			totleLoanAmount += lender.getLoanAmount();
    		}
    	}
    	request.setAttribute("totleLoanAmount", totleLoanAmount);
    	request.setAttribute("lenders", JSON.toJSON(lenders));
   		request.setAttribute("directory", properties.getUploadPath());
   		request.setAttribute("operation",DETAIL);
    	request.setAttribute("categorys", productService.list(-1));
    	request.setAttribute("contracts", productService.listContract(null, 1, 0, 0));
    	request.setAttribute("attachments", productService.listAttachments(id));
    	request.setAttribute("protocols", productService.listProtocol(1));
    	request.setAttribute("guarantees", productService.listGuarantee(1));
    	Map<Integer, String> bonus = new LinkedHashMap<Integer, String>();
    	SimpleDateFormat sdf = new SimpleDateFormat(NORMAL_DATE_FORMAT);
    	List<Merchant> merchants = new ArrayList<Merchant>();
		for(Merchant  me: clientService.list(null, 1, 0, 0)){
    		if(me.getStatus() > 0){
    			merchants.add(me);
    		}
    	}
		List<Project> projects = new ArrayList<Project>();
    	for(Project project : productService.list(0, productService.count())){
    		if(project.getStatus() == 1){
    			projects.add(project);
    		}
    	}
    	request.setAttribute("merchants", merchants);
    	request.setAttribute("projects", projects);
    	for(Bonus b : bonusService.list(sdf.format(new Date().getTime()),1,-1)){
			bonus.put(b.getId(), b.getName());
		}
		request.setAttribute("bonus", bonus);
		request.setAttribute("registerMsg", StringUtils.isNotBlank(registerMsg) ? registerMsg : "");
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat(NORMAL_DATE_FORMAT);
		List<String> dates = new ArrayList<String>();
		dates.add(dateFormat.format(calendar.getTime()));
		calendar.add(Calendar.DAY_OF_YEAR, 1);
		dates.add(dateFormat.format(calendar.getTime()));
		request.setAttribute("dates", dates);
		
		Calendar currentCalender = Calendar.getInstance();
		currentCalender.add(Calendar.MINUTE, 10);
		SimpleDateFormat datetimeFormat = new SimpleDateFormat(NORMAL_DATETIME_FORMAT);
		String dateStr = datetimeFormat.format(currentCalender.getTime());
		String[] dateInfo = StringUtils.split(dateStr, " ");
		if (dateInfo != null && dateInfo.length == 2) {
			request.setAttribute("choosedDate", dateInfo[0]);
			String[] timeInfo = StringUtils.split(dateInfo[1], ':');
			if (timeInfo != null && timeInfo.length == 3) {
				request.setAttribute("choosedHour", timeInfo[0]);
				request.setAttribute("choosedMinute", timeInfo[1]);
			}
		}
		return "product/edit";
   	}
   
	@RequestMapping("/display/platform")
    @ResponseBody
   	public String changeDisplayPlatform(int productId,int displayPlatformId) {
    	StringBuilder sb = new StringBuilder();  
    	if (productId > 0 && displayPlatformId > 0) {
       		Product product =productService.get(productId);
       		if (product != null && product.getId() > 0 ) {
       			List<String> displayPlatforms = new ArrayList<String>();
       			if(product.getDisplayPlatform() != null){
        			CollectionUtils.addAll(displayPlatforms, StringUtils.split(product.getDisplayPlatform(), ConstantUtil.COMMA));
        			if(displayPlatforms.size() > 0){
        				for(int i = 0; i<displayPlatforms.size(); i++){
        					if(StringUtils.isBlank(displayPlatforms.get(i))){
        						displayPlatforms.remove(i);
        					}
        				}
        			}
        			if(displayPlatforms.size() > 0){
        				int count = 0;
        				for(int i = 0; i<displayPlatforms.size(); i++){
        					
        					if(Integer.parseInt(displayPlatforms.get(i)) == displayPlatformId){
        						displayPlatforms.remove(i);
        						count ++;
        						continue;
        					}
        				}
        				if(count <= 0){
        					displayPlatforms.add(displayPlatformId+ConstantUtil.EMPTY);
        				}
        			}else{
        				displayPlatforms.add(displayPlatformId+ConstantUtil.EMPTY);
        			}
       			}else{
       				displayPlatforms.add(displayPlatformId+ConstantUtil.EMPTY);
       			}
    			if(displayPlatforms.size() >= 0){
    				
    				for(int i = 0; i < displayPlatforms.size(); i ++){
    					if(i < (displayPlatforms.size() - 1)){
    						sb.append(displayPlatforms.get(i));
    						sb.append(ConstantUtil.COMMA);
    					}else{
    						sb.append(displayPlatforms.get(i));
    					}
    					
    				}
    				productService.updateDisplayPlatform(productId, sb.toString());
    			}
       		}
       		return product.getId() + ConstantUtil.COMMA + sb.toString();
       	}
    	return ConstantUtil.EMPTY;
   	}
    
    @RequestMapping(value="/attachment/delete/{attachmentId:\\d+}", method=RequestMethod.POST)
    @ResponseBody
   	public boolean deleteImage(String attachmentUrl, @PathVariable("attachmentId")int attachmentId, HttpServletRequest request) {
    	if (attachmentId > 0) {
    		if(productService.removeAttachment(attachmentId)){
    			if(StringUtils.isNotEmpty(attachmentUrl)) {
    				File file = new File(getResourcePath(request)+attachmentUrl);
    				FileUtils.deleteQuietly(file);
    				return true;
    			}
    		}
    	}
    	return false;
   	}
    
    @RequestMapping(value="/check/name", method=RequestMethod.GET)
    @ResponseBody
    public String checkName(String fieldId, String fieldValue,int id){
    	if (StringUtils.isNotBlank(fieldId) && StringUtils.isNotBlank(fieldValue)) {
    		ArrayObjectEntity json = new ArrayObjectEntity();
    		int count = productService.count(StringUtils.trim(fieldValue));
    		if(id <= 0){
    			if(count >= 1){
    				json.setObject(fieldId);
    				json.setSuccess(false);
    				json.setMessage(properties.getAppNameNoPass());
    			}else{
    				json.setObject(fieldId);
    				json.setSuccess(true);
    				json.setMessage(properties.getAppNamePass());
    			}
    		}else{
    			if(count > 1){
    				json.setObject(fieldId);
					json.setSuccess(false);
					json.setMessage(properties.getAppNameNoPass());
    			}else{
    				if(count == 1){
    					Product product  = productService.get(id);
        				if(product.getName().equals(StringUtils.trim(fieldValue))){
        					json.setObject(fieldId);
        					json.setSuccess(true);
        					json.setMessage(properties.getAppNamePass());
        				}else{
        					json.setObject(fieldId);
        					json.setSuccess(false);
        					json.setMessage(properties.getAppNameNoPass());
        				}
    				}else{
    					json.setObject(fieldId);
    					json.setSuccess(true);
    					json.setMessage(properties.getAppNamePass());
    				}
    				
    			}
    		}
    		return json.toString();
    	}
    	return null;
    }
    
    @RequestMapping(value="/contract/duplicate/name", method=RequestMethod.GET)
	@ResponseBody
	public String duplicateContractName(String fieldId, String fieldValue, int id) {
		if (id >= 0 && StringUtils.isNotBlank(fieldId) && StringUtils.isNotBlank(fieldValue)) {
			ArrayObjectEntity json = new ArrayObjectEntity();
			if (productService.duplicateContract(id, fieldValue)) {
				json.setObject(fieldId);
				json.setSuccess(true);
				json.setMessage(messageSource.getMessage("contract.leisure", null, Locale.getDefault())); 
			} else {
				json.setObject(fieldId);
				json.setSuccess(false);
				json.setMessage(messageSource.getMessage("contract.occupy", null, Locale.getDefault())); 
			}
			return json.toString(); 
		}
		return null;
	}
    
    @RequestMapping(value="/protocol/duplicate/name", method=RequestMethod.GET)
	@ResponseBody
	public String duplicateProtocolName(String fieldId, String fieldValue, int id) {
		if (id >= 0 && StringUtils.isNotBlank(fieldId) && StringUtils.isNotBlank(fieldValue)) {
			ArrayObjectEntity json = new ArrayObjectEntity();
			if (productService.duplicateProtocol(id, fieldValue)) {
				json.setObject(fieldId);
				json.setSuccess(true);
				json.setMessage(messageSource.getMessage("contract.leisure", null, Locale.getDefault())); 
			} else {
				json.setObject(fieldId);
				json.setSuccess(false);
				json.setMessage(messageSource.getMessage("contract.occupy", null, Locale.getDefault())); 
			}
			return json.toString(); 
		}
		return null;
	}
    
    @RequestMapping("/audit/{type}/{id:\\d+}/{status}/{page:\\d+}")
 	public String audit(String productName, String productStatue, String productRisk, Integer periodStart, Integer periodEnd, Integer productCategoryId, Integer merchantId, Integer size, Date shippedTime, @PathVariable("type")String type, @PathVariable("page")int page, @PathVariable("id") int id, @PathVariable("status") String status, HttpServletRequest request, RedirectAttributesModelMap redirectAttributesMap) {
     	if (id > 0) {
     		Product product =productService.get(id);
     		if (product != null && product.getId() > 0) {
     			product = productParams(product, shippedTime, status, type);
     			productService.auditProduct(product, null, null);
     			changesort();
     		}
     	}
     	setRedirectAttributes(productName, productStatue, periodStart, periodEnd, productCategoryId, merchantId, EDIT, redirectAttributesMap);
     	return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/product/"+ this.getPage(page); 
 	}
    
    @RequestMapping("/{id:\\d+}/{status}/{page:\\d+}")
	public String changeStatus(String productName, String productStatue, String productRisk, Integer periodStart, Integer periodEnd, Integer productCategoryId, Integer merchantId, Integer size, Date shippedTime, @PathVariable("page")int page, @PathVariable("id") int id, @PathVariable("status") String status, HttpServletRequest request, RedirectAttributesModelMap redirectAttributesMap) {
    	if (id > 0) {
    		Product product =productService.get(id);
    		if (product != null && product.getId() > 0) {
    			product = productParams(product, shippedTime, status, null);
    			productService.fullScale(product, null, null);
    		}
    	}
    	setRedirectAttributes(productName, productStatue, periodStart, periodEnd, productCategoryId, merchantId, EDIT, redirectAttributesMap);
    	return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/product/"+ this.getPage(page); 
	}
    
    @RequestMapping(value="/guarantee/duplicate/name", method=RequestMethod.GET)
	@ResponseBody
	public String duplicateGuaranteeName(String fieldId, String fieldValue, int id) {
		if (id >= 0 && StringUtils.isNotBlank(fieldId) && StringUtils.isNotBlank(fieldValue)) {
			ArrayObjectEntity json = new ArrayObjectEntity();
			if (productService.duplicateGuarantee(id, fieldValue)) {
				json.setObject(fieldId);
				json.setSuccess(true);
				json.setMessage(messageSource.getMessage("contract.leisure", null, Locale.getDefault())); 
			} else {
				json.setObject(fieldId);
				json.setSuccess(false);
				json.setMessage(messageSource.getMessage("contract.occupy", null, Locale.getDefault())); 
			}
			return json.toString(); 
		}
		return null;
	}
    
    @RequestMapping(value="/check/status", method=RequestMethod.GET)
    @ResponseBody
    public boolean checkProductProperty(int id, int initStatus){
    	if(id > 0){
    		Product product = productService.get(id);
    		if(product != null){
    			if(product.getCategory() != null){
    				if(product.getCategory().getProperty().equals(ProductCategoryPropertyEnum.NOVICE.name()) || product.getCategory().getProperty().equals(ProductCategoryPropertyEnum.EXPERIENCE.name())){
    					if(initStatus == product.getStatus()){
    						return true;
    					}else if(product.getStatus() == 1 && product.getTotalAmount() <= product.getActualAmount() && initStatus == product.getStatus()){
    						return true;
    					}
    				}else{
    					if(product.getStatus() != 1 && initStatus == product.getStatus()){
            				return true;
            			}
    				}
    			}else{
    				return false;
    			}
    		}
    	}
    	return false;
    }
    
    @RequestMapping(value="/check/property", method=RequestMethod.GET)
    @ResponseBody
    public boolean checkProductProperty(String property){
    	if(property != null){
    		return productService.countByCategoryProperty(property) > 0 ? false : true;
    	}
    	return false;
    }
    
    @RequestMapping(value="/change/sort", method=RequestMethod.POST)
   	@ResponseBody
   	public boolean changeProductSort(String ids, String sorts) {
    	List<String> productIds = new LinkedList<String>();
		List<String> productSorts = new LinkedList<String>();
    	if(StringUtils.isNotBlank(ids) && StringUtils.isNotBlank(sorts)){
    		CollectionUtils.addAll(productIds, ids.split(COMMA));
    		CollectionUtils.addAll(productSorts, sorts.split(COMMA));
    	}
    	List<Product> products = new ArrayList<Product>();
    	if(productIds.size() > 0 && productSorts.size() > 0 && productIds.size() == productSorts.size()){
    		List<Integer> ps = JSON.parseArray(productSorts.toString(), Integer.class);
    		Collections.sort(ps);
    		Collections.reverse(ps);
    		for(int i =0; i < productIds.size(); i++){
    			Product product = new Product();
    			product.setId(Integer.parseInt(productIds.get(i)));
    			product.setSortNumber(ps.get(i));
    			products.add(product);
    		}
    	}
    	return productService.changeSort(products);
   	}
    
    @RequestMapping(value="/register", method=RequestMethod.POST)
    @ResponseBody
    public JSONObject productRegister(int productId) {
    	JSONObject result = new JSONObject(); 
    	if(productId > 0){
	    	Product product =productService.get(productId);
	    	
	    	List<NameValuePair> nvps = new ArrayList<NameValuePair>();
			nvps.add(new BasicNameValuePair("version", messageSource.getMessage("bank.version", null, null)));
			nvps.add(new BasicNameValuePair("txCode", "debtRegister"));
			nvps.add(new BasicNameValuePair("instCode", messageSource.getMessage("bank.instCode", null, null)));
			nvps.add(new BasicNameValuePair("bankCode", messageSource.getMessage("bank.bankCode", null, null)));
			Calendar calendar = Calendar.getInstance();
			SimpleDateFormat dateFormat = new SimpleDateFormat(ConstantUtil.NUMBER_DATE_FORMAT);
			SimpleDateFormat timeFormat = new SimpleDateFormat(ConstantUtil.NUMBER_TIME_FORMAT);
			nvps.add(new BasicNameValuePair("txDate", dateFormat.format(calendar.getTime())));
			nvps.add(new BasicNameValuePair("txTime", timeFormat.format(calendar.getTime())));
			nvps.add(new BasicNameValuePair("seqNo", timeFormat.format(calendar.getTime())));
			nvps.add(new BasicNameValuePair("channel", "000002"));
			Merchant merchant = clientService.getMerchant(product.getMerchant() != null ? product.getMerchant().getId():0);
			if(product.getProductDetail() != null && product.getProductDetail().getProject() != null && product.getProductDetail().getProject().getType() > 0){
				if(product.getProductDetail().getProject().getMerchant() != null && product.getProductDetail().getProject().getMerchant().getId() > 0){
					merchant = clientService.getMerchant(product.getProductDetail().getProject().getMerchant().getId());
				}
			}
			nvps.add(new BasicNameValuePair("accountId", merchant != null && merchant.getAccountId() != null ? merchant.getAccountId() : "6212461270000261202"));
			nvps.add(new BasicNameValuePair("productId", product.getId().toString()));
			nvps.add(new BasicNameValuePair("productDesc", product.getName()));
			nvps.add(new BasicNameValuePair("raiseDate", dateFormat.format(product.getShippedTime())));
			Calendar cal = Calendar.getInstance();
			cal.setTime(product.getShippedTime());
			cal.add(Calendar.DAY_OF_YEAR, product.getRaisePeriod());
			nvps.add(new BasicNameValuePair("raiseEndDate", dateFormat.format(cal.getTime())));
			nvps.add(new BasicNameValuePair("intType", "0"));
			nvps.add(new BasicNameValuePair("duration", product.getFinancePeriod().toString()));
			nvps.add(new BasicNameValuePair("txAmount", String.valueOf(product.getTotalAmount())));
			nvps.add(new BasicNameValuePair("rate", String.valueOf(product.getYearIncome())));
			LOGGER.info("product register params : "+JSON.toJSONString(nvps));
			String data = execute(properties.getPluginUrl()+"/product/register", nvps, ConstantUtil.UTF_8);
			result = JSON.parseObject(data);
			LOGGER.info("product register result : "+JSON.toJSONString(data));
    	}
    	return result;
	}
    
    @RequestMapping(value="/merchant/loan/payment", method=RequestMethod.POST)
	@ResponseBody
	public boolean payment(Integer id, Integer flag, HttpServletRequest request) {
		if (id != null && id > 0) {
			Product product = productService.get(id);
			if (product == null || product.getMerchant() == null) {
				return false;
			}
			if (product.getActualAmount() < product.getTotalAmount()) {
				return false;
			}
			MerchantOrder handleOrder = tradeService.getMerchantOrder(id, "", 1, 1);
			if (handleOrder != null) {
				return false;
			}
			MerchantOrder successtOrder = tradeService.getMerchantOrder(id, "", 1, 2);
			if (successtOrder != null) {
				return false;
			}
			Merchant merchant = clientService.getMerchant(product.getMerchant().getId());
			List<LoanEntity> list = tradeService.listLoan(id);
			if (merchant != null && list != null && list.size() > 0) {
				double txAmount = 0;
				double paymentAmount = 0;
				for (LoanEntity entity : list) {
					paymentAmount += entity.getTxAmount()+(Math.round(entity.getTxAmount()*product.getYearIncome()/365*product.getFinancePeriod())/100.0+Math.round(entity.getTxAmount()*product.getLoanYearIncome()/365*product.getFinancePeriod())/100.0);
					txAmount += entity.getTxAmount();
					entity.setOrderId("LOAN"+entity.getOrderId());
				}
				List<NameValuePair> nvps = new ArrayList<NameValuePair>();
				nvps.add(new BasicNameValuePair("version", messageSource.getMessage("bank.version", null, null)));
				nvps.add(new BasicNameValuePair("txCode", "batchLendPay"));
				nvps.add(new BasicNameValuePair("instCode", messageSource.getMessage("bank.instCode", null, null)));
				nvps.add(new BasicNameValuePair("bankCode", messageSource.getMessage("bank.bankCode", null, null)));
				Calendar calendar = Calendar.getInstance();
				SimpleDateFormat dateFormat = new SimpleDateFormat(ConstantUtil.NUMBER_DATE_FORMAT);
				SimpleDateFormat timeFormat = new SimpleDateFormat(ConstantUtil.NUMBER_TIME_FORMAT);
				String txDate = dateFormat.format(calendar.getTime());
				String txTime = timeFormat.format(calendar.getTime());
				String seqNo = timeFormat.format(calendar.getTime());
				String orderNO = OrderNOPrefixEnum.SILVERFOX_MERCHANT.toString()+txDate+txTime+seqNo;
				String acqRes = orderNO + COLON + id + COLON + merchant.getCellphone();
				nvps.add(new BasicNameValuePair("txDate", dateFormat.format(calendar.getTime())));
				nvps.add(new BasicNameValuePair("txTime", timeFormat.format(calendar.getTime())));
				nvps.add(new BasicNameValuePair("seqNo", timeFormat.format(calendar.getTime())));
				nvps.add(new BasicNameValuePair("channel", "000002"));
				nvps.add(new BasicNameValuePair("batchNo", timeFormat.format(calendar.getTime())));
				nvps.add(new BasicNameValuePair("txAmount", String.valueOf(txAmount)));
				nvps.add(new BasicNameValuePair("txCounts", String.valueOf(list.size())));
				nvps.add(new BasicNameValuePair("notifyURL", properties.getCustomersServiceUrl() + messageSource.getMessage("loan.validation.notify", null, null)));
				nvps.add(new BasicNameValuePair("retNotifyURL", properties.getCustomersServiceUrl() + messageSource.getMessage("loan.service.notify", null, null)));
				nvps.add(new BasicNameValuePair("acqRes", acqRes));
				nvps.add(new BasicNameValuePair("subPacks", JSON.toJSONString(list)));
				LOGGER.info("merchant loan payment params : "+JSON.toJSONString(nvps));
				String data = execute(properties.getPluginUrl()+messageSource.getMessage("loan.url", null, null), nvps, ConstantUtil.UTF_8);
				LOGGER.info("merchant loan payment result : "+data);
				if (StringUtils.isNotBlank(data)) {
					JSONObject result = JSON.parseObject(data);
					if (result != null && result.containsKey("received") && StringUtils.equals(result.getString("received"), "success")) {
						/*List<Signature> signatures = tradeService.getSignatureList(id);
						if (signatures == null || signatures.size() == 0) {
							List<EsignEntity> entities = tradeService.list(id);
							if (entities != null) {
								ProductDetail detail = productService.getProductDetail(product.getId());
								int type = 0;
								if (detail != null && detail.getProject() != null) {
									type = detail.getProject().getType();
								}
								if (type != 0) {
									List<Lender> lenders = clientService.listLenders(product.getId());
									if (lenders != null && lenders.size() > 0) {
										if (type == 1) { 
											for(EsignEntity entity : entities){
												String name = "";
												String idcard = "";
												int amount = entity.getPrincipal();
												for(Lender lender : lenders){
													if(lender.getLoanAmount() > 0){
														name += lender.getName() + COMMA;
														idcard += lender.getIdcard() + COMMA;
														if(amount <= lender.getLoanAmount()){
															lender.setLoanAmount(lender.getLoanAmount()-amount);
															amount = 0;
															break;
														}else{
															amount = amount-lender.getLoanAmount();
															lender.setLoanAmount(0);
														}
													}
												}
												name = StringUtils.isBlank(name) ? "" : StringUtils.substring(name, 0, StringUtils.length(name)-1);
												idcard = StringUtils.isBlank(idcard) ? "" : StringUtils.substring(idcard, 0, StringUtils.length(idcard)-1);
												entity.setMerchantName(name);
												entity.setMerchantNO(idcard);
												entity.setProductType(type);
												int index = entities.indexOf(entity);
												entity.setContractNO(entity.getProductName()+"-"+StringUtils.leftPad(String.valueOf((index+1)), 4, '0'));
											}
										} else {
											String name = lenders.get(0).getName();
											String idcard = lenders.get(0).getIdcard();
											for (EsignEntity entity : entities) {
												entity.setMerchantName(name);
												entity.setMerchantNO(idcard);
												entity.setProductType(type);
												int index = entities.indexOf(entity);
												entity.setContractNO(entity.getProductName()+"-"+StringUtils.leftPad(String.valueOf((index+1)), 4, '0'));
											}
										}
										Thread deamon = new Thread(new Esign(entities, tradeService, type));
										deamon.setDaemon(false);
										deamon.start();
									}
								} else {
									Thread deamon = new Thread(new Esign(entities, tradeService, type));
									deamon.setDaemon(true);
									deamon.start();
								}
							}
						}*/
						return tradeService.saveOrderForMerchant(product, product.getMerchant(), orderNO, txAmount, paymentAmount);
					}
				}
			}
		}
		return false;
	}

    private HttpServletRequest getSearchParam(String productName, String productStatue,Integer periodStart, Integer periodEnd, Integer productCategoryId, Integer merchantId, Integer size, int page, HttpServletRequest request){
    	SimpleDateFormat sdf = new SimpleDateFormat(NORMAL_DATETIME_FORMAT);
    	try {
			request.setAttribute("systemTime", sdf.format(new Date()));
		} catch (Exception e) {
			LOGGER.error(e);;
		}
    	request.setAttribute("size", this.getPageSize(size));
		request.setAttribute("page",this.getPage(page));
    	request.setAttribute("productName", productName);
    	request.setAttribute("productStatue", productStatue);
    	request.setAttribute("productCategoryId", productCategoryId);
    	request.setAttribute("merchantId", merchantId);
    	request.setAttribute("periodStart", periodStart);
    	request.setAttribute("periodEnd", periodEnd);
		return request;
    }
    
    private RedirectAttributesModelMap setRedirectAttributes(String productName, String productStatue, Integer periodStart, Integer periodEnd, Integer productCategoryId, Integer merchantId, String operation, RedirectAttributesModelMap redirectAttributesmap) {
    	if(operation.equals(EDIT) || operation.equals(DETAIL)){
    		if(StringUtils.isNotBlank(productName)){
        		redirectAttributesmap.addAttribute("productName", productName);
        	}
        	if(StringUtils.isNotBlank(productStatue)){
        		redirectAttributesmap.addAttribute("productStatue", productStatue);
        	}
        	
        	if(periodStart != null && periodStart > 0){
        		redirectAttributesmap.addAttribute("periodStart", periodStart);
        	}
        	if(periodEnd != null && periodEnd > 0){
        		redirectAttributesmap.addAttribute("periodEnd", periodEnd);
        	}
        	if(productCategoryId != null && productCategoryId > 0){
        		redirectAttributesmap.addAttribute("productCategoryId", productCategoryId);
        	}
        	if(merchantId != null && merchantId > 0){
        		redirectAttributesmap.addAttribute("merchantId", merchantId);
        	}
    	}else{
    		redirectAttributesmap.addAttribute("productName", EMPTY);
    		redirectAttributesmap.addAttribute("productStatue", EMPTY);
    		redirectAttributesmap.addAttribute("periodStart", EMPTY);
    		redirectAttributesmap.addAttribute("periodEnd", EMPTY);
    		redirectAttributesmap.addAttribute("productCategoryId", EMPTY);
    		redirectAttributesmap.addAttribute("merchantId", EMPTY);
    	}
    	return redirectAttributesmap;
	}
    
    private HttpServletRequest getProductParam(HttpServletRequest request){		
    	/*Map<Integer, String> rebates = new LinkedHashMap<Integer, String>();
		for(Rebate rebate : rebateService.list(sdf.format(new Date().getTime()),1,1)){
			rebates.put(rebate.getId(), rebate.getName());
		}
	
		request.setAttribute("rebates", rebates);*/
		
		Map<String, String> periods = new LinkedHashMap<String, String>();
		for(ProductPeriodEnum period : ProductPeriodEnum.values()){
			if(!period.name().equals("SFF")){
				periods.put(period.name(), period.toString());
			}
		}
	
		request.setAttribute("periods", periods);
		
		/*List<ProductParam> params = new ArrayList<ProductParam>();
		params = productService.listParam();*/
		Map<Integer, String> risks = new LinkedHashMap<Integer, String>();
		Map<Integer, String>  lowestMoneys= new LinkedHashMap<Integer, String>();
		/*Map<Integer, String>  refunds= new LinkedHashMap<Integer, String>();*/
		Map<String, String> statused = new LinkedHashMap<String, String>();
		Map<String, String> auditStatused = new LinkedHashMap<String, String>();
		Map<Integer, String> displayPlatforms = new LinkedHashMap<Integer, String>();
    	/*for(ProductParam param:params){
    		if(param.getCategory().equals(ProductParamCategoryEnum.RISK.name())){
    			risks.put(param.getId(), param.getName());
    		}
    		if(param.getCategory().equals(ProductParamCategoryEnum.LOWESTMONEY.name())){
    			lowestMoneys.put(param.getId(), param.getName());
    		}
    		if(param.getCategory().equals(ProductParamCategoryEnum.REFUND.name())){
    			refunds.put(param.getId(), param.getName());
    		}
    	}*/
    	
    	for(ProductStatusEnum statu : ProductStatusEnum.values()){
    		statused.put(statu.name(), statu.toString());
    	}
    	
    	for(GenericAuditStatusEnum statu : GenericAuditStatusEnum.values()){
    		auditStatused.put(String.valueOf(statu.getValue()), statu.getMsg());
    	}
    	
    	for(PlatformEnum platformEnum : PlatformEnum.values()){
    		displayPlatforms.put(platformEnum.value(), platformEnum.name());
    	}
    	request.setAttribute("statused",statused);
    	request.setAttribute("auditStatused",auditStatused);
    	request.setAttribute("displayPlatforms",displayPlatforms);
    	request.setAttribute("risks",risks);
    	request.setAttribute("lowestMoneys",lowestMoneys);
    	/*request.setAttribute("refunds",refunds);*/
		return  request;
    }
    
    private int getIntValue(Integer value){
    	if(value == null ){
    		value =0;
    	}
    	return value;
    }
    
    private String execute(String uri, List<NameValuePair> nvps, String encoding) {
		CloseableHttpClient closeableHttpClient = HttpClients.createDefault();
		HttpPost httpPost = new HttpPost(uri);
		RequestConfig requestConfig = RequestConfig.custom()  
		        .setConnectTimeout(30000).setConnectionRequestTimeout(10000)  
		        .setSocketTimeout(30000).build();  
		httpPost.setConfig(requestConfig);  
		try {
			if(nvps != null && nvps.size() > 0) {
				httpPost.setEntity(new UrlEncodedFormEntity(nvps, encoding));
			}
			CloseableHttpResponse httpResponse = closeableHttpClient.execute(httpPost);
			int statusCode = httpResponse.getStatusLine().getStatusCode();
			if(statusCode == 200) {
				return EntityUtils.toString(httpResponse.getEntity(), encoding);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			httpPost.releaseConnection();
		}
		return null;
	}
     
    @RequestMapping(value="/auto/produce/product/name", method=RequestMethod.POST)
    @ResponseBody
    public JSONObject produceProductName(int merchantIdData,int projectIdData,int financePeriodData) {
    	JSONObject result = new JSONObject(); 
    	Project project = productService.getProjectData(projectIdData);
    	Merchant merchant = clientService.getMerchantData(merchantIdData);
    	int loanCount = productService.getMerchantLoanCount(merchantIdData);
    	String licenseNum = "";
    	String financialPeriodNum ="";
    	String productName ="";
	    if(merchant != null){
	    	if(StringUtils.isNotBlank(merchant.getLicenseNO()) && merchant.getLicenseNO().length() >=6){
	    		 licenseNum = merchant.getLicenseNO().substring(merchant.getLicenseNO().length()-6);
	    	}
	    }
    	if(financePeriodData < 30){
    		financialPeriodNum = "A0";
    	}else if(30 <= financePeriodData && financePeriodData <=34){
    		financialPeriodNum = "A1";
    	}else if(35 <= financePeriodData && financePeriodData <=44){
    		financialPeriodNum = "A2";
    	}else if(45 <= financePeriodData && financePeriodData <=59){
    		financialPeriodNum = "A3";
    	}else if(60 <= financePeriodData && financePeriodData <=64){
    		financialPeriodNum = "B1";
    	}else if(65 <= financePeriodData && financePeriodData <=67){
    		financialPeriodNum = "B2";
    	}else if(68 <= financePeriodData && financePeriodData <=87){
    		financialPeriodNum = "B3";
    	}else if(88 <= financePeriodData && financePeriodData <=98){
    		financialPeriodNum = "C1";
    	}else if(99 <= financePeriodData && financePeriodData <=119){
    		financialPeriodNum = "C2";
    	}else if(120 <= financePeriodData && financePeriodData <=179){
    		financialPeriodNum = "C3";
    	}else if(180 <= financePeriodData && financePeriodData <=269){
    		financialPeriodNum = "C4";
    	}else if(270 <= financePeriodData && financePeriodData <=299){
    		financialPeriodNum = "D1";
    	}else if(300 <= financePeriodData && financePeriodData <=359){
    		financialPeriodNum = "D2";
    	}else if(360 <= financePeriodData && financePeriodData <=366){
    		financialPeriodNum = "D3";
    	}else if(367 <= financePeriodData && financePeriodData <=719){
    		financialPeriodNum = "E1";
    	}else if( financePeriodData >= 720){
    		financialPeriodNum = "E2";
    	}
    	if(project.getType() == 0){
    		productName = project.getName()+financialPeriodNum+licenseNum+String.format("%02d", loanCount);               
    	}else if(project.getType() == 1){
    		 Calendar calendar=Calendar.getInstance();
    	     calendar.setTime(new Date());
    	     String year=String.valueOf(calendar.get(Calendar.YEAR));
    	     String subYear = year.substring(2);
   	     int total = productService.getTotalNumberMark();
   	     String totalCount = String.valueOf(total);
   	     if(totalCount.length() <= 4){
   	    	 String productTempName = project.getName()+financialPeriodNum+","+subYear+String.format("%04d", total); 
   	    	 productName = project.getName()+financialPeriodNum+subYear+String.format("%04d", total); 
   	    	result.put("productTempName", productTempName);
   	     }else {
   	    	String totals = totalCount.substring(totalCount.length()-4);
   	    	String productTempName = project.getName()+financialPeriodNum+","+subYear+totals;
   	        productName = project.getName()+financialPeriodNum+subYear+String.format("%04d", total); 
   	        result.put("productTempName", productTempName);
   	     }
    	}else if(project.getType() == 2){
    		productName = project.getName()+financialPeriodNum;
    	}
    	result.put("name", productName);
    	result.put("type",project.getType());
    	return result;
	} 
    
    private Product productParams(Product product, Date shippedTime, String status, String type){
    	if(StringUtils.equalsIgnoreCase(ProductRecommendationEnum.RECOMMEND.name(), status)) {
			product.setStatus(product.getStatus());
		} else if(StringUtils.equalsIgnoreCase(ProductRecommendationEnum.CANCELED.name(), status)) {
			product.setStatus(product.getStatus());
		} else if(StringUtils.equalsIgnoreCase(GenericStatusEnum.ENABLE.name(), status)) {
			if(shippedTime != null && !type.equalsIgnoreCase(GenericStatusEnum.ENABLE.name())){
				product.setShippedTime(shippedTime);
			}
			product.setStatus(GenericStatusEnum.ENABLE.value());
		} else if(StringUtils.equalsIgnoreCase(GenericStatusEnum.DISABLED.name(), status)) {
			product.setStatus(GenericStatusEnum.DISABLED.value());
		} else if(StringUtils.equalsIgnoreCase(ProductStatusEnum.SOLDOUT.name(), status)){
			product.setTotalAmount(product.getActualAmount());
			product.setSortNumber(product.getId());
			product.setSoldOutTime(Calendar.getInstance().getTime());
			SimpleDateFormat dateFormat = new SimpleDateFormat(NORMAL_DATE_FORMAT);
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DAY_OF_YEAR, 1);
			if (product.getInterestType() == 1) {
				product.setInterestDate(dateFormat.format(calendar.getTime()));
			}
			product.setStatus(product.getStatus());
		}
    	return product;
    }
  
    @RequestMapping(value="/reaudit", method=RequestMethod.POST)
    @ResponseBody
    public boolean reaudit(Integer productId,Date shippedTime,String status) throws Exception{
    	if (productId > 0) {
    		Product product =productService.get(productId);
     		if (product != null && product.getId() > 0) {
     			if(StringUtils.equalsIgnoreCase(GenericStatusEnum.DISABLED.name(), status)){
     				product.setShippedTime(shippedTime);
     			}
     			productService.auditProduct(product, null, null);
     			changesort();
     			return true;
     		}
     		return false;
     	}
    	return false;
 
    }

    private boolean changesort() {
     	List<Product> productList = productService.getIntheSaleList();
     	List<Integer> productIds = new LinkedList<Integer>();
		List<Integer> productSorts = new LinkedList<Integer>();
		for (Product product : productList){
			productIds.add(product.getId());
			productSorts.add(product.getSortNumber());
		}
    	List<Product> products = new ArrayList<Product>();
    	if(productIds.size() > 0 && productSorts.size() > 0 && productIds.size() == productSorts.size()){
    		List<Integer> ps = JSON.parseArray(productSorts.toString(), Integer.class);
    		Collections.sort(ps);
    		Collections.reverse(ps);
    		for(int i =0; i < productIds.size(); i++){
    			Product product = new Product();
    			product.setId(productIds.get(i));
    			product.setSortNumber(ps.get(i));
    			products.add(product);
    		}
    	}
    	return productService.changeSort(products);
	}

	@RequestMapping(value="/recall/{id:\\d+}", method=RequestMethod.GET)
    @ResponseBody
    public JSONObject recallProduct(@PathVariable("id") int id){
    	  JSONObject result = new JSONObject(); 
    	  boolean flag =  productService.changeProductStatus(id);
    	  result.put("status",flag);
          return result;
    }
    
    private boolean getAddFunctionPermit(HttpServletRequest request) {
    	boolean flag = false;
    	final int addResourceId = 131;
    	SecurityEntity security = (SecurityEntity) request.getSession().getAttribute(ConstantUtil.SESSION_KEY);
    	if (security != null) {
    		Role role = security.getRole();
    		List<RoleResource> roleResources = clientService.listRoleResource(role.getId());
    		if (roleResources !=null && roleResources.size()>0) {
    			for (RoleResource roleResource : roleResources) {
    				if (addResourceId == roleResource.getResourceId()) {
    					flag = true;
    					break;
    				}
    			}
    		}
    	}
		return flag;
	}

}