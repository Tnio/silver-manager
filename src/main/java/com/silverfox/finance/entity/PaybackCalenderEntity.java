package com.silverfox.finance.entity;

import java.io.Serializable;

public class PaybackCalenderEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int productId;
	private String productName;
	private int actualAmount;
	private double yearIncome;
	private double increaseInterest;
	private int financePeriod;
	private double couponAmount;
	private double interestCouponAmount;
	private double interestAmount;
	private double vipInterestAmount;
	private double paybackAmount;
	private double merchantBackCharge;
	private double serviceCharge;
	private String paybackDate;

	public PaybackCalenderEntity() {

	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
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

	public double getYearIncome() {
		return yearIncome;
	}

	public void setYearIncome(double yearIncome) {
		this.yearIncome = yearIncome;
	}

	public double getIncreaseInterest() {
		return increaseInterest;
	}

	public void setIncreaseInterest(double increaseInterest) {
		this.increaseInterest = increaseInterest;
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

	public double getPaybackAmount() {
		return paybackAmount;
	}

	public void setPaybackAmount(double paybackAmount) {
		this.paybackAmount = paybackAmount;
	}

	public double getMerchantBackCharge() {
		return merchantBackCharge;
	}

	public void setMerchantBackCharge(double merchantBackCharge) {
		this.merchantBackCharge = merchantBackCharge;
	}

	public double getServiceCharge() {
		return serviceCharge;
	}

	public void setServiceCharge(double serviceCharge) {
		this.serviceCharge = serviceCharge;
	}

	public String getPaybackDate() {
		return paybackDate;
	}

	public void setPaybackDate(String paybackDate) {
		this.paybackDate = paybackDate;
	}

	public double getVipInterestAmount() {
		return vipInterestAmount;
	}

	public void setVipInterestAmount(double vipInterestAmount) {
		this.vipInterestAmount = vipInterestAmount;
	}
}