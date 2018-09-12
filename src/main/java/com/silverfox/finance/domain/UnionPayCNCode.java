package com.silverfox.finance.domain;

import java.io.Serializable;

public class UnionPayCNCode implements Serializable {
	private static final long serialVersionUID = 1L;
	private String city;
	private String cityCode;
	private String province;
	private String provinceCode;

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getProvinceCode() {
		return provinceCode;
	}

	public void setProvinceCode(String provinceCode) {
		this.provinceCode = provinceCode;
	}
}