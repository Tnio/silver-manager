package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

public class InviteesEntity implements Serializable {
	private static final long serialVersionUID = 1L; 
	private int id;
	private String inviterPhone;
	private String cellphone;
	private String name;
	private int totalTradeMoney;
	private Date registerTime;
	
	public InviteesEntity() {
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getInviterPhone() {
		return inviterPhone;
	}

	public void setInviterPhone(String inviterPhone) {
		this.inviterPhone = inviterPhone;
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

	public int getTotalTradeMoney() {
		return totalTradeMoney;
	}

	public void setTotalTradeMoney(int totalTradeMoney) {
		this.totalTradeMoney = totalTradeMoney;
	}

	public Date getRegisterTime() {
		return registerTime;
	}

	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}
	
}
