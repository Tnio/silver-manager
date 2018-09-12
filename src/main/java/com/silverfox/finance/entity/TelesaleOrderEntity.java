package com.silverfox.finance.entity;

import java.io.Serializable;

public class TelesaleOrderEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private String orderNO;
	private int principal;
	private String orderTime;
	private String productName;
	private int financePeriod;
	private double yearIncome;

	public TelesaleOrderEntity() {

	}

	public String getOrderNO() {
		return orderNO;
	}

	public void setOrderNO(String orderNO) {
		this.orderNO = orderNO;
	}

	public int getPrincipal() {
		return principal;
	}

	public void setPrincipal(int principal) {
		this.principal = principal;
	}

	public String getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
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

	public double getYearIncome() {
		return yearIncome;
	}

	public void setYearIncome(double yearIncome) {
		this.yearIncome = yearIncome;
	}
}