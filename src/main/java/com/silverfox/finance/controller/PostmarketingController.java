package com.silverfox.finance.controller;

import static com.silverfox.finance.util.ConstantUtil.BACK_SLASH;
import static com.silverfox.finance.util.ConstantUtil.COMMA;
import static com.silverfox.finance.util.ConstantUtil.PAGE_SIZE;
import static com.silverfox.finance.util.ConstantUtil.SLASH;
import static com.silverfox.finance.util.ConstantUtil.UTF_8;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.silverfox.finance.domain.CellphoneLog;
import com.silverfox.finance.domain.EBankLog;
import com.silverfox.finance.domain.Faq;
import com.silverfox.finance.domain.Feedback;
import com.silverfox.finance.domain.NewsBulletin;
import com.silverfox.finance.domain.PayBank;
import com.silverfox.finance.domain.PushMessage;
import com.silverfox.finance.domain.User;
import com.silverfox.finance.entity.ArrayObjectEntity;
import com.silverfox.finance.entity.LostUserEntity;
import com.silverfox.finance.entity.UninvestEntity;
import com.silverfox.finance.entity.UserEntity;
import com.silverfox.finance.enumeration.GenericEnableEnum;
import com.silverfox.finance.enumeration.PayChannelEnum;
import com.silverfox.finance.enumeration.AddFunctionPermitEnum;
import com.silverfox.finance.service.PostmarketingService;
import com.silverfox.finance.util.ExcelUtil;
import com.silverfox.finance.util.LogRecord;

@Controller
@RequestMapping("/")
public class PostmarketingController extends BaseController {
	@Autowired
	private PostmarketingService postmarketingService;
	
	@RequestMapping("faq/list")
    public String list(HttpServletRequest request){
		List<Faq> list = postmarketingService.listFaq();
		if(list.size() > 0){
			request.setAttribute("faqs",list);
		}else{
			request.setAttribute("faqs", new Faq[0]);
		}
    	return "faq/list";
    }
	
	@RequestMapping("faq/add")
	public String addFaq() {
		return "faq/add";
	}
	
