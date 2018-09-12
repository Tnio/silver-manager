package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

public class InviterRewardEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
    private String productName;
    private int principal;
    private int financePeriod;
    private Date orderTime;
    private int inviterId;
    private String cellphone;
    private String name;
    private int inviterLevel;
	
    public InviterRewardEntity() {

	}
	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getPrincipal() {
		return principal;
	}

	public void setPrincipal(int principal) {
		this.principal = principal;
	}

	public int getFinancePeriod() {
		return financePeriod;
	}

	public void setFinancePeriod(int financePeriod) {
		this.financePeriod = financePeriod;
	}

	public Date getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getInviterLevel() {
		return inviterLevel;
	}

	public void setInviterLevel(int inviterLevel) {
		this.inviterLevel = inviterLevel;
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	public int getInviterId() {
		return inviterId;
	}
	public void setInviterId(int inviterId) {
		this.inviterId = inviterId;
	}
}
