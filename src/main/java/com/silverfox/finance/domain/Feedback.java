package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class Feedback implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String contact;
	@Size(max = 50)
	private String phoneModel;
	@Size(max = 20)
	private String deviceVersion;
	@Size(max = 20)
	private String appVersion;
	private Date feedTime;
	@NotNull
	@Size(min = 1, max = 150)
	private String content;

	public Feedback() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getPhoneModel() {
		return phoneModel;
	}

	public void setPhoneModel(String phoneModel) {
		this.phoneModel = phoneModel;
	}

	public String getDeviceVersion() {
		return deviceVersion;
	}

	public void setDeviceVersion(String deviceVersion) {
		this.deviceVersion = deviceVersion;
	}

	public String getAppVersion() {
		return appVersion;
	}

	public void setAppVersion(String appVersion) {
		this.appVersion = appVersion;
	}

	public Date getFeedTime() {
		return feedTime;
	}

	public void setFeedTime(Date feedTime) {
		this.feedTime = feedTime;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}
