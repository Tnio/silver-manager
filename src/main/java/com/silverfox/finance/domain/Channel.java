package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class Channel implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private int category;
	private String registerUrl;
	private String spreadUrl;
	private String downloadUrl;
	private String banner;
	private String rule;
	private Coupon coupon;
	private int forwardCategory;
	private Double allTradeMoney;
	private Integer allRegisterCount;
	private Integer allCustomerCount;
	private Float allConvertRates;
	private Integer newRegisterCount;
	private Integer newCustomerCount;
	private Float newConvertRates;
	private Integer activeCustomerCount;
	private Integer totalTradeMoney;
	private Date dateTime;
	private int status;
	private String backgroundColor;
	private String textColor;
	private String backgroundUrl;

	public Channel() {

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

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public String getRegisterUrl() {
		return registerUrl;
	}

	public void setRegisterUrl(String registerUrl) {
		this.registerUrl = registerUrl;
	}

	public String getSpreadUrl() {
		return spreadUrl;
	}

	public void setSpreadUrl(String spreadUrl) {
		this.spreadUrl = spreadUrl;
	}

	public String getDownloadUrl() {
		return downloadUrl;
	}

	public void setDownloadUrl(String downloadUrl) {
		this.downloadUrl = downloadUrl;
	}

	public String getBanner() {
		return banner;
	}

	public void setBanner(String banner) {
		this.banner = banner;
	}

	public String getRule() {
		return rule;
	}

	public void setRule(String rule) {
		this.rule = rule;
	}

	public Coupon getCoupon() {
		return coupon;
	}

	public void setCoupon(Coupon coupon) {
		this.coupon = coupon;
	}

	public int getForwardCategory() {
		return forwardCategory;
	}

	public void setForwardCategory(int forwardCategory) {
		this.forwardCategory = forwardCategory;
	}

	public Double getAllTradeMoney() {
		return allTradeMoney;
	}

	public void setAllTradeMoney(Double allTradeMoney) {
		this.allTradeMoney = allTradeMoney;
	}

	public Integer getAllRegisterCount() {
		return allRegisterCount;
	}

	public void setAllRegisterCount(Integer allRegisterCount) {
		this.allRegisterCount = allRegisterCount;
	}

	public Integer getAllCustomerCount() {
		return allCustomerCount;
	}

	public void setAllCustomerCount(Integer allCustomerCount) {
		this.allCustomerCount = allCustomerCount;
	}

	public Float getAllConvertRates() {
		return allConvertRates;
	}

	public void setAllConvertRates(Float allConvertRates) {
		this.allConvertRates = allConvertRates;
	}

	public Integer getNewRegisterCount() {
		return newRegisterCount;
	}

	public void setNewRegisterCount(Integer newRegisterCount) {
		this.newRegisterCount = newRegisterCount;
	}

	public Integer getNewCustomerCount() {
		return newCustomerCount;
	}

	public void setNewCustomerCount(Integer newCustomerCount) {
		this.newCustomerCount = newCustomerCount;
	}

	public Float getNewConvertRates() {
		return newConvertRates;
	}

	public void setNewConvertRates(Float newConvertRates) {
		this.newConvertRates = newConvertRates;
	}

	public Integer getActiveCustomerCount() {
		return activeCustomerCount;
	}

	public void setActiveCustomerCount(Integer activeCustomerCount) {
		this.activeCustomerCount = activeCustomerCount;
	}

	public Integer getTotalTradeMoney() {
		return totalTradeMoney;
	}

	public void setTotalTradeMoney(Integer totalTradeMoney) {
		this.totalTradeMoney = totalTradeMoney;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getDateTime() {
		return dateTime;
	}

	public void setDateTime(Date dateTime) {
		this.dateTime = dateTime;
	}

	public String getBackgroundColor() {
		return backgroundColor;
	}

	public void setBackgroundColor(String backgroundColor) {
		this.backgroundColor = backgroundColor;
	}

	public String getTextColor() {
		return textColor;
	}

	public void setTextColor(String textColor) {
		this.textColor = textColor;
	}

	public String getBackgroundUrl() {
		return backgroundUrl;
	}

	public void setBackgroundUrl(String backgroundUrl) {
		this.backgroundUrl = backgroundUrl;
	}
}