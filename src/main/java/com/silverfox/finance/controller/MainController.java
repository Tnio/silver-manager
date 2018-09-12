package com.silverfox.finance.controller;

import static com.silverfox.finance.util.ConstantUtil.ALIYUN_OSS;
import static com.silverfox.finance.util.ConstantUtil.BLANK;
import static com.silverfox.finance.util.ConstantUtil.CODE;
import static com.silverfox.finance.util.ConstantUtil.DOT;
import static com.silverfox.finance.util.ConstantUtil.FILE_SUFFIX_APATCH;
import static com.silverfox.finance.util.ConstantUtil.FILE_SUFFIX_APK;
import static com.silverfox.finance.util.ConstantUtil.FILE_SUFFIX_CSV;
import static com.silverfox.finance.util.ConstantUtil.FILE_SUFFIX_IPA;
import static com.silverfox.finance.util.ConstantUtil.FILE_SUFFIX_PDF;
import static com.silverfox.finance.util.ConstantUtil.GBK;
import static com.silverfox.finance.util.ConstantUtil.MINUS;
import static com.silverfox.finance.util.ConstantUtil.MSG;
import static com.silverfox.finance.util.ConstantUtil.NUMBER_MONTH_FORMAT;
import static com.silverfox.finance.util.ConstantUtil.OTPAUTH;
import static com.silverfox.finance.util.ConstantUtil.SLASH;
import static com.silverfox.finance.util.ConstantUtil.TOTP;
import static com.silverfox.finance.util.OSSUtil.BUCKETNAME;
import static com.silverfox.finance.util.OSSUtil.BUCKETNAME_FILE;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSSException;
import com.silverfox.finance.domain.Admin;
import com.silverfox.finance.domain.GoodsCouponCode;
import com.silverfox.finance.domain.LogLogin;
import com.silverfox.finance.entity.SecurityEntity;
import com.silverfox.finance.enumeration.MainPageStatisticsEnum;
import com.silverfox.finance.service.SystemService;
import com.silverfox.finance.service.TradeService;
import com.silverfox.finance.util.CaptchaUtil;
import com.silverfox.finance.util.CaptchaUtil.ComplexLevel;
import com.silverfox.finance.util.ConstantUtil;
import com.silverfox.finance.util.OSSUtil;
import com.silverfox.finance.util.ValidatorUtil;

@Controller
@RequestMapping("/")
public class MainController extends BaseController {
	private static final int TOTP_BIND = 1;
	@Autowired
	private SystemService systemService;
	@Autowired
	private TradeService tradeService;
	
	@RequestMapping(value="")
	public String index(Model model) {
		return "login";
	}
	
	@RequestMapping("header")
	public String header() {
		return "include/header";
	}
	
	@RequestMapping("upload")
	public String upload(String rootPath, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "upload";
	}
	
	@RequestMapping("menu")
	public String menu() {
		return "include/menu";
	}
	
	@RequestMapping("message/board")
	public String messageBoard() {
		return "message-board";
	}

	@RequestMapping("message/board/save")
	@ResponseBody
	public boolean saveMessageBoard(String name, String content, Model model) {
		return true;
	}
	
	@RequestMapping("sidebar")
	public String sidebar() {
		
		return "include/sidebar";
	}
	
	@RequestMapping("navbar")
	public String navbar() {
		
		return "include/navbar";
	}
	
	@RequestMapping("breadcrumb")
	public String breadcrumb() {
		
		return "include/breadcrumb";
	}
	
	@RequestMapping("authority")
	public String authority() {
		
		return "include/authority";
	}

	@RequestMapping("footer")
	public String footer() {
		
		return "include/footer";
	}

	@RequestMapping("main")
	public String main(HttpServletRequest request) {
		return "main";
	}
	
