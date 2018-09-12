package com.silverfox.finance.entity;

import java.io.Serializable;

import com.silverfox.finance.domain.CustomerOrder;

public class OrderDetailEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private CustomerOrder order;
	private int remainingDays;

	public OrderDetailEntity() {

	}

	public CustomerOrder getOrder() {
		return order;
	}

	public void setOrder(CustomerOrder order) {
		this.order = order;
	}

	public int getRemainingDays() {
		return remainingDays;
	}

	public void setRemainingDays(int remainingDays) {
		this.remainingDays = remainingDays;
	}
}