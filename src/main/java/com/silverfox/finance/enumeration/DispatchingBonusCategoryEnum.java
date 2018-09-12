package com.silverfox.finance.enumeration;

public enum DispatchingBonusCategoryEnum {
	COUPON(0, "红包赠送"),
	SILVER(1, "银子赠送"),
	COUPON_RULE(2, "券码规则");
	
	private final int category;
	private final String msg;
	
	DispatchingBonusCategoryEnum(int category, String msg){
		this.category = category;
		this.msg = msg;
	}
	
	public String getMsg(){
		return this.msg;
	}
	
	public int getCategory(){
		return this.category;
	}
}