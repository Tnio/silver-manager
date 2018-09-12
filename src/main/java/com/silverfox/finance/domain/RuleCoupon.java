package com.silverfox.finance.domain;

import java.io.Serializable;

public class RuleCoupon implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String couponIds;
	private String couponAmounts;
	private int ruleId;
	private int quota;

	public RuleCoupon() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCouponIds() {
		return couponIds;
	}

	public void setCouponIds(String couponIds) {
		this.couponIds = couponIds;
	}

	public String getCouponAmounts() {
		return couponAmounts;
	}

	public void setCouponAmounts(String couponAmounts) {
		this.couponAmounts = couponAmounts;
	}

	public int getRuleId() {
		return ruleId;
	}

	public void setRuleId(int ruleId) {
		this.ruleId = ruleId;
	}

	public int getQuota() {
		return quota;
	}

	public void setQuota(int quota) {
		this.quota = quota;
	}
}