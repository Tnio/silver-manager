package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

public class UninvestEntity implements Serializable{
	private static final long serialVersionUID = 1L;
	private int userId;
	private String cellphone;
	private String name;
	private String channelName;
	private Date registerTime;
    
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getCellphone() {
		return cellphone;
	}
	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getChannelName() {
		return channelName;
	}
	public void setChannelName(String channelName) {
		this.channelName = channelName;
	}
	public Date getRegisterTime() {
		return registerTime;
	}
	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}
}
