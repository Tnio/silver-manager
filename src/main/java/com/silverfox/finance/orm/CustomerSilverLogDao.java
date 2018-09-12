package com.silverfox.finance.orm;

import com.silverfox.finance.domain.CustomerSilverLog;
import com.silverfox.finance.domain.DispatchingLog;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface CustomerSilverLogDao {
    List<CustomerSilverLog> selectRecentDataByCustomerId(Map<String, Object> params);
    int countRecentData(@Param("customerId")int customerId, @Param("pastTime")String pastTime);
    int insert(CustomerSilverLog customerSilverLog);
    int insertSilverLogInBatch(@Param("sourceId")int sourceId, @Param("channel")String channel, @Param("silverNum")int silverNum, @Param("dispatchingLogs")List<DispatchingLog> dispatchingLogs);

    List<CustomerSilverLog> selectAll(Map<String, Object> params);
}
