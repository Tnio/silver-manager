package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.silverfox.finance.entity.BonusOrderStrategyEntity;

public class Bonus implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	@NotNull
	@Size(min = 3, max = 20)
	private String name;
	private short status;
	private short giveType;
	private Date createTime;
	private String firstOrder;
	private int lastOrder;
	private int cashType;
	private int cashAmount;
	private List<BonusStrategy> bonusStrategy = new ArrayList<BonusStrategy>();
	private List<BonusOrderStrategyEntity> bonusOrderStrategy = new ArrayList<BonusOrderStrategyEntity>();// 兼容2.2.5之前版本

	public Bonus() {

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

	public short getStatus() {
		return status;
	}

	public void setStatus(short status) {
		this.status = status;
	}

	public short getGiveType() {
		return giveType;
	}

	public void setGiveType(short giveType) {
		this.giveType = giveType;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getFirstOrder() {
		return firstOrder;
	}

	public void setFirstOrder(String firstOrder) {
		this.firstOrder = firstOrder;
	}

	public int getLastOrder() {
		return lastOrder;
	}

	public void setLastOrder(int lastOrder) {
		this.lastOrder = lastOrder;
	}

	public List<BonusStrategy> getBonusStrategy() {
		return bonusStrategy;
	}

	public void setBonusStrategy(List<BonusStrategy> bonusStrategy) {
		this.bonusStrategy = bonusStrategy;
	}

	public List<BonusOrderStrategyEntity> getBonusOrderStrategy() {
		return bonusOrderStrategy;
	}

	public void setBonusOrderStrategy(List<BonusOrderStrategyEntity> bonusOrderStrategy) {
		this.bonusOrderStrategy = bonusOrderStrategy;
	}


	public int getCashAmount() {
		return cashAmount;
	}

	public void setCashAmount(int cashAmount) {
		this.cashAmount = cashAmount;
	}

	public int getCashType() {
		return cashType;
	}

	public void setCashType(int cashType) {
		this.cashType = cashType;
	}
	
}