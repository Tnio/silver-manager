package com.silverfox.finance.controller;

import static com.silverfox.finance.util.ConstantUtil.PAGE_SIZE;
import static com.silverfox.finance.util.ConstantUtil.PUSH;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.silverfox.finance.domain.NewsBulletin;
import com.silverfox.finance.domain.NewsMaterial;
import com.silverfox.finance.domain.Product;
import com.silverfox.finance.domain.PushMessage;
import com.silverfox.finance.domain.SmsTemplate;
import com.silverfox.finance.service.MessageService;
import com.silverfox.finance.util.CommonUtil;
import com.silverfox.finance.util.ConstantUtil;

@Controller
@RequestMapping("/message")
public class MessageController extends BaseController {
	protected static final String REGEX_STYLE="style\\s*=(['\"\"\\s]?)[^'\"\"]*?\\1";
	
	@Autowired
	private MessageService messageService;
	
	@RequestMapping(value="/list/{page:\\d+}")
	public String list(String beginTime, String endTime, Integer size, @PathVariable("page") int page, HttpServletRequest request) {
     
		int total=messageService.count(beginTime, endTime);
		if (total > 0) {
			request.setAttribute("total", total);
			List<PushMessage> message =messageService.list(beginTime, endTime, this.getOffset(page, size), this.getPageSize(size)); 
			request.setAttribute("messages", message);
		} else {
			request.setAttribute("total", 0);
			request.setAttribute("messages", new PushMessage[0]);
		}
		request.setAttribute("beginTime", StringUtils.trimToEmpty(beginTime));
		request.setAttribute("endTime", StringUtils.trimToEmpty(endTime));
		request.setAttribute("size", this.getPageSize(size));
		request.setAttribute("page", this.getPage(page));
		request.setAttribute("pages", this.getTotalPage(total, size));
		return "message/list";
	}

	@RequestMapping(value="/add/{page:\\d+}/{size:\\d+}", method=RequestMethod.POST)
	public String add(String beginTime, String endTime, @PathVariable("page") int page, @PathVariable("size") int size, HttpServletRequest request) {
		request.setAttribute("page", this.getPage(page));
		request.setAttribute("size", this.getPageSize(size));
		request.setAttribute("time", CommonUtil.getTime());
		request.setAttribute("beginTime", StringUtils.trimToEmpty(beginTime));
		request.setAttribute("endTime", StringUtils.trimToEmpty(endTime));
		getProductParam(request);
		return "message/add";
	}

	@RequestMapping(value="/edit/{id:\\d+}/{page:\\d+}/{size:\\d+}", method=RequestMethod.POST)
	public String edit(String beginTime, String endTime, @PathVariable("id") int id, @PathVariable("page") int page, @PathVariable("size") int size, HttpServletRequest request) {
		PushMessage pushMessage= messageService.getPushMessage(id);
		pushMessage.setContent(pushMessage.getContent().replace("\r\n",""));
		request.setAttribute("page", this.getPage(page));
		request.setAttribute("size", this.getPageSize(size));
		request.setAttribute("message", pushMessage);
		request.setAttribute("beginTime", StringUtils.trimToEmpty(beginTime));
		request.setAttribute("endTime", StringUtils.trimToEmpty(endTime));
		request.setAttribute("operation",ConstantUtil.EDIT);
		if (pushMessage.getPushType() == 1) {
			if (pushMessage.getProductId() > 0) {
				Product product = messageService.getProductById(pushMessage.getProductId());
				if (product != null && product.getId() > 0) {
					request.setAttribute("productName", product.getName());
				}
			}
		}
		if(pushMessage != null && pushMessage.getPushType() == 2) {
			if (pushMessage.getNewsId() > 0) {
				NewsMaterial news = messageService.getNews(pushMessage.getNewsId());
				if (news != null && news.getId() > 0) {
					request.setAttribute("news", news);
				}
			}
		}
		getProductParam(request);
		return "message/edit";
	}
	
