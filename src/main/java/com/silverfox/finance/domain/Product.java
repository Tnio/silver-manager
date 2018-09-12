package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

import javax.validation.constraints.DecimalMax;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Future;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class Product implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer id;
	@NotNull
	@Size(min = 1, max = 10)
	private String name;
	@NotNull
	@DecimalMin(value = "0.01")
	@DecimalMax(value = "36")
	private Float yearIncome;
	private ProductCategory category;
	@NotNull
	@Min(value = 1)
	@Max(value = 999999999)
	private int totalAmount;
	private int actualAmount;
	@NotNull
	@Min(value = 1)
	@Max(value = 999)
	private Integer financePeriod;
	@NotNull
	@Min(value = 1)
	@Max(value = 30)
	private Integer raisePeriod;
	@NotNull
	private Integer lowestMoney;
	@NotNull
	@Future
	private Date shippedTime;
	private String interestDate;
	private Bonus bonus;
	private int status;
	private String label;
	private Integer highestMoney;
	private float increaseInterest;
	private String displayPlatform;
	private Merchant merchant;
	private int initialTotalAmount;
	private Float loanYearIncome;
	private Integer sortNumber;
	private int version;
	private Date soldOutTime;
	private ProductDetail productDetail;
	private Integer interestType;
	public Product() {

	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public Integer getHighestMoney() {
		return highestMoney;
	}

	public void setHighestMoney(Integer highestMoney) {
		this.highestMoney = highestMoney;
	}

	public float getIncreaseInterest() {
		return increaseInterest;
	}

	public void setIncreaseInterest(float increaseInterest) {
		this.increaseInterest = increaseInterest;
	}

	public String getDisplayPlatform() {
		return displayPlatform;
	}

	public void setDisplayPlatform(String displayPlatform) {
		this.displayPlatform = displayPlatform;
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

	public Integer getSortNumber() {
		return sortNumber;
	}

	public void setSortNumber(Integer sortNumber) {
		this.sortNumber = sortNumber;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public Date getSoldOutTime() {
		return soldOutTime;
	}

	public void setSoldOutTime(Date soldOutTime) {
		this.soldOutTime = soldOutTime;
	}

	public ProductDetail getProductDetail() {
		return productDetail;
	}

	public void setProductDetail(ProductDetail productDetail) {
		this.productDetail = productDetail;
	}

	public Integer getInterestType() {
		return interestType;
	}

	public void setInterestType(Integer interestType) {
		this.interestType = interestType;
	}

	
}