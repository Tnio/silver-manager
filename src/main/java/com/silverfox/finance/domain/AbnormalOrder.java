package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class AbnormalOrder implements Serializable {
	private static final long serialVersionUID = 1L;
	private String orderNO;
	private String refundNO;
	private CustomerBank bank;
	private Product product;
	private int principal;
	private float fee;
	private double couponAmount;
	private int payType;
	private Date orderTime;
	private User user;
	private int version;
	private int status;

	public AbnormalOrder() {

	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getOrderNO() {
		return orderNO;
	}

	public void setOrderNO(String orderNO) {
		this.orderNO = orderNO;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public int getPrincipal() {
		return principal;
	}

	public void setPrincipal(int principal) {
		this.principal = principal;
	}

	public double getCouponAmount() {
		return couponAmount;
	}

	public void setCouponAmount(double couponAmount) {
		this.couponAmount = couponAmount;
	}

	public float getFee() {
		return fee;
	}

	public void setFee(float fee) {
		this.fee = fee;
	}

	public Date getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}

	public CustomerBank getBank() {
		return bank;
	}

	public void setBank(CustomerBank bank) {
		this.bank = bank;
	}

	public int getPayType() {
		return payType;
	}

	public void setPayType(int payType) {
		this.payType = payType;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getRefundNO() {
		return refundNO;
	}

	public void setRefundNO(String refundNO) {
		this.refundNO = refundNO;
	}
}