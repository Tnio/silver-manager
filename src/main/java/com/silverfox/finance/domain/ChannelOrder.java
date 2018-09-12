package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class ChannelOrder implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String requestNO;
	private String detail;
	private String result;
	private String cellphone;
	private String goods;
	private Date createTime;
	private Channel channel;

	public ChannelOrder() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getRequestNO() {
		return requestNO;
	}

	public void setRequestNO(String requestNO) {
		this.requestNO = requestNO;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public Channel getChannel() {
		return channel;
	}

	public void setChannel(Channel channel) {
		this.channel = channel;
	}

	public String getGoods() {
		return goods;
	}

	public void setGoods(String goods) {
		this.goods = goods;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
