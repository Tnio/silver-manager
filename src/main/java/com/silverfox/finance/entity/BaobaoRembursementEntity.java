package com.silverfox.finance.entity;

import java.io.Serializable;

public class BaobaoRembursementEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int productId;
	private String productName;
	private Integer borrowAmount;
	private Double retPrincipal;
	private Double waitPayingPrincipal;
	private Double waitPayingProfit;
	private Double waitPayingAmount;

	public BaobaoRembursementEntity() {

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

	public Integer getBorrowAmount() {
		return borrowAmount;
	}

	public void setBorrowAmount(Integer borrowAmount) {
		this.borrowAmount = borrowAmount;
	}

	public Double getRetPrincipal() {
		return retPrincipal;
	}

	public void setRetPrincipal(Double retPrincipal) {
		this.retPrincipal = retPrincipal;
	}

	public Double getWaitPayingPrincipal() {
		return waitPayingPrincipal;
	}

	public void setWaitPayingPrincipal(Double waitPayingPrincipal) {
		this.waitPayingPrincipal = waitPayingPrincipal;
	}

	public Double getWaitPayingProfit() {
		return waitPayingProfit;
	}

	public void setWaitPayingProfit(Double waitPayingProfit) {
		this.waitPayingProfit = waitPayingProfit;
	}

	public Double getWaitPayingAmount() {
		return waitPayingAmount;
	}

	public void setWaitPayingAmount(Double waitPayingAmount) {
		this.waitPayingAmount = waitPayingAmount;
	}
}