package com.silverfox.finance.controller;


import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.UUID;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ThreadFactory;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSSException;
import com.silverfox.finance.config.AplicationResourceProperties;
import com.silverfox.finance.domain.GoodsCouponCode;
import com.silverfox.finance.domain.Role;
import com.silverfox.finance.domain.RoleResource;
import com.silverfox.finance.entity.SecurityEntity;
import com.silverfox.finance.service.ClientService;
import com.silverfox.finance.util.ConstantUtil;
import com.silverfox.finance.util.OSSUtil;


@Controller
public class BaseController {
	protected static final Log LOGGER = LogFactory.getLog(BaseController.class);
	protected static final String FORMAT_UTF8 = "UTF-8";
	protected static final String EDIT = "edit";
	protected static final String DETAIL = "detail";
	protected static final String DEFAULT_SEED = "999999";
	protected static final String DEFAULT_TIMEOUT = "5";
	protected static final String DEFAULT_MESSAGE = "";
	protected static int seqNO = 1;

	protected String uri;
	protected String smsCode;
	protected String smsRegCode;
	protected String smsLoginCode;
	protected String smsTradeCode;
	protected String smsNotification;
	protected String smsUserLoginCode;
	protected String smsPaymentCode;
	protected String seed;
	protected String timeout;
	
	protected static final ScheduledExecutorService EXECUTOR = Executors.newScheduledThreadPool(Runtime.getRuntime().availableProcessors()*2, new ThreadFactory() {
		@Override
		public Thread newThread(Runnable r) {
			Thread t = new Thread(r);
			t.setDaemon(true);
			return t;
		}
	});
	@Autowired
	protected MessageSource messageSource;
	@Autowired
	protected AplicationResourceProperties properties;
	@Autowired
	protected ClientService clientService;
	
