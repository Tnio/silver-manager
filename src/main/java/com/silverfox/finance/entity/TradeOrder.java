package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

public class TradeOrder implements Serializable {
	private static final long serialVersionUID = 1L;
	private Double principal;
	private Date orderTime;
	private String productName;
	private Double couponAmount;
	private int interestPeriod;
	private String cardNO;
	private String bankNO;
	private int status;
	private int orderType;

	public TradeOrder() {

	}

	public Double getPrincipal() {
		return principal;
	}

	public void setPrincipal(Double principal) {
		this.principal = principal;
	}

	public Date getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public Double getCouponAmount() {
		return couponAmount;
	}

	public void setCouponAmount(Double couponAmount) {
		this.couponAmount = couponAmount;
	}

	public int getInterestPeriod() {
		return interestPeriod;
	}

	public void setInterestPeriod(int interestPeriod) {
		this.interestPeriod = interestPeriod;
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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getOrderType() {
		return orderType;
	}

	public void setOrderType(int orderType) {
		this.orderType = orderType;
	}
}