package com.silverfox.finance.entity;

import java.io.Serializable;

public class BonusOrderStrategyEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int orderType;
	private String give;
	private int bonusId;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getOrderType() {
		return orderType;
	}

	public void setOrderType(int orderType) {
		this.orderType = orderType;
	}

	public String getGive() {
		return give;
	}

	public void setGive(String give) {
		this.give = give;
	}

	public int getBonusId() {
		return bonusId;
	}

	public void setBonusId(int bonusId) {
		this.bonusId = bonusId;
	}
}
