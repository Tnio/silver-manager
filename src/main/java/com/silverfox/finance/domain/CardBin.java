package com.silverfox.finance.domain;

import java.io.Serializable;

public class CardBin implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String bankName;
	private String bankCode;
	private String cardPrefix;

	public CardBin() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

	public String getCardPrefix() {
		return cardPrefix;
	}

	public void setCardPrefix(String cardPrefix) {
		this.cardPrefix = cardPrefix;
	}
}