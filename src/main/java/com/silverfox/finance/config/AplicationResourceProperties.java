package com.silverfox.finance.config;

import java.util.List;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix=AplicationResourceProperties.RESOURCE_PREFIX)
public class AplicationResourceProperties {
	public static final String RESOURCE_PREFIX = "system.resource";
	private String httpsUrl;
	private String authUrl;
	private List<String> ignoreUri;
	private String uploadPath;
	private String versionNumberPass;
	private String versionNumberNoPass;
	private String imageCheck;
	private String appNamePass;
	private String appNameNoPass;
	private String couponActivityUrl;
	private String customersServiceUrl;
	private String customersAccountBalance;
	private String licensenoPass;
	private String licensenoNoPass;
	private String licenses;
	private String sessionLess;
	private String customerExcelName;
	private String commissionRate;
	private String customerUninvestExcelName;
	private String customerLostExcelName;

	private String templatePath;
	private String customerOrderExcelName;
	private String customerOrderInExcelName;
	private String couponCodeExcelName;
	private String pluginUrl;
	private String sayenSmsSend;
	private String huaxingSmsSend;
	private String monternetSmsSend;
	private String emaySmsSend;
	private String huaxingUserSignature;
	private String zookeeprtConfigNamespace;
	private String smsMessageContent;
	private String contractLeisure;
	private String contractOccupy;

	private String multipartMaxFileSize;
	private String multipartMaxRequestSize;
	
	private String ossPath;

	public String getHttpsUrl() {
		return httpsUrl;
	}

	public void setHttpsUrl(String httpsUrl) {
		this.httpsUrl = httpsUrl;
	}

	public String getAuthUrl() {
		return authUrl;
	}

	public void setAuthUrl(String authUrl) {
		this.authUrl = authUrl;
	}

	public List<String> getIgnoreUri() {
		return ignoreUri;
	}

	public void setIgnoreUri(List<String> ignoreUri) {
		this.ignoreUri = ignoreUri;
	}

