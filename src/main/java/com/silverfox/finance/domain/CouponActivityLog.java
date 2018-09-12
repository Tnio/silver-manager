package com.silverfox.finance.domain;

import java.io.Serializable;

public class CouponActivityLog implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private CouponActivity couponActivity;
	private CustomerCoupon customerCoupon;

	public CouponActivityLog() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public CouponActivity getCouponActivity() {
		return couponActivity;
	}

	public void setCouponActivity(CouponActivity couponActivity) {
		this.couponActivity = couponActivity;
	}

	public CustomerCoupon getCustomerCoupon() {
		return customerCoupon;
	}

	public void setCustomerCoupon(CustomerCoupon customerCoupon) {
		this.customerCoupon = customerCoupon;
	}
}