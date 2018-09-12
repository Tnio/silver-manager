package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.Customer;
import com.silverfox.finance.domain.CustomerBank;
import com.silverfox.finance.domain.UserBank;
import com.silverfox.finance.entity.LostUserEntity;
import com.silverfox.finance.entity.UninvestEntity;

public interface CustomerDao {
	//public Customer selectByAccount(String account);
	public int selectCollectPrincipal(int userId);
	public Customer selectByOrderNo(String orderNo);
	public List<Customer> selectTop10(@Param("productId")int productId);
	//public int giveBirthdayCouponInBatch(@Param("couponId")int couponId, @Param("ruleId")int ruleId, @Param("minAmount")int minAmount, @Param("maxAmount")double maxAmount, @Param("systemMonth")String systemMonth);
	
	//public int updateSendMessageFlag(@Param("account")String account, @Param("flag")int flag);
	
	public List<CustomerBank> selectBanksByCustomerId(@Param("customerId")int customerId, @Param("status")int status);
	public CustomerBank selectByCardNO(String cardNO);
	public CustomerBank selectById(int bankId);
	public int unbundling(@Param("id")int id, @Param("originalCard")String originalCard);
	public int changing(@Param("id")int id, @Param("originalCard")String originalCard, @Param("newCard")String newCard);
	public int insertBank(CustomerBank bank);
	public int updateBank(CustomerBank bank);
	public int insertUserBank(@Param("newCard")String newCard, @Param("bankName")String bankName, @Param("bankNo")String bankNo, @Param("userId")int userId);
	public int updateUserBank(@Param("oldCard")String oldCard, @Param("userId")int userId);
	public int insert(Customer customer);
	public int update(Customer customer);
	//public int adjust(@Param("account")String account, @Param("principal")float principal, @Param("latestTradeTime")Date latestTradeTime);
	public int cumulativeIncome(@Param("orderNo")String orderNo, @Param("orderMoney")double orderMoney);
	public int cumulativeBaobaoIncome(@Param("orderNo")String orderNo, @Param("orderMoney")double orderMoney);
	public int resetTurnOutBank(int id);
	public List<String> selectIdcardBeforThisMonth(@Param("lastDate")String lastDate);
	
	//public List<Map<String, Integer>> getTop15Scores(@Param("startDate")String startDate, @Param("endDate")String endDate);
	//public Integer getScore(@Param("account")String account, @Param("startDate")String startDate, @Param("endDate")String endDate);
	//public int giveSilverForBirthday(@Param("silverNumber")int silverNumber, @Param("systemMonth")String systemMonth);
	public List<String> selectInMonth(@Param("systemMonth")String systemMonth);
	//public int giveSilverForBirthdayInBatch(@Param("silverNumber")int silverNumber, @Param("channel")String channel, @Param("systemMonth")String systemMonth);
	
	public List<Customer> selectLossingCustomers(Map<String, Object> params);
	public int countCustomerBySinglePrincipal(Map<String, Object> params);
	public int countLossingCustomers(Map<String, Object> params);
	public int countSuccessfulTradingNumber(String cellphone);
	public Double totalAccumulationProfit();
	public Integer totalTradeMoney();
	
	public List<Integer> selectAccountGiveUser(Map<String,Object> params);
	public int countGiveUser(Map<String,Object> params);
	
	public int selectAccumulativeAmount(@Param("accumulativeAmount")int accumulativeAmount, @Param("beginDate")String beginDate, @Param("endDate")String endDate);
	public double countWinCentage(@Param("account")String account, @Param("totalTradeAmount")int totalTradeAmount);
	//public int countUsedCoupon(@Param("account")String account);
	//public int countCustomeTrade(@Param("account")String account);
	
	public List<String> selectTelesaleCellphones(@Param("cellphones")String[] cellphones);
	public UserBank selectBankByCustomerId(int id);
	public Customer selectByUserId(int id);
	//新加
	 int queryForCount(Map<String, Object> params);
	public int queryForUninvestCount(Map<String, Object> params);
	public List<UninvestEntity> queryUninvestList(Map<String, Object> params);
	public List<LostUserEntity> queryLostcustomers(Map<String, Object> params);
	public int queryForLostcustomerCount(Map<String, Object> params);
}