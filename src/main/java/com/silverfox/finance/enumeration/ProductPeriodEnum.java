package com.silverfox.finance.enumeration;

public enum ProductPeriodEnum {
	SFF(999, "全部"),
	SHORT(0, "短期"),
	MID(90, "中期"),
	LONG(180, "长期");
	private int value;
	private String msg;
	
	private ProductPeriodEnum(int value, String msg){
		this.value = value;
		this.msg = msg;
	}
	
	public int getPeriod() {
		return value;
	}
	
	public String getMsg(){
		return msg;
	}
	
	public String toString(){
		return String.valueOf(value);
	}
}