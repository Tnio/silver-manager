package com.silverfox.finance.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.silverfox.finance.domain.PictrueLibrary;
import com.silverfox.finance.entity.ArrayObjectEntity;
import com.silverfox.finance.enumeration.PictrueLibraryCategoryEnum;
import com.silverfox.finance.service.PictrueLibraryService;
import com.silverfox.finance.util.ConstantUtil;
import com.silverfox.finance.util.ValidatorUtil;

@Controller
@RequestMapping("/banner")
public class AdvertController extends MainController {

    @Autowired
    private PictrueLibraryService pictrueLibraryService;

    @RequestMapping(value="/add/{page:\\d+}/{size:\\d+}", method= RequestMethod.GET)
    public String forwardToCreation(@PathVariable("size")int size, @PathVariable("page")int page, HttpServletRequest request) {
        this.getAppParam(page, size, request);
        return "image/advert/add";
    }

    @RequestMapping(value="/edit/{id:\\d+}/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
    public String forwardToModification(Integer dPlatform, @PathVariable("id")int id, @PathVariable("size")int size, @PathVariable("page")int page, HttpServletRequest request) {
        request = this.getAppParam(page, size, request);
        request.setAttribute("dPlatform",dPlatform);
        request.setAttribute("operation",EDIT);
        request.setAttribute("image", pictrueLibraryService.get(id));
        return "image/advert/edit";
    }

    @RequestMapping(value="/detail/{id:\\d+}/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
    public String forwardToDetail(Integer dPlatform, @PathVariable("id")int id, @PathVariable("size")int size, @PathVariable("page")int page, HttpServletRequest request) {
        request = this.getAppParam(page, size, request);
        request.setAttribute("operation",DETAIL);
        request.setAttribute("dPlatform",dPlatform);
        request.setAttribute("image", pictrueLibraryService.get(id));
        return "image/advert/edit";
    }

    @RequestMapping("/list/{page:\\d+}")
    public String list(Integer dPlatform, Integer size, @PathVariable("page") int page, HttpServletRequest request) {
        dPlatform = dPlatform == null ? -1: dPlatform;
        int total = pictrueLibraryService.count(PictrueLibraryCategoryEnum.BANNER.value(), dPlatform, -1);
        if (total > 0) {
            request.setAttribute("total", total);
            request.setAttribute("images", pictrueLibraryService.list(PictrueLibraryCategoryEnum.BANNER.value(), dPlatform, -1, this.getOffset(page, size), this.getPageSize(size)));
        } else {
            request.setAttribute("total", 0);
            request.setAttribute("images", new PictrueLibrary[0]);
        }
        request.setAttribute("dPlatform", dPlatform);
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("pages", this.getTotalPage(total, size));
        return "image/advert/list";
    }

    @RequestMapping(value="/save", method=RequestMethod.POST)
    public String save(@Valid PictrueLibrary image, BindingResult validResult, Integer dPlatform, int page, int size, HttpServletRequest request, RedirectAttributesModelMap redirectAttributesModelMap) {
        if (!validResult.hasErrors()) {
            Map<String, String> result =upload(request);
            String url = StringUtils.substring(result.values().toString(), 1, result.values().toString().length() - 1);
            if (StringUtils.isNotBlank(url)) {
                image.setUrl(url);
            }
            image.setCategory(PictrueLibraryCategoryEnum.BANNER.value());
            if(StringUtils.isBlank(image.getContent())){
                image.setContent("");
            }
            if (StringUtils.isBlank(image.getUrl()) || (StringUtils.isNotBlank(image.getUrl()) && ValidatorUtil.isImageUrl(image.getUrl()))) {
                pictrueLibraryService.save(image);
            }
        }
        redirectAttributesModelMap.addAttribute("dPlatform", dPlatform);
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/banner/list/"+this.getPage(page);
    }

    @RequestMapping(value="/enable/{id:\\d+}/{value:\\d+}", method=RequestMethod.POST)
    @ResponseBody
    public boolean enable(@PathVariable("id")int id, @PathVariable("value")int value,HttpServletRequest request) {
        if (id > 0 && (value == 0 || value == 1)) {
            return pictrueLibraryService.enable(id, value);
        }
        return false;
    }

    @RequestMapping(value="/delete/{id:\\d+}", method=RequestMethod.POST)
    @ResponseBody
    public boolean removeApp(@PathVariable("id")int id,HttpServletRequest request) {
        PictrueLibrary image = pictrueLibraryService.get(id);
        if (image != null && image.getId() > 0) {
            return pictrueLibraryService.remove(id);
        }
        return false;
    }

    @RequestMapping(value="/duplicate/name", method=RequestMethod.GET)
    @ResponseBody
    public String duplicateName(int id, String fieldId, String fieldValue) {
        if (id >= 0 && StringUtils.isNotBlank(fieldId) && StringUtils.isNotBlank(fieldValue)) {
            ArrayObjectEntity json = new ArrayObjectEntity();
            boolean result = pictrueLibraryService.duplicate(id, StringUtils.trim(fieldValue), PictrueLibraryCategoryEnum.BANNER.value());
            json.setObject(fieldId);
            json.setSuccess(result);
            if (result) {
                json.setMessage(properties.getAppNamePass());//ApplicationConfigUtil.get("app.name.pass")
            } else {
                json.setMessage(properties.getAppNameNoPass());//ApplicationConfigUtil.get("app.name.no.pass")
            }
            return json.toString();
        }
        return null;
    }

    @RequestMapping("/app/upload")
    @ResponseBody
    public void uploadImage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("utf-8");
        String callback = request.getParameter("CKEditorFuncNum");
        PrintWriter out = response.getWriter();
        boolean checkResult = CheckImageSize(request);
        if(checkResult){
            Map<String, String> result = upload(request);
            String fileName = StringUtils.substring(result.values().toString(), 1, result.values().toString().length() - 1);
            out.println("<script type=\"text/javascript\">");
            out.println("window.parent.CKEDITOR.tools.callFunction(" + callback + ",'" + request.getContextPath() + fileName + "','')");
            out.println("</script>");
        }else{
            out.println("<script type=\"text/javascript\">");
            out.println("window.parent.CKEDITOR.tools.callFunction(" + callback + ",'" + "" + "','"+properties.getImageCheck()+"')");//ApplicationConfigUtil.get("image.check")
            out.println("</script>");
        }
    }

    @RequestMapping("/web/upload")
    @ResponseBody
    public void uploadWebImage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        Map<String, String> result = upload(request);
        String fileName = StringUtils.substring(result.values().toString(), 1, result.values().toString().length() - 1);
        out.print(fileName);
        out.flush();
    }

