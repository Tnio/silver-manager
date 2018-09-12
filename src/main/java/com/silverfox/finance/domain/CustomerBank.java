package com.silverfox.finance.domain;

import java.io.Serializable;

public class CustomerBank implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String bankNO;
	private String bankName;
	private String cardNO;
	private int status;
	private Customer customer;
	private String bankNumber;// 兼容旧版本,冗余字段,暂留
	private String serialNO;// 兼容旧版本,冗余字段,暂留

	public void customerBank() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getBankNO() {
		return bankNO;
	}

	public void setBankNO(String bankNO) {
		this.bankNO = bankNO;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getCardNO() {
		return cardNO;
	}

	public void setCardNO(String cardNO) {
		this.cardNO = cardNO;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public String getBankNumber() {
		return bankNumber;
	}

	public void setBankNumber(String bankNumber) {
		this.bankNumber = bankNumber;
	}

	public String getSerialNO() {
		return serialNO;
	}

	public void setSerialNO(String serialNO) {
		this.serialNO = serialNO;
	}
}