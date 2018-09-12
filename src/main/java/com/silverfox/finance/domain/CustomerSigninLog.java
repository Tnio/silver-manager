package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class CustomerSigninLog implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int userId;
	private Date signTime;
	private int successiveDay;

	public CustomerSigninLog() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public Date getSignTime() {
		return signTime;
	}

	public void setSignTime(Date signTime) {
		this.signTime = signTime;
	}

	public int getSuccessiveDay() {
		return successiveDay;
	}

	public void setSuccessiveDay(int successiveDay) {
		this.successiveDay = successiveDay;
	}
}