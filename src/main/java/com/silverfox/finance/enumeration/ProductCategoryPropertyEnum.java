package com.silverfox.finance.enumeration;

public enum ProductCategoryPropertyEnum {
	COMMON("常规产品"),
	EXPERIENCE("体验专享"),
	NOVICE("新手专享"),
	ACTIVITY("活动专享"),
	TREASURE("银狐宝");
	
	private String property;
	
	private ProductCategoryPropertyEnum(String property){
		this.property = property;
	}
	
	@Override
	public String toString(){
		return this.property;
	}
}