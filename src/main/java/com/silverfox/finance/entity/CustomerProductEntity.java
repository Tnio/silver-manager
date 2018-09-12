package com.silverfox.finance.entity;

import java.io.Serializable;

public class CustomerProductEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int productId;
	private String orderNo;
	private String productName;
	private float customerPrincipal;
	private float payBackAmount;
	private float customerProfit;
	private String payBackDate;
	private boolean payBack;
	private int remainingDays;

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getPayBackDate() {
		return payBackDate;
	}

	public void setPayBackDate(String payBackDate) {
		this.payBackDate = payBackDate;
	}

	public float getPayBackAmount() {
		return payBackAmount;
	}

	public void setPayBackAmount(float payBackAmount) {
		this.payBackAmount = payBackAmount;
	}

	public float getCustomerPrincipal() {
		return customerPrincipal;
	}

	public void setCustomerPrincipal(float customerPrincipal) {
		this.customerPrincipal = customerPrincipal;
	}

	public float getCustomerProfit() {
		return customerProfit;
	}

	public void setCustomerProfit(float customerProfit) {
		this.customerProfit = customerProfit;
	}

	public boolean isPayBack() {
		return payBack;
	}

	public void setPayBack(boolean payBack) {
		this.payBack = payBack;
	}

	public int getRemainingDays() {
		return remainingDays;
	}

	public void setRemainingDays(int remainingDays) {
		this.remainingDays = remainingDays;
	}
}