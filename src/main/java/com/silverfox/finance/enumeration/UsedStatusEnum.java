package com.silverfox.finance.enumeration;

public enum UsedStatusEnum {
	ALL(-1,"全部"),
	USED(0,"可使用"),
	NOUSED(1,"不可用");
	
	private int value;
	private String msg;
	
	private UsedStatusEnum(int value, String msg){
		this.value = value;
		this.msg = msg;
	}
	
	public int getValue() {
		return value;
	}

	public String getMsg() {
		return msg;
	}
}