	public String getUploadPath() {
		return uploadPath;
	}

	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}

	public String getVersionNumberPass() {
		return versionNumberPass;
	}

	public void setVersionNumberPass(String versionNumberPass) {
		this.versionNumberPass = versionNumberPass;
	}

	public String getVersionNumberNoPass() {
		return versionNumberNoPass;
	}

	public void setVersionNumberNoPass(String versionNumberNoPass) {
		this.versionNumberNoPass = versionNumberNoPass;
	}

	public String getImageCheck() {
		return imageCheck;
	}

	public void setImageCheck(String imageCheck) {
		this.imageCheck = imageCheck;
	}

	public String getAppNamePass() {
		return appNamePass;
	}

	public void setAppNamePass(String appNamePass) {
		this.appNamePass = appNamePass;
	}

	public String getAppNameNoPass() {
		return appNameNoPass;
	}

	public void setAppNameNoPass(String appNameNoPass) {
		this.appNameNoPass = appNameNoPass;
	}

	public String getCouponActivityUrl() {
		return couponActivityUrl;
	}

	public void setCouponActivityUrl(String couponActivityUrl) {
		this.couponActivityUrl = couponActivityUrl;
	}

	public String getCustomersServiceUrl() {
		return customersServiceUrl;
	}

	public void setCustomersServiceUrl(String customersServiceUrl) {
		this.customersServiceUrl = customersServiceUrl;
	}

	public String getCustomersAccountBalance() {
		return customersAccountBalance;
	}

	public void setCustomersAccountBalance(String customersAccountBalance) {
		this.customersAccountBalance = customersAccountBalance;
	}

	public String getLicensenoPass() {
		return licensenoPass;
	}

	public void setLicensenoPass(String licensenoPass) {
		this.licensenoPass = licensenoPass;
	}

	public String getLicensenoNoPass() {
		return licensenoNoPass;
	}

	public void setLicensenoNoPass(String licensenoNoPass) {
		this.licensenoNoPass = licensenoNoPass;
	}

	public String getLicenses() {
		return licenses;
	}

	public void setLicenses(String licenses) {
		this.licenses = licenses;
	}
	
	public String getSessionLess() {
		return sessionLess;
	}

	public void setSessionLess(String sessionLess) {
		this.sessionLess = sessionLess;
	}

	public String getCustomerExcelName() {
		return customerExcelName;
	}

	public void setCustomerExcelName(String customerExcelName) {
		this.customerExcelName = customerExcelName;
	}

	public String getCommissionRate() {
		return commissionRate;
	}

	public void setCommissionRate(String commissionRate) {
		this.commissionRate = commissionRate;
	}

	public String getTemplatePath() {
		return templatePath;
	}

	public void setTemplatePath(String templatePath) {
		this.templatePath = templatePath;
	}

	public String getCustomerOrderExcelName() {
		return customerOrderExcelName;
	}

	public void setCustomerOrderExcelName(String customerOrderExcelName) {
		this.customerOrderExcelName = customerOrderExcelName;
	}

	public String getCustomerOrderInExcelName() {
		return customerOrderInExcelName;
	}

	public void setCustomerOrderInExcelName(String customerOrderInExcelName) {
		this.customerOrderInExcelName = customerOrderInExcelName;
	}

	public String getCouponCodeExcelName() {
		return couponCodeExcelName;
	}

	public void setCouponCodeExcelName(String couponCodeExcelName) {
		this.couponCodeExcelName = couponCodeExcelName;
	}

	public String getPluginUrl() {
		return pluginUrl;
	}

	public void setPluginUrl(String pluginUrl) {
		this.pluginUrl = pluginUrl;
	}

	public String getSayenSmsSend() {
		return sayenSmsSend;
	}

	public void setSayenSmsSend(String sayenSmsSend) {
		this.sayenSmsSend = sayenSmsSend;
	}

	public String getHuaxingSmsSend() {
		return huaxingSmsSend;
	}

	public void setHuaxingSmsSend(String huaxingSmsSend) {
		this.huaxingSmsSend = huaxingSmsSend;
	}

	public String getMonternetSmsSend() {
		return monternetSmsSend;
	}

	public void setMonternetSmsSend(String monternetSmsSend) {
		this.monternetSmsSend = monternetSmsSend;
	}

	public String getEmaySmsSend() {
		return emaySmsSend;
	}

	public void setEmaySmsSend(String emaySmsSend) {
		this.emaySmsSend = emaySmsSend;
	}

	public String getHuaxingUserSignature() {
		return huaxingUserSignature;
	}

	public void setHuaxingUserSignature(String huaxingUserSignature) {
		this.huaxingUserSignature = huaxingUserSignature;
	}

	public String getZookeeprtConfigNamespace() {
		return zookeeprtConfigNamespace;
	}

	public void setZookeeprtConfigNamespace(String zookeeprtConfigNamespace) {
		this.zookeeprtConfigNamespace = zookeeprtConfigNamespace;
	}

	public String getSmsMessageContent() {
		return smsMessageContent;
	}

	public void setSmsMessageContent(String smsMessageContent) {
		this.smsMessageContent = smsMessageContent;
	}

	public String getContractLeisure() {
		return contractLeisure;
	}

	public void setContractLeisure(String contractLeisure) {
		this.contractLeisure = contractLeisure;
	}

	public String getContractOccupy() {
		return contractOccupy;
	}

	public void setContractOccupy(String contractOccupy) {
		this.contractOccupy = contractOccupy;
	}

	public String getMultipartMaxFileSize() {
		return multipartMaxFileSize;
	}

	public void setMultipartMaxFileSize(String multipartMaxFileSize) {
		this.multipartMaxFileSize = multipartMaxFileSize;
	}

	public String getMultipartMaxRequestSize() {
		return multipartMaxRequestSize;
	}

	public void setMultipartMaxRequestSize(String multipartMaxRequestSize) {
		this.multipartMaxRequestSize = multipartMaxRequestSize;
	}

	public String getOssPath() {
		return ossPath;
	}

	public void setOssPath(String ossPath) {
		this.ossPath = ossPath;
	}

	public String getCustomerUninvestExcelName() {
		return customerUninvestExcelName;
	}

	public void setCustomerUninvestExcelName(String customerUninvestExcelName) {
		this.customerUninvestExcelName = customerUninvestExcelName;
	}

	public String getCustomerLostExcelName() {
		return customerLostExcelName;
	}

	public void setCustomerLostExcelName(String customerLostExcelName) {
		this.customerLostExcelName = customerLostExcelName;
	}
}