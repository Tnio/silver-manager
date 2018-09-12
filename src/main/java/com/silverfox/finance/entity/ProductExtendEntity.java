package com.silverfox.finance.entity;

import java.util.List;

import com.silverfox.finance.domain.CustomerOrder;
import com.silverfox.finance.domain.Product;

public class ProductExtendEntity extends Product {
	private static final long serialVersionUID = 1L;
	private List<CustomerOrder> customerOrder;

	public List<CustomerOrder> getCustomerOrder() {
		return customerOrder;
	}

	public void setCustomerOrder(List<CustomerOrder> customerOrder) {
		this.customerOrder = customerOrder;
	}

}
