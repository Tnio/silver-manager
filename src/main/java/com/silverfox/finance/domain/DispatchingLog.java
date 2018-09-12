package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class DispatchingLog implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private DispatchingBonusLog dispatchingBonusLog;
	private String cellphone;
	private Date dispatchingDate;

	public DispatchingLog() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public DispatchingBonusLog getDispatchingBonusLog() {
		return dispatchingBonusLog;
	}

	public void setDispatchingBonusLog(DispatchingBonusLog dispatchingBonusLog) {
		this.dispatchingBonusLog = dispatchingBonusLog;
	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public Date getDispatchingDate() {
		return dispatchingDate;
	}

	public void setDispatchingDate(Date dispatchingDate) {
		this.dispatchingDate = dispatchingDate;
	}
}