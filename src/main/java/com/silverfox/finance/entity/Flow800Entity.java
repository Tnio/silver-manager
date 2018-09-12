package com.silverfox.finance.entity;

import java.io.Serializable;

public class Flow800Entity implements Serializable {
	private static final long serialVersionUID = 1L;
	private String partnerNO;
	private String requestNO;
	private String serviceCode;
	private String contractID;
	private String activityID;
	private String orderType;
	private String phoneID;
	private String platOfferID;
	private String effectType;
	private String oldMsgID;
	private String secretKey;
	private String vector;

	public Flow800Entity() {

	}

	public String getPartnerNO() {
		return partnerNO;
	}

	public void setPartnerNO(String partnerNO) {
		this.partnerNO = partnerNO;
	}

	public String getRequestNO() {
		return requestNO;
	}

	public void setRequestNO(String requestNO) {
		this.requestNO = requestNO;
	}

	public String getServiceCode() {
		return serviceCode;
	}

	public void setServiceCode(String serviceCode) {
		this.serviceCode = serviceCode;
	}

	public String getContractID() {
		return contractID;
	}

	public void setContractID(String contractID) {
		this.contractID = contractID;
	}

	public String getActivityID() {
		return activityID;
	}

	public void setActivityID(String activityID) {
		this.activityID = activityID;
	}

	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	public String getPhoneID() {
		return phoneID;
	}

	public void setPhoneID(String phoneID) {
		this.phoneID = phoneID;
	}

	public String getPlatOfferID() {
		return platOfferID;
	}

	public void setPlatOfferID(String platOfferID) {
		this.platOfferID = platOfferID;
	}

	public String getEffectType() {
		return effectType;
	}

	public void setEffectType(String effectType) {
		this.effectType = effectType;
	}

	public String getOldMsgID() {
		return oldMsgID;
	}

	public void setOldMsgID(String oldMsgID) {
		this.oldMsgID = oldMsgID;
	}

	public String getSecretKey() {
		return secretKey;
	}

	public void setSecretKey(String secretKey) {
		this.secretKey = secretKey;
	}

	public String getVector() {
		return vector;
	}

	public void setVector(String vector) {
		this.vector = vector;
	}
}