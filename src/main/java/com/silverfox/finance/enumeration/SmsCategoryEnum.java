package com.silverfox.finance.enumeration;

public enum SmsCategoryEnum {
    MERCHANT("merchant"),
    PAYMENT("payment"),
	REG("reg"),
	LOGIN("login"),
	MERCHANT_LOGIN("merchantlogin"),
	MERCHANT_PAYMENT("merchantpayment"),
	MERCHANT_PAYBACK("merchantpayback"),
	RESET_LOGIN_PASSWORD("resetloginpassword"),
	PAYBACK_SUCCESS("paybacksuccess"),
	LIANLIAN_PAYBACK_SUCCESS("lianlianpaybacksuccess"),
	OLD_CELLPHONE("oldphone"),
	NEW_CELLPHONE("newphone"),
	CHANGE_CELLPHONE_AUDIT_SUCCESS("changecellphoneauditsuccess"),
	CHANGE_CELLPHONE_AUDIT_FAILURE("changecellphoneauditfailure"),
	CHANGE_CELLPHONE_INFO_UPLOAD("changecellphoneinfoupload"),
	TRADE("trade"),
	BINDING_CARD("binding"),
	CHANGE_CARD("changecard"),
	PURCHASE_SUCCESS("purchasesuccess"),
	INTEREST_ACCRUAL_START("interestaccrualstart"),
	FINANCIAL_REBATE("financialrebate"),
	CHANGE_CELLPHONE_OLD("changecellphoneold"),
	CHANGE_CELLPHONE_NEW("changecellphonenew"),
	DONATION_COUPON_PUSH_MESSAGE("donationcoupon"),
	DONATION_INTEREST_PUSH_MESSAGE("donationinterest"),
	DONATION_PUSH_TITLE("donationpushtitle");

    private SmsCategoryEnum(String category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return this.category;
    }

    private String category;
    
    public String value(){
		return this.category;
	}
}
