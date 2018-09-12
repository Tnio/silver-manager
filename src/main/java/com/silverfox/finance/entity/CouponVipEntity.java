package com.silverfox.finance.entity;

import java.io.Serializable;

import com.silverfox.finance.domain.Coupon;

public class CouponVipEntity implements Serializable{
	private static final long serialVersionUID = 1L;
	private int id;
	private Coupon coupon;
	private int vipLevel;
	private int couponType;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Coupon getCoupon() {
		return coupon;
	}
	public void setCoupon(Coupon coupon) {
		this.coupon = coupon;
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
