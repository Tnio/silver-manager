package com.silverfox.finance.service.impl;

import com.silverfox.finance.domain.*;
import com.silverfox.finance.enumeration.CustomerCouponSourceEnum;
import com.silverfox.finance.orm.*;
import com.silverfox.finance.service.BonusService;
import com.silverfox.finance.util.LogRecord;
import com.silverfox.finance.util.ValidatorUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class BonusServiceImpl implements BonusService {
    @Autowired
    private BonusDao bonusDao;
    @Autowired
    private GoodsDao goodsDao;
    @Autowired
    private SignInDao signInDao;
    @Autowired
    private CustomerGoodsOrderDao customerGoodsOrderDao;
    @Autowired
    private BonusStrategyDao bonusStrategyDao;
    @Autowired
    private CouponDao couponDao;
    @Autowired
    private CustomerCouponDao customerCouponDao;
    @Autowired
    protected MessageSource messageSource;

    @Override
    @LogRecord(module=LogRecord.Module.GOODS, operation=LogRecord.Operation.GOODSSAVE, id="", name="${goods.name}")
    public boolean saveGoods(Goods goods) {
//        return bonusServiceConsumer.save(goods);
        boolean checkReslut = checkedParam(goods);
        if(checkReslut){
            if(goods.getId() > 0){
                return goodsDao.update(goods) > 0 ? true : false;
            }else{
                return goodsDao.insert(goods) > 0 ? true : false;
            }
        }else{
            return false;
        }
    }

    @Override
    public boolean save(CustomerGoodsOrder goodsOrder) {
//        return bonusServiceConsumer.save(goodsOrder);
        CustomerGoodsOrder order = customerGoodsOrderDao.selectByOrderNo(goodsOrder.getOrderNo());
        if(order != null && order.getOrderNo() != null){
            return customerGoodsOrderDao.update(goodsOrder) > 0 ? true : false;
        }else{
            return customerGoodsOrderDao.insert(goodsOrder) > 0 ? true : false;
        }
    }

    @Override
    @LogRecord(module=LogRecord.Module.ACTIVITY, operation=LogRecord.Operation.SIGNINSAVE, id="", name="签到机制")
    public boolean save(SignIn signIn) {
//        return bonusServiceConsumer.save(signIn);
        boolean checkResult = checkedParam(signIn);
        if(checkResult){
            if(signIn.getId() > 0){
                return signInDao.update(signIn) > 0 ? true : false;
            }else{
                return false;
            }
        }else{
            return false;
        }
    }

    @Override
    @LogRecord(module=LogRecord.Module.GOODS, operation=LogRecord.Operation.GOODSUD, id="${id}", name="")
    public boolean updateStatus(int id, int status) {
        Goods goods = new Goods();
        goods = goodsDao.selectById(id);//bonusServiceConsumer.getGoods(id);
        goods.setStatus(status);
//        return bonusServiceConsumer.save(goods);
        boolean checkReslut = checkedParam(goods);
        if(checkReslut){
            if(goods.getId() > 0){
                return goodsDao.update(goods) > 0 ? true : false;
            }else{
                return goodsDao.insert(goods) > 0 ? true : false;
            }
        }else{
            return false;
        }
    }

    @Override
    public SignIn getSignIn(int id) {
//        return bonusServiceConsumer.getSignIn(id);
        return signInDao.selectById(id);
    }

    @Override
    @LogRecord(module=LogRecord.Module.REBATE, operation=LogRecord.Operation.REBATESAVE, id="", name="${bonusStrategy.name}")
    public boolean save(BonusStrategy bonusStrategy) {
//        return bonusServiceConsumer.save(bonusStrategy);
        if (bonusStrategy != null) {
            return bonusStrategyDao.insert(bonusStrategy) > 0 ? true : false;
        }
        return false;
    }

    @Override
    public boolean delete(int bonusId) {
//        return bonusServiceConsumer.delete(bonusId);
        return bonusStrategyDao.delete(bonusId) > 0 ? true : false;
    }

    @Override
    public List<Bonus> list(int offset, int size) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("offset", offset);
        params.put("size", size);
        List<Bonus> list = bonusDao.queryForList(params);
        List<Bonus> fixedList = new ArrayList<Bonus>();
        List<Bonus> unFixedList = new ArrayList<Bonus>();
        for (Bonus bonus : list) {
            unFixedList.add(bonus);
        }
        Collections.sort(fixedList, new Comparator<Bonus>() {
            @Override
            public int compare(Bonus originalBonus, Bonus tempBonus) {
                if (originalBonus.getId() < tempBonus.getId()) {
                    return -1;
                } else if (originalBonus.getId() > tempBonus.getId()) {
                    return 1;
                } else {
                    return 0;
                }
            }
        });
        list = new ArrayList<Bonus>();
        list.addAll(fixedList);
        list.addAll(unFixedList);
        return list;
    }

    @Override
    public boolean duplicate(int id, String name) {
        return bonusDao.duplicate(id, name) > 0 ? true : false;
    }

    @Override
    public Bonus get(int id) {
        return bonusDao.selectById(id);
    }

    @Override
    public List<BonusStrategy> getStrategies(int bonusId) {
        return bonusDao.selectStrategiesByBonusId(bonusId);
    }

    @Override
    @LogRecord(module=LogRecord.Module.REBATE, operation=LogRecord.Operation.REBATESAVE, id="", name="${bonus.name}")
    public int saveBonus(Bonus bonus){
//        return bonusServiceConsumer.save(bonus);
        int n = 0;
        boolean checkResult = checkedParam(bonus);
        if(checkResult){
            if(bonus.getId() > 0){
                n =  bonusDao.update(bonus);
            }else{
                n =  bonusDao.insert(bonus);
            }
            if (n>0){
                return bonus.getId();
            }
        }else{
            return 0;
        }

        return 0;
    }

    @Override
    @LogRecord(module=LogRecord.Module.REBATE, operation=LogRecord.Operation.ENABLE, id="${id}", name="")
    public boolean enable(int id, short enable) {
//        return bonusServiceConsumer.enable(id, enable);
        if(id > 0){
            return bonusDao.enable(id, enable) > 0 ? true : false;
        }
        return false;
    }


    @Override
    public Coupon getCoupon(int couponId) {
//        return couponServiceConsumer.get(couponId);
        return couponDao.select(couponId);
    }

    @Override
    public CustomerCoupon getCumulativeCoupon(int userId) {
        return customerCouponDao.selectByUserId(userId);
    }

    @Override
    public int count() {
        return bonusDao.queryForCount();
    }

    @Override
    public boolean giveCoupon(User user, int couponId, CustomerCouponSourceEnum channel) {
        Coupon coupon = couponDao.select(couponId);//couponServiceConsumer.get(couponId);
        if (coupon != null && coupon.getId() > 0) {
            CustomerCoupon customerCoupon = new CustomerCoupon();
            customerCoupon.setUser(user);
            customerCoupon.setCreateTime(Calendar.getInstance().getTime());
            customerCoupon.setCoupon(coupon);
            customerCoupon.setCumulative(0);
            customerCoupon.setSource(channel.getValue());
            customerCoupon.setUsed(0);
            customerCoupon.setAmount(Integer.parseInt(coupon.getAmount()));
//            return bonusServiceConsumer.giveCoupon(customerCoupon);
            return customerCouponDao.insertCustomerCoupon(customerCoupon) > 0 ? true : false;
        }
        return false;
    }

    private boolean checkedParam(Bonus bonus){
        if(bonus != null){
            if(!ValidatorUtil.StrNotNullAndMinAndMax(bonus.getName(), 3, 20)){
                return false;
            }
            if(!(bonus.getGiveType() >= 0)){
                return false;
            }
            return true;
        }else{
            return false;
        }
    }

    private boolean checkedParam(SignIn signIn){
        if(signIn != null){
            if(!(signIn.getSilver() >= 1 && signIn.getSilver() <=999)){
                return false;
            }
            if(!(signIn.getIncrement() >= 1 && signIn.getIncrement() <=999)){
                return false;
            }
            if(!(signIn.getCeiling() >= 1 && signIn.getCeiling() <=999)){
                return false;
            }
            if(!ValidatorUtil.isDate(new SimpleDateFormat("yyyy-MM-dd").format(signIn.getStartDate()))){
                return false;
            }
            if(!ValidatorUtil.isDate(new SimpleDateFormat("yyyy-MM-dd").format(signIn.getEndDate()))){
                return false;
            }
            if(!ValidatorUtil.StrNotNull(signIn.getRuleDesc())){
                return false;
            }
            return true;
        }else{
            return false;
        }
    }

    private boolean checkedParam(Goods goods){
        if(goods != null){
            if(!ValidatorUtil.StrNotNullAndMinAndMax(goods.getName(), 3, 20)){
                return false;
            }
            if(!ValidatorUtil.StrNotNull(goods.getStock()+"")){
                return false;
            }
            if(!ValidatorUtil.StrNotNull(goods.getConsumeSilver()+"")){
                return false;
            }
            if(!ValidatorUtil.StrNotNull(goods.getType()+"")){
                return false;
            }
            if(!(goods.getSortNumber() != null && goods.getSortNumber() > 0)){
                return false;
            }
            return true;
        }else{
            return false;
        }
    }
    
    @Override
	public List<Bonus> list(String endTime, int rebateType, int enable) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(endTime != null){
			params.put("endTime", endTime);
		}
		params.put("enable", enable);
		return bonusDao.queryForListByEndTimeAndEnable(params);
	}
}