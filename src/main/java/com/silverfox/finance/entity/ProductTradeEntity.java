package com.silverfox.finance.entity;

import java.io.Serializable;

public class ProductTradeEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int aid;
	private Double inMoney;
	private Double outMoney;
	private int inTotal;
	private int outTotal;
	private int inPeople;
	private int outPeople;

	public ProductTradeEntity() {

	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public Double getInMoney() {
		return inMoney;
	}

	public void setInMoney(Double inMoney) {
		this.inMoney = inMoney;
	}

	public Double getOutMoney() {
		return outMoney;
	}

	public void setOutMoney(Double outMoney) {
		this.outMoney = outMoney;
	}

	public int getInTotal() {
		return inTotal;
	}

	public void setInTotal(int inTotal) {
		this.inTotal = inTotal;
	}

	public int getOutTotal() {
		return outTotal;
	}

	public void setOutTotal(int outTotal) {
		this.outTotal = outTotal;
	}

	public int getInPeople() {
		return inPeople;
	}

	public void setInPeople(int inPeople) {
		this.inPeople = inPeople;
	}

	public int getOutPeople() {
		return outPeople;
	}

	public void setOutPeople(int outPeople) {
		this.outPeople = outPeople;
	}
}
