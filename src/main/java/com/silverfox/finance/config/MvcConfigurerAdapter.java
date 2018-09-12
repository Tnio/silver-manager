package com.silverfox.finance.config;

import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.silverfox.finance.interceptor.SecurityHandlerInterceptor;

public class MvcConfigurerAdapter extends WebMvcConfigurerAdapter {
	private AplicationResourceProperties properties;
	
	public MvcConfigurerAdapter(AplicationResourceProperties properties) {
		this.properties = properties;
	}
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new SecurityHandlerInterceptor(this.properties)).addPathPatterns("/**");
		super.addInterceptors(registry);
	}
}
