package com.silverfox.finance.util;

import static com.silverfox.finance.util.ConstantUtil.NORMAL_DATETIME_FORMAT;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.silverfox.finance.entity.SecurityEntity;


public class CommonUtil {
	public static String getIpAddr(HttpServletRequest request) { 
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
	
	public static String getTime(){
		SimpleDateFormat df = new SimpleDateFormat(NORMAL_DATETIME_FORMAT);
		Date now=new Date();
	    return df.format(now);
	}
	
	public static String formatDate(Date date){
		SimpleDateFormat df = new SimpleDateFormat(NORMAL_DATETIME_FORMAT);
	    return df.format(date);
	}
	
	public static SecurityEntity getSecurity(HttpServletRequest request){
		SecurityEntity security = (SecurityEntity)request.getSession().getAttribute(ConstantUtil.SESSION_KEY);
		return security;
	}
}
