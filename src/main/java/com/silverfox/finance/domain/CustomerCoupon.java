package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class CustomerCoupon implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private User user;
	private Coupon coupon;
	private double amount;
	private int used;
	private int cumulative;
	private Date createTime;
	private Date usedTime;
	private String orderNO;
	private String cellphone;
	private int source;
	private int dispatchingBonusLogId;

	public CustomerCoupon() {

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

	public int getCumulative() {
		return cumulative;
	}

	public void setCumulative(int cumulative) {
		this.cumulative = cumulative;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public int getUsed() {
		return used;
	}

	public void setUsed(int used) {
		this.used = used;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUsedTime() {
		return usedTime;
	}

	public void setUsedTime(Date usedTime) {
		this.usedTime = usedTime;
	}

	public String getOrderNO() {
		return orderNO;
	}

	public void setOrderNO(String orderNO) {
		this.orderNO = orderNO;
	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public int getSource() {
		return source;
	}

	public void setSource(int source) {
		this.source = source;
	}

	public int getDispatchingBonusLogId() {
		return dispatchingBonusLogId;
	}

	public void setDispatchingBonusLogId(int dispatchingBonusLogId) {
		this.dispatchingBonusLogId = dispatchingBonusLogId;
	}
}