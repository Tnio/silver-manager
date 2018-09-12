package com.silverfox.finance.entity;

import java.io.Serializable;

public class CouponStatisticsEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int userId;
	private String cellphone;
	private Double totalMoney;
	private Double usedMoney;
	private Integer inviter;
	private Integer trade;

	public CouponStatisticsEntity() {

	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public Double getTotalMoney() {
		return totalMoney;
	}

	public void setTotalMoney(Double totalMoney) {
		this.totalMoney = totalMoney;
	}

	public Double getUsedMoney() {
		return usedMoney;
	}

	public void setUsedMoney(Double usedMoney) {
		this.usedMoney = usedMoney;
	}

	public Integer getInviter() {
		return inviter;
	}

	public void setInviter(Integer inviter) {
		this.inviter = inviter;
	}

	public Integer getTrade() {
		return trade;
	}

	public void setTrade(Integer trade) {
		this.trade = trade;
	}
}