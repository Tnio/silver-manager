package com.silverfox.finance.entity;

import java.io.Serializable;

public class LotteryPrizeEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int startAngle;
	private int endAngle;
	private String name;
	private int quantity;
	private int category;

	public LotteryPrizeEntity() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public int getStartAngle() {
		return startAngle;
	}

	public void setStartAngle(int startAngle) {
		this.startAngle = startAngle;
	}

	public int getEndAngle() {
		return endAngle;
	}

	public void setEndAngle(int endAngle) {
		this.endAngle = endAngle;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
}