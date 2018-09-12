package com.silverfox.finance.entity;

import java.io.Serializable;

public class GoodsOrderEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private String name;
	private String cellphone;

	public GoodsOrderEntity() {

	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}
}