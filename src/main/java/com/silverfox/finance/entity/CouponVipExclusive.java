package com.silverfox.finance.entity;

import java.io.Serializable;


public class CouponVipExclusive implements Serializable {
	private static final long serialVersionUID = 1L;
	private int vipLevel;
	private String couponId;
	
	public int getVipLevel() {
		return vipLevel;
	}
	public void setVipLevel(int vipLevel) {
		this.vipLevel = vipLevel;
	}
	public String getCouponId() {
		return couponId;
	}
	public void setCouponId(String couponId) {
		this.couponId = couponId;
	}
}