    private HttpServletRequest getAppParam(int page, int size, HttpServletRequest request) {
        request.setAttribute("path", properties.getUploadPath());//ApplicationConfigUtil.get("upload.path")
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("size", this.getPageSize(size));
        return request;
    }
    @RequestMapping(value="/change/sort", method=RequestMethod.POST)
   	@ResponseBody
   	public boolean changeBannertSort(String ids, String sorts) {
    	List<String> bannerIds = new LinkedList<String>();
		List<String> bannerSorts = new LinkedList<String>();
    	if(StringUtils.isNotBlank(ids) && StringUtils.isNotBlank(sorts)){
    		CollectionUtils.addAll(bannerIds, ids.split(ConstantUtil.COMMA));
    		CollectionUtils.addAll(bannerSorts, sorts.split(ConstantUtil.COMMA));
    	}
    	List<PictrueLibrary> pictrueLibraries = new ArrayList<PictrueLibrary>();
    	if(bannerIds.size() > 0 && bannerSorts.size() > 0 && bannerIds.size() == bannerSorts.size()){
    		List<Integer> ps = JSON.parseArray(bannerSorts.toString(), Integer.class);
    		Collections.sort(ps);
    		Collections.reverse(ps);
    		for(int i =0; i < bannerIds.size(); i++){
    			PictrueLibrary pictrueLibrary = new PictrueLibrary();
    			pictrueLibrary.setId(Integer.parseInt(bannerIds.get(i)));
    			pictrueLibrary.setSortNumber(ps.get(i));
    			pictrueLibraries.add(pictrueLibrary);
    		}
    	}
    	return pictrueLibraryService.changeSort(pictrueLibraries);
   	}
    
