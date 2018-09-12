package com.silverfox.finance.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.silverfox.finance.domain.Channel;
import com.silverfox.finance.domain.ChannelVisitLog;
import com.silverfox.finance.entity.ArrayObjectEntity;
import com.silverfox.finance.service.ChannelService;

@Controller
@RequestMapping("/thirdparty")
public class ThirdpartyController extends BaseController {
	@Autowired
	private ChannelService channelService;
	
	@RequestMapping("/channel/statistics/{channelId:\\d+}")
	public String channelStatistics(@PathVariable("channelId")int channelId,HttpServletRequest request){
		List<ChannelVisitLog> cvl = channelService.getVisit(channelId);
		int webSpreadQuantity = 0;
		int webRegQuantity = 0;
		int webDownQuantity = 0;
		int webVisitSpreadQuantity = 0;  //    17-立即参与app点击量; 18-注册app点击量; 19-下载app点击量;20-立马理财app点
		int webVisitRegQuantity = 0;
		int webVisitDownQuantity = 0;
		int appSpreadQuantity = 0;
		int appRegQuantity = 0;
		int appDownQuantity =0;
		int appVisitSpreadQuantity = 0;
		int appVisitRegSpreadQuantity = 0;
		int appVisitDownQuantity = 0;
        int webBtnPartakeQuantity = 0;
        int webBtnRegQuantity = 0;
        int webBtnDownQuantity = 0;
        int webBtnfinanceQuantity = 0;
        int appBtnPartakeQuantity = 0;
        int appBtnRegQuantity = 0;
        int appBtnDownQuantity = 0;
        int appBtnfinanceQuantity = 0;
        if(cvl.size()>0){
        	for(int i=0; i<cvl.size();i++){
        		if(cvl.get(i).getType()==1){
        			webSpreadQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==2){
        			webRegQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==3){
        			webDownQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==4){
        			webVisitSpreadQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==5){
        			webVisitRegQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==6){
        			webVisitDownQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==7){
        			appSpreadQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==8){
        			appRegQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==9){
        			appDownQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==10){
        			appVisitSpreadQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==11){
        			appVisitRegSpreadQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==12){
        			appVisitDownQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==13){
        			webBtnPartakeQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==14){
        			webBtnRegQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==15){
        			webBtnDownQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==16){
        			webBtnfinanceQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==17){
        			appBtnPartakeQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==18){
        			appBtnRegQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==19){
        			appBtnDownQuantity =cvl.get(i).getQuantity();
        		}
        		if(cvl.get(i).getType()==20){
        			appBtnfinanceQuantity =cvl.get(i).getQuantity();
        		}
        	}
        }
		request.setAttribute("webSpreadQuantity", webSpreadQuantity);
		request.setAttribute("webRegQuantity", webRegQuantity);
		request.setAttribute("webDownQuantity", webDownQuantity);
		request.setAttribute("webVisitSpreadQuantity", webVisitSpreadQuantity);
		request.setAttribute("webVisitRegQuantity", webVisitRegQuantity);
		request.setAttribute("webVisitDownQuantity", webVisitDownQuantity);
		request.setAttribute("appSpreadQuantity", appSpreadQuantity);
		request.setAttribute("appRegQuantity", appRegQuantity);
		request.setAttribute("appDownQuantity", appDownQuantity);
		request.setAttribute("appVisitSpreadQuantity", appVisitSpreadQuantity);
		request.setAttribute("appVisitRegSpreadQuantity", appVisitRegSpreadQuantity);
		request.setAttribute("appVisitDownQuantity", appVisitDownQuantity);
		request.setAttribute("webBtnPartakeQuantity", webBtnPartakeQuantity);
		request.setAttribute("webBtnRegQuantity", webBtnRegQuantity);
		request.setAttribute("webBtnDownQuantity", webBtnDownQuantity);
		request.setAttribute("webBtnfinanceQuantity", webBtnfinanceQuantity);
		request.setAttribute("appBtnPartakeQuantity", appBtnPartakeQuantity);
		request.setAttribute("appBtnRegQuantity", appBtnRegQuantity);
		request.setAttribute("appBtnDownQuantity", appBtnDownQuantity);
		request.setAttribute("appBtnfinanceQuantity", appBtnfinanceQuantity);
		return "/channel/statistics";
	}
	
