package com.silverfox.finance.orm;

import com.silverfox.finance.domain.CustomerAuthorisation;
import org.apache.ibatis.annotations.Param;

public interface CustomerAuthorisationDao {
    public int insert(CustomerAuthorisation customerAuthorisation);
    public int update(CustomerAuthorisation customerAuthorisation);
    public CustomerAuthorisation selectByUserId(@Param("category")int category, @Param("userId")int userId);
    public CustomerAuthorisation selectByOpenId(@Param("category")int category, @Param("openId")String openId);
}
