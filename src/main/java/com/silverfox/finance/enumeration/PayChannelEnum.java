package com.silverfox.finance.enumeration;

public enum PayChannelEnum {
	UNION_PAY(0, "连连认证支付"),
	UNION_PERSONAL_EBANK(1, "连连个人网银支付"),
	UNION_ENTERPRISE_EBANK(2, "连连企业网银支付");
	
	private int channel;
	private String msg;
	
	private PayChannelEnum(int channel, String msg) {
		this.channel = channel;
		this.msg = msg;
	}
	
	public int value() {
		return this.channel;
	}
	
	public String getMsg() {
		return this.msg;
	}
}