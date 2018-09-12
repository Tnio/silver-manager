package com.silverfox.finance.domain;

import java.io.Serializable;

public class Goods implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private int category;
	private int virtualGoods;
	private String url;
	private int stock;
	private int consumeSilver;
	private int type;
	private Integer sortNumber;
	private int status;
	private int hot;
	private String largerUrl;
	private String remark;
	private String rule;
	private double price;
	private int joinNum;
	private String cellphone;
	private double discount;
	private int times;
	private int achieveAmount;
	private String beginDate;
	private String endDate;
	private int isShow;
	private short financePeriod;
	private int vipDiscount;
	public Goods() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public double getDiscount() {
		return discount;
	}

	public void setDiscount(double discount) {
		this.discount = discount;
	}

	public int getTimes() {
		return times;
	}

	public void setTimes(int times) {
		this.times = times;
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

	public int getVirtualGoods() {
		return virtualGoods;
	}

	public void setVirtualGoods(int virtualGoods) {
		this.virtualGoods = virtualGoods;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public int getConsumeSilver() {
		return consumeSilver;
	}

	public void setConsumeSilver(int consumeSilver) {
		this.consumeSilver = consumeSilver;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public Integer getSortNumber() {
		return sortNumber;
	}

	public void setSortNumber(Integer sortNumber) {
		this.sortNumber = sortNumber;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getHot() {
		return hot;
	}

	public void setHot(int hot) {
		this.hot = hot;
	}

	public String getLargerUrl() {
		return largerUrl;
	}

	public void setLargerUrl(String largerUrl) {
		this.largerUrl = largerUrl;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getRule() {
		return rule;
	}

	public void setRule(String rule) {
		this.rule = rule;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getJoinNum() {
		return joinNum;
	}

	public void setJoinNum(int joinNum) {
		this.joinNum = joinNum;
	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public int getAchieveAmount() {
		return achieveAmount;
	}

	public void setAchieveAmount(int achieveAmount) {
		this.achieveAmount = achieveAmount;
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

	public int getIsShow() {
		return isShow;
	}

	public void setIsShow(int isShow) {
		this.isShow = isShow;
	}

	public short getFinancePeriod() {
		return financePeriod;
	}

	public void setFinancePeriod(short financePeriod) {
		this.financePeriod = financePeriod;
	}

	public int getVipDiscount() {
		return vipDiscount;
	}

	public void setVipDiscount(int vipDiscount) {
		this.vipDiscount = vipDiscount;
	}
	
}