    @RequestMapping(value="/list/{page:\\d+}/{category:\\d+}")
	public String listNoticeMessage(Integer dPlatform,@PathVariable("page") int page, @PathVariable("category") int category,Integer size, HttpServletRequest request) {
    	dPlatform = dPlatform == null ? -1: dPlatform;
        int total = pictrueLibraryService.count(category, dPlatform, -1);
        if (total > 0) {
            request.setAttribute("total", total);
            List<PictrueLibrary> list = pictrueLibraryService.list(category, dPlatform, -1, this.getOffset(page, size), this.getPageSize(size));
            List<PictrueLibrary> picLists=new ArrayList<PictrueLibrary>();
            if(category==7){
            	for (PictrueLibrary pictrueLibrary : list) {
					pictrueLibrary.setContent("");
					picLists.add(pictrueLibrary);
				}
            }else{
            	picLists=list;
            }
            request.setAttribute("activityEntrance",JSONObject.toJSON(picLists));
        } else {
            request.setAttribute("total", 0);
            request.setAttribute("images", new PictrueLibrary[0]);
        }
        request.setAttribute("dPlatform", dPlatform);
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("pages", this.getTotalPage(total, size));
		return "image/notice/list";
	}

	@RequestMapping(value="/notice/add",method=RequestMethod.GET)
	public String addNoticeMessage() {
		return "image/notice/add";
	}
	
	@RequestMapping(value="/notice/detail/{id:\\d+}")
	public String noticeDetail(@PathVariable("id") int id, HttpServletRequest request) {
		request.setAttribute("path", properties.getUploadPath());
    	request.setAttribute("operation",DETAIL);
    	PictrueLibrary image = pictrueLibraryService.get(id);
        request.setAttribute("image", image);
		return "image/notice/edit";
	}
	
	@RequestMapping(value="/notice/edit/{id:\\d+}")
	public String noticeEdit(@PathVariable("id") int id, HttpServletRequest request) {
		request.setAttribute("path", properties.getUploadPath());
    	request.setAttribute("operation",EDIT);
    	PictrueLibrary image = pictrueLibraryService.get(id);
        request.setAttribute("image", image);
		return "image/notice/edit";
	}
	
   @RequestMapping(value="/notice/save", method=RequestMethod.POST)
    public String noticeSave(@Valid PictrueLibrary image, BindingResult validResult,Integer dPlatform, HttpServletRequest request, RedirectAttributesModelMap redirectAttributesModelMap) {
        if (!validResult.hasErrors()) {
            Map<String, String> result =upload(request);
            String url = StringUtils.substring(result.values().toString(), 1, result.values().toString().length() - 1);
            if (StringUtils.isNotBlank(url)) {
                image.setUrl(url);
            }
            if(StringUtils.isBlank(image.getContent())){
                image.setContent("");
            }
            if (StringUtils.isBlank(image.getUrl()) || (StringUtils.isNotBlank(image.getUrl()) && ValidatorUtil.isImageUrl(image.getUrl()))) {
                pictrueLibraryService.save(image);
            }
        }
        redirectAttributesModelMap.addAttribute("dPlatform", dPlatform);
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/banner/list/1/7";
    }
   @RequestMapping(value="notice/all",method=RequestMethod.POST)
   @ResponseBody
    public JSONObject getAllPictrues(){
	   JSONObject result=new JSONObject();
	   List<PictrueLibrary> list = pictrueLibraryService.list(7, -1, -1, 0, 0);
	   if (list.size()>0){
		   result.put("code", true);
		   result.put("list",JSONObject.toJSON(list));
		   return result;
	   }
	   result.put("code", false);
	   return result;
   }
	
}
