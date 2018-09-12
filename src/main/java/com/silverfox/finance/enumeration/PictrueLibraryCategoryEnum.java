package com.silverfox.finance.enumeration;

public enum PictrueLibraryCategoryEnum {
    ALBUM(0),
    START(1),
    LOGIN(2),
    NAVIGATION(3),
    BANNER(4),
    PRODUCTAD(5),
    SILVER_MARKET(6),
    ACTIVITY_ENTRANCE(7),
    VIPPICTURE(8),
    PHOTOGALLERY(-1),
    WEBPHOTO(-2);

    private int category;

    private PictrueLibraryCategoryEnum(int category) {
        this.category = category;
    }

    public int value() {
        return this.category;
    }
}
