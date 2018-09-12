package com.silverfox.finance.entity;

import java.io.Serializable;

public class FbabaEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int userId;
	private String channelId;
	private String orderNo;
	private int principal;
	private String productName;
	private int financePeriod;
	private String orderTime;
	private String type;

	public FbabaEntity() {

	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getChannelId() {
		return channelId;
	}

	public void setChannelId(String channelId) {
		this.channelId = channelId;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public int getPrincipal() {
		return principal;
	}

	public void setPrincipal(int principal) {
		this.principal = principal;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getFinancePeriod() {
		return financePeriod;
	}

	public void setFinancePeriod(int financePeriod) {
		this.financePeriod = financePeriod;
	}

	public String getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}
