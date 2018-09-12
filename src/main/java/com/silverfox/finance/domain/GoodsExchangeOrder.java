package com.silverfox.finance.domain;

import java.io.Serializable;

public class GoodsExchangeOrder implements Serializable {
	private static final long serialVersionUID = 1L;
	private String orderNo;
	private int userId;
	private int amount;

	public GoodsExchangeOrder() {

	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	@Override
	public boolean equals(Object anObject) {
		if (anObject instanceof GoodsExchangeOrder) {
			GoodsExchangeOrder order = (GoodsExchangeOrder) anObject;
			return this.getOrderNo().equals(order.getOrderNo());
		}
		return false;
	}

	@Override
	public int hashCode() {
		return this.getOrderNo().hashCode();
	}

}