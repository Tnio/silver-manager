package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class InviteActivityLog implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private User user;
	private Customer customer;
	private Date regTime;
	private Date grantTime;
	private int buyAmount;
	private int financePeriod;
	private double couponAmount;
	private int inviteActivityId;
	private int inviteActivityRuleId;

	public InviteActivityLog() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Date getRegTime() {
		return regTime;
	}

	public void setRegTime(Date regTime) {
		this.regTime = regTime;
	}

	public Date getGrantTime() {
		return grantTime;
	}

	public void setGrantTime(Date grantTime) {
		this.grantTime = grantTime;
	}

	public int getBuyAmount() {
		return buyAmount;
	}

	public void setBuyAmount(int buyAmount) {
		this.buyAmount = buyAmount;
	}

	public int getFinancePeriod() {
		return financePeriod;
	}

	public void setFinancePeriod(int financePeriod) {
		this.financePeriod = financePeriod;
	}

	public double getCouponAmount() {
		return couponAmount;
	}

	public void setCouponAmount(double couponAmount) {
		this.couponAmount = couponAmount;
	}

	public int getInviteActivityId() {
		return inviteActivityId;
	}

	public void setInviteActivityId(int inviteActivityId) {
		this.inviteActivityId = inviteActivityId;
	}

	public int getInviteActivityRuleId() {
		return inviteActivityRuleId;
	}

	public void setInviteActivityRuleId(int inviteActivityRuleId) {
		this.inviteActivityRuleId = inviteActivityRuleId;
	}
}