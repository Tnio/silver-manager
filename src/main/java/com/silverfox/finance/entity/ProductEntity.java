package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

import com.silverfox.finance.domain.Bonus;
import com.silverfox.finance.domain.Merchant;
import com.silverfox.finance.domain.ProductCategory;
import com.silverfox.finance.domain.ProductContract;

public class ProductEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String name;
	private Float yearIncome;
	private Float loanYearIncome;
	private ProductCategory category;
	private int totalAmount;
	private int actualAmount;
	private int initialTotalAmount;
	private Integer financePeriod;
	private Integer raisePeriod;
	private Integer lowestMoney;
	private Integer highestMoney;
	private String refund;
	private String risk;
	private Integer sortNumber;
	private Date shippedTime;
	private String interestDate;
	private String productDesc;
	private String institutionDesc;
	private String securityDesc;
	private String serviceProtocol;
	private String assetsSafety;
	private String securedPartyDesc;
	private String obligatoryRight;
	private String riskWarning;
	private String label;
	private String remark;
	private Bonus bonus;
	private int status;
	private short recommend;
	private float increaseInterest;
	private String displayPlatform;
	private float fee;
	private int freeAmount;
	private int minPortion;
	private int version;
	private Merchant merchant;
	private ProductContract contract;
	private String protocolIds;
	private String fundPurpose;
	private int guaranteeId;
	public ProductEntity() {

	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Float getYearIncome() {
		return yearIncome;
	}

	public void setYearIncome(Float yearIncome) {
		this.yearIncome = yearIncome;
	}

	public ProductCategory getCategory() {
		return category;
	}

	public void setCategory(ProductCategory category) {
		this.category = category;
	}

	public int getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(int totalAmount) {
		this.totalAmount = totalAmount;
	}

	public int getActualAmount() {
		return actualAmount;
	}

	public void setActualAmount(int actualAmount) {
		this.actualAmount = actualAmount;
	}

	public Integer getFinancePeriod() {
		return financePeriod;
	}

	public void setFinancePeriod(Integer financePeriod) {
		this.financePeriod = financePeriod;
	}

	public Integer getRaisePeriod() {
		return raisePeriod;
	}

	public void setRaisePeriod(Integer raisePeriod) {
		this.raisePeriod = raisePeriod;
	}

	public Integer getLowestMoney() {
		return lowestMoney;
	}

	public void setLowestMoney(Integer lowestMoney) {
		this.lowestMoney = lowestMoney;
	}

	public Integer getHighestMoney() {
		return highestMoney;
	}

	public void setHighestMoney(Integer highestMoney) {
		this.highestMoney = highestMoney;
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

	public Integer getSortNumber() {
		return sortNumber;
	}

	public void setSortNumber(Integer sortNumber) {
		this.sortNumber = sortNumber;
	}

	public Date getShippedTime() {
		return shippedTime;
	}

	public void setShippedTime(Date shippedTime) {
		this.shippedTime = shippedTime;
	}

	public String getInterestDate() {
		return interestDate;
	}

	public void setInterestDate(String interestDate) {
		this.interestDate = interestDate;
	}

	public String getProductDesc() {
		return productDesc;
	}

	public void setProductDesc(String productDesc) {
		this.productDesc = productDesc;
	}

	public String getInstitutionDesc() {
		return institutionDesc;
	}

	public void setInstitutionDesc(String institutionDesc) {
		this.institutionDesc = institutionDesc;
	}

	public String getSecurityDesc() {
		return securityDesc;
	}

	public void setSecurityDesc(String securityDesc) {
		this.securityDesc = securityDesc;
	}

	public String getServiceProtocol() {
		return serviceProtocol;
	}

	public void setServiceProtocol(String serviceProtocol) {
		this.serviceProtocol = serviceProtocol;
	}

	public String getAssetsSafety() {
		return assetsSafety;
	}

	public void setAssetsSafety(String assetsSafety) {
		this.assetsSafety = assetsSafety;
	}

	public String getSecuredPartyDesc() {
		return securedPartyDesc;
	}

	public void setSecuredPartyDesc(String securedPartyDesc) {
		this.securedPartyDesc = securedPartyDesc;
	}

	public String getObligatoryRight() {
		return obligatoryRight;
	}

	public void setObligatoryRight(String obligatoryRight) {
		this.obligatoryRight = obligatoryRight;
	}

	public String getRiskWarning() {
		return riskWarning;
	}

	public void setRiskWarning(String riskWarning) {
		this.riskWarning = riskWarning;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Bonus getBonus() {
		return bonus;
	}

	public void setBonus(Bonus bonus) {
		this.bonus = bonus;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public short getRecommend() {
		return recommend;
	}

	public void setRecommend(short recommend) {
		this.recommend = recommend;
	}

	public String getDisplayPlatform() {
		return displayPlatform;
	}

	public void setDisplayPlatform(String displayPlatform) {
		this.displayPlatform = displayPlatform;
	}

	public ProductContract getContract() {
		return contract;
	}

	public void setContract(ProductContract contract) {
		this.contract = contract;
	}

	public float getIncreaseInterest() {
		return increaseInterest;
	}

	public void setIncreaseInterest(float increaseInterest) {
		this.increaseInterest = increaseInterest;
	}

	public float getFee() {
		return fee;
	}

	public void setFee(float fee) {
		this.fee = fee;
	}

	public int getFreeAmount() {
		return freeAmount;
	}

	public void setFreeAmount(int freeAmount) {
		this.freeAmount = freeAmount;
	}

	public int getMinPortion() {
		return minPortion;
	}

	public void setMinPortion(int minPortion) {
		this.minPortion = minPortion;
	}

	public Merchant getMerchant() {
		return merchant;
	}

	public void setMerchant(Merchant merchant) {
		this.merchant = merchant;
	}

	public int getInitialTotalAmount() {
		return initialTotalAmount;
	}

	public void setInitialTotalAmount(int initialTotalAmount) {
		this.initialTotalAmount = initialTotalAmount;
	}

	public Float getLoanYearIncome() {
		return loanYearIncome;
	}

	public void setLoanYearIncome(Float loanYearIncome) {
		this.loanYearIncome = loanYearIncome;
	}

	public String getProtocolIds() {
		return protocolIds;
	}

	public void setProtocolIds(String protocolIds) {
		this.protocolIds = protocolIds;
	}

	public String getFundPurpose() {
		return fundPurpose;
	}

	public void setFundPurpose(String fundPurpose) {
		this.fundPurpose = fundPurpose;
	}

	public int getGuaranteeId() {
		return guaranteeId;
	}

	public void setGuaranteeId(int guaranteeId) {
		this.guaranteeId = guaranteeId;
	}

	
}