	@RequestMapping(value="login/admin", method=RequestMethod.GET)
	@ResponseBody
	public Admin getAdmin(String name) {
		return systemService.getAdmin(name);
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String doLogin(String name, String rememberme, String authCode, HttpServletRequest request, HttpServletResponse response) {
		String page = "login";
		if(StringUtils.isBlank(name) || StringUtils.isBlank(authCode)){
			request.setAttribute("message", messageSource.getMessage("login.failure", null, Locale.getDefault()));
			return page;
		}
		if (!ValidatorUtil.isLoginName(name)) {
			request.setAttribute("message", messageSource.getMessage("login.name.error", null, Locale.getDefault()));
			return page;
		}
		Admin admin = systemService.getAdmin(name);
		if(admin == null || admin.getRole() == null ) {
			request.setAttribute("message", messageSource.getMessage("login.name.no.existence", null, Locale.getDefault()));
			return page;
		}
		if(admin.getRole().getStatus() == 0 || admin.getStatus() == 0){
			request.setAttribute("message", messageSource.getMessage("login.failure", null, Locale.getDefault()));
			return page;
		} 
		if(StringUtils.isNotBlank(rememberme)) {
			Cookie cookie = new Cookie("username", name);
			cookie.setMaxAge(604800);
			response.addCookie(cookie);
		}
		
//		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
//		nvps.add(new BasicNameValuePair("userName", name));
//		nvps.add(new BasicNameValuePair("authCode", authCode));
//		String result = this.invokeHttp(properties.getAuthUrl()+messageSource.getMessage("gauth.authorize.path",null, null), nvps);
//		if(StringUtils.isNotBlank(result)) {
//			JSONObject json = JSONObject.parseObject(result); 
//			if(json != null && json.containsKey(CODE)) {
//				if(StringUtils.equals(json.getString(CODE), String.valueOf(HttpServletResponse.SC_OK))) {
					if(admin.getRole() != null) {
						LogLogin logLogin = new LogLogin();
						logLogin.setIp(this.getIpAddr(request));
						logLogin.setName(admin.getRealName());
						logLogin = systemService.saveLogLogin(logLogin);
						Integer roleId = admin.getRole().getId();
						SecurityEntity security = new SecurityEntity();
						security.setServerPath(properties.getHttpsUrl());
						security.setAdmin(admin);
						security.setRole(systemService.getRole(roleId));
						security.setObject(logLogin);
						security.setMenu(systemService.getMenu(roleId));
						request.getSession().setAttribute(ConstantUtil.SESSION_KEY, security);
						request.getSession().removeAttribute(TOTP);
						request.getSession().removeAttribute(OTPAUTH);
						return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/main";
					} else {
						request.setAttribute("message", messageSource.getMessage("login.name.no.existence", null, Locale.getDefault()));
					}
//				} else {
//					request.setAttribute("message", json.getString(MSG));
//				}
//
//			} else {
//				request.setAttribute("message", messageSource.getMessage("auth.server.error", null, Locale.getDefault()));
//			}
//		} else {
//			request.setAttribute("message", messageSource.getMessage("auth.server.error", null, Locale.getDefault()));
//		}
		return "login";
	}

	@RequestMapping(value="login", method=RequestMethod.GET)
	public String initLogin(HttpServletRequest request) {
		
		return "login";
	}
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		if(session != null) {
			//session.invalidate();
			session.removeAttribute(ConstantUtil.SESSION_KEY);
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/";
	}
	
	@RequestMapping(value="get/function/{roleId:\\d+}", method=RequestMethod.GET)
	@ResponseBody
	public List<Integer> getFunctions(@PathVariable("roleId")int roleId){
		return systemService.getFunctions(roleId);
	}
	
	@RequestMapping(value="validate/code", method=RequestMethod.GET)
	@ResponseBody
	public void validateCode(HttpServletRequest request, HttpServletResponse response){
		try{
			HttpSession session = request.getSession();
			Object[] obj=CaptchaUtil.getCaptchaImage(70, 28, 16, 100, 500, true,true, ComplexLevel.SIMPLE);
			response.setHeader("Pragma","no-cache");
			response.setHeader("Cache-Control","no-cache");
			response.setDateHeader("Expires",0);
			response.setContentType("image/jpeg");
			ServletOutputStream sos=response.getOutputStream();
			ImageIO.write((BufferedImage)obj[0],"jpeg",sos);
			sos.close();
			session.setAttribute("imgValidationCode", obj[1]);
		} catch (IOException e){
			LOGGER.error("error", e);
		}
	}
	
	@RequestMapping(value="/totp/{user}", method=RequestMethod.GET)
	public String initTotp(@PathVariable("user")String userName, HttpServletRequest request) {
		//Object totp = request.getSession().getAttribute(TOTP);
		//if(totp != null) {
		Admin admin = systemService.getAdmin(userName);
		if(admin != null) {
			List<NameValuePair> nvps = new ArrayList<NameValuePair>();
			nvps.add(new BasicNameValuePair("userName", userName));
			String secretKey = this.invokeHttp(properties.getAuthUrl()+messageSource.getMessage("gauth.secret.path", null, null), nvps);
			LOGGER.info("get secret: url[" + properties.getAuthUrl()+messageSource.getMessage("gauth.secret.path", null, null) + "], result: [" + secretKey + "]");
			if(StringUtils.isNotBlank(secretKey)) {
				String totpURL = this.invokeHttp(properties.getAuthUrl()+messageSource.getMessage("gauth.totp.path", null, null), nvps);
				LOGGER.info("get totp: url[" + properties.getAuthUrl()+messageSource.getMessage("gauth.totp.path", null, null) + "], result: [" + totpURL + "]");
				if(StringUtils.isNotBlank(totpURL)) {
					request.setAttribute("secretKey", secretKey);
					request.setAttribute("totpURL", totpURL);
				} else {
					request.setAttribute("message", messageSource.getMessage("auth.server.error", null, Locale.getDefault()));
				}
			} else {
				request.setAttribute("message", messageSource.getMessage("auth.server.error", null, Locale.getDefault()));
			}
			request.setAttribute("userName", userName);
		} else {
			request.setAttribute("message", messageSource.getMessage("login.name.no.existence", null, Locale.getDefault()));
		}
		return "totp";
	}
	
	@RequestMapping(value="/totp", method=RequestMethod.POST)
	public String bindTotp(String userName, String authCodeFirst, String authCodeSecond, String secretKey, String totpURL, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(!StringUtils.equals(authCodeFirst, authCodeSecond)) {
			Admin admin = systemService.getAdmin(userName);
			if(admin != null) {
				String gauthURL = properties.getAuthUrl()+messageSource.getMessage("gauth.authorize.path",null,null);
				List<NameValuePair> nvps = new ArrayList<NameValuePair>();
				nvps.add(new BasicNameValuePair("userName", userName));
				nvps.add(new BasicNameValuePair("authCode", authCodeFirst));
				String authrizedFirest = this.invokeHttp(gauthURL, nvps);
				
				nvps = new ArrayList<NameValuePair>();
				nvps.add(new BasicNameValuePair("userName", userName));
				nvps.add(new BasicNameValuePair("authCode", authCodeSecond));
				String authrizedSecond = this.invokeHttp(gauthURL, nvps);
				
				if(StringUtils.isNotBlank(authrizedFirest) && StringUtils.isNotBlank(authrizedSecond)) {
					JSONObject jsonFirst = JSONObject.parseObject(authrizedFirest);
					JSONObject jsonSecond = JSONObject.parseObject(authrizedSecond);
					if(jsonFirst != null && jsonFirst.containsKey(CODE) && jsonSecond != null && jsonSecond.containsKey(CODE)) {
						String scOK = String.valueOf(HttpServletResponse.SC_OK);
						if(StringUtils.equals(jsonFirst.getString(CODE), scOK) && StringUtils.equals(jsonSecond.getString(CODE), scOK)) {
							if(admin.getId() > 0) {
								if (systemService.totp(admin.getId(), TOTP_BIND)) {
									return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/";
								}
							}
							request.setAttribute("message", messageSource.getMessage("gauth.totp.bind.success", null, Locale.getDefault()));
						} else {
							request.setAttribute("message", messageSource.getMessage("gauth.totp.bind.failure", null, Locale.getDefault()));
						}
					} else {
						request.setAttribute("message", messageSource.getMessage("auth.server.error", null, Locale.getDefault()));
					}
				} else {
					request.setAttribute("message", messageSource.getMessage("auth.server.error", null, Locale.getDefault()));
				}
			} else {
				request.setAttribute("message", messageSource.getMessage("login.name.no.existence", null, Locale.getDefault()));
			}
		} else {
			request.setAttribute("message", messageSource.getMessage("gauth.same.code", null, Locale.getDefault()));
		}
		request.setAttribute("userName", userName);
		request.setAttribute("secretKey", secretKey);
		request.setAttribute("totpURL", totpURL);
		
		return "totp";
	}
	
	@RequestMapping(value="/gauth/{user}", method=RequestMethod.GET)
	public String initGauthTotp(@PathVariable("user")String userName, HttpServletRequest request) {
		Object otpauth = request.getSession().getAttribute(OTPAUTH);
		if(otpauth != null) {
			Admin admin = systemService.getAdmin(userName);
			if(admin != null) {
				if(admin.getTotp() == 0) {
					request.setAttribute("message", messageSource.getMessage("gauth.totp.unbind", null, Locale.getDefault()));
				}
				request.setAttribute("userName", userName);
			} else {
				request.setAttribute("message", messageSource.getMessage("login.name.no.existence", null, Locale.getDefault()));
			}
		} else {
			return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/";
		}
		
		return "gauth";
	}
	
	@RequestMapping(value="/gauth", method=RequestMethod.POST)
	public String authorize(String userName, String authCode, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Admin admin = systemService.getAdmin(userName);
		if(admin != null) {
			List<NameValuePair> nvps = new ArrayList<NameValuePair>();
			nvps.add(new BasicNameValuePair("userName", userName));
			nvps.add(new BasicNameValuePair("authCode", authCode));
			String result = this.invokeHttp(properties.getAuthUrl()+messageSource.getMessage("gauth.authorize.path", null, null), nvps);
			if(StringUtils.isNotBlank(result)) {
				JSONObject json = JSONObject.parseObject(result); 
				if(json != null && json.containsKey(CODE)) {
					if(StringUtils.equals(json.getString(CODE), String.valueOf(HttpServletResponse.SC_OK))) {
						if(admin.getRole() != null) {
							LogLogin logLogin = new LogLogin();
							logLogin.setIp(this.getIpAddr(request));
							logLogin.setName(admin.getRealName());
							logLogin = systemService.saveLogLogin(logLogin);
							Integer roleId = admin.getRole().getId();
							SecurityEntity security = new SecurityEntity();
							security.setServerPath(properties.getHttpsUrl());
							security.setAdmin(admin);
							security.setRole(systemService.getRole(roleId));     
							security.setObject(logLogin);
							security.setMenu(systemService.getMenu(roleId));
							request.getSession().setAttribute(ConstantUtil.SESSION_KEY, security);
							request.getSession().removeAttribute(TOTP);
							request.getSession().removeAttribute(OTPAUTH);
							return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/main";
						} else {
							request.setAttribute("message", messageSource.getMessage("login.name.no.existence", null, Locale.getDefault()));
						}
					} else {
						request.setAttribute("message", json.getString(MSG));
					}
				} else {
					request.setAttribute("message", messageSource.getMessage("auth.server.error", null, Locale.getDefault()));
				}
			} else {
				request.setAttribute("message", messageSource.getMessage("auth.server.error", null, Locale.getDefault()));
			}
		} else {
			request.setAttribute("message", messageSource.getMessage("login.name.no.existence", null, Locale.getDefault()));
		}
		request.setAttribute("userName", userName);
		return "gauth";
	}
	
	@RequestMapping("/image/upload")
	@ResponseBody
	public void uploadImage(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("utf-8"); 
		boolean checkResult = CheckImageSize(request);
		String fileName = null;
		if(checkResult){
			Map<String, String> result = upload(request);
	        fileName = StringUtils.substring(result.values().toString(), 1, result.values().toString().length() - 1);
		}
		PrintWriter out = response.getWriter();
		out.println(request.getContextPath() + fileName);  
	}

	@RequestMapping(value="trade/customer/current/{type}", method=RequestMethod.GET)
	@ResponseBody
	public List<Long> countTradeCustomer(@PathVariable("type")String type) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		if (StringUtils.equals(type, MainPageStatisticsEnum.TODAY.toString())) {
			return tradeService.countAllCustomerInSometime(format.format(Calendar.getInstance().getTime()));
		} else if (StringUtils.equals(type, MainPageStatisticsEnum.YESTODAY.toString())) {
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DATE, -1);
			return tradeService.countAllCustomerInSometime(format.format(calendar.getTime()));
		}
		return null;
	}
	
	
	@RequestMapping(value="customer/current/{type}", method=RequestMethod.GET)
	@ResponseBody
	public List<Long> countAll(@PathVariable("type")String type) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		if (StringUtils.equals(type, MainPageStatisticsEnum.TODAY.toString())) {
			return tradeService.countAllInSometime(format.format(Calendar.getInstance().getTime()));
		} else if (StringUtils.equals(type, MainPageStatisticsEnum.YESTODAY.toString())) {
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DATE, -1);
			return tradeService.countAllInSometime(format.format(calendar.getTime()));
		}
		return null;
	}
	

	@RequestMapping(value="customer/order/current/{type}", method=RequestMethod.GET)
	@ResponseBody
	public JSONObject countCustomerOrder(@PathVariable("type")String type) {
		JSONObject result = new JSONObject();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		if (StringUtils.equals(type, MainPageStatisticsEnum.TODAY.toString())) {
			result.put("common", tradeService.countOrderInSometime(format.format(Calendar.getInstance().getTime())));
		} else if (StringUtils.equals(type, MainPageStatisticsEnum.YESTODAY.toString())) {
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DATE, -1);
			result.put("common", tradeService.countOrderInSometime(format.format(calendar.getTime())));
		}
		return result;
	}
	
	@RequestMapping(value="order/principal/current/{type}", method=RequestMethod.GET)
	@ResponseBody
	public JSONObject sumOrderPrincipal(@PathVariable("type")String type) {
		JSONObject result = new JSONObject();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		if (StringUtils.equals(type, MainPageStatisticsEnum.TODAY.toString())) {
			result.put("common", tradeService.sumOrderInSometime(format.format(Calendar.getInstance().getTime())));
		} else if (StringUtils.equals(type, MainPageStatisticsEnum.YESTODAY.toString())) {
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DATE, -1);
			result.put("common", tradeService.sumOrderInSometime(format.format(calendar.getTime())));
		}
		return result;
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
	
	private String getIpAddr(HttpServletRequest request) { 
	    String ip = request.getHeader("x-forwarded-for"); 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	        ip = request.getHeader("Proxy-Client-IP"); 
	    } 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	        ip = request.getHeader("WL-Proxy-Client-IP"); 
	    } 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	        ip = request.getRemoteAddr(); 
	    } 
	    return ip; 

	}

	protected boolean CheckImageSize(HttpServletRequest request){
		CommonsMultipartResolver multipartResolver  = new CommonsMultipartResolver(request.getSession().getServletContext());
    	if(multipartResolver.isMultipart(request)){
    		MultipartHttpServletRequest  multiRequest = (MultipartHttpServletRequest)request;
    	    Iterator<String>  iterator = multiRequest.getFileNames();
    		 while(iterator.hasNext()){
 		    	MultipartFile file = multiRequest.getFile(iterator.next());
 		    	if(file.getContentType().equals(ConstantUtil.IMAGE_TYPE)){
 		    		if(file.getSize() > 2048000){
 		    			return false;
 		    		}else{
 		    			return true;
 		    		}
 		    	}
 		    }
    	}
    	return true;
	}
  }