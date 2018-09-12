package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.MerchantOrder;
import com.silverfox.finance.entity.ProductEntity;
import com.silverfox.finance.entity.ReceivablesEntity;

public interface MerchantOrderDao {

	int queryOrderForCount(Map<String, Object> params);

	List<MerchantOrder> queryOrderForList(Map<String, Object> params);

	Double countTotalAmountForOrder(Map<String, Object> params);

	List<String> selectLoanNames();
	public List<MerchantOrder> selectByMerchantId(@Param("merchantId")int merchantId, @Param("type")int type);
	public int addVoucher(@Param("voucher")String voucher, @Param("id")int id);

	public int queryWaitPayPaymentForCount(Map<String, Object> params);
	
	public List<ProductEntity> queryWaitPaymentForList(Map<String, Object> params);
	
	public List<ProductEntity> queryProductPaymentedForList(Map<String, Object> params);
	public List<ProductEntity> queryProductPaymentingForList(Map<String, Object> params);
	public List<ProductEntity> queryProductForList(Map<String, Object> params);
	public double sumWaitpaymentMoney(Map<String, Object> params);
	public Double sumPaymentMoney(Map<String, Object> params);
	public Double sumShouldPaybackmentMoney(Map<String, Object> params);
	public double sumTradeAmount(Map<String, Object> params);
	public Double sumServiceCharge(Map<String, Object> params);
	public int queryProductForCount(Map<String, Object> params);


	MerchantOrder selectByProductIdAntDate(@Param("productId")int productId, @Param("systemDate")String systemDate, @Param("type")int type, @Param("status")int status);

	int insert(MerchantOrder merchantOrder);

	List<ReceivablesEntity> selectMerchantTradeAmount(@Param("id")int id, @Param("type")int type);

	float selectInAmountById(@Param("id")int id, @Param("yesterday")String yesterday);

}