	@RequestMapping(value="/detail/{id:\\d+}/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
	public String detail(@PathVariable("id") int id, @PathVariable("page") int page, @PathVariable("size") int size, HttpServletRequest request) {
		PushMessage pushMessage= messageService.getPushMessage(id);
		pushMessage.setContent(pushMessage.getContent().replace("\r\n",""));
		request.setAttribute("page", this.getPage(page));
		request.setAttribute("size", this.getPageSize(size));
		request.setAttribute("message", pushMessage);
		request.setAttribute("operation",ConstantUtil.DETAIL);
		if(pushMessage != null && pushMessage.getPushType() == 1) {
			if (pushMessage.getProductId() > 0) {
				Product product = messageService.getProductById(pushMessage.getProductId());
				if (product != null && product.getId() > 0) {
					request.setAttribute("productName", product.getName());
				}
			}
		}
		if(pushMessage != null && pushMessage.getPushType() == 2) {
			if (pushMessage.getNewsId() > 0) {
				NewsMaterial news = messageService.getNews(pushMessage.getNewsId());
				if (news != null && news.getId() > 0) {
					request.setAttribute("news", news);
				}
			}
		}
		getProductParam(request);
		return "message/edit";
	}

	@RequestMapping(value="/save", method=RequestMethod.POST)
	public String save(PushMessage pushMessage, BindingResult result, String beginTime, String endTime, int page, int size, HttpServletRequest request) {
		if (!result.hasErrors()) {
			messageService.savePushMessage(pushMessage);
 		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/message/list/"+page;
	}

	@RequestMapping(value="/audit/{id:\\d+}")
	@ResponseBody
	public boolean audit(@PathVariable("id") int id, HttpServletRequest request) throws InterruptedException, ExecutionException {
		boolean success = messageService.auditPushMessage(id);
		if (success) {
			PushMessage pushMessage= messageService.getPushMessage(id);
			if(pushMessage != null) {
				messageService.pushMessage(properties.getPluginUrl() + PUSH, pushMessage);
			}
		}
		return success;
	}
	
	@RequestMapping(value="/news/list/{page:\\d+}")
	public String listNews(@PathVariable("page") int page, Integer size, Map<String, Object> model) {
		int total= messageService.countNews();
		if (total > 0) {
			model.put("total", total);
			model.put("newsList", messageService.listNews(this.getOffset(page, size), this.getPageSize(size)));
		} else {
			model.put("total", 0);
			model.put("newsList", new NewsMaterial[0]);
		}
		model.put("size", this.getPageSize(size));
		model.put("page", this.getPage(page));
		model.put("pages", this.getTotalPage(total, size));
		return "message/news/list";
	}
	
	@RequestMapping("/news/all/{page:\\d+}")
	@ResponseBody
	public Map<String, Object> getNews(Integer size, @PathVariable("page")int page){
		Map<String, Object> result = new HashMap<String, Object>();
		int total= messageService.countNews();
		if(total > 0){
			result.put("total", total);
			result.put("newsList", messageService.listNews(this.getOffset(page, size), this.getPageSize(size)));
		}else{
			result.put("total", 0);
			result.put("newsList", new NewsMaterial[0]);
		}
		result.put("size", this.getPageSize(size));
		result.put("page", this.getPage(page));
		result.put("pages", this.getTotalPage(total, size));
		return result;
	}
	
	@RequestMapping(value="/news/add/{page:\\d+}/{size:\\d+}", method=RequestMethod.POST)
	public String addNews(@PathVariable("page") int page, @PathVariable("size") int size, Map<String, Object> model) {
		model.put("page", this.getPage(page));
		model.put("size", this.getPageSize(size));
		return "message/news/add";
	}
	
	@RequestMapping(value="/news/save", method=RequestMethod.POST)
	public String saveNews(NewsMaterial news, int page, int size, HttpServletRequest request) {
		Map<String, String> attachmentsMap = this.upload(request);
		if(attachmentsMap.size() > 0){
			for(String key : attachmentsMap.keySet()){
				news.setImgUrl(attachmentsMap.get(key));
			}
		}
		if (news.getId() == null || news.getId() < 1) {
			news.setCreateTime(new Date());
		}
		messageService.saveNews(news);
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/message/news/list/"+page;
	}
	
	@RequestMapping(value="/news/detail/{id:\\d+}/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
	public String detailNews(@PathVariable("id") int id, @PathVariable("page") int page, @PathVariable("size") int size, Map<String, Object> model) {
		
		NewsMaterial news = messageService.getNews(id);
		model.put("page", this.getPage(page));
		model.put("size", this.getPageSize(size));
		model.put("news", news);
		model.put("operation", ConstantUtil.DETAIL);
		return "message/news/edit";
	}

	@RequestMapping(value="/news/edit/{id:\\d+}/{page:\\d+}/{size:\\d+}", method=RequestMethod.POST)
	public String editNews(@PathVariable("id") int id, @PathVariable("page") int page, @PathVariable("size") int size, Map<String, Object> model) {
		NewsMaterial news = messageService.getNews(id);
		model.put("page", this.getPage(page));
		model.put("size", this.getPageSize(size));
		model.put("news", news);
		model.put("operation",ConstantUtil.EDIT);
		return "message/news/edit";
	}
	
	@RequestMapping(value="/app/list/{page:\\d+}")
	public String listAppMessage(@PathVariable("page") int page, Integer size, Map<String, Object> model) {
		int total = messageService.countNewsBulletin(null, 5, -1);
		if (total > 0) {
			model.put("total", total);
			model.put("messages", messageService.listNewsBulletin(null, 5, -1, this.getOffset(page, size), this.getPageSize(size)));
		} else {
			model.put("total", 0);
			model.put("messages", new NewsBulletin[0]);
		}
		model.put("size", this.getPageSize(size));
		model.put("page", this.getPage(page));
		model.put("pages", this.getTotalPage(total, size));
		return "message/app/list";
	}
	
	@RequestMapping(value="/app/add/{page:\\d+}/{size:\\d+}", method=RequestMethod.POST)
	public String addAppMessage(@PathVariable("page") int page, @PathVariable("size") int size, Map<String, Object> model) {
		model.put("page", this.getPage(page));
		model.put("size", this.getPageSize(size));
		model.put("newsPage", this.getPage(1));
		model.put("newsSize", this.getPageSize(PAGE_SIZE));
		return "message/app/add";
	}
	
	@RequestMapping(value="/app/save", method=RequestMethod.POST)
	public String saveAppMessage(NewsBulletin newsBulletin, Integer contentId, int page, int size, HttpServletRequest request) {
		//postmarketingService.saveNewsBulletin(newsBulletin);
		   messageService.saveNewsBulletin(newsBulletin);
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/message/app/list/"+page;
	}
	
	@RequestMapping(value="/app/detail/{id:\\d+}/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
	public String detailAppMessage(@PathVariable("id") int id, @PathVariable("page") int page, @PathVariable("size") int size, Map<String, Object> model) {
		model.put("page", this.getPage(page));
		model.put("size", this.getPageSize(size));
		model.put("message", messageService.getNewsBulletinByid(id));
		model.put("operation", ConstantUtil.DETAIL);
		return "message/app/detail";
	}
	
	@RequestMapping(value="/app/edit/{id:\\d+}/{page:\\d+}/{size:\\d+}", method=RequestMethod.POST)
	public String editAppMessage(@PathVariable("id") int id, @PathVariable("page") int page, @PathVariable("size") int size, Map<String, Object> model) {
		model.put("message", messageService.getNewsBulletin(id));
		model.put("operation", ConstantUtil.EDIT);
		model.put("page", this.getPage(page));
		model.put("size", this.getPageSize(size));
		model.put("newsPage", this.getPage(1));
		model.put("newsSize", this.getPageSize(PAGE_SIZE));
		return "message/app/edit";
	}
	
	@RequestMapping(value="/app/audit/{id:\\d+}")
	@ResponseBody
	public boolean auditAppMessage(@PathVariable("id") int id, int status, HttpServletRequest request) throws InterruptedException, ExecutionException {
		NewsBulletin newsBulletin = messageService.getNewsBulletin(id);
		if(newsBulletin != null && newsBulletin.getId() > 0){
			newsBulletin.setStatus((short)status);
			//return postmarketingService.saveNewsBulletin(newsBulletin);
			return messageService.saveNewsBulletins(newsBulletin);
		}
		return false;
	}
	
	@RequestMapping(value="/news/{id:\\d+}", method=RequestMethod.POST)
	@ResponseBody
	public NewsMaterial getNews(@PathVariable("id") int id) {
		NewsMaterial news = messageService.getNews(id);
		String content = news.getContent().replaceAll(REGEX_STYLE, "");
		news.setContent(content);
		return news;
	}
	
	@RequestMapping(value="/news/list/{page:\\d+}/{size:\\d+}")
	@ResponseBody
	public Map<String, Object> listNews(@PathVariable("page") int page, @PathVariable("size") int size) {
		Map<String, Object> result = new HashMap<String, Object>();
		int total = messageService.countNews();
		if (total > 0) {
			result.put("total", total);
			result.put("newsList", messageService.listNews(this.getOffset(page, size), this.getPageSize(size)));
		} else {
			result.put("total", 0);
			result.put("newsList", new NewsMaterial[0]);
		}
		result.put("newsPage", this.getPage(page));
		result.put("newsSize", this.getPageSize(size));
		return result;
	}
	
	@RequestMapping("/template/list/{page:\\d+}")
	public String list(Integer size, @PathVariable("page")int page, Model model){
		int total = messageService.count(-1);
		if(total > 0){
			model.addAttribute("total", total);
			model.addAttribute("templates", messageService.listSmsTemplate(-1,this.getOffset(page, size), this.getPageSize(size)));
		}else{
			model.addAttribute("total", 0);
			model.addAttribute("templates", new SmsTemplate[0]);
		}
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "message/template";
	}
	
	@RequestMapping(value="/template/audit", method=RequestMethod.POST)
	@ResponseBody
	public boolean audit(Integer id, Short status) throws IOException {
		if (id > 0 && (status == 0 || status == 1)) {
			return messageService.auditSmsTemplate(id, status);
		}
		return false;
	}
	
	@RequestMapping(value="/template/save", method=RequestMethod.POST)
	@ResponseBody
	public boolean saveSmsTemplate(SmsTemplate smsTemplate, HttpServletRequest request) {
		if (StringUtils.isNotBlank(smsTemplate.getContent().trim())) {
			return messageService.save(smsTemplate);
		}
		return false;
	}
	
	private void getProductParam(HttpServletRequest request) {
		request.setAttribute("productSize", this.getPageSize(PAGE_SIZE));
		request.setAttribute("productPage", this.getPage(1));
	}
}
