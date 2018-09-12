package com.silverfox.finance.domain;

import java.io.Serializable;

public class BonusStrategy implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int quota;
	private String giveAmount;
	private int bonusId;
	private Coupon coupon;
	private String couponCardName;

	public BonusStrategy() {

	}

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

	public int getQuota() {
		return quota;
	}

	public void setQuota(int quota) {
		this.quota = quota;
	}

	public String getGiveAmount() {
		return giveAmount;
	}

	public void setGiveAmount(String giveAmount) {
		this.giveAmount = giveAmount;
	}

	public int getBonusId() {
		return bonusId;
	}

	public void setBonusId(int bonusId) {
		this.bonusId = bonusId;
	}

	public String getCouponCardName() {
		return couponCardName;
	}

	public void setCouponCardName(String couponCardName) {
		this.couponCardName = couponCardName;
	}
}