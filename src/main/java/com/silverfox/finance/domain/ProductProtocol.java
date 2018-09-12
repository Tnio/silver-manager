package com.silverfox.finance.domain;

import java.io.Serializable;

public class ProductProtocol implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private int category;
	private String content;
	private int status;

	public ProductProtocol() {

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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}
