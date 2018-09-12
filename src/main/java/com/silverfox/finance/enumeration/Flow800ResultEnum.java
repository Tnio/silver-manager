package com.silverfox.finance.enumeration;

public enum Flow800ResultEnum {
	SUCCESS("00000", "支付成功"),
	ORDERING("10229", "订购中"),
	EMPTYPHONE("10001", "空号/号码不存在"),
	REPEAT("10018", "不能重复订购"),
	BLACKLIST("10013", "黑名单客户"),
	INVALIDPARAMETER("10003", "非法参数"),
	UNKNOWN("99999","未知结果");
	
	private final String code;
	private final String msg;
	
	private Flow800ResultEnum(String code, String msg) {
		this.code = code;
		this.msg = msg;
	}
	
	public String getCode() {
		return code;
	}

	public String getMsg() {
		return msg;
	}
	
	public static boolean isFlow800Result(String code) {
		for (Flow800ResultEnum v : Flow800ResultEnum.values()) {
			if (v.getCode().equals(code)) {
				return true;
			}
		}
		return false;
	}

	public static String getMsgByCode(String code) {
		for (Flow800ResultEnum v : Flow800ResultEnum.values()) {
			if (v.getCode().equals(code)) {
				return v.getMsg();
			}
		}
		return UNKNOWN.msg;
	}
}
