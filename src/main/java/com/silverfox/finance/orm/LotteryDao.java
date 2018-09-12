package com.silverfox.finance.orm;

import com.silverfox.finance.domain.CustomerLotteryLog;
import com.silverfox.finance.domain.Lottery;
import com.silverfox.finance.domain.LotteryPrize;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface LotteryDao {
    List<Lottery> queryForList(Map<String, Object> params);
    int queryForCount();
    int duplicate(@Param("id")int id, @Param("name")String name);
    Lottery selectById(int id);
    int update(Lottery lottery);
    int insert(Lottery lottery);

    List<LotteryPrize> selectPrizeById(int LotteryId);
    Lottery selectCurrentLottery(@Param("scene") int scene);
    List<LotteryPrize> selectRotaryPrize();
    void insertPrizeBatch(@Param("prizes")List<LotteryPrize> prizes);
    void updatePrize(LotteryPrize prize);
//    void insertPrize(LotteryPrize prize);
    int deletePrizeById(int lotteryId);
    int audit(@Param("id")int id, @Param("status")int status);

    List<CustomerLotteryLog> queryDetailForList(Map<String, Object> params);
    List<CustomerLotteryLog> selectLastestPrizeDetailById(@Param("lotteryId")int lotteryId);
    int queryDetailForCount(Map<String, Object> params);
    Integer queryGetSilvers(Map<String, Object> params);
    Integer queryCostSilvers(Map<String, Object> params);
    int queryGetCoupons(Map<String, Object> params);
    int insertDetail(CustomerLotteryLog customerLotteryLog);
    int decrSurplusQuantity(int id);

    int queryLotteryLogForCount();
    int count(@Param("enable")int enable, @Param("scene")short scene);

    int countParticipateTimeByLotteryId(@Param("id")int id);
    int countParticipatePeoplesByLotteryId(@Param("id")int id);
    Integer countConsumeLottery(@Param("id")int id, @Param("shareGetSilver")int shareGetSilver);
}
