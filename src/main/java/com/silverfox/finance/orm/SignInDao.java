package com.silverfox.finance.orm;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.SignIn;
import com.silverfox.finance.domain.SignInPrize;

public interface SignInDao {
    List<SignInPrize> selectAll();
    SignIn selectById(int id);
    int insert(SignIn signIn);
    int update(SignIn signIn);
    int insertSignInPrizes(@Param("toSaveList")List<SignInPrize> toSaveList);
    int updateSignInPrizes(@Param("toUpdateList")List<SignInPrize> toUpdateList);
}
