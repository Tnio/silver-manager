package com.silverfox.finance.domain;

import java.io.Serializable;


public class CouponVip implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int couponId;
	private int vipLevel;
	private int couponType;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int  getCouponId() {
		return couponId;
	}
	public void setCouponId(int couponId) {
		this.couponId = couponId;
	}
	public int getVipLevel() {
		return vipLevel;
	}
	public void setVipLevel(int vipLevel) {
		this.vipLevel = vipLevel;
	}
	public int getCouponType() {
		return couponType;
	}
	public void setCouponType(int couponType) {
		this.couponType = couponType;
	}
	

}
