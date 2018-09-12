package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.List;

public class Lender implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int productId;
	private String name;
	private String idcard;
	private String cellphone;
	private int loanAmount;
	private int loanPeriod;
	private int tradeCount;
	private int sex;
	private int age;
	private String workUnit;
	private String address;
	private int type;
	private int status;
	private int monthlyIncome;
	private String otherData;
	private String idcardUrl;
	private String orderNO;
	private List<Attachment> attachments;

	public Lender() {

	}

	public int getTradeCount() {
		return tradeCount;
	}

	public void setTradeCount(int tradeCount) {
		this.tradeCount = tradeCount;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getOrderNO() {
		return orderNO;
	}

	public void setOrderNO(String orderNO) {
		this.orderNO = orderNO;
	}

	public List<Attachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<Attachment> attachments) {
		this.attachments = attachments;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIdcard() {
		return idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public int getLoanAmount() {
		return loanAmount;
	}

	public void setLoanAmount(int loanAmount) {
		this.loanAmount = loanAmount;
	}

	public int getLoanPeriod() {
		return loanPeriod;
	}

	public void setLoanPeriod(int loanPeriod) {
		this.loanPeriod = loanPeriod;
	}

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getWorkUnit() {
		return workUnit;
	}

	public void setWorkUnit(String workUnit) {
		this.workUnit = workUnit;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getMonthlyIncome() {
		return monthlyIncome;
	}

	public void setMonthlyIncome(int monthlyIncome) {
		this.monthlyIncome = monthlyIncome;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getOtherData() {
		return otherData;
	}

	public void setOtherData(String otherData) {
		this.otherData = otherData;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getIdcardUrl() {
		return idcardUrl;
	}

	public void setIdcardUrl(String idcardUrl) {
		this.idcardUrl = idcardUrl;
	}

	@Override
	public String toString() {
		return "Lender [id=" + id + ", productId=" + productId + ", name=" + name + ", idcard=" + idcard
				+ ", cellphone=" + cellphone + ", loanAmount=" + loanAmount + ", loanPeriod=" + loanPeriod
				+ ", tradeCount=" + tradeCount + ", sex=" + sex + ", age=" + age + ", workUnit=" + workUnit
				+ ", address=" + address + ", type=" + type + ", status=" + status + ", monthlyIncome=" + monthlyIncome
				+ ", otherData=" + otherData + ", idcardUrl=" + idcardUrl + "]";
	}

}