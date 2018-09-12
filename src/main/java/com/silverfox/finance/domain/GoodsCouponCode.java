package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class GoodsCouponCode implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private Goods goods;
	private String code;
	private int used;
	private int userId;
	private String orderNo;
	private Date exchangeTime;
	private CustomerCoupon customerCoupon;
	private CouponExchange couponExchange;

	public GoodsCouponCode() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public int getUsed() {
		return used;
	}

	public void setUsed(int used) {
		this.used = used;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public CouponExchange getCouponExchange() {
		return couponExchange;
	}

	public void setCouponExchange(CouponExchange couponExchange) {
		this.couponExchange = couponExchange;
	}

	public Date getExchangeTime() {
		return exchangeTime;
	}

	public void setExchangeTime(Date exchangeTime) {
		this.exchangeTime = exchangeTime;
	}

	public CustomerCoupon getCustomerCoupon() {
		return customerCoupon;
	}

	public void setCustomerCoupon(CustomerCoupon customerCoupon) {
		this.customerCoupon = customerCoupon;
	}
}
