package com.silverfox.finance.domain;

import java.io.Serializable;

public class CellphoneAttribution implements Serializable {
	private static final long serialVersionUID = 1L;
	private String section;
	private String province;
	private String city;
	private String operator;

	public CellphoneAttribution() {

	}

	public String getSection() {
		return section;
	}

	public void setSection(String section) {
		this.section = section;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}
}