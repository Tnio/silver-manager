package com.silverfox.finance.entity;

import java.io.Serializable;

public class WdzjOrderEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	private String subscribeUserName;
	private double amount;
	private double validAmount;
	private String addDate;
	private int status;
	private int type;
	// private int sourceType;

	public WdzjOrderEntity() {

	}

	public String getSubscribeUserName() {
		return subscribeUserName;
	}

	public void setSubscribeUserName(String subscribeUserName) {
		this.subscribeUserName = subscribeUserName;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public double getValidAmount() {
		return validAmount;
	}

	public void setValidAmount(double validAmount) {
		this.validAmount = validAmount;
	}

	public String getAddDate() {
		return addDate;
	}

	public void setAddDate(String addDate) {
		this.addDate = addDate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
	/*
	 * public int getSourceType() { return sourceType; } public void
	 * setSourceType(int sourceType) { this.sourceType = sourceType; }
	 */
}
