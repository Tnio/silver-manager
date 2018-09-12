package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class CustomerLotteryLog implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private User user;
	private LotteryPrize lotteryPrize;
	private Date createTime;
	private int silverCost;

	public CustomerLotteryLog() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getSilverCost() {
		return silverCost;
	}

	public void setSilverCost(int silverCost) {
		this.silverCost = silverCost;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public LotteryPrize getLotteryPrize() {
		return lotteryPrize;
	}

	public void setLotteryPrize(LotteryPrize lotteryPrize) {
		this.lotteryPrize = lotteryPrize;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}