package com.silverfox.finance.service;

import com.silverfox.finance.domain.CustomerLotteryLog;
import com.silverfox.finance.domain.Lottery;
import com.silverfox.finance.domain.LotteryPrize;

import java.util.List;

public interface LotteryService {
    int count();
    Lottery get(int id);
    List<Lottery> list(int offset, int size);
    boolean duplicate(int id, String name);
    boolean saveLottery(Lottery lottery, String prizeStr);
    boolean audit(int id, int status);
    boolean save(CustomerLotteryLog customerLotteryLog);
    boolean count(int status, short scene);
    boolean decrSurplusQuantity(int id);
    int countParticipateTimeByLotteryId(int id);
    int countConsumeLottery(int id, int shareGetSilver);
    int countParticipatePeoplesByLotteryId(int id);
    List<LotteryPrize> selectPrizeById(int lotteryId);
    int countDetail(int lotteryId, String cellphone, int prizeId, String beginTime, String endTime);
    int getCostSilvers(int lotteryId, String cellphone, int prizeId, String beginTime, String endTime);
    int getSilvers(int lotteryId, String cellphone, int prizeId, String beginTime, String endTime);
    int getCoupons(int lotteryId, String cellphone, int prizeId, String beginTime, String endTime);
    List<CustomerLotteryLog> selectDetail(int lotteryId, String cellphone, int prizeId, String beginTime, String endTime, int offset, int size);
}
