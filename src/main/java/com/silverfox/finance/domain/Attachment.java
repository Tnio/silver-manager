package com.silverfox.finance.domain;

import java.io.Serializable;

public class Attachment implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int category;
	private int productId;
	private int guaranteeId;
	private ProductContract contract;
	private String url;

	public Attachment() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getGuaranteeId() {
		return guaranteeId;
	}

	public void setGuaranteeId(int guaranteeId) {
		this.guaranteeId = guaranteeId;
	}

	public ProductContract getContract() {
		return contract;
	}

	public void setContract(ProductContract contract) {
		this.contract = contract;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
}