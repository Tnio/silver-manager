package com.silverfox.finance.entity;

import java.io.Serializable;

public class OpexEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private String consumeTime;
	private double couponAmount;
	private double couponInterest;
	private double interestAmount;
	private double feeAmount;

	public OpexEntity() {

	}

	public double getCouponInterest() {
		return couponInterest;
	}

	public void setCouponInterest(double couponInterest) {
		this.couponInterest = couponInterest;
	}

	public String getConsumeTime() {
		return consumeTime;
	}

	public void setConsumeTime(String consumeTime) {
		this.consumeTime = consumeTime;
	}

	public double getCouponAmount() {
		return couponAmount;
	}

	public void setCouponAmount(double couponAmount) {
		this.couponAmount = couponAmount;
	}

	public double getInterestAmount() {
		return interestAmount;
	}

	public void setInterestAmount(double interestAmount) {
		this.interestAmount = interestAmount;
	}

	public double getFeeAmount() {
		return feeAmount;
	}

	public void setFeeAmount(double feeAmount) {
		this.feeAmount = feeAmount;
	}
}