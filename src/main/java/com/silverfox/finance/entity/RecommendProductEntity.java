package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

public class RecommendProductEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private float yearIncome;
	private float increaseInterest;
	private int category;
	private String categoryName;
	private String property;
	private int financePeriod;
	private int TradingCount;
	private int purchaseNumber;
	private String rebateName;
	private String label;
	private int totalAmount;
	private int actualAmount;
	private Date shippedTime;
	private String interestDate;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public float getIncreaseInterest() {
		return increaseInterest;
	}

	public void setIncreaseInterest(float increaseInterest) {
		this.increaseInterest = increaseInterest;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public float getYearIncome() {
		return yearIncome;
	}

	public void setYearIncome(float yearIncome) {
		this.yearIncome = yearIncome;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getProperty() {
		return property;
	}

	public void setProperty(String property) {
		this.property = property;
	}

	public int getFinancePeriod() {
		return financePeriod;
	}

	public void setFinancePeriod(int financePeriod) {
		this.financePeriod = financePeriod;
	}

	public int getTradingCount() {
		return TradingCount;
	}

	public void setTradingCount(int tradingCount) {
		TradingCount = tradingCount;
	}

	public int getPurchaseNumber() {
		return purchaseNumber;
	}

	public void setPurchaseNumber(int purchaseNumber) {
		this.purchaseNumber = purchaseNumber;
	}

	public String getRebateName() {
		return rebateName;
	}

	public void setRebateName(String rebateName) {
		this.rebateName = rebateName;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public int getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(int totalAmount) {
		this.totalAmount = totalAmount;
	}

	public int getActualAmount() {
		return actualAmount;
	}

	public void setActualAmount(int actualAmount) {
		this.actualAmount = actualAmount;
	}

	public Date getShippedTime() {
		return shippedTime;
	}

	public void setShippedTime(Date shippedTime) {
		this.shippedTime = shippedTime;
	}

	public String getInterestDate() {
		return interestDate;
	}

	public void setInterestDate(String interestDate) {
		this.interestDate = interestDate;
	}
}