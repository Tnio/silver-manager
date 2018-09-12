package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

import com.silverfox.finance.domain.CustomerCoupon;

public class PayOrderEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private String productName;
	private int productId;
	private CustomerCoupon userRebate;
	private String orderInfo;
	private String orderNo;
	private int orderMoney;
	private Date orderTime;
	private int payType;
	private int portion;
	private int userId;
	private String regTime;

	public PayOrderEntity() {

	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public Date getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}

	public int getPayType() {
		return payType;
	}

	public void setPayType(int payType) {
		this.payType = payType;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getOrderInfo() {
		return orderInfo;
	}

	public void setOrderInfo(String orderInfo) {
		this.orderInfo = orderInfo;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public CustomerCoupon getUserRebate() {
		return userRebate;
	}

	public void setUserRebate(CustomerCoupon userRebate) {
		this.userRebate = userRebate;
	}

	public int getOrderMoney() {
		return orderMoney;
	}

	public void setOrderMoney(int orderMoney) {
		this.orderMoney = orderMoney;
	}

	public int getPortion() {
		return portion;
	}

	public void setPortion(int portion) {
		this.portion = portion;
	}

	public String getRegTime() {
		return regTime;
	}

	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

}