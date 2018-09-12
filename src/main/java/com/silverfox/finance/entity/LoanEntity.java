package com.silverfox.finance.entity;

import java.io.Serializable;

public class LoanEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private String accountId;
	private String orderId;
	private double txAmount;
	private double bidFee;
	private double debtFee;
	private String forAccountId;
	private String productId;
	private String authCode;

	public LoanEntity() {

	}

	public String getAccountId() {
		return accountId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public double getTxAmount() {
		return txAmount;
	}

	public void setTxAmount(double txAmount) {
		this.txAmount = txAmount;
	}

	public double getBidFee() {
		return bidFee;
	}

	public void setBidFee(double bidFee) {
		this.bidFee = bidFee;
	}

	public double getDebtFee() {
		return debtFee;
	}

	public void setDebtFee(double debtFee) {
		this.debtFee = debtFee;
	}

	public String getForAccountId() {
		return forAccountId;
	}

	public void setForAccountId(String forAccountId) {
		this.forAccountId = forAccountId;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getAuthCode() {
		return authCode;
	}

	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}
}