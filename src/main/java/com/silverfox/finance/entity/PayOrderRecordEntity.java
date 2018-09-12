package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

public class PayOrderRecordEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private String orderNO;
	private String cellphone;
	private Date orderTime;
	private int principal;

	public PayOrderRecordEntity() {

	}

	public String getOrderNO() {
		return orderNO;
	}

	public void setOrderNO(String orderNO) {
		this.orderNO = orderNO;
	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public Date getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}

	public int getPrincipal() {
		return principal;
	}

	public void setPrincipal(int principal) {
		this.principal = principal;
	}
}