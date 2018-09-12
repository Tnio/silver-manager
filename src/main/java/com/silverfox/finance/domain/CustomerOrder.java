package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class CustomerOrder implements Serializable {
	private static final long serialVersionUID = 1L;
	private String orderNO;
	private CustomerBank bank;
	private Product product;
	private int principal;
	private float fee;
	private Date orderTime;
	private Date createTime;
	private float paybackAmount;
	private int isPayback;
	private Date paybackTime;
	private double couponAmount;
	private int interestPeriod;
	private int payType;
	private int version;
	private String paybackNO;
	private Customer customer;
	private String authCode;
	private float vipInterest;

	public CustomerOrder() {

	}

	public float getPaybackAmount() {
		return paybackAmount;
	}

	public void setPaybackAmount(float paybackAmount) {
		this.paybackAmount = paybackAmount;
	}

	public int getIsPayback() {
		return isPayback;
	}

	public void setIsPayback(int isPayback) {
		this.isPayback = isPayback;
	}

	public Date getPaybackTime() {
		return paybackTime;
	}

	public void setPaybackTime(Date paybackTime) {
		this.paybackTime = paybackTime;
	}

	public double getCouponAmount() {
		return couponAmount;
	}

	public void setCouponAmount(double couponAmount) {
		this.couponAmount = couponAmount;
	}

	public int getInterestPeriod() {
		return interestPeriod;
	}

	public void setInterestPeriod(int interestPeriod) {
		this.interestPeriod = interestPeriod;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public int getPayType() {
		return payType;
	}

	public void setPayType(int payType) {
		this.payType = payType;
	}

	public CustomerBank getBank() {
		return bank;
	}

	public void setBank(CustomerBank bank) {
		this.bank = bank;
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

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public String getPaybackNO() {
		return paybackNO;
	}

	public void setPaybackNO(String paybackNO) {
		this.paybackNO = paybackNO;
	}

	public String getAuthCode() {
		return authCode;
	}

	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}

	public float getvipInterest() {
		return vipInterest;
	}

	public void setvipInterest(float vipInterest) {
		this.vipInterest = vipInterest;
	}
	
}