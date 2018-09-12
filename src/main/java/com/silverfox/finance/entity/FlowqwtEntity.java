package com.silverfox.finance.entity;

import java.io.Serializable;

public class FlowqwtEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private String userName;
	private String passwrod;
	private String meal;
	private String apikey;
	private String mobile;

	public FlowqwtEntity() {

	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPasswrod() {
		return passwrod;
	}

	public void setPasswrod(String passwrod) {
		this.passwrod = passwrod;
	}

	public String getMeal() {
		return meal;
	}

	public void setMeal(String meal) {
		this.meal = meal;
	}

	public String getApikey() {
		return apikey;
	}

	public void setApikey(String apikey) {
		this.apikey = apikey;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

}
