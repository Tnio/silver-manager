package com.silverfox.finance.enumeration;

public enum PrizeCategoryEnum {
    SILVER(1),
    COUPON(2),
    ENTITY(3),
    NO_PRIZE(4);

    int value;

    private PrizeCategoryEnum(int value) {
        this.value = value;
    }

    public int value() {
        return this.value;
    }
}
