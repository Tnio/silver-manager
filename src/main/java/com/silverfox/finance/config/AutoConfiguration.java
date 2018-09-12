package com.silverfox.finance.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableConfigurationProperties({AplicationResourceProperties.class})
public class AutoConfiguration {
	@Autowired
	private AplicationResourceProperties properties;
	
	@Bean
	public WebMvcConfigurer webMvcConfigurer() {
		return new MvcConfigurerAdapter(properties);
	}
}