package com.silverfox.finance.domain;

import java.io.Serializable;

public class PayBank implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String bankName;
	private String bankNO;
	private int singleLimit;
	private int dayLimit;
	private int monthLimit;
	private int payChannel;
	private int enable;
	private String logoUrl;
	private int sortNumber;

	public PayBank() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getLogoUrl() {
		return logoUrl;
	}

	public void setLogoUrl(String logoUrl) {
		this.logoUrl = logoUrl;
	}

	public int getSortNumber() {
		return sortNumber;
	}

	public void setSortNumber(int sortNumber) {
		this.sortNumber = sortNumber;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getBankNO() {
		return bankNO;
	}

	public void setBankNO(String bankNO) {
		this.bankNO = bankNO;
	}

	public int getSingleLimit() {
		return singleLimit;
	}

	public void setSingleLimit(int singleLimit) {
		this.singleLimit = singleLimit;
	}

	public int getDayLimit() {
		return dayLimit;
	}

	public void setDayLimit(int dayLimit) {
		this.dayLimit = dayLimit;
	}

	public int getMonthLimit() {
		return monthLimit;
	}

	public void setMonthLimit(int monthLimit) {
		this.monthLimit = monthLimit;
	}

	public int getPayChannel() {
		return payChannel;
	}

	public void setPayChannel(int payChannel) {
		this.payChannel = payChannel;
	}

	public int getEnable() {
		return enable;
	}

	public void setEnable(int enable) {
		this.enable = enable;
	}
}