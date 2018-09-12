package com.silverfox.finance.domain;

import java.io.Serializable;

public class Coupon implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int category;
	private String name;
	private String amount;
	private String condition;
	private int lifeCycle;
	private String expiresPoint;
	private Integer amountCategory;
	private Integer moneyLimit;
	private Integer tradeAmount;
	private Integer financePeriod;
	private Integer increaseDays;
	private int status;
	private String useScene;
	// keep for 2.2.5
	private int source;
	// keep for 2.2.5 -
	private double profit;
	private String remark;
	private int donation;
	private String usingProduct;

	public Coupon() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUseScene() {
		return useScene;
	}

	public void setUseScene(String useScene) {
		this.useScene = useScene;
	}

	public String getUsingProduct() {
		return usingProduct;
	}

	public void setUsingProduct(String usingProduct) {
		this.usingProduct = usingProduct;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public int getLifeCycle() {
		return lifeCycle;
	}

	public void setLifeCycle(int lifeCycle) {
		this.lifeCycle = lifeCycle;
	}

	public String getExpiresPoint() {
		return expiresPoint;
	}

	public void setExpiresPoint(String expiresPoint) {
		this.expiresPoint = expiresPoint;
	}

	public Integer getAmountCategory() {
		return amountCategory;
	}

	public void setAmountCategory(Integer amountCategory) {
		this.amountCategory = amountCategory;
	}

	public Integer getMoneyLimit() {
		return moneyLimit;
	}

	public void setMoneyLimit(Integer moneyLimit) {
		this.moneyLimit = moneyLimit;
	}

	public Integer getTradeAmount() {
		return tradeAmount;
	}

	public void setTradeAmount(Integer tradeAmount) {
		this.tradeAmount = tradeAmount;
	}

	public Integer getFinancePeriod() {
		return financePeriod;
	}

	public void setFinancePeriod(Integer financePeriod) {
		this.financePeriod = financePeriod;
	}

	public Integer getIncreaseDays() {
		return increaseDays;
	}

	public void setIncreaseDays(Integer increaseDays) {
		this.increaseDays = increaseDays;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getSource() {
		return source;
	}

	public void setSource(int source) {
		this.source = source;
	}

	public double getProfit() {
		return profit;
	}

	public void setProfit(double profit) {
		this.profit = profit;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public int getDonation() {
		return donation;
	}

	public void setDonation(int donation) {
		this.donation = donation;
	}
}
