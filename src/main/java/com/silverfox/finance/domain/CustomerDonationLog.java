package com.silverfox.finance.domain;

import java.io.Serializable;

public class CustomerDonationLog implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private CustomerCoupon newCoupon;
	private CustomerCoupon oldCoupon;

	public CustomerDonationLog() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public CustomerCoupon getNewCoupon() {
		return newCoupon;
	}

	public void setNewCoupon(CustomerCoupon newCoupon) {
		this.newCoupon = newCoupon;
	}

	public CustomerCoupon getOldCoupon() {
		return oldCoupon;
	}

	public void setOldCoupon(CustomerCoupon oldCoupon) {
		this.oldCoupon = oldCoupon;
	}
}