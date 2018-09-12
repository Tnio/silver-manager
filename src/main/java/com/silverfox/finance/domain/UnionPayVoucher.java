package com.silverfox.finance.domain;

import java.io.Serializable;

public class UnionPayVoucher implements Serializable {
	private static final long serialVersionUID = 1L;
	private String bankCode;
	private String cityCode;
	private String payVoucher;
	private String brabankName;

	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}

	public String getPayVoucher() {
		return payVoucher;
	}

	public void setPayVoucher(String payVoucher) {
		this.payVoucher = payVoucher;
	}

	public String getBrabankName() {
		return brabankName;
	}

	public void setBrabankName(String brabankName) {
		this.brabankName = brabankName;
	}
}