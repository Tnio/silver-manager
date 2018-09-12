package com.silverfox.finance.domain;

import java.io.Serializable;

public class SmsChannel implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private Double cost;
	private short enable;
	private int sortNumber;

	public SmsChannel() {

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

	public Double getCost() {
		return cost;
	}

	public void setCost(Double cost) {
		this.cost = cost;
	}

	public short getEnable() {
		return enable;
	}

	public void setEnable(short enable) {
		this.enable = enable;
	}

	public int getSortNumber() {
		return sortNumber;
	}

	public void setSortNumber(int sortNumber) {
		this.sortNumber = sortNumber;
	}
}