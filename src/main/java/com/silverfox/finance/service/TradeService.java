package com.silverfox.finance.service;

import java.util.List;

import com.silverfox.finance.domain.Customer;
import com.silverfox.finance.domain.CustomerBalanceLog;
import com.silverfox.finance.domain.CustomerOrder;
import com.silverfox.finance.domain.CustomerSilverLog;
import com.silverfox.finance.domain.Merchant;
import com.silverfox.finance.domain.MerchantOrder;
import com.silverfox.finance.domain.Product;
import com.silverfox.finance.domain.Signature;
import com.silverfox.finance.domain.VipLevelChangeLog;
import com.silverfox.finance.entity.EarningEntity;
import com.silverfox.finance.entity.EsignEntity;
import com.silverfox.finance.entity.LoanEntity;
import com.silverfox.finance.entity.OpexEntity;
import com.silverfox.finance.entity.PaybackCalenderEntity;
import com.silverfox.finance.entity.ProductTradeEntity;
import com.silverfox.finance.entity.ReceivablesEntity;
import com.silverfox.finance.entity.ReinvestEntity;
import com.silverfox.finance.entity.StatisticsEntity;


public interface TradeService {

	public int countLossing(String paybackDate);
	List<Customer> getLossing(String sort, String paybackDate, int offset, int size);
	ReinvestEntity getReinvest(String paybackDate);
	ReinvestEntity getNotReinvest(String paybackDate);
	public List<EarningEntity> oldEarning(String beginDate, String endDate);
	public List<EarningEntity> newEarning(String beginDate, String endDate);
	public List<PaybackCalenderEntity> paybackCalender(Integer type, Integer backChannel, String beginDate, String endDate);
	public int countOpex(String beginDate, String endDate);
	public List<OpexEntity> listOpex(String beginDate, String endDate, int offset, int size);
	public int countOrderInSomeday(String systemDate);
	public int sumOrderInSomeday(String systemDate);
	
	public int countInSomeday(String systemDate);
	public int countCustomerInSomeday(String systemDate);
	public List<StatisticsEntity> statisticsIncreaseCoupon(String beginTime,String endTime);
	public List<CustomerSilverLog> statisticsSilver(String beginTime, String endTime);
	public List<StatisticsEntity> statisticsBonus(int i, int source, String beginTime,String endTime);
	public List<StatisticsEntity> statisticsBonus(String beginTime, String endTime);
	public List<ReceivablesEntity> getMerchantTradeAmount(Integer id, int i);
	public List<ReceivablesEntity> getProductIncomeAmountByMonths(Integer id,int offset, int pageSize);
	public float getInAmount(Integer id, String yesterday);
	public float getProductIncomeById(Integer id, String yesterday);
	public List<ProductTradeEntity> getInMoneys(String beginTime, String endTime);
	public List<ProductTradeEntity> getOutMoneys(Integer type, String beginTime,String endTime);
	public List<ProductTradeEntity> getInTotals(String beginTime, String endTime);
	public List<ProductTradeEntity> getOutTotals(Integer type, String beginTime,String endTime);
	public List<ProductTradeEntity> getInPeoples(String beginTime, String endTime);
	public List<ProductTradeEntity> getOutPeoples(Integer type, String beginTime,String endTime);
	public List<Long> countAllCustomerInSometime(String systemDate);
	public List<Long> countAllInSometime(String systemDate);
	public List<Long> countOrderInSometime(String systemDate);
	public List<Long> sumOrderInSometime(String systemDate);
	boolean saveLender(int productId, int[] lenderIds);

	List<CustomerOrder> listCustomerOrder(int productId);
	public int countTrade(String beginTime, String endTime, String orderNO, Integer isPayback, Integer couponType, String systemTime, int customerId);
	public List<CustomerOrder> listTrade(String beginTime, String endTime, String orderNO, Integer isPayback, Integer couponType, String systemTime, int customerId, int offset, int size);
	int countBalance(int type, int userId);
	List<CustomerBalanceLog> listBalance(int type, int userId, int offset, int pageSize);
	int countFrozenOrder(int customerId, int isPayback);
	List<CustomerOrder> listFrozenOrder(int customerId, int isPayback, int offset, int pageSize);
	
	public MerchantOrder getMerchantOrder(int productId, String systemDate, int type, int status);
	public List<LoanEntity> listLoan(Integer productId);
	List<Signature> getSignatureList(int productId);
	public List<EsignEntity> list(int productId);
	
	public boolean saveOrderForMerchant(Product product, Merchant merchant,String orderNO, double orderMoney, double paymentAmount);
	public boolean save(List<Signature> signatures);

	public int countvipDetails(int customerId);
	List<VipLevelChangeLog> listvipDetails(int customerId,  int offset, int pageSize);
	


}