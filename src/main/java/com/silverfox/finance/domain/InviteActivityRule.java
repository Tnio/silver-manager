package com.silverfox.finance.domain;

import java.io.Serializable;

public class InviteActivityRule implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int inviteActivityId;
	private int startPeriod;
	private int endPeriod;
	private double interest;
	private double budgetAmount;
	private double useAmount;

	public InviteActivityRule() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getInviteActivityId() {
		return inviteActivityId;
	}

	public void setInviteActivityId(int inviteActivityId) {
		this.inviteActivityId = inviteActivityId;
	}

	public int getStartPeriod() {
		return startPeriod;
	}

	public void setStartPeriod(int startPeriod) {
		this.startPeriod = startPeriod;
	}

	public int getEndPeriod() {
		return endPeriod;
	}

	public void setEndPeriod(int endPeriod) {
		this.endPeriod = endPeriod;
	}

	public double getInterest() {
		return interest;
	}

	public void setInterest(double interest) {
		this.interest = interest;
	}

	public double getBudgetAmount() {
		return budgetAmount;
	}

	public void setBudgetAmount(double budgetAmount) {
		this.budgetAmount = budgetAmount;
	}

	public double getUseAmount() {
		return useAmount;
	}

	public void setUseAmount(double useAmount) {
		this.useAmount = useAmount;
	}
}