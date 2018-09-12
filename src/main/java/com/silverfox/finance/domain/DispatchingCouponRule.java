package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class DispatchingCouponRule implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int source;
	private int quantity;
	private int status;
	private SmsTemplate template;
	private int giveCondition;
	private String couponIds;
	private String couponAmounts;
	private List<RuleCoupon> rules = new ArrayList<RuleCoupon>();

	public DispatchingCouponRule() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public List<RuleCoupon> getRules() {
		return rules;
	}

	public void setRules(List<RuleCoupon> rules) {
		this.rules = rules;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getSource() {
		return source;
	}

	public void setSource(int source) {
		this.source = source;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public SmsTemplate getTemplate() {
		return template;
	}

	public void setTemplate(SmsTemplate template) {
		this.template = template;
	}

	public int getGiveCondition() {
		return giveCondition;
	}

	public void setGiveCondition(int giveCondition) {
		this.giveCondition = giveCondition;
	}

	public String getCouponIds() {
		return couponIds;
	}

	public void setCouponIds(String couponIds) {
		this.couponIds = couponIds;
	}

	public String getCouponAmounts() {
		return couponAmounts;
	}

	public void setCouponAmounts(String couponAmounts) {
		this.couponAmounts = couponAmounts;
	}
}