package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class CustomerGoodsOrder implements Serializable {
	private static final long serialVersionUID = 1L;
	private Customer customer;
	private Goods goods;
	private String name;
	private String cellphone;
	private String address;
	private Date exchangeTime;
	private int status;
	private String orderNo;
	// 老版本，返回兑换的第三方券码号
	private String thirdpartyNo;

	public CustomerGoodsOrder() {

	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getExchangeTime() {
		return exchangeTime;
	}

	public void setExchangeTime(Date exchangeTime) {
		this.exchangeTime = exchangeTime;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getThirdpartyNo() {
		return thirdpartyNo;
	}

	public void setThirdpartyNo(String thirdpartyNo) {
		this.thirdpartyNo = thirdpartyNo;
	}
}