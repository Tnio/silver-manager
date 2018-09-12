package com.silverfox.finance.service.impl;

import com.silverfox.finance.domain.Coupon;
import com.silverfox.finance.domain.CustomerLotteryLog;
import com.silverfox.finance.domain.Lottery;
import com.silverfox.finance.domain.LotteryPrize;
import com.silverfox.finance.orm.LotteryDao;
import com.silverfox.finance.service.LotteryService;
import com.silverfox.finance.util.LogRecord;
import com.silverfox.finance.util.ValidatorUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.silverfox.finance.util.ConstantUtil.MAX_TIME;
import static com.silverfox.finance.util.ConstantUtil.MIN_TIME;

@Service
public class LotteryServiceImpl implements LotteryService {
    @Autowired
    private LotteryDao lotteryDao;

    @Override
    public int count() {
        return lotteryDao.queryForCount();
    }

    @Override
    public Lottery get(int id) {
        return lotteryDao.selectById(id);
    }

    @Override
    public List<Lottery> list(int offset, int size) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("offset", offset);
        params.put("size", size);
        return lotteryDao.queryForList(params);
    }

    @Override
    public boolean duplicate(int id, String name) {
        return lotteryDao.duplicate(id, name) > 0 ? true : false;
    }

    @Override
    @LogRecord(module=LogRecord.Module.LOTTERY, operation=LogRecord.Operation.LOTTERYSAVE, id="", name="${lottery.name}")
    public boolean saveLottery(Lottery lottery, String prizeStr) {
        boolean result = false;
//        lottery = lotteryDao.save(lottery);
        boolean checkedReslut = checkedParam(lottery);
        if(checkedReslut){
            if(lottery.getId() > 0){
                lotteryDao.update(lottery);
            }else{
                lotteryDao.insert(lottery);
            }
//            return lottery;
        }else{
            lottery = null;
        }
        if (lottery != null) {
            if (lottery.getId() > 0) {
                result = true;
            }
            int lotteryId = lottery.getId();
            //lotteryServiceConsumer.deleteLotteryPrize(lotteryId);
            if (StringUtils.isNotBlank(prizeStr)) {
                List<LotteryPrize> lotteryPrizes = new ArrayList<LotteryPrize>();
                String[] prizeArr = prizeStr.split(";");
                for (int i = 0; i < prizeArr.length; i++) {
                    LotteryPrize lotteryPrize = new LotteryPrize();
                    String[] prizeArrj = prizeArr[i].split(",");
                    lotteryPrize.setId(Integer.parseInt(prizeArrj[0]));
                    lotteryPrize.setCategory(Short.parseShort(prizeArrj[1]));
                    lotteryPrize.setSilverQuantity(Integer.parseInt(prizeArrj[2]));
                    Coupon coupon = new Coupon();
                    int couponId = 0;
                    if (StringUtils.isNotBlank(prizeArrj[3])) {
                        try {
                            couponId = Integer.parseInt(prizeArrj[3]);
                        } catch (Exception e) {
                            couponId = 0;
                        }
                    }
                    coupon.setId(couponId);
                    lotteryPrize.setCoupon(coupon);
                    lotteryPrize.setRequirement(Integer.parseInt(prizeArrj[4]));
                    lotteryPrize.setPrizeName(prizeArrj[5]);
                    lotteryPrize.setLimitedNumber(Integer.parseInt(prizeArrj[6]));
                    lotteryPrize.setSurplusQuantity(Integer.parseInt(prizeArrj[6]));
                    lotteryPrize.setLotteryId(lotteryId);
                    lotteryPrizes.add(lotteryPrize);
                }
//                lotteryServiceConsumer.saveLotteryPrize(lotteryPrizes);
                if(lotteryPrizes != null && lotteryPrizes.size() >0){
                    if (lotteryPrizes.get(0) != null && lotteryPrizes.get(0).getId() > 0) {
                        for (LotteryPrize prize : lotteryPrizes) {
                            lotteryDao.updatePrize(prize);
                        }
                    } else {
                        lotteryDao.insertPrizeBatch(lotteryPrizes);
                    }
                }
            }
        }
        return result;
    }

    @Override
    @LogRecord(module=LogRecord.Module.LOTTERY, operation=LogRecord.Operation.AUDIT_STATUS, id="${id}", name="")
    public boolean audit(int id, int status) {
//        return lotteryServiceConsumer.audit(id, status);
        if(id > 0){
            return lotteryDao.audit(id, status) > 0 ? true : false;
        }
        return false;
    }

    @Override
    @LogRecord(module=LogRecord.Module.LOTTERY, operation=LogRecord.Operation.LOTTERYSAVE, id="", name="${lottery.name}")
    public boolean save(CustomerLotteryLog customerLotteryLog) {
//        return lotteryServiceConsumer.saveLotteryLog(customerLotteryLog);
        return lotteryDao.insertDetail(customerLotteryLog) > 0 ? true : false;
    }

    @Override
    public boolean count(int status, short scene) {
        return lotteryDao.count(status, scene) > 0 ? true : false;
    }

    @Override
    public boolean decrSurplusQuantity(int id) {
//        return lotteryServiceConsumer.decrSurplusQuantity(id);
        return lotteryDao.decrSurplusQuantity(id) > 0 ? true : false;
    }

    @Override
    public int countParticipateTimeByLotteryId(int id) {
        return lotteryDao.countParticipateTimeByLotteryId(id);
    }

    @Override
    public int countConsumeLottery(int id, int shareGetSilver) {
        Integer quentity = lotteryDao.countConsumeLottery(id, shareGetSilver);
        if (quentity == null) {
            return 0;
        }
        return quentity;
    }

    @Override
    public int countParticipatePeoplesByLotteryId(int id) {
        return lotteryDao.countParticipatePeoplesByLotteryId(id);
    }

    @Override
    public List<LotteryPrize> selectPrizeById(int lotteryId) {
        return lotteryDao.selectPrizeById(lotteryId);
    }

    @Override
    public int countDetail(int lotteryId, String cellphone, int prizeId, String beginTime, String endTime) {
        return lotteryDao.queryDetailForCount(this.getParams(lotteryId,cellphone, prizeId, beginTime, endTime));
    }

    @Override
    public int getCostSilvers(int lotteryId, String cellphone, int prizeId, String beginTime, String endTime) {
        Integer silvers = lotteryDao.queryCostSilvers(getParams(lotteryId,cellphone, prizeId, beginTime, endTime));
        return silvers == null ? 0 : silvers;
    }

    @Override
    public int getSilvers(int lotteryId, String cellphone, int prizeId, String beginTime, String endTime) {
        Integer silvers = lotteryDao.queryGetSilvers(getParams(lotteryId,cellphone, prizeId, beginTime, endTime));
        return silvers == null ? 0 : silvers;
    }

    @Override
    public int getCoupons(int lotteryId, String cellphone, int prizeId, String beginTime, String endTime) {
        return lotteryDao.queryGetCoupons(getParams(lotteryId,cellphone, prizeId, beginTime, endTime));
    }

    @Override
    public List<CustomerLotteryLog> selectDetail(int lotteryId, String cellphone, int prizeId, String beginTime, String endTime, int offset, int size) {
        Map<String, Object> params = new HashMap<String, Object>();
        params = this.getParams(lotteryId, cellphone, prizeId, beginTime, endTime);
        params.put("offset", offset);
        params.put("size", size);
        return lotteryDao.queryDetailForList(params);
    }

    private boolean checkedParam(Lottery lottery){
        if(lottery != null){
            if(!ValidatorUtil.StrNotNullAndMinAndMax(lottery.getName(), 3, 40)){
                return false;
            }
            if(!ValidatorUtil.StrNotNull(lottery.getCategory())){
                return false;
            }
            if(!ValidatorUtil.StrNotNull(lottery.getBegin())){
                return false;
            }
            if(!ValidatorUtil.StrNotNull(lottery.getEnd())){
                return false;
            }
            if(!ValidatorUtil.StrNotNull(lottery.getFrequency()+"")){
                return false;
            }
            if(!ValidatorUtil.StrNotNull(lottery.getSilverCost()+"")){
                return false;
            }
			/*if(!ValidatorUtil.StrNotNull(lottery.getTimeDesc())){
				return false;
			}
			if(!ValidatorUtil.StrNotNull(lottery.getRemark())){
				return false;
			}
			if(!ValidatorUtil.StrNotNull(lottery.getPrizeDesc())){
				return false;
			}*/
            return true;
        }else{
            return false;
        }
    }

    private Map<String, Object> getParams(int lotteryId, String cellphone, int prizeId, String beginTime, String endTime){
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("lotteryId", lotteryId);
        if(StringUtils.isNotEmpty(cellphone)){
            params.put("cellphone", cellphone);
        }
        params.put("prizeId", prizeId);
        if (StringUtils.isNotEmpty(beginTime) && StringUtils.isNotEmpty(endTime)) {
            params.put("beginTime", beginTime + MIN_TIME);
            params.put("endTime", endTime + MAX_TIME);
        }
        return params;
    }
}