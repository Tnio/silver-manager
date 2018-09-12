package com.silverfox.finance.domain;

import java.io.Serializable;

public class CouponActivity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private int status;
	private int quantity;
	private int initialNumber;
	private int raceFrequency;
	private String remark;
	private String beginTime;
	private String endTime;
	private String url;
	private String couponIds;
	private String couponAmounts;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getInitialNumber() {
		return initialNumber;
	}

	public void setInitialNumber(int initialNumber) {
		this.initialNumber = initialNumber;
	}

	public int getRaceFrequency() {
		return raceFrequency;
	}

	public void setRaceFrequency(int raceFrequency) {
		this.raceFrequency = raceFrequency;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getCouponIds() {
		return couponIds;
	}

	public void setCouponIds(String couponIds) {
		this.couponIds = couponIds;
	}

	public String getCouponAmounts() {
		return couponAmounts;
	}

	public void setCouponAmounts(String couponAmounts) {
		this.couponAmounts = couponAmounts;
	}
}