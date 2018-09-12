package com.silverfox.finance.enumeration;

public enum AuthorisationCategoryEnum {
    QQ(0),
    WCHAT(1);

    int category;

    private AuthorisationCategoryEnum(int category) {
        this.category = category;
    }

    public int value() {
        return category;
    }
}
