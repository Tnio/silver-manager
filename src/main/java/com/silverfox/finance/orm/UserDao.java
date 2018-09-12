package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import com.silverfox.finance.entity.UserEntity;
import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.DispatchingLog;
import com.silverfox.finance.domain.User;

public interface UserDao {
	public int queryForCount(Map<String,Object> params);
	public List<String> selectCellphones(@Param("cellphones")List<String> cellphones);
	public List<User> selectUsers(@Param("ids")List<Integer> ids);
	public User selectByCellphone(String cellphone);
	public List<Integer> selectByCellphones(@Param("cellphones")String[] cellphones);
	public List<String> selectByAccounts(@Param("ids")List<Integer> ids);

 	public int countBeforThisMonth(@Param("lastDate")String lastDate);
	public int countInSomeday(String systemDate);
	public int countCustomerInSomeday(String systemDate);
	public int countCustomerByTradeTime(@Param("firstTradeTime")String firstTradeTime);
	public User selectByUserId(int id);
	public List<Map<String, Object>> countAllCustomerInSometime(String systemDate);
	public List<Map<String, Object>> countAllInSometime(String systemDate);
	
	public int giveSilverInBatch(@Param("silverNumber")int silverNumber, @Param("dispatchingLogs")List<DispatchingLog> dispatchingLogs);
	public int countCustomerByDate(String date);
	public int update(User user);
	public void updateInviteCellphone(@Param("newCellphone")String newCellphone, @Param("oldCellphone")String oldCellphone);
	public List<UserEntity> queryForList(Map<String,Object> params);
	public List<String> selectByInviterPhone(String cellphone);
	public Double countInvitorReward(@Param("cellphones")List<String> cellphones);
	public int countInviteNumber(String cellphone);
	public int changeToVip(@Param("userId")int userId);
}
