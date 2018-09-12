package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.List;

public class Merchant implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String name;
	private String address;
	private String legalPerson;
	private String license;
	private String cellphone;
	private int version;
	private String bankNO;
	private String cardNO;
	private String provinceCode;
	private String cityCode;
	private String payVoucher;
	private int status;
	private int loanNum;
	private String linkman;
	private String legalPersonIdcard;
	private String licenceImg;
	private double pendingRepaymentAmount;
	private String licenseNO;
	// private String leasingContract;
	private String realDiagram;
	private String accountId;
	private int closeNotice;
	private String letterOfCommitment;
	private String otherData;
	private int type;
	private List<Attachment> attachments;

	public Merchant() {

	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAccountId() {
		return accountId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}

	public String getLetterOfCommitment() {
		return letterOfCommitment;
	}

	public void setLetterOfCommitment(String letterOfCommitment) {
		this.letterOfCommitment = letterOfCommitment;
	}

	public List<Attachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<Attachment> attachments) {
		this.attachments = attachments;
	}

	public String getCardNO() {
		return cardNO;
	}

	public void setCardNO(String cardNO) {
		this.cardNO = cardNO;
	}

	public String getBankNO() {
		return bankNO;
	}

	public void setBankNO(String bankNO) {
		this.bankNO = bankNO;
	}

	public String getProvinceCode() {
		return provinceCode;
	}

	public void setProvinceCode(String provinceCode) {
		this.provinceCode = provinceCode;
	}

	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}

	public String getPayVoucher() {
		return payVoucher;
	}

	public void setPayVoucher(String payVoucher) {
		this.payVoucher = payVoucher;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getLegalPerson() {
		return legalPerson;
	}

	public void setLegalPerson(String legalPerson) {
		this.legalPerson = legalPerson;
	}

	public String getLicense() {
		return license;
	}

	public void setLicense(String license) {
		this.license = license;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getLoanNum() {
		return loanNum;
	}

	public void setLoanNum(int loanNum) {
		this.loanNum = loanNum;
	}

	public String getLinkman() {
		return linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}

	public String getLegalPersonIdcard() {
		return legalPersonIdcard;
	}

	public void setLegalPersonIdcard(String legalPersonIdcard) {
		this.legalPersonIdcard = legalPersonIdcard;
	}

	public String getLicenceImg() {
		return licenceImg;
	}

	public void setLicenceImg(String licenceImg) {
		this.licenceImg = licenceImg;
	}

	public double getPendingRepaymentAmount() {
		return pendingRepaymentAmount;
	}

	public void setPendingRepaymentAmount(double pendingRepaymentAmount) {
		this.pendingRepaymentAmount = pendingRepaymentAmount;
	}

	public String getLicenseNO() {
		return licenseNO;
	}

	public void setLicenseNO(String licenseNO) {
		this.licenseNO = licenseNO;
	}

	/*
	 * public String getLeasingContract() { return leasingContract; }
	 * 
	 * public void setLeasingContract(String leasingContract) {
	 * this.leasingContract = leasingContract; }
	 */

	public String getRealDiagram() {
		return realDiagram;
	}

	public void setRealDiagram(String realDiagram) {
		this.realDiagram = realDiagram;
	}

	public int getCloseNotice() {
		return closeNotice;
	}

	public void setCloseNotice(int closeNotice) {
		this.closeNotice = closeNotice;
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
}