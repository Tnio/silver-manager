package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class CustomerSigninPrizeLog implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private SignInPrize signInPrize;
	private int userId;
	private Date awardDate;

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

	public SignInPrize getSignInPrize() {
		return signInPrize;
	}

	public void setSignInPrize(SignInPrize signInPrize) {
		this.signInPrize = signInPrize;
	}

	public Date getAwardDate() {
		return awardDate;
	}

	public void setAwardDate(Date awardDate) {
		this.awardDate = awardDate;
	}
}