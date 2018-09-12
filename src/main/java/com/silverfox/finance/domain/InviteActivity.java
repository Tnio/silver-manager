package com.silverfox.finance.domain;

import java.io.Serializable;

public class InviteActivity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private String beginDate;
	private String endDate;
	private int firstTradeAmount;
	private short auditStatus;
	private String ruleContent;

	public InviteActivity() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public int getFirstTradeAmount() {
		return firstTradeAmount;
	}

	public void setFirstTradeAmount(int firstTradeAmount) {
		this.firstTradeAmount = firstTradeAmount;
	}

	public short getAuditStatus() {
		return auditStatus;
	}

	public void setAuditStatus(short auditStatus) {
		this.auditStatus = auditStatus;
	}

	public String getRuleContent() {
		return ruleContent;
	}

	public void setRuleContent(String ruleContent) {
		this.ruleContent = ruleContent;
	}
}