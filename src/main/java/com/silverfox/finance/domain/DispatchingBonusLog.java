package com.silverfox.finance.domain;

import java.io.Serializable;

public class DispatchingBonusLog implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String source;
	private Integer quantity;
	private String cellphones;
	private short status;
	private String reason;
	private short category;
	private String couponIds;
	private String couponAmounts;
	private SmsTemplate template;
	private String giveDate;
	private String beginDate;
	private String endDate;
	private int userNum;
	private short giveCondition;
	private short choiceType;
	private Integer satisfyType;
	private int satisfyInitialAmount;
	private int satisfyEndAmount;

	public DispatchingBonusLog() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public String getCellphones() {
		return cellphones;
	}

	public void setCellphones(String cellphones) {
		this.cellphones = cellphones;
	}

	public short getStatus() {
		return status;
	}

	public void setStatus(short status) {
		this.status = status;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public short getCategory() {
		return category;
	}

	public void setCategory(short category) {
		this.category = category;
	}

	public String getCouponIds() {
		return couponIds;
	}

	public void setCouponIds(String couponIds) {
		this.couponIds = couponIds;
	}

	public String getCouponAmounts() {
		return couponAmounts;
	}

	public void setCouponAmounts(String couponAmounts) {
		this.couponAmounts = couponAmounts;
	}

	public SmsTemplate getTemplate() {
		return template;
	}

	public void setTemplate(SmsTemplate template) {
		this.template = template;
	}

	public String getGiveDate() {
		return giveDate;
	}

	public void setGiveDate(String giveDate) {
		this.giveDate = giveDate;
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

	public int getUserNum() {
		return userNum;
	}

	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}

	public short getGiveCondition() {
		return giveCondition;
	}

	public void setGiveCondition(short giveCondition) {
		this.giveCondition = giveCondition;
	}

	public short getChoiceType() {
		return choiceType;
	}

	public void setChoiceType(short choiceType) {
		this.choiceType = choiceType;
	}

	public Integer getSatisfyType() {
		return satisfyType;
	}

	public void setSatisfyType(Integer satisfyType) {
		this.satisfyType = satisfyType;
	}

	public int getSatisfyInitialAmount() {
		return satisfyInitialAmount;
	}

	public void setSatisfyInitialAmount(int satisfyInitialAmount) {
		this.satisfyInitialAmount = satisfyInitialAmount;
	}

	public int getSatisfyEndAmount() {
		return satisfyEndAmount;
	}

	public void setSatisfyEndAmount(int satisfyEndAmount) {
		this.satisfyEndAmount = satisfyEndAmount;
	}
}