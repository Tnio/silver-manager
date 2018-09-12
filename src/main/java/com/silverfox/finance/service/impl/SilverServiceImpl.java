package com.silverfox.finance.service.impl;

import com.silverfox.finance.domain.*;
import com.silverfox.finance.orm.*;
import com.silverfox.finance.service.SilverService;
import com.silverfox.finance.util.LogRecord;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SilverServiceImpl implements SilverService {
    @Autowired
    private SignInDao signInDao;
    @Autowired
    private SilverStrategyDao silverStrategyDao;
    @Autowired
    private GoodsDao goodsDao;
    @Autowired
    private GoodsCouponCodeDao goodsCouponCodeDao;
    @Autowired
    private CustomerGoodsOrderDao customerGoodsOrderDao;
    @Autowired
    private CustomerSilverLogDao customerSilverLogDao;
    @Autowired
    private EarnSilverDao earnSilverDao;
    @Autowired
    private RaceLogDao raceLogDao;
    @Autowired
    private DispatchingLogDao dispatchingLogDao;

    @Override
    public SignIn getSignIn(int id) {
        return signInDao.selectById(id);
    }

    @Override
    public SilverStrategy get(int id) {
        return silverStrategyDao.selectById(id);
    }

    @Override
    @LogRecord(module=LogRecord.Module.SILVER, operation=LogRecord.Operation.INVITATION, id="", name="")
    public boolean saveSilverStrategy(SilverStrategy silverStrategy) {
        return silverStrategyDao.update(silverStrategy) > 0 ? true : false;
    }

    @Override
    @LogRecord(module=LogRecord.Module.SILVERGIVE, operation=LogRecord.Operation.ENABLE, id="${id}", name="")
    public boolean audit(int id, short enable) {
        return silverStrategyDao.enable(id, enable) > 0 ? true : false;
    }

    @Override
    public Goods getGoods(int id) {

        return goodsDao.selectById(id);
    }

    @Override
    @LogRecord(module=LogRecord.Module.GOODS, operation=LogRecord.Operation.AUDIT, id="", name="${goods.name}")
    public boolean save(Goods goods, List<GoodsCouponCode> codes) {
        if(goods != null){
            int result = 0;
            if(goods != null){
                if(goods.getType() == 3 && codes != null && codes.size() > 0){
                    goods.setStock(codes.size());
                }
                if(goods.getId() > 0){
                    result = goodsDao.update(goods);
                }else{
                    result = goodsDao.insert(goods);
                }
                if(result > 0){
                    if(goods.getId() > 0){
                        if(goods.getType() == 3 && codes != null && codes.size() > 0){
                            goodsCouponCodeDao.deleteByGoodsId(goods.getId());
                            goodsCouponCodeDao.insertGoodsCouponCodes(codes, goods.getId(), 0);
                        }
                    }
                }
            }
            return result > 0 ? true : false;
        }
        return false;
    }

    @Override
    public List<Goods> listGoods(int achieveAmount, int platform, int type, int offset, int size) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("achieveAmount", achieveAmount);
        params.put("type", type);
        params.put("platform", platform);
        params.put("offset", offset);
        params.put("size", size);
        return goodsDao.queryForList(params);
    }

    @Override
    public int countGoods(int achieveAmount, int platform, int type, String name) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("achieveAmount", achieveAmount);
        params.put("type", type);
        params.put("name", name);
        params.put("platform", platform);
        return goodsDao.queryForCount(params);
    }

    @Override
    public List<CustomerGoodsOrder> list(String goodsName, String cellphone, String beginDate, String endDate, int type, int offset, int size) {
        Map<String, Object> params = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(cellphone)){
            params.put("cellphone", cellphone);
        }
        if (StringUtils.isNotBlank(beginDate) && StringUtils.isNotBlank(endDate)) {
            params.put("beginDate", beginDate);
            params.put("endDate", endDate);
        }
        if (StringUtils.isNotBlank(goodsName)) {
            params.put("goodsName", goodsName);
        }
        if(type > 0){
            params.put("type", type);
        }
        params.put("offset", offset);
        params.put("size", size);
        return customerGoodsOrderDao.queryForList(params);
    }

    @Override
    public int count(String goodsName, String cellphone, String beginDate, String endDate, int type) {
        Map<String, Object> params = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(cellphone)){
            params.put("cellphone", cellphone);
        }
        if (StringUtils.isNotBlank(beginDate) && StringUtils.isNotBlank(endDate)) {
            params.put("beginDate", beginDate);
            params.put("endDate", endDate);
        }
        if (StringUtils.isNotBlank(goodsName)) {
            params.put("goodsName", goodsName);
        }
        if(type > 0){
            params.put("type", type);
        }
        return customerGoodsOrderDao.queryForCount(params);
    }

    @Override
    public boolean saveSignInPrizes(List<SignInPrize> signInPrizes, SignIn signIn) {
        int result = 0;
        if(signIn != null){
            if(signIn.getId() != null && signIn.getId() > 0){
                signInDao.update(signIn);
            }else{
                signInDao.insert(signIn);
            }
        }

        if(signInPrizes.size() > 0){
            List<SignInPrize> toSaveList = new ArrayList<SignInPrize>();
            List<SignInPrize> toUpdateList = new ArrayList<SignInPrize>();
            for(SignInPrize prize: signInPrizes){
                if(signIn != null){
                    prize.setSignIn(signIn);
                }
                if(prize.getId() <= 0){
                    toSaveList.add(prize);
                }
                if(prize.getId() > 0){
                    toUpdateList.add(prize);
                }
            }

            if(toSaveList.size() > 0){
                result += signInDao.insertSignInPrizes(toSaveList);
            }
            if(toUpdateList.size() > 0){
                result += signInDao.updateSignInPrizes(toUpdateList);
            }
        }
        return result > 0 ? true : false;
    }

    @Override
    public List<EarnSilver> listEarnSilver(short enable) {
        return earnSilverDao.selectByEnable(enable);
    }

    @Override
    public EarnSilver getEarnSilver(int id) {
        return earnSilverDao.selectById(id);
    }

    @Override
    @LogRecord(module=LogRecord.Module.EARNMONEY, operation=LogRecord.Operation.EDIT, id="${earnSilver.id}", remark="")
    public boolean saveEarnSilver(EarnSilver earnSilver) {
        if(earnSilver != null && earnSilver.getId() > 0){
            return earnSilverDao.update(earnSilver) > 0 ? true : false;
        }
        return false;
    }

    @Override
    @LogRecord(module=LogRecord.Module.EARNMONEY, operation=LogRecord.Operation.ENABLE, id="${id}", remark="")
    public boolean enableEarnSilver(int id, short enable) {
        return earnSilverDao.enable(id, enable)> 0 ? true : false;
    }

    @Override
    public int countCode(int goodsId, int couponExchangeId) {

        Map<String, Object> params = new HashMap<String, Object>();
        if(goodsId > 0){
            params.put("goodsId", goodsId);
        }
        if(couponExchangeId > 0){
            params.put("couponExchangeId", couponExchangeId);
        }
        return goodsCouponCodeDao.queryForCount(params);
    }

    @Override
    public List<GoodsCouponCode> listCodes(int goodsId, int couponExchangeId, int offset, int pageSize) {
        Map<String, Object> params = new HashMap<String, Object>();
        if(goodsId > 0){
            params.put("goodsId", goodsId);
        }
        if(couponExchangeId > 0){
            params.put("couponExchangeId", couponExchangeId);
        }
        params.put("offset", offset);
        params.put("size", pageSize);
        return goodsCouponCodeDao.queryForList(params);
    }

    @Override
    public int count(int goodsId, String cellphone) {
        Map<String, Object> params = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(cellphone)){
            params.put("cellphone", cellphone);
        }
        params.put("goodsId", goodsId);
        return raceLogDao.queryForCount(params);
    }

    @Override
    public List<RaceLog> list(int goodsId, String cellphone, int offset, int pageSize) {
        Map<String, Object> params = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(cellphone)){
            params.put("cellphone", cellphone);
        }
        params.put("goodsId", goodsId);
        params.put("offset", offset);
        params.put("size", pageSize);
        return raceLogDao.queryForList(params);
    }

    @Override
    public boolean changeGoodsSort(List<Goods> goodes) {
        return goodsDao.updateSort(goodes) > 0 ? true : false;
    }

    @Override
    public boolean validateExchangeCode(int id, String code) {
        return goodsCouponCodeDao.checkExchangeCode(id, code) > 0 ? false : true;
    }

    @Override
    public int giveUserCount(int dispatchingBonusLogId, String cellphone,String beginDate, String endDate) {
        Map<String, Object> params = new HashMap<String, Object>();
        if(dispatchingBonusLogId > 0){
            params.put("dispatchingBonusLogId", dispatchingBonusLogId);
        }
        if(StringUtils.isNotBlank(cellphone)){
            params.put("cellphone", cellphone);
        }
        if(StringUtils.isNotBlank(beginDate) && StringUtils.isNotBlank(endDate)){
            params.put("beginDate", beginDate);
            params.put("endDate", endDate);
        }
        return dispatchingLogDao.queryForCount(params);
    }

    @Override
    public List<DispatchingLog> giveUserList(int dispatchingBonusLogId, String cellphone, String beginDate, String endDate, int offset, int pageSize) {
        Map<String, Object> params = new HashMap<String, Object>();
        if(dispatchingBonusLogId > 0){
            params.put("dispatchingBonusLogId", dispatchingBonusLogId);
        }
        if(StringUtils.isNotBlank(cellphone)){
            params.put("cellphone", cellphone);
        }
        if(StringUtils.isNotBlank(beginDate) && StringUtils.isNotBlank(endDate)){
            params.put("beginDate", beginDate);
            params.put("endDate", endDate);
        }
        params.put("offset", offset);
        params.put("size", pageSize);
        return dispatchingLogDao.queryForList(params);
    }

}