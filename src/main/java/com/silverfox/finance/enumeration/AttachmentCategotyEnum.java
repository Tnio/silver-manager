package com.silverfox.finance.enumeration;

public enum AttachmentCategotyEnum {
	BILL(1, "商户流水证明"),
	DIAGRAM(2, "商户实拍图"),
	COLLATERAL_SECURITY(3, "商户质押物"),
	COMMITMENT(4, "商户承诺书"),
	GUARANTEE(5, "质押担保函"),
	GOODSSTORAGE(6,"物品仓储"),
	REPORT(7,"监管报告"),
	PROTOCOL(8,"资金监管协议"),
	CONTRACT(9,"合同");
	
	private final int category;
	private final String msg;
	
	private AttachmentCategotyEnum(int category, String msg) {
		this.category = category;
		this.msg = msg;
	}
	
	public int getCategory() {
		return category;
	}

	public String getMsg() {
		return msg;
	}
	
	
}