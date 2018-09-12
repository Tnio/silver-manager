package com.silverfox.finance.orm;

import com.silverfox.finance.domain.EBankLog;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface EBankLogDao {
    public List<EBankLog> queryForList(Map<String, Object> params);
    public int queryForCount();
    public EBankLog selectById(int id);
    public int insert(EBankLog log);
    public int audit(@Param("id")int id, @Param("status")int status, @Param("remark")String remark);
    public List<EBankLog> selectByNewCardId(@Param("newBankId")int newBankId, @Param("status")int status);
    public List<EBankLog> selectByOldCardId(@Param("oldBankId")int oldBankId, @Param("status")int status);
}
