package com.silverfox.finance.service;

import com.silverfox.finance.domain.*;

import java.util.List;

public interface SilverService {
    public SignIn getSignIn(int id);
    public SilverStrategy get(int id);
    public boolean saveSilverStrategy(SilverStrategy silverStrategy);
    public boolean audit(int id, short enable);
    public Goods getGoods(int id);
    public boolean save(Goods goods, List<GoodsCouponCode> codes);
    public List<Goods> listGoods(int achieveAmount, int platform, int type, int offset, int size);
    public int countGoods(int achieveAmount, int platform, int type, String name);
    public int countCode(int goodsId, int couponExchangeId);
    public List<GoodsCouponCode> listCodes(int goodsId, int couponExchangeId, int offset, int pageSize);
    public int count(String goodsName, String cellphone, String beginDate, String endDate, int type);
    public List<CustomerGoodsOrder> list(String goodsName, String cellphone, String beginDate, String endDate, int type, int offset, int pageSize);
    public boolean saveSignInPrizes(List<SignInPrize> signInPrizes, SignIn signIn);

    public List<EarnSilver> listEarnSilver(short enable);
    public EarnSilver getEarnSilver(int id);
    public boolean saveEarnSilver(EarnSilver earnSilver);
    public boolean enableEarnSilver(int id, short enable);
    public int count(int goodsId, String cellphone);
    public List<RaceLog> list(int goodsId, String cellphone, int offset, int pageSize);
    public boolean changeGoodsSort(List<Goods> goodes);
    public boolean validateExchangeCode(int id, String code);
    public int giveUserCount(int dispatchingBonusLogId, String cellphone,
                             String beginDate, String endDate);
    public List<DispatchingLog> giveUserList(int dispatchingBonusLogId, String cellphone,
                                             String beginDate, String endDate, int offset, int pageSize);
	

}