	@InitBinder
	public void initBinder(ServletRequestDataBinder binder) {
		binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat(ConstantUtil.NORMAL_DATETIME_FORMAT), true));
	}
	
	protected int getOffset(Integer page, Integer size) {
		if(page == null || page == 0 ) {
			page = 1;
		}
		if(size == null || size == 0) {
			size = 15;
		}
		return (page-1)*size;
	}
	
	protected int getPageSize(Integer size) {
		if(size == null || size == 0) {
			size = 15;
		}
		return size;
	}
	
	protected int getPage(Integer page) {
		if(page == null || page == 0) {
			page = 1;
		}
		return page;
	}
	
	protected int getTotalPage(int total, Integer size) {
		if(size == null || size == 0) {
			size = 15;
		}
		return (int)Math.ceil((double)total / (double)size);
	}
	
	protected String getMessage(String code) {
		return this.messageSource.getMessage(code, null, Locale.getDefault());
	}
	
	protected String getMessage(String code, Object[] args) {
		return this.messageSource.getMessage(code, args, Locale.getDefault());
	}
	
	protected String getMessage(String code, Object[] args, Locale locale) {
		return this.messageSource.getMessage(code, args, locale);
	}
	
	protected String getMessage(String code, Object[] args, String defaultMessage, Locale locale) {
		return this.messageSource.getMessage(code, args, defaultMessage, locale);
	}
	
	protected String invokeHttp(String url, List<NameValuePair> nvps) {
		CloseableHttpClient closeableHttpClient = HttpClients.createDefault();
		HttpPost httpPost = new HttpPost(url);
		try {
			if(nvps != null && nvps.size() > 0) {
				httpPost.setEntity(new UrlEncodedFormEntity(nvps, ConstantUtil.UTF_8));
			}
			CloseableHttpResponse httpResponse = closeableHttpClient.execute(httpPost);
			int statusCode = httpResponse.getStatusLine().getStatusCode();
			if(statusCode == 200) {
				return EntityUtils.toString(httpResponse.getEntity(), ConstantUtil.UTF_8);
			}
		} catch (IOException e) {
			LOGGER.error(e.getMessage());
		} finally {
			httpPost.releaseConnection();
		}
		
		return null;
	}
	
	protected JSONObject service(String url, List<NameValuePair> nvps) {
		CloseableHttpClient closeableHttpClient = HttpClients.createDefault();
		HttpPost httpPost = new HttpPost(url);
		try {
			if(nvps != null && nvps.size() > 0) {
				httpPost.setEntity(new UrlEncodedFormEntity(nvps, ConstantUtil.UTF_8));
			}
			CloseableHttpResponse httpResponse = closeableHttpClient.execute(httpPost);
			int statusCode = httpResponse.getStatusLine().getStatusCode();
			if(statusCode == 200) {
				return JSON.parseObject(EntityUtils.toString(httpResponse.getEntity(), ConstantUtil.UTF_8));
				
			}
		} catch (IOException e) {
			LOGGER.error(e.getMessage());
		} finally {
			httpPost.releaseConnection();
		}
		return null;
	}

	protected ResponseEntity<byte[]> export(String realPath, String fileName, HttpServletRequest request) {
		String agent = request.getHeader("User-Agent");
		boolean isMSIE = (agent != null && agent.toUpperCase().indexOf("MSIE") > 0);
   		HttpHeaders headers = new HttpHeaders();
   		File file = new File(realPath+fileName);
   		try {
   			if(isMSIE){ 
   				fileName = URLEncoder.encode(fileName, ConstantUtil.UTF_8);
   				if(fileName.length() > 150){  
   					fileName = new String(fileName.getBytes(ConstantUtil.UTF_8), ConstantUtil.ISO_8859_1);  
   				}  
   			} else {
   				fileName = new String(fileName.getBytes(ConstantUtil.UTF_8), ConstantUtil.ISO_8859_1);
   			}
   			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
   			headers.setContentDispositionFormData("attachment", fileName);
   			return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.OK);
		} catch (IOException e) {
			LOGGER.error(e.getMessage(), e);
		}
   		return null;
	}
	protected LinkedHashMap<String, String> upload(HttpServletRequest request) {
		SimpleDateFormat sdf = new SimpleDateFormat(ConstantUtil.NUMBER_MONTH_FORMAT);
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
						uuid = StringUtils.replace(uuid, ConstantUtil.MINUS, ConstantUtil.BLANK);
						String suffix = StringUtils.substring(originalFilename, StringUtils.lastIndexOf(originalFilename, ConstantUtil.DOT));
						String name = file.getName();
						String fileName = sdf.format(new Date())+ConstantUtil.SLASH+uuid+suffix;
						if (suffix.toLowerCase().equals(ConstantUtil.FILE_SUFFIX_PDF) || suffix.toLowerCase().equals(ConstantUtil.FILE_SUFFIX_APK) || suffix.toLowerCase().equals(ConstantUtil.FILE_SUFFIX_IPA) ||suffix.toLowerCase().equals(ConstantUtil.FILE_SUFFIX_APATCH)) {
							fileName = sdf.format(new Date())+ConstantUtil.SLASH+ originalFilename;
							putOSSObject(fileName, OSSUtil.BUCKETNAME_FILE,	stream);
							result.put(name, ConstantUtil.ALIYUN_OSS+OSSUtil.BUCKETNAME_FILE+ConstantUtil.SLASH + fileName);
						} else if(suffix.toLowerCase().equals(ConstantUtil.FILE_SUFFIX_CSV)){
							result.put(name, JSON.toJSONString(this.readCsv(file.getInputStream())));
						}else {
							putOSSObject(fileName, OSSUtil.BUCKETNAME, stream);
							result.put(name, ConstantUtil.ALIYUN_OSS+OSSUtil.BUCKETNAME+ConstantUtil.SLASH+fileName);
						}
					} catch (IOException e) {
						LOGGER.error("upload file to oss error: "+e.getMessage());
					}
 		    	}
 		    }
    	}
		return result;
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
	protected List<GoodsCouponCode> readCsv(InputStream in){
		List<GoodsCouponCode> codes = new ArrayList<GoodsCouponCode>();
		BufferedReader br=null;
		try {
			InputStreamReader isr = new InputStreamReader(in,ConstantUtil.GBK);
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
	
	protected boolean getAddFunctionPermit(int resourceId,HttpServletRequest request) {
        boolean flag = false;
	    SecurityEntity security = (SecurityEntity) request.getSession().getAttribute(ConstantUtil.SESSION_KEY);
	    if (security != null) {
		    Role role = security.getRole();
		    List<RoleResource> roleResources = clientService.listRoleResource(role.getId());
		    if (roleResources !=null && roleResources.size()>0) {
			    for (RoleResource roleResource : roleResources) {
				    if (resourceId == roleResource.getResourceId()) {
					    flag = true;
					    break;
				    }
			    }
		    }
	    }
	    return flag;
	}

//	protected void init() {
//		if (org.apache.commons.lang.StringUtils.isBlank(this.uri)) {
//
//			this.uri = properties.getPluginUrl() + this.getMessage("monternet.sms.send", null, null);
//			this.smsCode = this.getMessage("sms.code", null, DEFAULT_MESSAGE, Locale.getDefault());
//			this.smsRegCode = this.getMessage("sms.reg.code", null, DEFAULT_MESSAGE, Locale.getDefault());
//			this.smsLoginCode = this.getMessage("sms.login.code", null, DEFAULT_MESSAGE, Locale.getDefault());
//			this.smsUserLoginCode = this.getMessage("sms.user.login", null, DEFAULT_MESSAGE, Locale.getDefault());
//			this.smsPaymentCode = this.getMessage("sms.payment.code", null, DEFAULT_MESSAGE, Locale.getDefault());
//			this.smsTradeCode = this.getMessage("sms.trade.code", null, DEFAULT_MESSAGE, Locale.getDefault());
//			this.smsNotification = this.getMessage("sms.notification", null, DEFAULT_MESSAGE, Locale.getDefault());
//			this.seed = this.getMessage("sms.seed", null, DEFAULT_SEED, Locale.getDefault());
//			this.timeout = this.getMessage("sms.timeout", null, DEFAULT_TIMEOUT, Locale.getDefault());
//		}
//	}
}