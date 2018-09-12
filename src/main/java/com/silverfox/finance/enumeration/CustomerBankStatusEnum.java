package com.silverfox.finance.enumeration;

public enum CustomerBankStatusEnum {
    ALL(-1),
    NOCANCELLATION(-2),
    CANCELLATION(0),
    USING(1),
    TURNOUT(2),
    EBANK(3);

    private int status;

    private CustomerBankStatusEnum(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return String.valueOf(this.status);
    }

    public int value() {
        return this.status;
    }
}
