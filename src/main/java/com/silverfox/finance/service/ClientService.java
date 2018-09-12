package com.silverfox.finance.service;

import java.util.Calendar;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.silverfox.finance.domain.Attachment;
import com.silverfox.finance.domain.CardBin;
import com.silverfox.finance.domain.Customer;
import com.silverfox.finance.domain.CustomerAuthorisation;
import com.silverfox.finance.domain.CustomerBank;
import com.silverfox.finance.domain.CustomerSilverLog;
import com.silverfox.finance.domain.DispatchingBonusLog;
import com.silverfox.finance.domain.Lender;
import com.silverfox.finance.domain.Merchant;
import com.silverfox.finance.domain.MerchantOrder;
import com.silverfox.finance.domain.RoleResource;
import com.silverfox.finance.domain.SmsChannel;
import com.silverfox.finance.domain.User;
import com.silverfox.finance.domain.UserBank;
import com.silverfox.finance.entity.InviteesEntity;
import com.silverfox.finance.entity.ProductEntity;
import com.silverfox.finance.entity.UserEntity;
import com.silverfox.finance.enumeration.AuthorisationCategoryEnum;

public interface ClientService {
	public JSONObject getCellphones(List<String> cellphones);
	public User getByCellphone(String cellphone);
	public boolean giveCouponInBatch(int dispatchingId);
	int countLender(int productId, int type, String name, String cellphone, int startNum, int endNum, int status, int categoryId);
	List<Lender> listLender(int productId, int type, String name, String cellphone, int startNum, int endNum, int status, int categoryId, int offset, int size);
	Lender selectByLenderId(Integer lenderId);
	Lender getLender(int id);
	boolean saveLender(Lender lender);
	//boolean save(Lender lender);
	public int count(int projectType, String productStatue, int payChannel, String name, String productName, int timeCategory, String fromDate, String toDate);
	public List<ProductEntity> list(String projectTimeType,int projectType, int orderStatus, int payChannel, String name, String productName, int orderType, String fromDate, String toDate, int offset, int size);
	public List<ProductEntity> list(int projectType, String productStatue, int payChannel, String name, String productName, int timeCategory, String fromDate, String toDate, int offset, int size);
	double sumWaitpaymentMoney(int projectType, String productStatue, String name, String productName, int timeCategory, String fromDate, String toDate);
	Double sumPaymentMoney(String projectTimeType,int projectType, String productStatue, String name, String productName, int orderType, String fromDate, String toDate);
	Double sumShouldPaybackmentMoney(String projectTimeType,int projectType, String productStatue, String name, String productName, int timeCategory, String fromDate, String toDate);
	double sumTradeAmount(int projectType, String productStatue, String name, String productName, String fromDate, String toDate);
	double sumServiceCharge(int projectType, String productStatue, String name, String productName, int timeCategory, String fromDate, String toDate);
	public List<Merchant> list(String name, int status, int offset, int size);
	int count(String projectTimeType,int projectType, int orderStatus, int payChannel, String name, String productName, int orderType, String fromDate, String toDate);
	public boolean save(CustomerAuthorisation customerAuthorisation);
	public CustomerAuthorisation get(AuthorisationCategoryEnum category, String openId);

	public User get(int id);
	public int count(Calendar calendar);
	public boolean save(int id,CustomerBank bank);
	public boolean giveSilverInBatch(int dispatchingId);

	public boolean audit(int id, int status);
	public int getCanBorrowMoney(int merchantId);
	public Merchant getMerchant(int id);
	String selectOtherDataByMerchantId(int id);
	Attachment selectByAttachmentId(int attachmentId);
	public boolean duplicate(int id, String licenseNO);
	int queryForBorrowerCreditCount(Integer type, String searchName, String cellphone, String startAmount, String endAmount);
	List<Lender> queryForBorrowerCreditList(Integer type, String searchName, String cellphone, String startAmount, String endAmount,  int offset, int pageSize);
	Integer queryForBorrowerTotalMoney(Integer type, String searchName, String cellphone, String startAmount, String endAmount);
	public List<MerchantOrder> list(int merchantId, int type);
	List<Merchant> getLicenseNO(String licenseNO);
	int queryForBorrowCountDetailCount(String merchantId, Integer status);
	List<Lender> queryForBorrowCountDetailList(String type, String merchantId, Integer status, int offset, int pageSize);
	int queryForBorrowCountDetailTotalMoney(String type, String merchantId, Integer status);
	public boolean saveMerchant(Merchant merchant);
	public boolean addVoucher(String voucher, int id);
	UserBank getBankByCustomerId(int id);
	public boolean cardRefresh(String newCard,String bankName,String bankNo,String oldCard,int userId);
	public CardBin get(String prefix);
	public CustomerAuthorisation getWithAccount(AuthorisationCategoryEnum category, int userId);
	public double countReward(String cellphone);
	public Customer getCustomer(int id);
	public int getCollectPrincipal(int userId);
	int getfreezingAmountByCustomerId(int id);
	public int countInviteNumber(String cellphone);
	public CustomerBank getBank(Integer bankId);
	public List<CustomerBank> listBanks(int customerId, int status);
	boolean setVip(int userId);
	boolean resetTurnOutBank(int id);
	int countLender(int loanPeriod, int projectType, int productId);
	List<Lender> listLender(int loanPeriod, int projectType, int productId, int offset, int size);

	public DispatchingBonusLog getDispatchingBonusLog(int dispatchingBonusLogId);
	boolean saveDispatchingBonusLog(DispatchingBonusLog dispatchingBonusLog);

	int countRecentSilverLog(int customerId, String pastTime);
	List<CustomerSilverLog> listSilverLog(int customerId, String pastTime, int offset, int size);

	int count(String cellphone, int category);
	List<DispatchingBonusLog> listDispatchingBonusLog(String cellphone, int category, int offset, int size);
	public int countGiveUser(DispatchingBonusLog log);
	public int count(int vipLevel, String name, String account, String idcard, String timeType, int channelId, String beginTime, String endTime, int beginAmount, int endAmount);
	public List<UserEntity> list(int vipLevel, String name, String account, String idcard, String timeType, int channelId, String beginTime, String endTime, int startAmount, int endAmount, String sort, int offset, int size);
	int queryForCount(Integer type, String borrowerName, String cellphone, String startAmount, String endAmount,int status);
	List<Merchant> queryForlist(Integer type, String borrowerName, String cellphone, String startAmount,
								String endAmount, int status, int offset, int pageSize);
	List<Lender> listLenders(int productId, int projectType);
	public Merchant getMerchantData(int merchantIdData);
	public int queryLenderLoanCount(Integer lenderId);
	public List<Lender> listLenders(Integer productId);
	public double queryTotalMoney(Integer type, String searchName, String cellphone, String startAmount, String endAmount);
	public SmsChannel getSmsChannel(int parseInt);
	public List<RoleResource> listRoleResource(int roleId);
	public List<InviteesEntity> queryInviteesEntities(String cellphone, Integer inviterLevel, int offset, int size);
	public int queryBeInviterCount(String cellphone, Integer inviterLevel);
	
}
