package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.List;

public class Project implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private int type;
	private int status;
	private String introduce;
	private String fundPurpose;
	private String coreEnterprise;
	private String assetsSafety;
	// private Guarantee guarantee;
	private String buyBackAttachment;
	private String guaranteeAttachment;
	private String securedPartyDesc;
	private String securityDesc;
	private String otherData;
	private Merchant merchant;
	private String dataAuditing;
	private String riskWarning;
	private List<Attachment> attachments;
	private List<Attachment> guaranteeAttachments;

	public Project() {

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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public String getFundPurpose() {
		return fundPurpose;
	}

	public void setFundPurpose(String fundPurpose) {
		this.fundPurpose = fundPurpose;
	}

	public String getCoreEnterprise() {
		return coreEnterprise;
	}

	public void setCoreEnterprise(String coreEnterprise) {
		this.coreEnterprise = coreEnterprise;
	}

	public String getAssetsSafety() {
		return assetsSafety;
	}

	public void setAssetsSafety(String assetsSafety) {
		this.assetsSafety = assetsSafety;
	}

	/*
	 * public Guarantee getGuarantee() { return guarantee; }
	 * 
	 * public void setGuarantee(Guarantee guarantee) { this.guarantee =
	 * guarantee; }
	 */

	public String getGuaranteeAttachment() {
		return guaranteeAttachment;
	}

	public void setGuaranteeAttachment(String guaranteeAttachment) {
		this.guaranteeAttachment = guaranteeAttachment;
	}

	public String getBuyBackAttachment() {
		return buyBackAttachment;
	}

	public List<Attachment> getGuaranteeAttachments() {
		return guaranteeAttachments;
	}

	public void setGuaranteeAttachments(List<Attachment> guaranteeAttachments) {
		this.guaranteeAttachments = guaranteeAttachments;
	}

	public void setBuyBackAttachment(String buyBackAttachment) {
		this.buyBackAttachment = buyBackAttachment;
	}

	public List<Attachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<Attachment> attachments) {
		this.attachments = attachments;
	}

	public String getSecurityDesc() {
		return securityDesc;
	}

	public void setSecurityDesc(String securityDesc) {
		this.securityDesc = securityDesc;
	}

	public String getOtherData() {
		return otherData;
	}

	public void setOtherData(String otherData) {
		this.otherData = otherData;
	}

	public Merchant getMerchant() {
		return merchant;
	}

	public void setMerchant(Merchant merchant) {
		this.merchant = merchant;
	}

	public String getDataAuditing() {
		return dataAuditing;
	}

	public void setDataAuditing(String dataAuditing) {
		this.dataAuditing = dataAuditing;
	}

	public String getSecuredPartyDesc() {
		return securedPartyDesc;
	}

	public void setSecuredPartyDesc(String securedPartyDesc) {
		this.securedPartyDesc = securedPartyDesc;
	}

	public String getRiskWarning() {
		return riskWarning;
	}

	public void setRiskWarning(String riskWarning) {
		this.riskWarning = riskWarning;
	}

}