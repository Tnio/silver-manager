package com.silverfox.finance.entity;

import java.io.Serializable;

public class PayBankEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String serialNO;
	private String name;
	private String cardType;
	private String servicePhone;
	private String remark;
	private int enable;

	public PayBankEntity() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getEnable() {
		return enable;
	}

	public void setEnable(int enable) {
		this.enable = enable;
	}

	public String getSerialNO() {
		return serialNO;
	}

	public void setSerialNO(String serialNO) {
		this.serialNO = serialNO;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCardType() {
		return cardType;
	}

	public void setCardType(String cardType) {
		this.cardType = cardType;
	}

	public String getServicePhone() {
		return servicePhone;
	}

	public void setServicePhone(String servicePhone) {
		this.servicePhone = servicePhone;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
}
