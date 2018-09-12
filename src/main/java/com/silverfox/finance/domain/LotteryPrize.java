package com.silverfox.finance.domain;

import java.io.Serializable;

public class LotteryPrize implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int lotteryId;
	private short category;
	private String prizeName;
	private int limitedNumber;
	private int silverQuantity;
	private Coupon coupon;
	private int surplusQuantity;
	private int requirement;

	public LotteryPrize() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Coupon getCoupon() {
		return coupon;
	}

	public void setCoupon(Coupon coupon) {
		this.coupon = coupon;
	}

	public int getLotteryId() {
		return lotteryId;
	}

	public void setLotteryId(int lotteryId) {
		this.lotteryId = lotteryId;
	}

	public short getCategory() {
		return category;
	}

	public void setCategory(short category) {
		this.category = category;
	}

	public int getLimitedNumber() {
		return limitedNumber;
	}

	public void setLimitedNumber(int limitedNumber) {
		this.limitedNumber = limitedNumber;
	}

	public int getSilverQuantity() {
		return silverQuantity;
	}

	public void setSilverQuantity(int silverQuantity) {
		this.silverQuantity = silverQuantity;
	}

	public String getPrizeName() {
		return prizeName;
	}

	public void setPrizeName(String prizeName) {
		this.prizeName = prizeName;
	}

	public int getSurplusQuantity() {
		return surplusQuantity;
	}

	public void setSurplusQuantity(int surplusQuantity) {
		this.surplusQuantity = surplusQuantity;
	}

	public int getRequirement() {
		return requirement;
	}

	public void setRequirement(int requirement) {
		this.requirement = requirement;
	}
}