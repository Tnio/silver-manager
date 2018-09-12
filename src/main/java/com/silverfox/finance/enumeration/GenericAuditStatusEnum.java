package com.silverfox.finance.enumeration;

public enum GenericAuditStatusEnum {
	ALL(-1,"全部"),
	TOAUDIT(0,"待审核"),
	PASSED(1,"通过"),
	NOTPASSED(2,"不通过"),
	INTHESALE(3,"在售");
	
	private int value;
	private String msg;
	
	private GenericAuditStatusEnum(int value, String msg){
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