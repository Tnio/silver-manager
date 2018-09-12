package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

import com.silverfox.finance.domain.Channel;

public class UserEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int silverNumber;
	private int totalTradeAmount;
	private String name;
	private String cellphone;
	private String idcard;
	private String tradePassword;
	private String loginPassword;
	private Date firstTradeTime;
	private Date registerTime;
	private Channel channel;
	private int totalTradeMoney;
	private Date latestSignTime;

	private double totalTradeIncome;
	private double baobaoTradeIncome;
	private String registerCellphone;
	private String latestLoginDevice;
	private String investmentStyle;
	private String inviterPhone;
	private String registerDevice;
	private Date latestTradeTime;
	private Date latestLoginTime;
	private short open;
	private int wrongTimes;
	private short source;
	private String newsIds;
	private int fundTradeAmount;
	private int sendMessage;

	private int isVip;
	private int vipLevel;

	public int getVipLevel() {
		return vipLevel;
	}

	public void setVipLevel(int vipLevel) {
		this.vipLevel = vipLevel;
	}

	public UserEntity() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public short getOpen() {
		return open;
	}

	public void setOpen(short open) {
		this.open = open;
	}

	public int getSilverNumber() {
		return silverNumber;
	}

	public void setSilverNumber(int silverNumber) {
		this.silverNumber = silverNumber;
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

	public void setTotalTradeIncome(double totalTradeIncome) {
		this.totalTradeIncome = totalTradeIncome;
	}

	public double getBaobaoTradeIncome() {
		return baobaoTradeIncome;
	}

	public void setBaobaoTradeIncome(double baobaoTradeIncome) {
		this.baobaoTradeIncome = baobaoTradeIncome;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRegisterCellphone() {
		return registerCellphone;
	}

	public void setRegisterCellphone(String registerCellphone) {
		this.registerCellphone = registerCellphone;
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

	public String getLatestLoginDevice() {
		return latestLoginDevice;
	}

	public void setLatestLoginDevice(String latestLoginDevice) {
		this.latestLoginDevice = latestLoginDevice;
	}

	public String getTradePassword() {
		return tradePassword;
	}

	public void setTradePassword(String tradePassword) {
		this.tradePassword = tradePassword;
	}

	public String getLoginPassword() {
		return loginPassword;
	}

	public void setLoginPassword(String loginPassword) {
		this.loginPassword = loginPassword;
	}

	public String getInvestmentStyle() {
		return investmentStyle;
	}

	public void setInvestmentStyle(String investmentStyle) {
		this.investmentStyle = investmentStyle;
	}

	public int getWrongTimes() {
		return wrongTimes;
	}

	public void setWrongTimes(int wrongTimes) {
		this.wrongTimes = wrongTimes;
	}

	public String getInviterPhone() {
		return inviterPhone;
	}

	public void setInviterPhone(String inviterPhone) {
		this.inviterPhone = inviterPhone;
	}

	public String getRegisterDevice() {
		return registerDevice;
	}

	public void setRegisterDevice(String registerDevice) {
		this.registerDevice = registerDevice;
	}

	public Date getLatestTradeTime() {
		return latestTradeTime;
	}

	public void setLatestTradeTime(Date latestTradeTime) {
		this.latestTradeTime = latestTradeTime;
	}

	public Date getRegisterTime() {
		return registerTime;
	}

	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}

	public Date getLatestLoginTime() {
		return latestLoginTime;
	}

	public void setLatestLoginTime(Date latestLoginTime) {
		this.latestLoginTime = latestLoginTime;
	}

	public Date getFirstTradeTime() {
		return firstTradeTime;
	}

	public void setFirstTradeTime(Date firstTradeTime) {
		this.firstTradeTime = firstTradeTime;
	}

	public Channel getChannel() {
		return channel;
	}

	public void setChannel(Channel channel) {
		this.channel = channel;
	}

	public Date getLatestSignTime() {
		return latestSignTime;
	}

	public void setLatestSignTime(Date latestSignTime) {
		this.latestSignTime = latestSignTime;
	}

	public short getSource() {
		return source;
	}

	public void setSource(short source) {
		this.source = source;
	}

	public String getNewsIds() {
		return newsIds;
	}

	public void setNewsIds(String newsIds) {
		this.newsIds = newsIds;
	}

	public int getFundTradeAmount() {
		return fundTradeAmount;
	}

	public void setFundTradeAmount(int fundTradeAmount) {
		this.fundTradeAmount = fundTradeAmount;
	}

	public int getSendMessage() {
		return sendMessage;
	}

	public void setSendMessage(int sendMessage) {
		this.sendMessage = sendMessage;
	}

	public int getIsVip() {
		return isVip;
	}

	public void setIsVip(int isVip) {
		this.isVip = isVip;
	}
}
