package com.silverfox.finance.domain;

import java.io.Serializable;

public class EarnSilver implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private short type;
	private String content;
	private String address;
	private int giveSilver;
	private short shareNum;
	private String shareContent;
	private short enable;
	private NewsMaterial news;

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

	public short getType() {
		return type;
	}

	public void setType(short type) {
		this.type = type;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getGiveSilver() {
		return giveSilver;
	}

	public void setGiveSilver(int giveSilver) {
		this.giveSilver = giveSilver;
	}

	public short getShareNum() {
		return shareNum;
	}

	public void setShareNum(short shareNum) {
		this.shareNum = shareNum;
	}

	public String getShareContent() {
		return shareContent;
	}

	public void setShareContent(String shareContent) {
		this.shareContent = shareContent;
	}

	public short getEnable() {
		return enable;
	}

	public void setEnable(short enable) {
		this.enable = enable;
	}

	public NewsMaterial getNews() {
		return news;
	}

	public void setNews(NewsMaterial news) {
		this.news = news;
	}
}