package com.silverfox.finance.enumeration;

public enum TradeResultEnum {
	HANDING("处理中"),
	FAILURE("交易失败"),
	SUCCESS("交易成功");
	
	private String result;
	
	private TradeResultEnum(String result) {
		this.result = result;
	}

	@Override
	public String toString() {
		return this.result;
	}
}
