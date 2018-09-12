package com.silverfox.finance.entity;

import java.io.Serializable;

public class ReceivablesEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private String dueDate;
	private float payAmount;
	private float backAmount;
	private float productIncome;
	private float monthReceivables;

	public ReceivablesEntity() {

	}

	public String getDueDate() {
		return dueDate;
	}

	public void setDueDate(String dueDate) {
		this.dueDate = dueDate;
	}

	public float getPayAmount() {
		return payAmount;
	}

	public void setPayAmount(float payAmount) {
		this.payAmount = payAmount;
	}

	public float getBackAmount() {
		return backAmount;
	}

	public void setBackAmount(float backAmount) {
		this.backAmount = backAmount;
	}

	public float getProductIncome() {
		return productIncome;
	}

	public void setProductIncome(float productIncome) {
		this.productIncome = productIncome;
	}

	public float getMonthReceivables() {
		return monthReceivables;
	}

	public void setMonthReceivables(float monthReceivables) {
		this.monthReceivables = monthReceivables;
	}
}