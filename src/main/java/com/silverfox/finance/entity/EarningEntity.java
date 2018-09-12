package com.silverfox.finance.entity;

import java.io.Serializable;

public class EarningEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private String productName;
	private int actualAmount;
	private int borrowAmount;
	private int financePeriod;
	private double yearIncome;
	private double couponAmount;
	private double interestCouponAmount;
	private double interestAmount;
	private double borrowInterest;
	private double paymentCost;

	private double overrangingProfit;
	private double borrowProfit;
	private double customerProfit;
	private double operatingCost;
	private double companyEarning;

	public EarningEntity() {

	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getActualAmount() {
		return actualAmount;
	}

	public void setActualAmount(int actualAmount) {
		this.actualAmount = actualAmount;
	}

	public int getBorrowAmount() {
		return borrowAmount;
	}

	public void setBorrowAmount(int borrowAmount) {
		this.borrowAmount = borrowAmount;
	}

	public int getFinancePeriod() {
		return financePeriod;
	}

	public void setFinancePeriod(int financePeriod) {
		this.financePeriod = financePeriod;
	}

	public double getYearIncome() {
		return yearIncome;
	}

	public void setYearIncome(double yearIncome) {
		this.yearIncome = yearIncome;
	}

	public double getCouponAmount() {
		return couponAmount;
	}

	public void setCouponAmount(double couponAmount) {
		this.couponAmount = couponAmount;
	}

	public double getInterestCouponAmount() {
		return interestCouponAmount;
	}

	public void setInterestCouponAmount(double interestCouponAmount) {
		this.interestCouponAmount = interestCouponAmount;
	}

	public double getInterestAmount() {
		return interestAmount;
	}

	public void setInterestAmount(double interestAmount) {
		this.interestAmount = interestAmount;
	}

	public double getBorrowInterest() {
		return borrowInterest;
	}

	public void setBorrowInterest(double borrowInterest) {
		this.borrowInterest = borrowInterest;
	}

	public double getPaymentCost() {
		return paymentCost;
	}

	public void setPaymentCost(double paymentCost) {
		this.paymentCost = paymentCost;
	}

	public double getOverrangingProfit() {
		return overrangingProfit;
	}

	public void setOverrangingProfit(double overrangingProfit) {
		this.overrangingProfit = overrangingProfit;
	}

	public double getBorrowProfit() {
		return borrowProfit;
	}

	public void setBorrowProfit(double borrowProfit) {
		this.borrowProfit = borrowProfit;
	}

	public double getCustomerProfit() {
		return customerProfit;
	}

	public void setCustomerProfit(double customerProfit) {
		this.customerProfit = customerProfit;
	}

	public double getOperatingCost() {
		return operatingCost;
	}

	public void setOperatingCost(double operatingCost) {
		this.operatingCost = operatingCost;
	}

	public double getCompanyEarning() {
		return companyEarning;
	}

	public void setCompanyEarning(double companyEarning) {
		this.companyEarning = companyEarning;
	}
}