package com.silverfox.finance.domain;

import java.io.Serializable;

public class Signature implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int productId;
	private int customerId;
	private String originalUrl;
	private String desensitizationUrl;

	public Signature() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public String getOriginalUrl() {
		return originalUrl;
	}

	public void setOriginalUrl(String originalUrl) {
		this.originalUrl = originalUrl;
	}

	public String getDesensitizationUrl() {
		return desensitizationUrl;
	}

	public void setDesensitizationUrl(String desensitizationUrl) {
		this.desensitizationUrl = desensitizationUrl;
	}
}