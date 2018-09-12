package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class CouponExchange implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private Coupon coupon;
	private String quantity;
	private int makeMode;
	private int status;
	private int category;
	private Date createTime;
	private String beginTime;
	private String endTime;
	private GoodsCouponCode goodsCouponCode;

	public CouponExchange() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Coupon getCoupon() {
		return coupon;
	}

	public void setCoupon(Coupon coupon) {
		this.coupon = coupon;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public int getMakeMode() {
		return makeMode;
	}

	public void setMakeMode(int makeMode) {
		this.makeMode = makeMode;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public GoodsCouponCode getGoodsCouponCode() {
		return goodsCouponCode;
	}

	public void setGoodsCouponCode(GoodsCouponCode goodsCouponCode) {
		this.goodsCouponCode = goodsCouponCode;
	}
}