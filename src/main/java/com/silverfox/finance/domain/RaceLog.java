package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class RaceLog implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private Goods goods;
	private String name;
	private String cellphone;
	private int joinCode;
	private Date createTime;
	private int mark;
	private int winning;
	private long random;

	public RaceLog() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public int getJoinCode() {
		return joinCode;
	}

	public void setJoinCode(int joinCode) {
		this.joinCode = joinCode;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public int getMark() {
		return mark;
	}

	public void setMark(int mark) {
		this.mark = mark;
	}

	public int getWinning() {
		return winning;
	}

	public void setWinning(int winning) {
		this.winning = winning;
	}

	public long getRandom() {
		return random;
	}

	public void setRandom(long random) {
		this.random = random;
	}
}
