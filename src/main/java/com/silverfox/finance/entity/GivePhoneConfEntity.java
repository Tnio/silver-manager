package com.silverfox.finance.entity;

import java.io.Serializable;

public class GivePhoneConfEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private int tradeMoney;
	private int quantity;
	private int moneyLimt;
	private int financePeriod;
	private String beginTime;

	public GivePhoneConfEntity() {

	}

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

	public int getTradeMoney() {
		return tradeMoney;
	}

	public void setTradeMoney(int tradeMoney) {
		this.tradeMoney = tradeMoney;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getMoneyLimt() {
		return moneyLimt;
	}

	public void setMoneyLimt(int moneyLimt) {
		this.moneyLimt = moneyLimt;
	}

	public int getFinancePeriod() {
		return financePeriod;
	}

	public void setFinancePeriod(int financePeriod) {
		this.financePeriod = financePeriod;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}
}
