package com.silverfox.finance.entity;

import java.io.Serializable;

public class CustomerEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int userId;
	private String cellphone;
	private String name;
	private int couponNumber;
	private int bonusNumber;
	private int silverNumber;
    private int vipLevel;
	

	public int getVipLevel() {
		return vipLevel;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCouponNumber() {
		return couponNumber;
	}

	public void setCouponNumber(int couponNumber) {
		this.couponNumber = couponNumber;
	}

	public int getBonusNumber() {
		return bonusNumber;
	}

	public void setBonusNumber(int bonusNumber) {
		this.bonusNumber = bonusNumber;
	}

	public int getSilverNumber() {
		return silverNumber;
	}

	public void setSilverNumber(int silverNumber) {
		this.silverNumber = silverNumber;
	}
}