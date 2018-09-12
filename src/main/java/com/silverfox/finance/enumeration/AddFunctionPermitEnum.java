package com.silverfox.finance.enumeration;

public enum AddFunctionPermitEnum {
    INVITER_LOOK_DETAIL(2081,"邀请人管理-查看用户明细"),
	NOINVEST_EXCEL_EXPORT(1012,"注册2-7天未投资用户数据导出"),
	LOST_CUSTOMER_EXCEL_EXPORT(1013,"6	流失用户管理数据导出");
	
	private final int code;
	private final String msg;
	
	private AddFunctionPermitEnum(int code, String msg) {
		this.code = code;
		this.msg = msg;
	}

	public int getCode() {
		return code;
	}

	public String getMsg() {
		return msg;
	}
}
