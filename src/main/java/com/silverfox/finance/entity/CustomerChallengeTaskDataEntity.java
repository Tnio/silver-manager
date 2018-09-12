package com.silverfox.finance.entity;

import java.io.Serializable;

public class CustomerChallengeTaskDataEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private String receiver;
	private String cellphone;
	private int goodsNO;
	private String address;
	private String receiverDate;

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public int getGoodsNO() {
		return goodsNO;
	}

	public void setGoodsNO(int goodsNO) {
		this.goodsNO = goodsNO;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getReceiverDate() {
		return receiverDate;
	}

	public void setReceiverDate(String receiverDate) {
		this.receiverDate = receiverDate;
	}

}
