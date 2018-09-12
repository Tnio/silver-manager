package com.silverfox.finance.domain;

import java.io.Serializable;

public class ProductParam implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private String category;
	private ProductParam parent;

	public ProductParam() {

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

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public ProductParam getParent() {
		return parent;
	}

	public void setParent(ProductParam parent) {
		this.parent = parent;
	}

}