package com.silverfox.finance.entity;

import java.io.Serializable;

public class ReinvestEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private String paybackDate;
	private Integer paybackCustomers;
	private Double paybackAmount;
	private Integer investAmount;
	private Integer investCustomers;

	public ReinvestEntity() {

	}

	public String getPaybackDate() {
		return paybackDate;
	}

	public void setPaybackDate(String paybackDate) {
		this.paybackDate = paybackDate;
	}

	public Integer getPaybackCustomers() {
		return paybackCustomers;
	}

	public void setPaybackCustomers(Integer paybackCustomers) {
		this.paybackCustomers = paybackCustomers;
	}

	public Double getPaybackAmount() {
		return paybackAmount;
	}

	public void setPaybackAmount(Double paybackAmount) {
		this.paybackAmount = paybackAmount;
	}

	public Integer getInvestAmount() {
		return investAmount;
	}

	public void setInvestAmount(Integer investAmount) {
		this.investAmount = investAmount;
	}

	public Integer getInvestCustomers() {
		return investCustomers;
	}

	public void setInvestCustomers(Integer investCustomers) {
		this.investCustomers = investCustomers;
	}
}