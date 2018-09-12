package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class BaobaoOrder implements Serializable {
	private static final long serialVersionUID = 1L;
	private String orderNO;
	private Date orderTime;
	private Date tradeTime;
	private String productName;
	private double principal;
	private short status;
	private double fee;
	private String customerName;
	private int version;
	private short payType;
	private String paybackNO;
	private double couponAmount;
	private int interestPeriod;
	private String cellphone;
	private String channelName;

	public BaobaoOrder() {

	}

	public String getOrderNO() {
		return orderNO;
	}

	public void setOrderNO(String orderNO) {
		this.orderNO = orderNO;
	}

	public Date getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}

	public Date getTradeTime() {
		return tradeTime;
	}

	public void setTradeTime(Date tradeTime) {
		this.tradeTime = tradeTime;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public double getPrincipal() {
		return principal;
	}

	public void setPrincipal(double principal) {
		this.principal = principal;
	}

	public short getStatus() {
		return status;
	}

	public void setStatus(short status) {
		this.status = status;
	}

	public double getFee() {
		return fee;
	}

	public void setFee(double fee) {
		this.fee = fee;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public short getPayType() {
		return payType;
	}

	public void setPayType(short payType) {
		this.payType = payType;
	}

	public String getPaybackNO() {
		return paybackNO;
	}

	public void setPaybackNO(String paybackNO) {
		this.paybackNO = paybackNO;
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

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public String getChannelName() {
		return channelName;
	}

	public void setChannelName(String channelName) {
		this.channelName = channelName;
	}
}