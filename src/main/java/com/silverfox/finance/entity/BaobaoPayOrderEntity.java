package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

public class BaobaoPayOrderEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private String cellphone;
	private Double principal;
	private Date orderTime;

	public BaobaoPayOrderEntity() {

	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public Double getPrincipal() {
		return principal;
	}

	public void setPrincipal(Double principal) {
		this.principal = principal;
	}

	public Date getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}
}