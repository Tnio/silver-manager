package com.silverfox.finance.entity;

import java.io.Serializable;

public class GivePhoneDataEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private String cellphone;
	private String helperPhone;
	private int financeperiod;
	private int principal;
	private int typeHelp;
	private String createTime;

	public GivePhoneDataEntity() {

	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public String getHelperPhone() {
		return helperPhone;
	}

	public void setHelperPhone(String helperPhone) {
		this.helperPhone = helperPhone;
	}

	public int getFinanceperiod() {
		return financeperiod;
	}

	public void setFinanceperiod(int financeperiod) {
		this.financeperiod = financeperiod;
	}

	public int getPrincipal() {
		return principal;
	}

	public void setPrincipal(int principal) {
		this.principal = principal;
	}

	public int getTypeHelp() {
		return typeHelp;
	}

	public void setTypeHelp(int typeHelp) {
		this.typeHelp = typeHelp;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}
