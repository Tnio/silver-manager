package com.silverfox.finance.enumeration;

public enum MessageSceneEnum {
	BUYSUCCESS(1),	
	INTEREST(2),
	EXPIRE(3),
	RECEIVEDPAYMENTS(4),
	BAOBAOBUYSUCCESS(5),
	BAOBAOTURNOUT(6),
	BAOBAOTURNOUTSUCCESS(7),
	FINANCIALREBATE(8);
	
	int value;
	
	private MessageSceneEnum(int value) {
		this.value = value;
	}

	public int toInt() {
		return value;
	}
}