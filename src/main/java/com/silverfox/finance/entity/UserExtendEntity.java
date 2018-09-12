package com.silverfox.finance.entity;

import java.util.Date;

import com.silverfox.finance.domain.Customer;

public class UserExtendEntity extends Customer {
	private static final long serialVersionUID = 1L;
	private int totalTradeAmount;
	private int totalTradeMoney;
	private double totalTradeIncome;
	private Date firstTradeTime;
	private Date latestTradeTime;

	public int getTotalTradeAmount() {
		return totalTradeAmount;
	}

	public void setTotalTradeAmount(int totalTradeAmount) {
		this.totalTradeAmount = totalTradeAmount;
	}

	public int getTotalTradeMoney() {
		return totalTradeMoney;
	}

	public void setTotalTradeMoney(int totalTradeMoney) {
		this.totalTradeMoney = totalTradeMoney;
	}

	public double getTotalTradeIncome() {
		return totalTradeIncome;
	}

	public void setTotalTradeIncome(double totalTradeIncome) {
		this.totalTradeIncome = totalTradeIncome;
	}

	public Date getFirstTradeTime() {
		return firstTradeTime;
	}

	public void setFirstTradeTime(Date firstTradeTime) {
		this.firstTradeTime = firstTradeTime;
	}

	public Date getLatestTradeTime() {
		return latestTradeTime;
	}

	public void setLatestTradeTime(Date latestTradeTime) {
		this.latestTradeTime = latestTradeTime;
	}
}