	@RequestMapping("/channel/list/{page:\\d+}")
	public String listChannel(String channelName,  Integer category, Integer size, @PathVariable("page")int page, HttpServletRequest request){
		if(channelName == null){
			channelName = "";
		}
		category = category == null ? -1 : category;
		int total = channelService.count(channelName, category);
		if(total > 0){
			request.setAttribute("total", total);
			request.setAttribute("channels", channelService.queryForChannellist(channelName, category, this.getOffset(page, size), this.getPageSize(size)));
		}else{
			request.setAttribute("total", 0);
			request.setAttribute("channels", new ArrayList<Channel>(0));
		}
		request.setAttribute("channelsUse", channelService.listForUsed());
		request.setAttribute("channelName", channelName);
		request.setAttribute("category", category);
		request.setAttribute("size", this.getPageSize(size));
		request.setAttribute("page", this.getPage(page));
		request.setAttribute("pages", this.getTotalPage(total, size));
		return "channel/list";
	}
	 @RequestMapping(value=("/channel/detail/{id:\\d+}/{page:\\d+}"), method=RequestMethod.GET)
	   	public String forwardToDetail(Integer size, @PathVariable("id") int id, @PathVariable("page")int page, HttpServletRequest request) {
	       	request.setAttribute("channel", channelService.get(id));
	       	request.setAttribute("operation",DETAIL);
	   		return "channel/edit";
	   	}
	 @RequestMapping(value=("/channel/edit/{id:\\d+}/{page:\\d+}"), method=RequestMethod.GET)
		public String forwardToModification(Integer size, @PathVariable("id") int id, @PathVariable("page")int page, HttpServletRequest request) {
	    	request.setAttribute("channel", channelService.get(id));
	    	request.setAttribute("operation",EDIT);
			return "channel/edit";
		}
	
	 @RequestMapping(value="/channel/save", method=RequestMethod.POST)
		public String saveChannel(Channel channel, int page, HttpServletRequest request) {
			Map<String, String> result =upload(request);
			String backgroundUrl = result.get("backUrls");
			String url = result.get("urls");
			//String url = StringUtils.substring(result.values().toString(), 1, result.values().toString().length() - 1);
			if (StringUtils.isNotBlank(url)) {
				channel.setBanner(url);
			}
			if (StringUtils.isNotBlank(backgroundUrl)) {
				channel.setBackgroundUrl(backgroundUrl);
			}
	    	channelService.saveChannel(channel);
	    	return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/thirdparty/channel/list/"+page;
	    }
	
	 @RequestMapping(value="/channel/validate/name", method=RequestMethod.GET)
		@ResponseBody
		public String validateChannelName(int id, String fieldId, String fieldValue) {
			if (StringUtils.isNotBlank(fieldId) && StringUtils.isNotBlank(fieldValue)) {
				ArrayObjectEntity json = new ArrayObjectEntity();
				List<Channel> channels = channelService.checkChannelName(id, fieldValue);
				if (channels.size() > 0) {
					json.setObject(fieldId);
					json.setSuccess(false);
					json.setMessage(messageSource.getMessage("channel.occupy", null, Locale.getDefault())); 
				} else {
					json.setObject(fieldId);
					json.setSuccess(true);
					json.setMessage(messageSource.getMessage("channel.leisure", null, Locale.getDefault())); 
				}
				return json.toString(); 
			}
			return null;
	    }
	
	
	
	
	
	
	
	
	
	
	
}