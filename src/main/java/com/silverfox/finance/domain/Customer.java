package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class Customer implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private String cellphone;
	private String idcard;
	private Channel channel;
	private Date latestTradeTime;
	private int totalTradeAmount;
	private int totalTradeMoney;
	private double totalTradeIncome;
	private int sendMessage;
	private Date firstTradeTime;
	private int vipLevel;
	

	public int getVipLevel() {
		return vipLevel;
	}

	public void setVipLevel(int vipLevel) {
		this.vipLevel = vipLevel;
	}

	public Customer() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getFirstTradeTime() {
		return firstTradeTime;
	}

	public void setFirstTradeTime(Date firstTradeTime) {
		this.firstTradeTime = firstTradeTime;
	}

	public void setTotalTradeIncome(double totalTradeIncome) {
		this.totalTradeIncome = totalTradeIncome;
	}

	public int getTotalTradeAmount() {
		return totalTradeAmount;
	}

	public void setTotalTradeAmount(int totalTradeAmount) {
		this.totalTradeAmount = totalTradeAmount;
	}

	public int getTotalTradeMoney() {
		return totalTradeMoney;
	}

	public void setTotalTradeMoney(int totalTradeMoney) {
		this.totalTradeMoney = totalTradeMoney;
	}

	public double getTotalTradeIncome() {
		return totalTradeIncome;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public String getIdcard() {
		return idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

	public Date getLatestTradeTime() {
		return latestTradeTime;
	}

	public void setLatestTradeTime(Date latestTradeTime) {
		this.latestTradeTime = latestTradeTime;
	}

	public Channel getChannel() {
		return channel;
	}

	public void setChannel(Channel channel) {
		this.channel = channel;
	}

	public int getSendMessage() {
		return sendMessage;
	}

	public void setSendMessage(int sendMessage) {
		this.sendMessage = sendMessage;
	}
}