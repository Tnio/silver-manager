package com.silverfox.finance.domain;

import java.io.Serializable;

public class ChannelVisitLog implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int channelId;
	private int quantity;
	private int type;

	public ChannelVisitLog() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getChannelId() {
		return channelId;
	}

	public void setChannelId(int channelId) {
		this.channelId = channelId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

}
