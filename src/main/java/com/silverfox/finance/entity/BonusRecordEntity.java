package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

public class BonusRecordEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int userId;
	private Double amount;
	private Date createTime;
	private String cellphone;
	private String productName;

	public BonusRecordEntity() {

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

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
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

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}
}
