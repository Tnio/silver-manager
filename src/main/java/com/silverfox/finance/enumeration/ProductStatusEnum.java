package com.silverfox.finance.enumeration;

public enum ProductStatusEnum {
	INTHESALE("在售"),
	NOTSTARTED("未开始"),
	SOLDOUT("售罄");
	private String status;
	
	private ProductStatusEnum(String status){
		this.status = status;
	}
	
	public String toString(){
		return this.status.toString();
	}
}