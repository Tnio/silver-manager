package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.Max;
import javax.validation.constraints.NotNull;

public class SignIn implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer id;
	@NotNull
	private int silver;
	@NotNull
	@Max(value = 99)
	private int increment;
	@NotNull
	@Max(value = 999)
	private int ceiling;
	@NotNull
	private Date startDate;
	@NotNull
	private Date endDate;
	@NotNull
	private String ruleDesc;
	private List<SignInPrize> signInPrizes;

	public SignIn() {

	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public int getSilver() {
		return silver;
	}

	public void setSilver(int silver) {
		this.silver = silver;
	}

	public int getIncrement() {
		return increment;
	}

	public void setIncrement(int increment) {
		this.increment = increment;
	}

	public int getCeiling() {
		return ceiling;
	}

	public void setCeiling(int ceiling) {
		this.ceiling = ceiling;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getRuleDesc() {
		return ruleDesc;
	}

	public void setRuleDesc(String ruleDesc) {
		this.ruleDesc = ruleDesc;
	}

	public List<SignInPrize> getSignInPrizes() {
		return signInPrizes;
	}

	public void setSignInPrizes(List<SignInPrize> signInPrizes) {
		this.signInPrizes = signInPrizes;
	}
}