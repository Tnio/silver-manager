package com.silverfox.finance.entity;

import java.io.Serializable;

public class RegisterAreaEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int areaNO;
	private int regNum;
	private int cusNum;

	public RegisterAreaEntity() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getAreaNO() {
		return areaNO;
	}

	public void setAreaNO(int areaNO) {
		this.areaNO = areaNO;
	}

	public int getRegNum() {
		return regNum;
	}

	public void setRegNum(int regNum) {
		this.regNum = regNum;
	}

	public int getCusNum() {
		return cusNum;
	}

	public void setCusNum(int cusNum) {
		this.cusNum = cusNum;
	}
}