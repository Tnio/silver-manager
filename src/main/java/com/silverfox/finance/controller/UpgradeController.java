package com.silverfox.finance.controller;

import static com.silverfox.finance.util.ConstantUtil.ALIYUN_OSS;
import static com.silverfox.finance.util.ConstantUtil.BACK_SLASH;
import static com.silverfox.finance.util.ConstantUtil.BLANK;
import static com.silverfox.finance.util.ConstantUtil.DOT;
import static com.silverfox.finance.util.ConstantUtil.FILE_SUFFIX_APATCH;
import static com.silverfox.finance.util.ConstantUtil.FILE_SUFFIX_APK;
import static com.silverfox.finance.util.ConstantUtil.FILE_SUFFIX_CSV;
import static com.silverfox.finance.util.ConstantUtil.FILE_SUFFIX_IPA;
import static com.silverfox.finance.util.ConstantUtil.FILE_SUFFIX_PDF;
import static com.silverfox.finance.util.ConstantUtil.GBK;
import static com.silverfox.finance.util.ConstantUtil.MINUS;
import static com.silverfox.finance.util.ConstantUtil.NUMBER_MONTH_FORMAT;
import static com.silverfox.finance.util.ConstantUtil.SLASH;
import static com.silverfox.finance.util.OSSUtil.BUCKETNAME;
import static com.silverfox.finance.util.OSSUtil.BUCKETNAME_FILE;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.alibaba.fastjson.JSON;
import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSSException;
import com.silverfox.finance.domain.AppVersion;
import com.silverfox.finance.domain.GoodsCouponCode;
import com.silverfox.finance.entity.ArrayObjectEntity;
import com.silverfox.finance.service.SystemService;
import com.silverfox.finance.util.OSSUtil;


@Controller
@RequestMapping("/upgrade")
public class UpgradeController extends BaseController {
	@Autowired
	private SystemService systemService;
	 
