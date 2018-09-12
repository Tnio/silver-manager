package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

public class SilverRecord implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String channel;
	private int amount;
	private Date createTime;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getChannel() {
		return channel;
	}

	public void setChannel(String channel) {
		this.channel = channel;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}