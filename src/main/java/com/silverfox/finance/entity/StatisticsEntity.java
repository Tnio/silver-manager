package com.silverfox.finance.entity;

import java.io.Serializable;

public class StatisticsEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private String amount;
	private String useCondition;
	private int source;
	private int quantity;
	private int financePeriod;
	private double totalAmount;
	private double usedAmount;
	private int usedQuantity;
	private double profit;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUseCondition() {
		return useCondition;
	}

	public void setUseCondition(String useCondition) {
		this.useCondition = useCondition;
	}

	public int getFinancePeriod() {
		return financePeriod;
	}

	public void setFinancePeriod(int financePeriod) {
		this.financePeriod = financePeriod;
	}

	public int getSource() {
		return source;
	}

	public void setSource(int source) {
		this.source = source;
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

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public double getUsedAmount() {
		return usedAmount;
	}

	public void setUsedAmount(double usedAmount) {
		this.usedAmount = usedAmount;
	}

	public int getUsedQuantity() {
		return usedQuantity;
	}

	public void setUsedQuantity(int usedQuantity) {
		this.usedQuantity = usedQuantity;
	}

	public double getProfit() {
		return profit;
	}

	public void setProfit(double profit) {
		this.profit = profit;
	}
}