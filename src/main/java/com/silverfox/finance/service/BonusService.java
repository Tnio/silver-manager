package com.silverfox.finance.service;

import com.silverfox.finance.domain.*;
import com.silverfox.finance.enumeration.CustomerCouponSourceEnum;

import java.util.List;

public interface BonusService {
    List<Bonus> list(int offset, int size);
    boolean duplicate(int id ,String name);
    Bonus get(int id);
    public List<BonusStrategy> getStrategies(int bonusId);
    int saveBonus(Bonus bonus);
    boolean enable(int id, short enable);
    boolean giveCoupon(User user, int couponId, CustomerCouponSourceEnum channel);
    Coupon getCoupon(int couponId);
    CustomerCoupon getCumulativeCoupon(int userId);

    int count();
    public SignIn getSignIn(int id);
    public boolean save(SignIn signIn);

    boolean save(BonusStrategy bonusStrategy);
    boolean delete(int bonusId);

    public boolean saveGoods(Goods goods);
    public boolean save(CustomerGoodsOrder goodsOrder);

    public boolean updateStatus(int id, int status);
    List<Bonus> list(String endTime, int rebateType, int enable);
}
