package com.silverfox.finance.enumeration;

public enum CustomerBalanceTypeEnum {
    RECHARGE(1, "充值"),
    WITHDRAWALS(2, "提现"),
    PURCHASE(3, "购买"),
    PAYMENT(4, "回款"),
    FEE(5, "手续费"),
    COUPON(6, "优惠券"),
    INCREASEINTEREST(7,"产品加息");

    private int type;
    private String msg;

    private CustomerBalanceTypeEnum(int type, String msg) {
        this.type = type;
        this.msg = msg;
    }

    public int getType() {
        return type;
    }

    public String getMsg() {
        return msg;
    }
}
