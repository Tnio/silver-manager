package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

public class InviterRecordEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int userId;
	private Date createTime;
	private String cellphone;
	private String firstTradeTime;

	public InviterRecordEntity() {

	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
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

	public String getFirstTradeTime() {
		return firstTradeTime;
	}

	public void setFirstTradeTime(String firstTradeTime) {
		this.firstTradeTime = firstTradeTime;
	}
}
