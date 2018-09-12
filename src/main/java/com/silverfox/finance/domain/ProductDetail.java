package com.silverfox.finance.domain;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

public class ProductDetail implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String refund;
	private String risk;
	@NotNull
	private String securityDesc;
	private String securedPartyDesc;
	private String remark;
	private String riskWarning;
	private ProductContract contract;
	private String protocolIds;
	private String institutionDesc;
	private String serviceProtocol;
	private String obligatoryRight;
	private Project project;
	private String dataAuditing;
	private String poundage;

	public ProductDetail() {

	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getRefund() {
		return refund;
	}

	public void setRefund(String refund) {
		this.refund = refund;
	}

	public String getRisk() {
		return risk;
	}

	public void setRisk(String risk) {
		this.risk = risk;
	}

	public String getSecurityDesc() {
		return securityDesc;
	}

	public void setSecurityDesc(String securityDesc) {
		this.securityDesc = securityDesc;
	}

	public String getSecuredPartyDesc() {
		return securedPartyDesc;
	}

	public void setSecuredPartyDesc(String securedPartyDesc) {
		this.securedPartyDesc = securedPartyDesc;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getRiskWarning() {
		return riskWarning;
	}

	public void setRiskWarning(String riskWarning) {
		this.riskWarning = riskWarning;
	}

	public ProductContract getContract() {
		return contract;
	}

	public void setContract(ProductContract contract) {
		this.contract = contract;
	}

	public String getProtocolIds() {
		return protocolIds;
	}

	public void setProtocolIds(String protocolIds) {
		this.protocolIds = protocolIds;
	}

	public String getInstitutionDesc() {
		return institutionDesc;
	}

	public void setInstitutionDesc(String institutionDesc) {
		this.institutionDesc = institutionDesc;
	}

	public String getServiceProtocol() {
		return serviceProtocol;
	}

	public void setServiceProtocol(String serviceProtocol) {
		this.serviceProtocol = serviceProtocol;
	}

	public String getObligatoryRight() {
		return obligatoryRight;
	}

	public void setObligatoryRight(String obligatoryRight) {
		this.obligatoryRight = obligatoryRight;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public String getDataAuditing() {
		return dataAuditing;
	}

	public void setDataAuditing(String dataAuditing) {
		this.dataAuditing = dataAuditing;
	}

	public String getPoundage() {
		return poundage;
	}

	public void setPoundage(String poundage) {
		this.poundage = poundage;
	}
}
