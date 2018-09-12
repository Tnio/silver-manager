package com.silverfox.finance.orm;

import com.silverfox.finance.domain.Lender;
import com.silverfox.finance.domain.Merchant;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface MerchantDao {
	public List<Merchant> queryForList(Map<String, Object> params);
	public List<Merchant> getOldMerchantRepaymentAmount();
	public List<Merchant> selectByVersion(int version);
	public int queryForCount(Map<String, Object> params);
	public Merchant selectById(int id);
	public List<Merchant> selectByCellphone(String cellphone);
	public int duplicate(@Param("id")int id, @Param("licenseNO")String licenseNO);
	public int insert(Merchant merchant);
	public int update(Merchant merchant);
	public int updateStatus(@Param("id")int id, @Param("status")int status);
	public Integer selectMerchantCanBorrowMoney(@Param("merchantId")int merchantId);
	public int increasing(@Param("id")int id);
	public int adjustAmount(@Param("paymentAmount")double paymentAmount, @Param("orderNO")String orderNO);
	public int queryForBorrowerCreditCount(Map<String, Object> params);
	public List<Lender> queryForBorrowerCreditList(Map<String, Object> params);
	public List<Lender> queryForBorrowCountDetailList(Map<String, Object> params);
	public int queryForBorrowCountDetailCount(Map<String, Object> params);
	public double queryTotalMoney(Map<String, Object> params);
	public Integer queryForBorrowerTotalMoney(Map<String, Object> params);
	public int queryForBorrowCountDetailTotalMoney(Map<String, Object> params);
	public String selectOtherDataByMerchantId(int id);
	public Lender selectByLenderId(Integer lenderId);
	public List<Merchant> queryForLicenseNO(String licenseNO);
	public List<Lender> queryForBorrowerCreditList2(Map<String, Object> params);
	public Integer queryForBorrowerTotalMoney2(Map<String, Object> params);
	public int queryForBorrowerCreditCount2(Map<String, Object> params);
	public int queryForBorrowCountDetailTotalMoney2(Map<String, Object> params);
}
