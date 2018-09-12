package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class User implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String name;
	private String cellphone;
	private String idcard;
	private String newsIds;
	private String accountId;
	private Date registerTime;
	private String registerDevice;
	private String registerCellphone;
	private Date latestLoginTime;
	private String latestLoginDevice;
	private int silverNumber;
	private String loginPassword;
	private String tradePassword;
	private String investmentStyle;
	private int wrongTimes;
	private Channel channel;
	private String inviterPhone;
	private int open;
	private int source;
	private Date latestSignTime;
	private Date firstTradeTime;
	private int isVip;
    private int vipLevel;
    
	public int getVipLevel() {
		return vipLevel;
	}

	public void setVipLevel(int vipLevel) {
		this.vipLevel = vipLevel;
	}

	public User() {

	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	public String getIdcard() {
		return idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

	public String getNewsIds() {
		return newsIds;
	}

	public void setNewsIds(String newsIds) {
		this.newsIds = newsIds;
	}

	public String getTradePassword() {
		return tradePassword;
	}

	public void setTradePassword(String tradePassword) {
		this.tradePassword = tradePassword;
	}

	public Date getFirstTradeTime() {
		return firstTradeTime;
	}

	public void setFirstTradeTime(Date firstTradeTime) {
		this.firstTradeTime = firstTradeTime;
	}

	public String getAccountId() {
		return accountId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}

	public Date getRegisterTime() {
		return registerTime;
	}

	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}

	public String getRegisterDevice() {
		return registerDevice;
	}

	public void setRegisterDevice(String registerDevice) {
		this.registerDevice = registerDevice;
	}

	public String getRegisterCellphone() {
		return registerCellphone;
	}

	public void setRegisterCellphone(String registerCellphone) {
		this.registerCellphone = registerCellphone;
	}

	public Date getLatestLoginTime() {
		return latestLoginTime;
	}

	public void setLatestLoginTime(Date latestLoginTime) {
		this.latestLoginTime = latestLoginTime;
	}

	public String getLatestLoginDevice() {
		return latestLoginDevice;
	}

	public void setLatestLoginDevice(String latestLoginDevice) {
		this.latestLoginDevice = latestLoginDevice;
	}

	public int getSilverNumber() {
		return silverNumber;
	}

	public void setSilverNumber(int silverNumber) {
		this.silverNumber = silverNumber;
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

	public Channel getChannel() {
		return channel;
	}

	public void setChannel(Channel channel) {
		this.channel = channel;
	}

	public String getInviterPhone() {
		return inviterPhone;
	}

	public void setInviterPhone(String inviterPhone) {
		this.inviterPhone = inviterPhone;
	}

	public int getOpen() {
		return open;
	}

	public void setOpen(int open) {
		this.open = open;
	}

	public int getSource() {
		return source;
	}

	public void setSource(int source) {
		this.source = source;
	}

	public Date getLatestSignTime() {
		return latestSignTime;
	}

	public void setLatestSignTime(Date latestSignTime) {
		this.latestSignTime = latestSignTime;
	}

	public int getIsVip() {
		return isVip;
	}

	public void setIsVip(int isVip) {
		this.isVip = isVip;
	}
}