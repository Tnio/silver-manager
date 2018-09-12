package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

public class AssetDetailEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private String orderNO;
	private String productName;
	private double principal;
	private double income;
	private Date buyDate;
	private Date expireDate;
	private int surplusPeriod;
	private int isClearing;
	private String cardNO;
	private String bankNO;

	public String getOrderNO() {
		return orderNO;
	}

	public void setOrderNO(String orderNO) {
		this.orderNO = orderNO;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public double getPrincipal() {
		return principal;
	}

	public void setPrincipal(double principal) {
		this.principal = principal;
	}

	public double getIncome() {
		return income;
	}

	public void setIncome(double income) {
		this.income = income;
	}

	public Date getBuyDate() {
		return buyDate;
	}

	public void setBuyDate(Date buyDate) {
		this.buyDate = buyDate;
	}

	public Date getExpireDate() {
		return expireDate;
	}

	public void setExpireDate(Date expireDate) {
		this.expireDate = expireDate;
	}

	public int getSurplusPeriod() {
		return surplusPeriod;
	}

	public void setSurplusPeriod(int surplusPeriod) {
		this.surplusPeriod = surplusPeriod;
	}

	public int getIsClearing() {
		return isClearing;
	}

	public void setIsClearing(int isClearing) {
		this.isClearing = isClearing;
	}

	public String getCardNO() {
		return cardNO;
	}

	public void setCardNO(String cardNO) {
		this.cardNO = cardNO;
	}

	public String getBankNO() {
		return bankNO;
	}

	public void setBankNO(String bankNO) {
		this.bankNO = bankNO;
	}
}