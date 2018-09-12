package com.silverfox.finance.entity;

import java.io.Serializable;

public class CashTransferEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private String oidPartner;
	private String signType;
	private String sign;
	private String noOrder;
	private String dtOrder;
	private float moneyOrder;
	private String flagCard;
	private String cardNo;
	private String acctName;
	private String infoOrder;
	private String notifyUrl;
	private String apiVersion;

	public CashTransferEntity() {

	}

	public String getOidPartner() {
		return oidPartner;
	}

	public void setOidPartner(String oidPartner) {
		this.oidPartner = oidPartner;
	}

	public String getSignType() {
		return signType;
	}

	public void setSignType(String signType) {
		this.signType = signType;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}

	public String getNoOrder() {
		return noOrder;
	}

	public void setNoOrder(String noOrder) {
		this.noOrder = noOrder;
	}

	public String getDtOrder() {
		return dtOrder;
	}

	public void setDtOrder(String dtOrder) {
		this.dtOrder = dtOrder;
	}

	public float getMoneyOrder() {
		return moneyOrder;
	}

	public void setMoneyOrder(float moneyOrder) {
		this.moneyOrder = moneyOrder;
	}

	public String getFlagCard() {
		return flagCard;
	}

	public void setFlagCard(String flagCard) {
		this.flagCard = flagCard;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getAcctName() {
		return acctName;
	}

	public void setAcctName(String acctName) {
		this.acctName = acctName;
	}

	public String getInfoOrder() {
		return infoOrder;
	}

	public void setInfoOrder(String infoOrder) {
		this.infoOrder = infoOrder;
	}

	public String getNotifyUrl() {
		return notifyUrl;
	}

	public void setNotifyUrl(String notifyUrl) {
		this.notifyUrl = notifyUrl;
	}

	public String getApiVersion() {
		return apiVersion;
	}

	public void setApiVersion(String apiVersion) {
		this.apiVersion = apiVersion;
	}
}