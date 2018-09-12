package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.List;

public class WdzjBorrowEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	private String projectId;
	private String title;
	private double amount;
	private String schedule;
	private String interestRate;
	private int deadline;
	private String deadlineUnit;
	private double reward;
	private String type;
	private int repaymentType;
	// private String plateType;
	// private String guarantorsType;
	private List<WdzjOrderEntity> subscribes;
	// private String province;
	// private String city;
	private String userName;
	// private String userAvatarUrl;
	// private String amountUsedDesc;
	// private String revenue;
	private String loanUrl;
	private String successTime;
	// private String publishTime;
	// private int isAgency;

	public WdzjBorrowEntity() {

	}

	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public String getSchedule() {
		return schedule;
	}

	public void setSchedule(String schedule) {
		this.schedule = schedule;
	}

	public String getInterestRate() {
		return interestRate;
	}

	public void setInterestRate(String interestRate) {
		this.interestRate = interestRate;
	}

	public int getDeadline() {
		return deadline;
	}

	public void setDeadline(int deadline) {
		this.deadline = deadline;
	}

	public String getDeadlineUnit() {
		return deadlineUnit;
	}

	public void setDeadlineUnit(String deadlineUnit) {
		this.deadlineUnit = deadlineUnit;
	}

	public double getReward() {
		return reward;
	}

	public void setReward(double reward) {
		this.reward = reward;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getRepaymentType() {
		return repaymentType;
	}

	public void setRepaymentType(int repaymentType) {
		this.repaymentType = repaymentType;
	}

	/*
	 * public String getPlateType() { return plateType; }
	 * 
	 * 
	 * 
	 * public void setPlateType(String plateType) { this.plateType = plateType;
	 * }
	 * 
	 * 
	 * 
	 * public String getGuarantorsType() { return guarantorsType; }
	 * 
	 * 
	 * 
	 * public void setGuarantorsType(String guarantorsType) {
	 * this.guarantorsType = guarantorsType; }
	 */

	public List<WdzjOrderEntity> getSubscribes() {
		return subscribes;
	}

	public void setSubscribes(List<WdzjOrderEntity> subscribes) {
		this.subscribes = subscribes;
	}

	/*
	 * public String getProvince() { return province; }
	 * 
	 * 
	 * 
	 * public void setProvince(String province) { this.province = province; }
	 * 
	 * 
	 * 
	 * public String getCity() { return city; }
	 * 
	 * 
	 * 
	 * public void setCity(String city) { this.city = city; }
	 */

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	/*
	 * public String getUserAvatarUrl() { return userAvatarUrl; }
	 * 
	 * 
	 * 
	 * public void setUserAvatarUrl(String userAvatarUrl) { this.userAvatarUrl =
	 * userAvatarUrl; }
	 * 
	 * 
	 * 
	 * public String getAmountUsedDesc() { return amountUsedDesc; }
	 * 
	 * 
	 * 
	 * public void setAmountUsedDesc(String amountUsedDesc) {
	 * this.amountUsedDesc = amountUsedDesc; }
	 * 
	 * 
	 * 
	 * public String getRevenue() { return revenue; }
	 * 
	 * 
	 * 
	 * public void setRevenue(String revenue) { this.revenue = revenue; }
	 * 
	 */

	public String getLoanUrl() {
		return loanUrl;
	}

	public void setLoanUrl(String loanUrl) {
		this.loanUrl = loanUrl;
	}

	public String getSuccessTime() {
		return successTime;
	}

	public void setSuccessTime(String successTime) {
		this.successTime = successTime;
	}

	/*
	 * public String getPublishTime() { return publishTime; }
	 * 
	 * 
	 * 
	 * public void setPublishTime(String publishTime) { this.publishTime =
	 * publishTime; }
	 * 
	 * 
	 * 
	 * public int getIsAgency() { return isAgency; }
	 * 
	 * 
	 * 
	 * public void setIsAgency(int isAgency) { this.isAgency = isAgency; }
	 */
}
