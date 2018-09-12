package com.silverfox.finance.entity;

import java.io.Serializable;

public class CouponEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private double amount;
	private String condition;
	private int category;

	public CouponEntity() {

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

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}
}