	@RequestMapping(value="faq/duplicate/name", method=RequestMethod.GET)
	@ResponseBody
	public String duplicateFaqName(String fieldId, String fieldValue, int id) {
		if (id >= 0 && StringUtils.isNotBlank(fieldId) && StringUtils.isNotBlank(fieldValue)) {
			ArrayObjectEntity json = new ArrayObjectEntity();
			if (postmarketingService.duplicateName(id, fieldValue)) {
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
	
	@RequestMapping(value="faq/save", method=RequestMethod.POST)
	public String  saveFaq(@Valid Faq faq, BindingResult result, HttpServletRequest request)throws IOException{
		if (!result.hasErrors()) {
			postmarketingService.saveFaq(faq);
		}
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/faq/list";
    }
	
	@RequestMapping("faq/edit/{id:\\d+}")
	public String edit(@PathVariable("id") int id, HttpServletRequest request){
		request.setAttribute("faq", postmarketingService.getFaq(id));
		request.setAttribute("operation",EDIT);
		return "faq/edit";
	}
	
	@RequestMapping("faq/detail/{id:\\d+}")
	public String detail(@PathVariable("id") int id, HttpServletRequest request){
		request.setAttribute("faq", postmarketingService.getFaq(id));
		request.setAttribute("operation",DETAIL);
		return "faq/edit";
	}
	
	@RequestMapping("faq/delete/{id:\\d+}")
	public String delete(@PathVariable("id") int id, HttpServletRequest request){
		if(id > 0){
			Faq faq = postmarketingService.getFaq(id);
			if (faq != null && faq.getId() > 0) {
				postmarketingService.deleteFaq(id);
			}
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/faq/list";
	}
	
	@RequestMapping("faq/{id:\\d+}/{status}")
	public String changeStatus(@PathVariable("id") int id, @PathVariable("status") String status, HttpServletRequest request) {
    	if(id > 0){
    		Faq faq = postmarketingService.getFaq(id);
    		if(faq != null && faq.getId() > 0){
    			if(status.equalsIgnoreCase(GenericEnableEnum.ENABLE.name())){
    				faq.setEnable(GenericEnableEnum.ENABLE.value());
    			}else if(status.equalsIgnoreCase(GenericEnableEnum.DISABLED.name())){
    				faq.setEnable(GenericEnableEnum.DISABLED.value());
    			}
    			postmarketingService.saveFaqs(faq);
    		}
    	}
   		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/faq/list";
	}
	
	@RequestMapping(value="faq/change/sort", method=RequestMethod.POST)
   	@ResponseBody
   	public boolean changeFaqSort(String ids, String sorts) {
    	List<String> faqIds = new LinkedList<String>();
		List<String> faqSorts = new LinkedList<String>();
    	if(StringUtils.isNotBlank(ids) && StringUtils.isNotBlank(sorts)){
    		CollectionUtils.addAll(faqIds, ids.split(COMMA));
    		CollectionUtils.addAll(faqSorts, sorts.split(COMMA));
    	}
    	List<Faq> faqs = new ArrayList<Faq>();
    	if(faqIds.size() > 0 && faqSorts.size() > 0 && faqIds.size() == faqSorts.size()){
    		List<Integer> fs = JSON.parseArray(faqSorts.toString(), Integer.class);
    		Collections.sort(fs);
    		Collections.reverse(fs);
    		for(int i =0; i < faqIds.size(); i++){
    			Faq faq = new Faq();
    			faq.setId(Integer.parseInt(faqIds.get(i)));
    			faq.setSortNumber(fs.get(i));
    			faqs.add(faq);
    		}
    	}
    	return postmarketingService.changeFaqSort(faqs);
   	}
	
	@RequestMapping("notice/list/{page:\\d+}")
    public String list(@PathVariable("page")int page, String title, Integer type, Integer size, HttpServletRequest request){		
		if (type == null) {
			type = 0;
		}
		int total = postmarketingService.countNewsBulletin(StringUtils.trimToEmpty(title), type, -1);
		if (total > 0) {
			request.setAttribute("total", total);
			request.setAttribute("notices", postmarketingService.listNewsBulletin(StringUtils.trimToEmpty(title), type, -1, this.getOffset(page, size), this.getPageSize(size)));
		} else {
			request.setAttribute("total", 0);
			request.setAttribute("notices", new NewsBulletin[0]);
		}
		request.setAttribute("title", StringUtils.trimToEmpty(title));
		request.setAttribute("type", type != null ? type : 0);
		request.setAttribute("size", this.getPageSize(size));
		request.setAttribute("page", this.getPage(page));
		request.setAttribute("pages", this.getTotalPage(total, size));
    	return "notice/list";
    }
	
	@RequestMapping("notice/add")
	public String addNotice() {
		return "notice/add";
	}
	
	@RequestMapping(value="notice/save", method=RequestMethod.POST)
	public String  saveNotice(NewsBulletin newsBulletin, Integer page,Integer size, HttpServletRequest request)throws IOException{
		newsBulletin.setCreateTime(Calendar.getInstance().getTime());
		//newsBulletin.setSortNumber(999);
		postmarketingService.saveNewsBulletin(newsBulletin);
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/notice/list/" + this.getPage(page);
    }
	
	@RequestMapping("notice/edit/{id:\\d+}")
	public String edit(Integer page,Integer size, @PathVariable("id") int id, HttpServletRequest request){
		request.setAttribute("notice", postmarketingService.getNewsBulletin(id));
		request.setAttribute("operation",EDIT);
		return "notice/edit";
	}
	
	@RequestMapping("notice/detail/{id:\\d+}")
	public String detail(Integer page,Integer size, @PathVariable("id") int id, HttpServletRequest request){
		request.setAttribute("notice", postmarketingService.getNewsBulletin(id));
		request.setAttribute("operation",DETAIL);
		return "notice/edit";
	}
	
	@RequestMapping("notice/delete/{id:\\d+}")
	public String delete(Integer page,Integer size, @PathVariable("id") int id, HttpServletRequest request){
		if(id > 0){
			NewsBulletin notice = postmarketingService.getNewsBulletin(id);
			if (notice != null && notice.getId() > 0) {
				postmarketingService.deleteNewsBulletin(id);
			}
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/notice/list/" + this.getPage(page);
	}
	
	@RequestMapping(value="notice/status", method=RequestMethod.POST)
	@ResponseBody
	public void changeStatus(int id, String status, Integer page,Integer size, HttpServletRequest request) {
    	if(id > 0){
    		NewsBulletin notice = postmarketingService.getNewsBulletin(id);
    		if(notice != null && notice.getId() > 0){
    			if(status.equalsIgnoreCase(GenericEnableEnum.ENABLE.name())){
    				notice.setStatus((short)GenericEnableEnum.ENABLE.value());
    			}else if(status.equalsIgnoreCase(GenericEnableEnum.DISABLED.name())){
    				notice.setStatus((short)GenericEnableEnum.DISABLED.value());
    			}
    			postmarketingService.saveNewsBulletins(notice);
    			
    		}
    	}
	}
	
	@RequestMapping(value="notice/change/sort", method=RequestMethod.POST)
   	@ResponseBody
   	public boolean changeNoticeSort(String ids, String sorts) {
    	List<String> noticeIds = new LinkedList<String>();
		List<String> noticeSorts = new LinkedList<String>();
    	if(StringUtils.isNotBlank(ids) && StringUtils.isNotBlank(sorts)){
    		CollectionUtils.addAll(noticeIds, ids.split(COMMA));
    		CollectionUtils.addAll(noticeSorts, sorts.split(COMMA));
    	}
    	List<NewsBulletin> notices = new ArrayList<NewsBulletin>();
    	if(noticeIds.size() > 0 && noticeSorts.size() > 0 && noticeIds.size() == noticeSorts.size()){
    		List<Integer> ps = JSON.parseArray(noticeSorts.toString(), Integer.class);
    		Collections.sort(ps);
    		Collections.reverse(ps);
    		for(int i =0; i < noticeIds.size(); i++){
    			NewsBulletin notice = new NewsBulletin();
    			notice.setId(Integer.parseInt(noticeIds.get(i)));
    			notice.setSortNumber(ps.get(i));
    			notices.add(notice);
    		}
    	}
    	return postmarketingService.changeNewsBulletinSort(notices);
   	}
	
	@RequestMapping("user/feedback/list/{page:\\d+}")
	public String list(String contact, String content, String beginTime, String endTime, Integer size, @PathVariable("page") int page, HttpServletRequest request) {
		int total = postmarketingService.countFeedback(StringUtils.trimToEmpty(contact), StringUtils.trimToEmpty(content), beginTime, endTime);
		if (total > 0) {
			request.setAttribute("total", total);
			request.setAttribute("feedbacks", postmarketingService.listFeedback(StringUtils.trimToEmpty(contact), StringUtils.trimToEmpty(content), beginTime, endTime, this.getOffset(page, size), this.getPageSize(size)));
		} else {
			request.setAttribute("total", 0);
			request.setAttribute("feedbacks", new Feedback[0]);
		}
		request.setAttribute("contact", StringUtils.trimToEmpty(contact));
		request.setAttribute("content", StringUtils.trimToEmpty(content));
		request.setAttribute("beginTime", StringUtils.trimToEmpty(beginTime));
		request.setAttribute("endTime", StringUtils.trimToEmpty(endTime));
		request.setAttribute("size", this.getPageSize(size));
		request.setAttribute("page", this.getPage(page));
		request.setAttribute("pages", this.getTotalPage(total, size));
		return "user/feedback";
	}
	
	@RequestMapping("unionpay/bank/list")
    public String listBank(HttpServletRequest request){
		List<PayBank> list = postmarketingService.getBankList(PayChannelEnum.UNION_PAY, GenericEnableEnum.ALL.value());
		if(list.size() > 0){
			request.setAttribute("banks",list);
		}else{
			request.setAttribute("banks", new PayBank[0]);
		}
    	return "content/bank/list";
    }
	
	@RequestMapping("ebank/list")
    public String listEBank(HttpServletRequest request){
		List<PayBank> list = postmarketingService.getBankList(PayChannelEnum.UNION_PERSONAL_EBANK, GenericEnableEnum.ALL.value());
		if(list.size() > 0){
			request.setAttribute("banks",list);
		}else{
			request.setAttribute("banks", new PayBank[0]);
		}
    	return "content/bank/ebank";
    }
	
	@RequestMapping("ebank/log/list/{page:\\d+}")
    public String listEBankLog(@PathVariable("page") int page, Model model){
		int total = postmarketingService.countEBankLog();
		if (total > 0) {
			model.addAttribute("total", total);
			model.addAttribute("logs", postmarketingService.listEBankLog(this.getOffset(page, PAGE_SIZE), this.getPageSize(PAGE_SIZE)));
		} else {
			model.addAttribute("total", 0);
			model.addAttribute("logs", new EBankLog[0]);
		}
		model.addAttribute("size", this.getPageSize(PAGE_SIZE));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, PAGE_SIZE));
    	return "content/bank/ebank-log";
    }
	
	@RequestMapping("ebank/log/detail/{id:\\d+}")
	public String detailEBankLog(@PathVariable("id") int id, HttpServletRequest request){
		request.setAttribute("ebankLog", postmarketingService.getEBankLog(id));
		return "content/bank/ebank-detail";
	}
	
	@RequestMapping(value="ebank/log/audit/{id:\\d+}", method=RequestMethod.POST)
	@ResponseBody
	public boolean auditBank(@PathVariable("id") int id, int result, String remark, HttpServletRequest request)throws IOException{
		return postmarketingService.audit(id, result, remark);
    }
	
	@RequestMapping("unionpay/bank/add")
	public String addBank() {
		return "content/bank/add";
	}
	
	@RequestMapping("unionpay/bank/edit/{id:\\d+}")
	public String editBank(@PathVariable("id") int id, HttpServletRequest request){
		request.setAttribute("bank", postmarketingService.get(id));
		request.setAttribute("operation",EDIT);
		return "content/bank/edit";
	}
	
	@RequestMapping("unionpay/bank/detail/{id:\\d+}")
	public String detailBank(@PathVariable("id") int id, HttpServletRequest request){
		request.setAttribute("bank", postmarketingService.get(id));
		request.setAttribute("operation",DETAIL);
		return "content/bank/edit";
	}
	
	@RequestMapping(value="unionpay/bank/save", method=RequestMethod.POST)
	public String  saveBank(PayBank payBank, HttpServletRequest request)throws IOException{
		Map<String, String> result = upload(request);
		if (result != null && result.values() != null) {
			String url = StringUtils.substring(result.values().toString(), 1, result.values().toString().length() - 1);
			if (StringUtils.isNotBlank(url)) {
				payBank.setLogoUrl(url);
			}
		}
		postmarketingService.savePayBank(payBank);
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/unionpay/bank/list";
    }
	
	@RequestMapping("unionpay/bank/{id:\\d+}/{status}")
	public String enable(@PathVariable("id") int id, @PathVariable("status")int status, HttpServletRequest request) {
    	if(id > 0){
    		postmarketingService.enable(id, status);
    	}
   		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/unionpay/bank/list";
	}
	
	@RequestMapping("ebank/{id:\\d+}/{status}")
	public String enableEbank(@PathVariable("id") int id, @PathVariable("status")int status, HttpServletRequest request) {
    	if(id > 0){
    		postmarketingService.enable(id, status);
    	}
   		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/ebank/list";
	}
	
	@RequestMapping(value="unionpay/bank/duplicate/name", method=RequestMethod.GET)
	@ResponseBody
	public String duplicate(int id, String fieldId, String fieldValue) {
		ArrayObjectEntity json = new ArrayObjectEntity();
		boolean result = postmarketingService.duplicate(id, StringUtils.trim(fieldValue));
		json.setObject(fieldId);
		json.setSuccess(result);
		if (result) {
			json.setMessage(properties.getAppNamePass());
		} else {
			json.setMessage(properties.getAppNameNoPass()); 
		}
		return json.toString(); 
	}
	
	
	@RequestMapping(value="cellphonelog/list/{page:\\d+}")
	public String list( String oldCellphone, Integer size, @PathVariable("page") int page, HttpServletRequest request) {

		int total =postmarketingService.countCellphone(oldCellphone);
		if (total > 0) {
			request.setAttribute("total", total);
			request.setAttribute("cellphonelogs", postmarketingService.listCellphoneLog(oldCellphone, this.getOffset(page, size), this.getPageSize(size)));
		} else {
			request.setAttribute("total", 0);
			request.setAttribute("cellphonelogs", new PushMessage[0]);
		}
		request.setAttribute("oldCellphone", oldCellphone);
		request.setAttribute("size", this.getPageSize(size));
		request.setAttribute("page", this.getPage(page));
		request.setAttribute("pages", this.getTotalPage(total, size));
		return "cellphonelog/list";
	}
	
	@RequestMapping(value="log/cellphone/smscode")
	@ResponseBody
	public JSONObject getSmsCode(int status, String cellphone) {
		JSONObject result = new JSONObject();
		LOGGER.info("start send sms");
		//this.init();
		if (status == 1 && StringUtils.isNotBlank(cellphone)) {
			return postmarketingService.send(messageSource.getMessage("sms.cellphone.pass", null, null), cellphone, UTF_8);
		} else if (status == 2 && StringUtils.isNotBlank(cellphone)) {
			return postmarketingService.send(messageSource.getMessage("sms.cellphone.nopass",null, null), cellphone, UTF_8);
		}
		return result; 
	}
	
	@RequestMapping(value="cellphonelog/audit/{id:\\d+}/{status}")
	@ResponseBody
	public int audit( @PathVariable("id") int id, @PathVariable("status") short status,HttpServletRequest request,HttpServletResponse response) throws IOException {
		boolean auditResult = false;
		int result = -1;
		CellphoneLog log = postmarketingService.getCellphoneLog(id);
		if (log != null && log.getId() > 0) {
			User user = postmarketingService.getByCellphone(log.getNewCellphone());
			if(user == null && status==1){
				result = 0;
				auditResult = postmarketingService.audit(id, status);			    
			}else if(status==2){
				result = 0;
				auditResult = postmarketingService.audit(id, status);		
			}
			if(auditResult && status==1){
				result = 1;
			}else if(auditResult && status==2){
				result = 1;
			}
		}
		return result;
	}
	
    @RequestMapping(value="user/uninvest/list/{page:\\d+}")
    public String uninvest(@PathVariable("page") int page,String userName ,String cellphone, String startTime,String endTime, Integer size, HttpServletRequest request) {
        int total = postmarketingService.countUninvestlist(userName,cellphone,startTime,endTime);
        if(total > 0) {
            request.setAttribute("total", total);
            request.setAttribute("uninvestCustomers", postmarketingService.uninvestList(userName,cellphone,startTime,endTime,this.getOffset(page, size), this.getPageSize(size)));
        } else {
            request.setAttribute("total", 0);
            request.setAttribute("uninvestCustomers", new UninvestEntity[0]);
        }
        request.setAttribute("userName", userName);
        request.setAttribute("cellphone", cellphone);
        request.setAttribute("startTime", startTime);
        request.setAttribute("endTime", endTime);
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("pages", this.getTotalPage(total, size));
        request.setAttribute("excelImport", this.getAddFunctionPermit(AddFunctionPermitEnum.NOINVEST_EXCEL_EXPORT.getCode(), request));
        return "user/statistics/uninvest";
    }
    
    @RequestMapping("/user/uninvest/export")
    @LogRecord(module=LogRecord.Module.UNINVEST, operation=LogRecord.Operation.EXPORT)
    @ResponseBody
    public ResponseEntity<byte[]> exportUninvestUser(String userName, String cellphone, String startTime, String endTime, HttpServletRequest request, HttpServletResponse response) {
        String realPath = request.getSession().getServletContext().getRealPath("");
        realPath = StringUtils.replace(realPath, BACK_SLASH, SLASH) + properties.getTemplatePath();//ApplicationConfigUtil.get("template.path")
        String fileName = properties.getCustomerUninvestExcelName();//ApplicationConfigUtil.get("customer.excel.name");
        List<UninvestEntity> uninvestList = postmarketingService.uninvestList(userName,cellphone,startTime,endTime,0,0);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        List<Serializable> list = new LinkedList<Serializable>();
        for(UninvestEntity entity : uninvestList) {
            list.add(entity);
        }
        String errorMessage = "";
        if (list != null && list.size() > 0) {
            String finalFileName = ExcelUtil.writeToExcel(list, messageSource.getMessage("template.xls.customer.uninvest", null, null), realPath, fileName, null);
            if (StringUtils.isNotBlank(finalFileName)) {
                return this.export(realPath, fileName, request);
            }
            errorMessage = "no file find!";
        }
        errorMessage = "this is empty!";
        headers.setContentDispositionFormData("attachment", fileName);
        return new ResponseEntity<byte[]>(errorMessage.getBytes(), headers, HttpStatus.OK);
    }
    
    
    @RequestMapping(value="user/lost/customer/list/{page:\\d+}")
    public String lostcustomer(@PathVariable("page") int page,String userName ,String cellphone, String startTime,String endTime, Integer size, HttpServletRequest request) {
        int total = postmarketingService.countlostcustomers(userName,cellphone,startTime,endTime);
        if(total > 0) {
            request.setAttribute("total", total);
            request.setAttribute("lostcustomers", postmarketingService.lostcustomerList(userName,cellphone,startTime,endTime,this.getOffset(page, size), this.getPageSize(size)));
        } else {
            request.setAttribute("total", 0);
            request.setAttribute("inviterRewards", new LostUserEntity[0]);
        }
        request.setAttribute("userName", userName);
        request.setAttribute("cellphone", cellphone);
        request.setAttribute("startTime", startTime);
        request.setAttribute("endTime", endTime);
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("pages", this.getTotalPage(total, size));
        request.setAttribute("excelImport", this.getAddFunctionPermit(AddFunctionPermitEnum.LOST_CUSTOMER_EXCEL_EXPORT.getCode(), request));
        return "user/statistics/lostcustomer";
    }
    
    @RequestMapping("/user/lost/customer/export")
    @LogRecord(module=LogRecord.Module.LOSTCUSTOMER, operation=LogRecord.Operation.EXPORT)
    @ResponseBody
    public ResponseEntity<byte[]> exportLostCustomer(String userName, String cellphone, String startTime, String endTime, HttpServletRequest request, HttpServletResponse response) {
        String realPath = request.getSession().getServletContext().getRealPath("");
        realPath = StringUtils.replace(realPath, BACK_SLASH, SLASH) + properties.getTemplatePath();//ApplicationConfigUtil.get("template.path")
        String fileName = properties.getCustomerLostExcelName();//ApplicationConfigUtil.get("customer.excel.name");
        List<LostUserEntity> lostcustomers = postmarketingService.lostcustomerList(userName,cellphone,startTime,endTime,0,0);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        List<Serializable> list = new LinkedList<Serializable>();
        for(LostUserEntity entity : lostcustomers) {
            list.add(entity);
        }
        String errorMessage = "";
        if (list != null && list.size() > 0) {
            String finalFileName = ExcelUtil.writeToExcel(list, messageSource.getMessage("template.xls.customer.lost", null, null), realPath, fileName, null);
            if (StringUtils.isNotBlank(finalFileName)) {
                return this.export(realPath, fileName, request);
            }
            errorMessage = "no file find!";
        }
        errorMessage = "this is empty!";
        headers.setContentDispositionFormData("attachment", fileName);
        return new ResponseEntity<byte[]>(errorMessage.getBytes(), headers, HttpStatus.OK);
    }
	
}