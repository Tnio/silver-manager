package com.silverfox.finance.entity;

import java.io.Serializable;

public class EsignEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private String orderNO;
	private String protoName;
	private int productId;
	private String productName;
	private String merchantName;
	private String merchantNO;
	private int merchantAmount;
	private int customerId;
	private String customerName;
	private String idcard;
	private String cellphone;
	private int principal;
	private double yearIncome;
	private int financePeriod;
	private String interestDate;
	private String soldOutTime;
	private int productType;
	private String contractNO;

	public EsignEntity() {

	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public String getOrderNO() {
		return orderNO;
	}

	public void setOrderNO(String orderNO) {
		this.orderNO = orderNO;
	}

	public String getProtoName() {
		return protoName;
	}

	public void setProtoName(String protoName) {
		this.protoName = protoName;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getMerchantName() {
		return merchantName;
	}

	public void setMerchantName(String merchantName) {
		this.merchantName = merchantName;
	}

	public String getMerchantNO() {
		return merchantNO;
	}

	public void setMerchantNO(String merchantNO) {
		this.merchantNO = merchantNO;
	}

	public int getMerchantAmount() {
		return merchantAmount;
	}

	public void setMerchantAmount(int merchantAmount) {
		this.merchantAmount = merchantAmount;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
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

	public int getPrincipal() {
		return principal;
	}

	public void setPrincipal(int principal) {
		this.principal = principal;
	}

	public double getYearIncome() {
		return yearIncome;
	}

	public void setYearIncome(double yearIncome) {
		this.yearIncome = yearIncome;
	}

	public int getFinancePeriod() {
		return financePeriod;
	}

	public void setFinancePeriod(int financePeriod) {
		this.financePeriod = financePeriod;
	}

	public String getInterestDate() {
		return interestDate;
	}

	public void setInterestDate(String interestDate) {
		this.interestDate = interestDate;
	}

	public String getSoldOutTime() {
		return soldOutTime;
	}

	public void setSoldOutTime(String soldOutTime) {
		this.soldOutTime = soldOutTime;
	}

	public int getProductType() {
		return productType;
	}

	public void setProductType(int productType) {
		this.productType = productType;
	}

	public String getContractNO() {
		return contractNO;
	}

	public void setContractNO(String contractNO) {
		this.contractNO = contractNO;
	}
}