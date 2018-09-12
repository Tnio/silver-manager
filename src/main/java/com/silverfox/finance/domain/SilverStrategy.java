package com.silverfox.finance.domain;

import java.io.Serializable;

public class SilverStrategy implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private short giveCategory;
	private int quantity;
	private short enable;

	public SilverStrategy() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public short getGiveCategory() {
		return giveCategory;
	}

	public void setGiveCategory(short giveCategory) {
		this.giveCategory = giveCategory;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public short getEnable() {
		return enable;
	}

	public void setEnable(short enable) {
		this.enable = enable;
	}
}