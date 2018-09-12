package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class MerchantOrder implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String orderNO;
	private double principal;
	private Date orderTime;
	private short type;
	private short status;
	private Date tradeTime;
	private Product product;
	private Merchant merchant;
	private int version;
	private String paymentVoucher;
	private int auditStatus;
	private double repamentAmount;
	private String loanName;

	public MerchantOrder() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public double getRepamentAmount() {
		return repamentAmount;
	}

	public void setRepamentAmount(double repamentAmount) {
		this.repamentAmount = repamentAmount;
	}

	public Date getTradeTime() {
		return tradeTime;
	}

	public void setTradeTime(Date tradeTime) {
		this.tradeTime = tradeTime;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public String getOrderNO() {
		return orderNO;
	}

	public void setOrderNO(String orderNO) {
		this.orderNO = orderNO;
	}

	public double getPrincipal() {
		return principal;
	}

	public void setPrincipal(double principal) {
		this.principal = principal;
	}

	public Date getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}

	public short getType() {
		return type;
	}

	public void setType(short type) {
		this.type = type;
	}

	public short getStatus() {
		return status;
	}

	public void setStatus(short status) {
		this.status = status;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Merchant getMerchant() {
		return merchant;
	}

	public void setMerchant(Merchant merchant) {
		this.merchant = merchant;
	}

	public String getPaymentVoucher() {
		return paymentVoucher;
	}

	public void setPaymentVoucher(String paymentVoucher) {
		this.paymentVoucher = paymentVoucher;
	}

	public int getAuditStatus() {
		return auditStatus;
	}

	public void setAuditStatus(int auditStatus) {
		this.auditStatus = auditStatus;
	}

	public String getLoanName() {
		return loanName;
	}

	public void setLoanName(String loanName) {
		this.loanName = loanName;
	}
}