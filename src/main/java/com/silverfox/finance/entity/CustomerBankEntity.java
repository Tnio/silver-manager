package com.silverfox.finance.entity;

import java.io.Serializable;

import com.silverfox.finance.domain.CustomerBank;

public class CustomerBankEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private CustomerBank customerBank;
	private String quota;

	public CustomerBankEntity() {

	}

	public CustomerBank getCustomerBank() {
		return customerBank;
	}

	public void setCustomerBank(CustomerBank customerBank) {
		this.customerBank = customerBank;
	}

	public String getQuota() {
		return quota;
	}

	public void setQuota(String quota) {
		this.quota = quota;
	}
}