package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class CustomerInviteCouponLog implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private CustomerOrder order;
	private CustomerCoupon customerCoupon;
	private double amount;
	private Date createTime;
	private String cellphone;

	public CustomerInviteCouponLog() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public CustomerOrder getOrder() {
		return order;
	}

	public void setOrder(CustomerOrder order) {
		this.order = order;
	}

	public CustomerCoupon getCustomerCoupon() {
		return customerCoupon;
	}

	public void setCustomerCoupon(CustomerCoupon customerCoupon) {
		this.customerCoupon = customerCoupon;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}
}