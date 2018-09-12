package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

public class InviterEntity implements Serializable {
	private static final long serialVersionUID = 1L;
    private int id;
    private String orderNo;
    private int customerId;
    private String customerPhone;
    private double amount;
    private int source;
    private Date createTime;
    private int inviterLevel;
    private String name;
    
    public InviterEntity() {
		
	}
    
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	public String getCustomerPhone() {
		return customerPhone;
	}
	public void setCustomerPhone(String customerPhone) {
		this.customerPhone = customerPhone;
	}
	
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public int getSource() {
		return source;
	}
	public void setSource(int source) {
		this.source = source;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public int getInviterLevel() {
		return inviterLevel;
	}
	public void setInviterLevel(int inviterLevel) {
		this.inviterLevel = inviterLevel;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