	@RequestMapping(value="/version/add/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
	public String forwardToCreation(String versionSearch, String contentSearch, @PathVariable("size")int size, @PathVariable("page")int page, HttpServletRequest request) {
		request.setAttribute("page", this.getPage(page));
		request.setAttribute("size", this.getPageSize(size));
		request.setAttribute("version",versionSearch);
		request.setAttribute("content",contentSearch);
		request.setAttribute("path", properties.getUploadPath());
		return "upgrade/version/add";
	}
	
	@RequestMapping(value="/version/edit/{id:\\d+}/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
	public String forwardToModification(String versionSearch, String contentSearch, @PathVariable("id")int id, @PathVariable("size")int size, @PathVariable("page")int page, HttpServletRequest request) {
		request.setAttribute("page", this.getPage(page));
		request.setAttribute("size", this.getPageSize(size));
		request.setAttribute("version",versionSearch);
		request.setAttribute("content",contentSearch);
		request.setAttribute("path", properties.getUploadPath());
		request.setAttribute("operation",EDIT);
		request.setAttribute("appVersion", systemService.getAppVersion(id));
		return "upgrade/version/edit";
	}
	
	@RequestMapping(value="/version/detail/{id:\\d+}/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
	public String forwardToDetail(@PathVariable("id")int id, @PathVariable("size")int size, @PathVariable("page")int page, HttpServletRequest request) {
		request.setAttribute("page", this.getPage(page));
		request.setAttribute("size", this.getPageSize(size));
		request.setAttribute("path", properties.getUploadPath());
		request.setAttribute("operation", DETAIL);
		request.setAttribute("appVersion", systemService.getAppVersion(id));
		return "upgrade/version/edit";
	}
	
	@RequestMapping(value="/version/patch/{id:\\d+}/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
	public String forwardToPatch(String versionSearch, String contentSearch, @PathVariable("id")int id, @PathVariable("size")int size, @PathVariable("page")int page, HttpServletRequest request) {
		request.setAttribute("page", this.getPage(page));
		request.setAttribute("size", this.getPageSize(size));
		request.setAttribute("version",versionSearch);
		request.setAttribute("content",contentSearch);
		AppVersion appVersion = systemService.getAppVersion(id);
		short patchNo = systemService.getPatchNoByVersion(appVersion.getVersion());
		appVersion.setPatchNO(patchNo);
		request.setAttribute("appVersion", appVersion);
		return "upgrade/version/patch";
	}
	
	@RequestMapping("/version/list/{page:\\d+}")
	public String list(String versionSearch, String contentSearch, Integer size, @PathVariable("page") int page, HttpServletRequest request) {
		int total = systemService.countAppVersion(versionSearch, contentSearch);
		if (total > 0) {
			request.setAttribute("total", total);
			request.setAttribute("appVersions", systemService.listAppVersion(versionSearch, contentSearch, this.getOffset(page, size), this.getPageSize(size)));
		} else {
			request.setAttribute("total", 0);
			request.setAttribute("appVersions", new AppVersion[0]);
		}
		request.setAttribute("size", this.getPageSize(size));
		request.setAttribute("page", this.getPage(page));
		request.setAttribute("pages", this.getTotalPage(total, size));
		request.setAttribute("version",versionSearch);
		request.setAttribute("content",contentSearch);
		return "upgrade/version/list";
	}

	@RequestMapping(value = "/version/save", method = RequestMethod.POST)
	public String save(@Valid AppVersion appVersion, BindingResult result, String versionSearch, String contentSearch, Integer page, Integer size, HttpServletRequest request) {
		if (!result.hasErrors()) {
			systemService.saveAppVersion(appVersion);
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/upgrade/version/list/"+this.getPage(page);
	}
	
	
	@RequestMapping(value = "/version/patch/save", method = RequestMethod.POST)
	public String patchSave(AppVersion appVersion, String versionSearch, String contentSearch, Integer page, Integer size, HttpServletRequest request) {
		systemService.saveAppVersionPatch(appVersion);
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/upgrade/version/list/"+this.getPage(page);
	}
	
	@RequestMapping(value = "/version/enable/{id:\\d+}/{status:\\d+}", method = RequestMethod.POST)
	@ResponseBody
	public boolean enable(@PathVariable("id")int id, @PathVariable("status")short status, HttpServletRequest request) {
		if (id > 0) {
			return systemService.enableVersion(id, status);
		}
		return false;
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
	
	@RequestMapping(value="/version/duplicate/number", method=RequestMethod.GET)
	@ResponseBody
	public String duplicate(int id, String fieldId, String fieldValue) {
		if (StringUtils.isNotBlank(fieldId) && StringUtils.isNotBlank(fieldValue)) {
			ArrayObjectEntity json = new ArrayObjectEntity();
			boolean result = systemService.duplicateAppVersion(id, StringUtils.trim(fieldValue));
			json.setObject(fieldId);
			json.setSuccess(result);
			if (result) {
				json.setMessage(properties.getVersionNumberPass()); 
			} else {
				json.setMessage(properties.getVersionNumberNoPass()); 
			}
			return json.toString(); 
		}
		return null;
	}
	
	@RequestMapping(value="/version/upload", method=RequestMethod.POST)
	@ResponseBody
	public void uploadApp(HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("");
		realPath = StringUtils.replace(realPath, BACK_SLASH, SLASH);
		String sourcePath =  properties.getUploadPath();
		
		CommonsMultipartResolver multipartResolver  = new CommonsMultipartResolver(request.getSession().getServletContext());
    	if(multipartResolver.isMultipart(request)){
    		MultipartHttpServletRequest  multiRequest = (MultipartHttpServletRequest)request;
    	    Iterator<String>  iterator = multiRequest.getFileNames();
    	    File path =new File(realPath+sourcePath);
			if(!path.exists() && !path.isDirectory()){       
				path.mkdir();    
			}
			
		    while(iterator.hasNext()){
		    	MultipartFile file = multiRequest.getFile(iterator.next());
		    	String originalFilename = file.getOriginalFilename();
		    	if(file != null && StringUtils.isNotBlank(originalFilename)){
					try {
						file.transferTo(new File(path.getAbsolutePath()+File.separator+originalFilename));
					} catch (IOException e) {
						LOGGER.error(e.getMessage(), e);
						continue;
					}
		    	}
		    }
    	}
	}
	
	protected LinkedHashMap<String, String> upload(HttpServletRequest request) {
		SimpleDateFormat sdf = new SimpleDateFormat(NUMBER_MONTH_FORMAT);
		LinkedHashMap<String, String> result = new LinkedHashMap<String, String>();
		CommonsMultipartResolver multipartResolver  = new CommonsMultipartResolver(request.getSession().getServletContext());
    	if(multipartResolver.isMultipart(request)){
    		MultipartHttpServletRequest  multiRequest = (MultipartHttpServletRequest)request;
    	    Iterator<String>  iterator = multiRequest.getFileNames();
    		 while(iterator.hasNext()){
 		    	MultipartFile file = multiRequest.getFile(iterator.next());
 		    	String originalFilename = file.getOriginalFilename();
 		    	if(file != null && StringUtils.isNotBlank(originalFilename)){
					try (InputStream stream = file.getInputStream()) {
						String uuid = UUID.randomUUID().toString();
						uuid = StringUtils.replace(uuid, MINUS, BLANK);
						String suffix = StringUtils.substring(originalFilename, StringUtils.lastIndexOf(originalFilename, DOT));
						String name = file.getName();
						String fileName = sdf.format(new Date())+SLASH+uuid+suffix;
						if (suffix.toLowerCase().equals(FILE_SUFFIX_PDF) || suffix.toLowerCase().equals(FILE_SUFFIX_APK) || suffix.toLowerCase().equals(FILE_SUFFIX_IPA) ||suffix.toLowerCase().equals(FILE_SUFFIX_APATCH)) {
							fileName = sdf.format(new Date())+SLASH+ originalFilename;
							putOSSObject(fileName, BUCKETNAME_FILE,	stream);
							result.put(name, ALIYUN_OSS+BUCKETNAME_FILE+SLASH + fileName);
						} else if(suffix.toLowerCase().equals(FILE_SUFFIX_CSV)){
							result.put(name, JSON.toJSONString(this.readCsv(file.getInputStream())));
						}else {
							putOSSObject(fileName, BUCKETNAME, stream);
							result.put(name, ALIYUN_OSS+BUCKETNAME+SLASH+fileName);
						}
					} catch (IOException e) {
						LOGGER.error("upload file to oss error: "+e.getMessage());
					}
 		    	}
 		    }
    	}
		return result;
	}
	
	protected List<GoodsCouponCode> readCsv(InputStream in){
		List<GoodsCouponCode> codes = new ArrayList<GoodsCouponCode>();
		BufferedReader br=null;
		try {
			InputStreamReader isr = new InputStreamReader(in,GBK);
			br = new BufferedReader(isr);
			String line = "";
			int index = 0;
			int row = 0;
            while ((line = br.readLine()) != null) {
            	index ++;
            	if(index == 1){
            		continue;
            	}
            	if(StringUtils.isNotBlank(line)){
            		if(line.length() > 0 && line.length() <= 20){
            			GoodsCouponCode code = new GoodsCouponCode();
        				code.setCode(line);
        				code.setUsed(0);
        				codes.add(code);
        				row ++;
        				if(row > 999){
        					break;
        				}
            		}
            	}
            }
		} catch (Exception e) {
			LOGGER.info(e.getMessage());
		}finally{
			if(br!=null){
				try{
					br.close();
					br=null;
				}catch(IOException e){
					LOGGER.info(e.getMessage());
				}
			}
		}
		return codes;
	}
	
	protected void putOSSObject(String key, String bucketName, InputStream stream) {
		try {
			OSSUtil.ensureBucket( bucketName);
			OSSUtil.setBucketPublicReadable(bucketName);
			OSSUtil.uploadFile(bucketName, key, stream);
		} catch (OSSException | ClientException | IOException e) {
			LOGGER.error("put oss object to aliyun error: "+e.getMessage());
		}
	}
}