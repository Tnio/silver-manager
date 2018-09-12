package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class InviterReward implements Serializable {
	private static final long serialVersionUID = 1L;
    private int id;
    private String orderNo;
    private int customerId;
    private String customerPhone;
    private int beInviterId;
    private String beInviterPhone;
    private double amount;
    private int source;
    private Date createTime;
    private int inviterLevel;
    
    public InviterReward() {
		
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
	public int getBeInviterId() {
		return beInviterId;
	}
	public void setBeInviterId(int beInviterId) {
		this.beInviterId = beInviterId;
	}
	public String getBeInviterPhone() {
		return beInviterPhone;
	}
	public void setBeInviterPhone(String beInviterPhone) {
		this.beInviterPhone = beInviterPhone;
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
   
}
