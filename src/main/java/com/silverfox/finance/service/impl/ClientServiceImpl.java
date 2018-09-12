package com.silverfox.finance.service.impl;

import static com.silverfox.finance.util.ConstantUtil.COMMA;
import static com.silverfox.finance.util.ConstantUtil.MAX_TIME;
import static com.silverfox.finance.util.ConstantUtil.MIN_TIME;
import static com.silverfox.finance.util.ConstantUtil.NORMAL_DATE_FORMAT;
import static com.silverfox.finance.util.ConstantUtil.SEMICOLON;
import static com.silverfox.finance.util.ConstantUtil.UNDERLINE;

import java.io.IOException;
import java.text.MessageFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.silverfox.finance.config.AplicationResourceProperties;
import com.silverfox.finance.domain.Attachment;
import com.silverfox.finance.domain.CardBin;
import com.silverfox.finance.domain.Coupon;
import com.silverfox.finance.domain.Customer;
import com.silverfox.finance.domain.CustomerAuthorisation;
import com.silverfox.finance.domain.CustomerBank;
import com.silverfox.finance.domain.CustomerCoupon;
import com.silverfox.finance.domain.CustomerSilverLog;
import com.silverfox.finance.domain.DispatchingBonusLog;
import com.silverfox.finance.domain.DispatchingLog;
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
import com.silverfox.finance.enumeration.CustomerCouponSourceEnum;
import com.silverfox.finance.enumeration.DispatchingBonusCategoryEnum;
import com.silverfox.finance.enumeration.GenericEnableEnum;
import com.silverfox.finance.enumeration.SilverGainSourceEnum;
import com.silverfox.finance.enumeration.SilverUsedSourceEnum;
import com.silverfox.finance.orm.AttachmentDao;
import com.silverfox.finance.orm.CardBinDao;
import com.silverfox.finance.orm.CustomerAuthorisationDao;
import com.silverfox.finance.orm.CustomerCouponDao;
import com.silverfox.finance.orm.CustomerDao;
import com.silverfox.finance.orm.CustomerOrderDao;
import com.silverfox.finance.orm.CustomerSilverLogDao;
import com.silverfox.finance.orm.DispatchingBonusLogDao;
import com.silverfox.finance.orm.DispatchingLogDao;
import com.silverfox.finance.orm.InviterRewardDao;
import com.silverfox.finance.orm.LenderDao;
import com.silverfox.finance.orm.MerchantDao;
import com.silverfox.finance.orm.MerchantOrderDao;
import com.silverfox.finance.orm.ResourceDao;
import com.silverfox.finance.orm.SmsChannelDao;
import com.silverfox.finance.orm.UserDao;
import com.silverfox.finance.service.ClientService;
import com.silverfox.finance.util.ConstantUtil;
import com.silverfox.finance.util.LogRecord;

import net.sf.json.xml.XMLSerializer;

@Service
public class ClientServiceImpl implements ClientService {
	private static final Log LOG = LogFactory.getLog(ClientServiceImpl.class);
	private static final int TENTHOUSAND = 10000;
	private static final int THOUSAND = 1000;
	private static final ScheduledExecutorService EXECUTOR = Executors.newScheduledThreadPool(Runtime.getRuntime().availableProcessors()*2, new ThreadFactory() {
		@Override
		public Thread newThread(Runnable r) {
			return new Thread(r);
		}
	});
	
	@Autowired
	private AttachmentDao attachmentDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private CardBinDao CardBinDao;
	@Autowired
	private CustomerDao customerDao;
	@Autowired
	private CustomerOrderDao customerOrderDao;
	@Autowired
	private MerchantDao merchantDao;
	@Autowired
	private MerchantOrderDao merchantOrderDao;
	@Autowired
	private CustomerAuthorisationDao customerAuthorisationDao;
	@Autowired
	private DispatchingLogDao dispatchingLogDao;
	@Autowired
	private CustomerSilverLogDao customerSilverLogDao;
	@Autowired
	private DispatchingBonusLogDao dispatchingBonusLogDao;
	@Autowired
	private CustomerCouponDao customerCouponDao;
	@Autowired
	private SmsChannelDao smsChannelDao;
	@Autowired
	private AplicationResourceProperties properties;
	@Autowired
	private LenderDao lenderDao;
	@Autowired
	private ResourceDao resourceDao;
	@Autowired
	private InviterRewardDao inviterRewardDao;

	@Override
	public JSONObject getCellphones(List<String> cellphones) {
		List<String> userCellphones = null;
		if (cellphones != null && cellphones.size() > 0) {
			userCellphones = userDao.selectCellphones(cellphones);
		}
		JSONObject result = new JSONObject();
		result.put("code", 200);
		result.put("msg", null);
		for (String cellphone : cellphones) {
			if (!userCellphones.contains(cellphone)) {
				result.put("code", 400);
				result.put("msg", cellphone);
				break;
			}
		}
		return result;
	}
	
	@Override
	public User getByCellphone(String cellphone) {
		return userDao.selectByCellphone(cellphone);
	}



	@Override
	public boolean save(CustomerAuthorisation customerAuthorisation) {
		boolean result = false;
		if (customerAuthorisation == null) {
			return result;
		}
		if (customerAuthorisation != null) {
			if (customerAuthorisation.getId() > 0) {
				return customerAuthorisationDao.update(customerAuthorisation) > 0 ? true : false;
			} else {
				CustomerAuthorisation authorisation = customerAuthorisationDao.selectByUserId(customerAuthorisation.getCategory(), customerAuthorisation.getUserId());
				if (authorisation == null) {
					return customerAuthorisationDao.insert(customerAuthorisation) > 0 ? true : false;
				}
			}
		}
		return false;
	}

	@Override
	public CustomerAuthorisation get(AuthorisationCategoryEnum category, String openId) {
		return customerAuthorisationDao.selectByOpenId(category.value(), openId);
	}

	@Override
	@LogRecord(module = LogRecord.Module.SILVERGIVE, operation = LogRecord.Operation.AUDIT, id = "${dispatchingId}", name = "")
	public boolean giveSilverInBatch(int dispatchingId) {
		try {
			final Map<String, Object> params = new HashMap<String, Object>();
			if(dispatchingId > 0){
				params.put("dispatchingBonusLogId", dispatchingId);
			}
			final DispatchingBonusLog dispatchingBonusLog = dispatchingBonusLogDao.selectById(dispatchingId);
			if(dispatchingBonusLog != null && StringUtils.isNotBlank(dispatchingBonusLog.getGiveDate())){
				long delay = 0;
				Calendar nowDate = Calendar.getInstance();
				nowDate.setTime(new SimpleDateFormat(NORMAL_DATE_FORMAT).parse(new SimpleDateFormat(NORMAL_DATE_FORMAT).format(nowDate.getTime())));
				Calendar giveDate = Calendar.getInstance();
				giveDate.setTime(new SimpleDateFormat(NORMAL_DATE_FORMAT).parse(dispatchingBonusLog.getGiveDate()));
				Calendar nowLastTime = Calendar.getInstance();
				nowLastTime.set(Calendar.HOUR_OF_DAY, 24);
				nowLastTime.set(Calendar.SECOND, 00);
				nowLastTime.set(Calendar.MINUTE, 00);
				if(nowLastTime.getTimeInMillis() - giveDate.getTimeInMillis() < 0){
					giveDate.set(Calendar.HOUR_OF_DAY, 10);
					nowDate.setTime(Calendar.getInstance().getTime());
					delay = giveDate.getTimeInMillis() - nowDate.getTimeInMillis();
				}
				if(dispatchingBonusLog.getChoiceType() == 1){
					Thread	thread = new Thread(new Runnable() {
						@Override
						public void run() {
							try {
								int i = 1;
								int count = dispatchingLogDao.queryForCount(params);
								int pages = (int)(Math.ceil((float) count / TENTHOUSAND));
								while(i <= pages){
									params.put("offset", (i -1) * TENTHOUSAND);
									params.put("size", THOUSAND);
									List<DispatchingLog> dispatchingLogs = dispatchingLogDao.queryForList(params);
									if(dispatchingLogs.size() > 0){
										userDao.giveSilverInBatch(dispatchingBonusLog.getQuantity(), dispatchingLogs);
										customerSilverLogDao.insertSilverLogInBatch(SilverGainSourceEnum.SYSTEMGIVE.getValue(), SilverGainSourceEnum.SYSTEMGIVE.getName(), dispatchingBonusLog.getQuantity(), dispatchingLogs);
									}
									i++;
									if(pages - i > 0){
										Thread.sleep(5000);
									}
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
						}
					});
					EXECUTOR.schedule(thread, delay, TimeUnit.MINUTES);
				}else if(dispatchingBonusLog.getChoiceType() == 0){
					int type = 0;
					if(dispatchingBonusLog.getSatisfyType() == 2 && dispatchingBonusLog.getSatisfyInitialAmount() > 0){
						type = 1;
						params.put("amount", dispatchingBonusLog.getSatisfyInitialAmount());
					}else{
						params.put("amount", dispatchingBonusLog.getSatisfyInitialAmount());
					}
					params.put("type", type);
					params.put("beginDate", dispatchingBonusLog.getBeginDate()+MIN_TIME);
					params.put("endDate", dispatchingBonusLog.getEndDate()+MAX_TIME);
					Thread	thread = new Thread(new Runnable() {
						@Override
						public void run() {
							try {
								int i = 1;
								int count = 0;
								List<Integer> counts = dispatchingLogDao.countCellphones(params);
								if(counts.size() > 0){
									for(int j = 0; j<counts.size(); j++){
										if(counts.get(j) != null && counts.get(j) > 0){
											count ++;
										}
									}
								}
								int pages = (int)(Math.ceil((float) count / TENTHOUSAND));
								while(i <= pages){
									params.put("offset", (i -1) * TENTHOUSAND);
									params.put("size", TENTHOUSAND);
									List<DispatchingLog> dispatchings = dispatchingLogDao.listCellphones(params);
									List<DispatchingLog> dispatchingLogs = new ArrayList<DispatchingLog>();
									if(dispatchings.size() > 0){
										for(int k=0; k<dispatchings.size(); k++){
											if(dispatchings.get(k) != null && StringUtils.isNotBlank(dispatchings.get(k).getCellphone())){
												dispatchingLogs.add(dispatchings.get(k));
											}
										}
									}
									if(dispatchingLogs.size() > 0){
										userDao.giveSilverInBatch(dispatchingBonusLog.getQuantity(), dispatchingLogs);
										dispatchingLogDao.insertDispatchingLogBatch(dispatchingBonusLog.getId(), dispatchingLogs);
										customerSilverLogDao.insertSilverLogInBatch(SilverGainSourceEnum.SYSTEMGIVE.getValue(), SilverGainSourceEnum.SYSTEMGIVE.getName(), dispatchingBonusLog.getQuantity(), dispatchingLogs);
									}
									i++;
									if(pages - i > 0){
										Thread.sleep(5000);
									}
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
						}
					});
					EXECUTOR.schedule(thread, delay, TimeUnit.MINUTES);
				}else{
					//do nothing
				}
				dispatchingBonusLog.setStatus(Short.parseShort("2"));
				return dispatchingBonusLogDao.update(dispatchingBonusLog) > 0 ? true : false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public List<Merchant> list(String name, int status, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		params.put("status", status);
		params.put("offset", offset);
		params.put("size", size);
		List<Merchant> merchants = merchantDao.queryForList(params);
		List<Merchant> oldMerchants = merchantDao.getOldMerchantRepaymentAmount();
		if (oldMerchants != null && oldMerchants.size() > 0) {
			for (Merchant merchant : merchants) {
				if (merchant.getId() <= 4) {
					merchant.setPendingRepaymentAmount(0);
					for (Merchant oldMerchant : oldMerchants) {
						if (merchant.getId() == oldMerchant.getId()) {
							merchant.setPendingRepaymentAmount(oldMerchant.getPendingRepaymentAmount());
							break;
						}
					}
				}
			}
		}
		return merchants;
	}

	@Override
	@LogRecord(module=LogRecord.Module.MERCHANT, operation=LogRecord.Operation.AUDIT_STATUS, id="${id}", name="")
	public boolean audit(int id, int status) {
		return merchantDao.updateStatus(id, status) > 0 ? true : false;
	}

	@Override
	public int getCanBorrowMoney(int merchantId) {
		Integer money = merchantDao.selectMerchantCanBorrowMoney(merchantId);
		if (money == null) {
			money = 0;
		}
		return money;
	}

	@Override
	public Merchant getMerchant(int id) {
		Merchant merchant = merchantDao.selectById(id);
		if (merchant != null) {
			if (StringUtils.isNotBlank(merchant.getLetterOfCommitment())) {
				List<Integer> attachmentIds = new ArrayList<Integer>();
				String[] infos = StringUtils.split(merchant.getLetterOfCommitment(), COMMA);
				if (infos != null && infos.length > 0) {
					for (String info : infos) {
						if (StringUtils.isNotBlank(info)) {
							attachmentIds.add(Integer.parseInt(StringUtils.trim(info)));
						}
					}
					merchant.setAttachments(attachmentDao.selectByIds(attachmentIds));
				}
			}
			return merchant;
		}
		return null;
	}

	@Override
	public String selectOtherDataByMerchantId(int id) {
		return merchantDao.selectOtherDataByMerchantId(id);
	}

	@Override
	public Attachment selectByAttachmentId(int attachmentId) {
		return attachmentDao.selectByAttachmentId(attachmentId);
	}

	@Override
	public boolean duplicate(int id, String licenseNO) {
		return merchantDao.duplicate(id, licenseNO) < 1 ? true : false;
	}

	@Override
	public int queryForBorrowerCreditCount(Integer type, String searchName, String cellphone, String startAmount, String endAmount) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(type+"")) {
			params.put("type", type);
		}
		if(StringUtils.isNotBlank(searchName)) {
			params.put("name", searchName);
		}
		if(StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		if(StringUtils.isNotBlank(startAmount)&&StringUtils.isNotBlank(endAmount)) {
			params.put("startAmount", startAmount);
			params.put("endAmount", endAmount);
		}
		if(type == 1){
			return merchantDao.queryForBorrowerCreditCount(params);
		}else{
			return merchantDao.queryForBorrowerCreditCount2(params);
		}
	}

	@Override
	public List<Lender> queryForBorrowerCreditList(Integer type, String searchName, String cellphone, String startAmount, String endAmount, int offset, int pageSize) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(type+"")) {
			params.put("type", type);
		}
		if(StringUtils.isNotBlank(searchName)) {
			params.put("name", searchName);
		}
		if(StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		if(StringUtils.isNotBlank(startAmount)&&StringUtils.isNotBlank(endAmount)) {
			params.put("startAmount", startAmount);
			params.put("endAmount", endAmount);
		}
		params.put("offset", offset);
		params.put("size", pageSize);
		if(type == 1){
			List<Lender> merchants = merchantDao.queryForBorrowerCreditList(params);
			return merchants;
		}else{
			List<Lender> merchants = merchantDao.queryForBorrowerCreditList2(params);
			return merchants;
		}
	}

	@Override
	public Integer queryForBorrowerTotalMoney(Integer type, String searchName, String cellphone, String startAmount, String endAmount) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(type+"")) {
			params.put("type", type);
		}
		if(StringUtils.isNotBlank(searchName)) {
			params.put("name", searchName);
		}
		if(StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		if(StringUtils.isNotBlank(startAmount)&&StringUtils.isNotBlank(endAmount)) {
			params.put("startAmount", startAmount);
			params.put("endAmount", endAmount);
		}
		if(type == 1){
			return merchantDao.queryForBorrowerTotalMoney(params);
		}else{
			return merchantDao.queryForBorrowerTotalMoney2(params);
		}
	}

	@Override
	public List<MerchantOrder> list(int merchantId, int type) {
		return merchantOrderDao.selectByMerchantId(merchantId, type);
	}

	@Override
	public List<Merchant> getLicenseNO(String licenseNO) {
		return  merchantDao.queryForLicenseNO(licenseNO);
	}

	@Override
	public int queryForBorrowCountDetailCount(String merchantId, Integer status) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(merchantId)) {
			params.put("idcard", merchantId);
		}
		if(StringUtils.isNotBlank(status+"")) {
			params.put("status", status);
		}
		return merchantDao.queryForBorrowCountDetailCount( params);
	}

	@Override
	public List<Lender> queryForBorrowCountDetailList(String type,String idcard, Integer status, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(type)) {
			params.put("type", type);
		}
		if(StringUtils.isNotBlank(idcard)) {
			params.put("idcard", idcard);
		}
		if(StringUtils.isNotBlank(status+"")) {
			params.put("status", status);
		}
		params.put("offset", offset);
		params.put("size", size);
		List<Lender> list = merchantDao.queryForBorrowCountDetailList(params);
		return list;
	}

	@Override
	public int queryForBorrowCountDetailTotalMoney(String type,String idcard, Integer status) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(type)) {
			params.put("type", type);
		}
		if(StringUtils.isNotBlank(idcard)) {
			params.put("idcard", idcard);
		}
		if(StringUtils.isNotBlank(status+"")) {
			params.put("status", status);
		}
		if(type.equals("1")){
			return merchantDao.queryForBorrowCountDetailTotalMoney(params);
		}else{
			return merchantDao.queryForBorrowCountDetailTotalMoney2(params);
		}
	}

	@Override
	@LogRecord(module=LogRecord.Module.MERCHANT, operation=LogRecord.Operation.MERCHANTSAVE, id="", name="${merchant.name}")
	public boolean saveMerchant(Merchant merchant) {
		if (merchant != null) {
			if (merchant.getId() > 0) {
				if (merchant.getAttachments() != null && merchant.getAttachments().size() > 0) {
					Attachment attachment = merchant.getAttachments().get(0);
					attachmentDao.insertSingle(attachment);
					int attachmentId = attachment.getId();
					merchant.setLetterOfCommitment(String.valueOf(attachmentId));
				}
				String temp = "";
				if(StringUtils.isNotBlank(merchant.getOtherData())){
					String otherData = merchant.getOtherData();
					String[] split = otherData.split(",");
					for (String str : split) {
						Attachment attachment = new Attachment();
						attachment.setCategory(11);
						attachment.setProductId(0);
						attachment.setGuaranteeId(0);
						attachment.setUrl(str);
						attachmentDao.insertSingle(attachment);
						temp = temp + attachment.getId() + ",";
					}
					merchant.setOtherData(temp);
				}
				return merchantDao.update(merchant) > 0 ? true :false;
			} else {
				if (merchant.getAttachments() != null && merchant.getAttachments().size() > 0) {
					List<Integer> ids = new ArrayList<Integer>();
					String attachmentId = null;
					for (Attachment attachment : merchant.getAttachments()) {
						if (attachmentDao.insertSingle(attachment) > 0) {
							ids.add(attachment.getId());
						}
					}
					if (ids != null && ids.size() > 0) {
						attachmentId = Arrays.toString(ids.toArray());
						attachmentId = StringUtils.substring(attachmentId, 1, StringUtils.length(attachmentId)-1);
						merchant.setLetterOfCommitment(StringUtils.trim(attachmentId));
					}
				}
				String temp = "";
				if(StringUtils.isNotBlank(merchant.getOtherData())){
					String otherData = merchant.getOtherData();
					String[] split = otherData.split(",");
					for (String str : split) {
						Attachment attachment = new Attachment();
						attachment.setCategory(11);
						attachment.setProductId(0);
						attachment.setGuaranteeId(0);
						attachment.setUrl(str);
						attachmentDao.insertSingle(attachment);
						temp = temp + attachment.getId() + ",";
					}
					merchant.setOtherData(temp);
				}
				return merchantDao.insert(merchant) > 0 ? true : false;
			}
		}
		return false;
	}

	@Override
	public boolean addVoucher(String voucher, int id) {
		return merchantOrderDao.addVoucher(voucher, id) > 0 ? true : false;
	}

	@Override
	public UserBank getBankByCustomerId(int id) {
		return customerDao.selectBankByCustomerId(id);
	}

	@Override
	public boolean cardRefresh(String newCard, String bankName, String bankNo, String oldCard, int userId) {
		if(customerDao.insertUserBank(newCard, bankName, bankNo, userId) > 0){
			return customerDao.updateUserBank(oldCard, userId) > 0 ? true : false;
		}
		return false;
	}

	@Override
	public CardBin get(String prefix) {
		return CardBinDao.selectByPrefix(prefix);
	}

	@Override
	public CustomerAuthorisation getWithAccount(AuthorisationCategoryEnum category, int userId) {
		return customerAuthorisationDao.selectByUserId(category.value(), userId);
	}

	@Override
	public double countReward(String cellphone) {
		List<String> cellphones = userDao.selectByInviterPhone(cellphone);
		if(cellphones.size() > 0){
			Double reward = userDao.countInvitorReward(cellphones);
			if(reward != null && reward > 0){
				return reward;
			}
		}
		return 0.00d;
	}

	@Override
	public Customer getCustomer(int id) {
		return customerDao.selectByUserId(id);
	}

	@Override
	public int getCollectPrincipal(int userId) {
		return customerDao.selectCollectPrincipal(userId);
	}

	@Override
	public int getfreezingAmountByCustomerId(int id) {
		return customerOrderDao.selectfreezingAmountByCustomerId(id);
	}

	@Override
	public int countInviteNumber(String cellphone) {
		return userDao.countInviteNumber(cellphone);
	}

	@Override
	public CustomerBank getBank(Integer bankId) {
		return customerDao.selectById(bankId);
	}

	@Override
	public List<CustomerBank> listBanks(int customerId, int status) {
		return customerDao.selectBanksByCustomerId(customerId, status);
	}

	@Override
	public boolean setVip(int userId) {
		return userDao.changeToVip(userId) > 0 ? true : false;
	}

	@Override
	public boolean resetTurnOutBank(int id) {
		return customerDao.resetTurnOutBank(id) > 0 ? true : false;
	}

	@Override
	public int countLender(int loanPeriod, int projectType, int productId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("productId", productId);
		params.put("projectType", projectType);
		params.put("loanPeriod", loanPeriod);
		return lenderDao.queryForCount(params);
	}

	@Override
	public List<Lender> listLender(int loanPeriod, int projectType, int productId, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("productId", productId);
		params.put("projectType", projectType);
		params.put("loanPeriod", loanPeriod);
		params.put("offset", offset);
		params.put("size", size);
		List<Lender> listLender = lenderDao.queryForList(params);
		if(projectType == 1){
			listLender.sort((e1,e2)->(e1.getLoanAmount()> e2.getLoanAmount() ? 1 : -1));
		}
		return listLender;
	}

	@Override
	public User get(int id) {
		return userDao.selectByUserId(id);
	}

	@Override
	public int count(Calendar calendar) {
		SimpleDateFormat sdf = new SimpleDateFormat(NORMAL_DATE_FORMAT);
		return userDao.countCustomerByDate((sdf.format(calendar.getTime())));
	}

	@Override
	@LogRecord(module=LogRecord.Module.CUSTOMER_CARD, operation=LogRecord.Operation.CARDRESET, id="${id}", name="${bank.cardNO}")
	public boolean save(int id,CustomerBank bank) {
		return saveBank(bank) != null ? true : false;
	}

	public CustomerBank saveBank(CustomerBank bank) {
		if (bank != null) {
			boolean result = false;
			if (bank.getId() > 0) {
				result = customerDao.updateBank(bank)>0 ? true : false;
			} else {
				result = customerDao.insertBank(bank)>0 ? true : false;
			}
			if (result) {
				return bank;
			}
		}
		return null;
	}

	@Override
	public DispatchingBonusLog getDispatchingBonusLog(int dispatchingBonusLogId) {

		return dispatchingBonusLogDao.selectById(dispatchingBonusLogId);
	}

	@Override
	@LogRecord(module=LogRecord.Module.SILVERGIVE, operation=LogRecord.Operation.DISPATCHINGBONUSLOGSAVE, id="${dispatchingBonusLog.id}", name="", remark="${dispatchingBonusLog.giveDate}")
	public boolean saveDispatchingBonusLog(DispatchingBonusLog dispatchingBonusLog) {
		if(dispatchingBonusLog != null){
			if(dispatchingBonusLog.getChoiceType() == 1){
				dispatchingBonusLog.setUserNum(dispatchingBonusLog.getCellphones().split(ConstantUtil.SEMICOLON).length);
			}else{
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("beginDate", dispatchingBonusLog.getBeginDate()+MIN_TIME);
				params.put("endDate", dispatchingBonusLog.getEndDate()+MAX_TIME);
				params.put("satisfyType", dispatchingBonusLog.getSatisfyType());
				params.put("satisfyInitialAmount", dispatchingBonusLog.getSatisfyInitialAmount());
				params.put("satisfyEndAmount", dispatchingBonusLog.getSatisfyEndAmount());
				//System.out.println("用户数量:"+customerDao.countGiveUser(params)+"开始日期:"+ params.get("beginDate")+"结束日期:"+params.get("endDate")+"类型:"+params.get("satisfyType")+"开始数量:"+params.get("satisfyInitialAmount")+"结束数量:"+params.get("satisfyEndAmount"));
				dispatchingBonusLog.setUserNum(customerDao.countGiveUser(params));
			}
			if(dispatchingBonusLog.getId()> 0){
				if(dispatchingBonusLog.getCategory() == DispatchingBonusCategoryEnum.SILVER.getCategory()){
					dispatchingLogDao.delete(dispatchingBonusLog.getId());
					List<DispatchingLog> dispatchingLogs = new ArrayList<DispatchingLog>();
					for(String cellphone : dispatchingBonusLog.getCellphones().split(ConstantUtil.SEMICOLON)){
						if(StringUtils.isNotBlank(cellphone)){
							DispatchingLog dispatchingLog = new DispatchingLog();
							dispatchingLog.setCellphone(cellphone);
							dispatchingLogs.add(dispatchingLog);
						}
					}
					if(dispatchingBonusLog.getStatus() != 1 && dispatchingLogs.size() > 0){
						dispatchingLogDao.insertDispatchingLogBatch(dispatchingBonusLog.getId(), dispatchingLogs);
					}
				}
				return dispatchingBonusLogDao.update(dispatchingBonusLog) > 0 ? true : false;
			}else{
				int result = dispatchingBonusLogDao.insert(dispatchingBonusLog);
				if(dispatchingBonusLog.getCategory() == DispatchingBonusCategoryEnum.SILVER.getCategory()){
					if(result > 0 && StringUtils.isNotBlank(dispatchingBonusLog.getCellphones())){
						List<DispatchingLog> dispatchingLogs = new ArrayList<DispatchingLog>();
						for(String cellphone : dispatchingBonusLog.getCellphones().split(ConstantUtil.SEMICOLON)){
							DispatchingLog dispatchingLog = new DispatchingLog();
							dispatchingLog.setCellphone(cellphone);
							dispatchingLogs.add(dispatchingLog);
						}
						return dispatchingLogDao.insertDispatchingLogBatch(dispatchingBonusLog.getId(), dispatchingLogs) > 0 ? true : false;
					}
				}
			}
		}
		return false;
	}

	@Override
	public int countRecentSilverLog(int customerId, String pastTime) {
		return customerSilverLogDao.countRecentData(customerId, pastTime);
	}

	@Override
	public List<CustomerSilverLog> listSilverLog(int customerId, String pastTime, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("customerId", customerId);
		params.put("pastTime", pastTime);
		params.put("offset", offset);
		params.put("size", size);
		List<CustomerSilverLog> customerSilverLogs  = customerSilverLogDao.selectRecentDataByCustomerId(params);
		if(customerSilverLogs != null && customerSilverLogs.size() > 0){
			for(int i = 0; i < customerSilverLogs.size(); i++){
				if(customerSilverLogs.get(i).getAmount() > 0){
					String[] patch = customerSilverLogs.get(i).getChannel().split(UNDERLINE);
					customerSilverLogs.get(i).setChannel(SilverGainSourceEnum.getChannelByValue(customerSilverLogs.get(i).getSourceId()) +(patch.length>1?UNDERLINE+patch[1]:""));
				}
				if(customerSilverLogs.get(i).getAmount() < 0 ){
					customerSilverLogs.get(i).setChannel(SilverUsedSourceEnum.getChannelByValue(customerSilverLogs.get(i).getSourceId()));
				}
			}
		}
		return customerSilverLogs;
	}

	@Override
	public int count(String cellphone, int category) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(cellphone)){
			params.put("cellphone", cellphone);
		}
		params.put("category", category);
		return dispatchingBonusLogDao.queryForCount(params);
	}

	@Override
	public List<DispatchingBonusLog> listDispatchingBonusLog(String cellphone, int category, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(cellphone)){
			params.put("cellphone", cellphone);
		}
		params.put("category", category);
		params.put("offset", offset);
		params.put("size", size);
		return dispatchingBonusLogDao.queryForList(params);
	}

	@Override
	public int countGiveUser(DispatchingBonusLog log) {
		if(log != null && log.getId() > 0){
			Map<String, Object> params = getParams(log);
			return customerDao.countGiveUser(params);
		}
		return 0;
	}

	@Override
	public int count(int vipLevel, String name, String account, String idcard, String timeType, int channelId, String beginTime, String endTime, int beginAmount, int endAmount) {
		Map<String, Object> params = this.getOrderParam(name, account, idcard, beginTime, endTime);
		
		params.put("timeType", timeType);
		params.put("channelId", channelId);
		params.put("startAmount", beginAmount);
		params.put("endAmount", endAmount);
		params.put("vipLevel", vipLevel);
		return userDao.queryForCount(params);
	}

	@Override
	public List<UserEntity> list(int vipLevel, String name, String account, String idcard, String timeType, int channelId, String beginTime, String endTime, int startAmount, int endAmount, String sort, int offset, int size) {
		Map<String, Object> params = this.getOrderParam(name, account, idcard, beginTime, endTime);
		params.put("vipLevel", vipLevel);
		params.put("sort", sort);
		params.put("timeType", timeType);
		params.put("channelId", channelId);
		params.put("startAmount", startAmount);
		params.put("endAmount", endAmount);
		params.put("offset", offset);
		params.put("size", size);
		return userDao.queryForList(params);
	}

	@Override
	public int queryForCount(Integer type, String name, String cellphone, String startAmount,
							 String endAmount, int status) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(type+"")) {
			params.put("type", type);
		}
		if(StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		if(StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		if(StringUtils.isNotBlank(startAmount)&&StringUtils.isNotBlank(endAmount)) {
			params.put("startAmount", startAmount);
			params.put("endAmount", endAmount);
		}
		params.put("status", status);
		return merchantDao.queryForCount(params);
	}

	@Override
	public List<Merchant> queryForlist(Integer type, String name, String cellphone, String startAmount,
									   String endAmount, int status, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(type+"")) {
			params.put("type", type);
		}
		if(StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		if(StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		if(StringUtils.isNotBlank(startAmount)&&StringUtils.isNotBlank(endAmount)) {
			params.put("startAmount", startAmount);
			params.put("endAmount", endAmount);
		}
		params.put("status", status);
		params.put("offset", offset);
		params.put("size", size);
		List<Merchant> merchants = merchantDao.queryForList(params);
		List<Merchant> oldMerchants = merchantDao.getOldMerchantRepaymentAmount();

		if (oldMerchants != null && oldMerchants.size() > 0) {
			for (Merchant merchant : merchants) {
				if (merchant.getId() <= 4) {
					merchant.setPendingRepaymentAmount(0);
					for (Merchant oldMerchant : oldMerchants) {
						if (merchant.getId() == oldMerchant.getId()) {
							merchant.setPendingRepaymentAmount(oldMerchant.getPendingRepaymentAmount());
							break;
						}
					}
				}
			}
		}
		return merchants;

	}

	@Override
	@LogRecord(module=LogRecord.Module.DISPATCHINGBONUSLOG, operation=LogRecord.Operation.AUDIT, id="${dispatchingId}", name="")	
	public boolean giveCouponInBatch(int dispatchingId) {
		final DispatchingBonusLog log =dispatchingBonusLogDao.selectById(dispatchingId);
		if(log != null && StringUtils.isNotBlank(log.getGiveDate())){
			long delay = 0;
			Calendar nowDate = Calendar.getInstance();
			try {
				Calendar giveDate = Calendar.getInstance();
				giveDate.setTime(new SimpleDateFormat(NORMAL_DATE_FORMAT).parse(log.getGiveDate()));
				Calendar nowLastTime = Calendar.getInstance();
				nowLastTime.set(Calendar.HOUR_OF_DAY, 24);
				nowLastTime.set(Calendar.SECOND, 00);
				nowLastTime.set(Calendar.MINUTE, 00);
				if(nowLastTime.getTimeInMillis() - giveDate.getTimeInMillis() < 0){
					giveDate.set(Calendar.HOUR_OF_DAY, 10);
					nowDate.setTime(Calendar.getInstance().getTime());
					delay = giveDate.getTimeInMillis() - nowDate.getTimeInMillis();
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			if(log.getChoiceType() == 1){
				Runnable runnable = new Runnable() {
					@Override
					public void run() {
						String[] cellphoneArr = StringUtils.split(log.getCellphones(), SEMICOLON);
						List<Integer> ids = userDao.selectByCellphones(cellphoneArr);
						List<CustomerCoupon> customerCoupons = getCustomerCoupon(log,ids);
						if(customerCoupons != null){							
							boolean result = save(customerCoupons) > 0 ? true : false;
							if(result){
								List<String> cellphones = Arrays.asList(cellphoneArr);
								giveSmsTemplate(log, cellphones);
							}
						}
					}
				};
				EXECUTOR.schedule(runnable, delay, TimeUnit.MINUTES);
			}else if(log.getChoiceType() == 0){
				if(log != null){
					LOG.info("give coupon type 0 : "+log);
					final int userNum = log.getUserNum();
					Runnable runnable = new Runnable() {
						@Override
						public void run() {
							int count = userNum;
							int pages = (int)(Math.ceil((float) count / THOUSAND));
							LOG.info("give coupon pages : "+pages);
							if(count > 0){
								int i = 1;
								List<Integer> totalAccounts = getAccountGiveUser(log);
								while(i <= pages){
									List<Integer> ids = null;
									if(i < pages){
										ids =  totalAccounts.subList((i-1)*THOUSAND, i*THOUSAND);
									}else{										
										ids =  totalAccounts.subList((i-1)*THOUSAND, totalAccounts.size());
									}
									List<CustomerCoupon> customerCoupons = getCustomerCoupon(log, ids);
									int res = save(customerCoupons);
									LOG.info("give coupon result "+i+": "+res);
									if (log.getTemplate() != null && log.getTemplate().getId() > 0 && log.getTemplate().getStatus() == 1) {
										List<String> cellphones = userDao.selectByAccounts(ids);
										LOG.info("give coupon smsTemplate "+i+" result start");
										giveSmsTemplate(log, cellphones);
										LOG.info("give coupon smsTemplate  "+i+" result end");
									}
									i++;
									try {
										if(pages - i >= 0){
											Thread.sleep(5000);
										}
									} catch (InterruptedException e) {
										continue;
									}
								}
							}
						}
					};
					EXECUTOR.schedule(runnable, delay, TimeUnit.MINUTES);
				}
			}else{
				//do nothing
			}
			log.setStatus(Short.parseShort("2"));
			return save(log);
		}
		return false;
	}
	private boolean save(DispatchingBonusLog dispatchingBonusLog) {
		if(dispatchingBonusLog != null){
			if(dispatchingBonusLog.getChoiceType() == 1){
				dispatchingBonusLog.setUserNum(dispatchingBonusLog.getCellphones().split(ConstantUtil.SEMICOLON).length);
			}else{
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("beginDate", dispatchingBonusLog.getBeginDate()+ConstantUtil.MIN_TIME);
				params.put("endDate", dispatchingBonusLog.getEndDate()+ConstantUtil.MAX_TIME);
				params.put("satisfyType", dispatchingBonusLog.getSatisfyType());
				params.put("satisfyInitialAmount", dispatchingBonusLog.getSatisfyInitialAmount());
				params.put("satisfyEndAmount", dispatchingBonusLog.getSatisfyEndAmount());
				dispatchingBonusLog.setUserNum(customerDao.countGiveUser(params));
			}
			if(dispatchingBonusLog.getId()> 0){
				if(dispatchingBonusLog.getCategory() == DispatchingBonusCategoryEnum.SILVER.getCategory()){					
					dispatchingLogDao.delete(dispatchingBonusLog.getId());
					List<DispatchingLog> dispatchingLogs = new ArrayList<DispatchingLog>();
					for(String cellphone : dispatchingBonusLog.getCellphones().split(ConstantUtil.SEMICOLON)){
						if(StringUtils.isNotBlank(cellphone)){
							DispatchingLog dispatchingLog = new DispatchingLog();
							dispatchingLog.setCellphone(cellphone);
							dispatchingLogs.add(dispatchingLog);
						}
					}
					if(dispatchingBonusLog.getStatus() != 1 && dispatchingLogs.size() > 0){
						dispatchingLogDao.insertDispatchingLogBatch(dispatchingBonusLog.getId(), dispatchingLogs);
					}
				}
				return dispatchingBonusLogDao.update(dispatchingBonusLog) > 0 ? true : false;
			}else{
				int result = dispatchingBonusLogDao.insert(dispatchingBonusLog);
				if(dispatchingBonusLog.getCategory() == DispatchingBonusCategoryEnum.SILVER.getCategory()){
					if(result > 0 && StringUtils.isNotBlank(dispatchingBonusLog.getCellphones())){
						List<DispatchingLog> dispatchingLogs = new ArrayList<DispatchingLog>();
						for(String cellphone : dispatchingBonusLog.getCellphones().split(ConstantUtil.SEMICOLON)){
							DispatchingLog dispatchingLog = new DispatchingLog();
							dispatchingLog.setCellphone(cellphone);
							dispatchingLogs.add(dispatchingLog);
						}
						return dispatchingLogDao.insertDispatchingLogBatch(dispatchingBonusLog.getId(), dispatchingLogs) > 0 ? true : false;
					}
				}
			}
		}
		return false;
	}
	private List<Integer> getAccountGiveUser(DispatchingBonusLog log) {
		Map<String, Object> params = getParams(log);
		return customerDao.selectAccountGiveUser(params);
	}

	private Map<String, Object> getParams(DispatchingBonusLog log){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("beginDate", log.getBeginDate()+ConstantUtil.MIN_TIME);
		params.put("endDate", log.getEndDate()+ConstantUtil.MAX_TIME);
		params.put("satisfyInitialAmount", log.getSatisfyInitialAmount());
		params.put("satisfyEndAmount", log.getSatisfyEndAmount());
		params.put("satisfyType", log.getSatisfyType());
		return params;
	}


	private Map<String, Object> getOrderParam(String name, String account, String idcard, String beginTime, String endTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		if(StringUtils.isNotBlank(account)) {
			params.put("cellphone", account);
		}
		if(StringUtils.isNotBlank(idcard)) {
			params.put("idcard", idcard);
		}
		if (StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(endTime)) {
			params.put("beginTime", beginTime+MIN_TIME);
			params.put("endTime", endTime+MAX_TIME);
		}
		return params;
	}

	private int save(List<CustomerCoupon> customerCoupons) {
		if(customerCoupons != null && customerCoupons.size() > 0) {
			return customerCouponDao.insertCustomerCoupons(customerCoupons);
		}
		return 0;
	}
	private void giveSmsTemplate(DispatchingBonusLog log, List<String> cellphones){
		if (log.getTemplate() != null && log.getTemplate().getId() > 0 && log.getTemplate().getStatus() == 1) {
			String content = MessageFormat.format(log.getTemplate().getContent(), log.getQuantity()+properties.getSmsMessageContent());
			for (String cellphone : cellphones) {
				smsOrderMessage(content, cellphone);
			}
		}
	}
	private void smsOrderMessage(String text, String mobile) {
		this.handleSMS(text, mobile,"utf-8");
	}
	private String handleSMS(String text, String mobile, String encoding){
		/*String uri =  zookeeperService.getConfigData("plugin.uri");
		String sayenSuffix = zookeeperService.getConfigData("sayen.sms.send");
		String huaxingSuffix = zookeeperService.getConfigData("huaxing.sms.send");
		String monternetSuffix = zookeeperService.getConfigData("monternet.sms.send");
		String emaySuffix = zookeeperService.getConfigData("emay.sms.send");*/
		String uri = properties.getPluginUrl();         
		String sayenSuffix = properties.getSayenSmsSend();                  
		String huaxingSuffix = properties.getHuaxingSmsSend();            
		String monternetSuffix = properties.getMonternetSmsSend();           
		String emaySuffix = properties.getEmaySmsSend();             
		
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair(ConstantUtil.SAYEN_SMS_TEXT, text));
		nvps.add(new BasicNameValuePair(ConstantUtil.SAYEN_SMS_MOBILE, mobile ));
		
		List<SmsChannel> smsChannels = smsChannelDao.selectByEnable((short)GenericEnableEnum.ENABLE.value());                 
		if(smsChannels.size() > 0){
			for(SmsChannel smsChannel : smsChannels){
				if(smsChannel.getId() == 1){
					String sayenResult = this.execute(uri + sayenSuffix, nvps, encoding);
					try {
						if(StringUtils.isNotBlank(sayenResult) && sayenResponse2JSON(sayenResult).containsKey(ConstantUtil.CODE) && sayenResponse2JSON(sayenResult).getIntValue(ConstantUtil.CODE) == 0 ) {
							return sayenResponse2JSON(sayenResult).toJSONString();
						}else{
							continue;
						}
					} catch (Exception e) {
					}
				}else if(smsChannel.getId() == 2){
					//String	signature = zookeeperService.getConfigData("huaxing.user.signature");
					String	signature = properties.getHuaxingUserSignature();         
					nvps = new ArrayList<NameValuePair>();
					nvps.add(new BasicNameValuePair(ConstantUtil.HUAXING_SMS_TEXT, signature + text));
					nvps.add(new BasicNameValuePair(ConstantUtil.HUAXING_SMS_MOBILE, mobile));
					String huaxingResult = this.execute(uri + huaxingSuffix, nvps, encoding);
					try {
						if(StringUtils.isNotBlank(huaxingResult) && huaxingResponse2JSON(huaxingResult).containsKey(ConstantUtil.CODE) && huaxingResponse2JSON(huaxingResult).getIntValue(ConstantUtil.CODE) == 0) {
							return huaxingResponse2JSON(huaxingResult).toJSONString();
						} else {
							continue;
						}
					} catch (Exception e) {
					}
				}else if(smsChannel.getId() == 3){
					nvps = new ArrayList<NameValuePair>();
					nvps.add(new BasicNameValuePair(ConstantUtil.MONTERNET_SMS_TEXT, text));
					nvps.add(new BasicNameValuePair(ConstantUtil.MONTERNET_SMS_MOBILE, mobile));
					String monternetResult = this.execute(uri + monternetSuffix, nvps, encoding);
					try {
						if(StringUtils.isNotBlank(monternetResult) && monternetResponse2JSON(monternetResult).containsKey(ConstantUtil.CODE) && monternetResponse2JSON(monternetResult).getIntValue(ConstantUtil.CODE) == 0) {
							return monternetResponse2JSON(monternetResult).toJSONString();
						}else{
							continue;
						}
					} catch (Exception e) {
					}
				}else if(smsChannel.getId() == 4){
					nvps = new ArrayList<NameValuePair>();
					nvps.add(new BasicNameValuePair(ConstantUtil.EMAY_SMS_TEXT, text));
					nvps.add(new BasicNameValuePair(ConstantUtil.EMAY_SMS_MOBILE, mobile));
					String emayResult = this.execute(uri + emaySuffix, nvps, encoding);
					try {
						if(StringUtils.isNotBlank(emayResult) && emayResponse2JSON(emayResult).containsKey(ConstantUtil.CODE) && emayResponse2JSON(emayResult).getIntValue(ConstantUtil.CODE) == 0) {
							return emayResponse2JSON(emayResult).toJSONString();
						}else{
							continue;
						}
					} catch (Exception e) {
					}
				}else{
				}
				break;
			}
		}
		return null;
	}
	
	private String execute(String uri, List<NameValuePair> nvps, String encoding) {
		CloseableHttpClient closeableHttpClient = HttpClients.createDefault();
		HttpPost httpPost = new HttpPost(uri);
		try {
			if(nvps != null && nvps.size() > 0) {
				httpPost.setEntity(new UrlEncodedFormEntity(nvps, encoding));
			}
			CloseableHttpResponse httpResponse = closeableHttpClient.execute(httpPost);
			int statusCode = httpResponse.getStatusLine().getStatusCode();
			if(statusCode == 200) {
				return EntityUtils.toString(httpResponse.getEntity(), encoding);
			}
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		} finally {
			httpPost.releaseConnection();
		}
		return null;
	}
	private List<CustomerCoupon> getCustomerCoupon(DispatchingBonusLog log, List<Integer> ids){
		List<CustomerCoupon> customerCoupons = new ArrayList<CustomerCoupon>();
		if (log != null && log.getCouponIds() != null && log.getCellphones() != null) {
			String[] couponIds = StringUtils.split(log.getCouponIds(),  COMMA);
			String[] couponAmounts = StringUtils.split(log.getCouponAmounts(), COMMA);
			if(ids == null){
				return customerCoupons;
			}
			for(Object id : ids){
				if(couponIds.length > 0 && couponIds.length == couponAmounts.length){
					User user = new User();
					if(id instanceof Integer) {
						user.setId((Integer)id);
					} else {
						Integer uid = Integer.parseInt((String) id);
						user.setId(uid);
					}
					for(int j =0; j < couponIds.length; j++){
						CustomerCoupon customerCoupon = new CustomerCoupon();
						customerCoupon.setUser(user);
						customerCoupon.setCreateTime(new Date());
						customerCoupon.setUsed(0);
						customerCoupon.setCumulative(0);
						customerCoupon.setSource(CustomerCouponSourceEnum.COUPONGIVE.getValue());
						Coupon coupon = new Coupon();
						coupon.setId(Integer.parseInt(couponIds[j]));
						if(couponAmounts[j].indexOf(ConstantUtil.PERCENT) > -1){
							customerCoupon.setAmount(Double.parseDouble(couponAmounts[j].substring(0, couponAmounts[j].indexOf(ConstantUtil.PERCENT))));
						}else{
							customerCoupon.setAmount(Double.parseDouble(couponAmounts[j].substring(0, couponAmounts[j].indexOf(ConstantUtil.YUAN))));
						}
						customerCoupon.setCoupon(coupon);
						customerCoupon.setDispatchingBonusLogId(log.getId());
						customerCoupons.add(customerCoupon);
					}
				}
			}
		}
		return customerCoupons;
	}
	
	private JSONObject huaxingResponse2JSON(String response) {
		String result = ConstantUtil.FAILED_SMS_JSON;
		if(StringUtils.isNotBlank(response)) { 
			JSONObject json = JSON.parseObject(response);
			if(StringUtils.equals(json.getString("returnstatus"), "Success")) {
				result = ConstantUtil.SUCCEED_SMS_JSON;
			}
        }  
		return JSON.parseObject(result);
	}
	private JSONObject sayenResponse2JSON(String response) {
		String result = ConstantUtil.FAILED_SMS_JSON;
		if(StringUtils.isNotBlank(response)){
			try {
				if((response.split(","))[1].equals("0")){
					result = ConstantUtil.SUCCEED_SMS_JSON;
				}
			} catch(Exception e) {
				
			}
		}
		return JSON.parseObject(result);
	}
	private JSONObject monternetResponse2JSON(String response) {
		String result = ConstantUtil.FAILED_SMS_JSON;
		Pattern p = Pattern.compile(ConstantUtil.MONTERNET_REX_RESPONSE);
		Matcher m = p.matcher(response);
		if(m.find()) {  
			if(m.group(1).length() > ConstantUtil.MONTERNET_RESULT_MIN_LENGTH) {
				result = ConstantUtil.SUCCEED_SMS_JSON;
			}
        }  
		return  JSON.parseObject(result);
	}
	private static JSONObject emayResponse2JSON(String response) {
		String result = ConstantUtil.FAILED_SMS_JSON;
		if(StringUtils.isNotBlank(response)) { 
			String xml = response.trim();
			if (StringUtils.startsWithIgnoreCase(xml, ConstantUtil.EMAY_XML_LABEL)) {
				XMLSerializer xmlSerializer = new XMLSerializer();
				String emayResult = xmlSerializer.read(xml).toString();
				if(JSON.parseObject(emayResult) != null && JSON.parseObject(emayResult).containsKey(ConstantUtil.EMAY_RESULT_KEY) && JSON.parseObject(emayResult).getIntValue(ConstantUtil.EMAY_RESULT_KEY)==0){
					result = ConstantUtil.SUCCEED_SMS_JSON;
				}
			}
        }  
		return JSON.parseObject(result);
	}

	@Override
	public int countLender(int productId, int type, String name, String cellphone, int startNum, int endNum, int status, int categoryId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		if (StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		if (StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		if(productId > 0){
			params.put("productId", productId);
		}
		params.put("startNum", startNum);
		params.put("endNum", endNum);
		params.put("status", status);
		params.put("categoryId", categoryId);
		return lenderDao.queryLenderForCount(params);
	}

	@Override
	public List<Lender> listLender(int productId, int type, String name, String cellphone, int startNum, int endNum, int status, int categoryId, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("size", size);
		params.put("type", type);
		if (StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		if (StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		if(productId > 0){
			params.put("productId", productId);
		}
		params.put("startNum", startNum);
		params.put("endNum", endNum);
		params.put("status", status);
		params.put("categoryId", categoryId);
		params.put("size", size);
		params.put("offset", offset);
		return lenderDao.queryLenderForList(params);
	}

	@Override
	public Lender selectByLenderId(Integer lenderId) {
		return merchantDao.selectByLenderId(lenderId);
	}

	@Override
	public Lender getLender(int id) {
		Lender lender = lenderDao.selectById(id);
		if (lender != null) {
			if (StringUtils.isNotBlank(lender.getOtherData())) {
				List<Integer> attachmentIds = new ArrayList<Integer>();
				String[] infos = StringUtils.split(lender.getOtherData(), ",");
				if (infos != null && infos.length > 0) {
					for (String info : infos) {
						if (StringUtils.isNotBlank(info)) {
							attachmentIds.add(Integer.parseInt(StringUtils.trim(info)));
						}
					}
					lender.setAttachments(attachmentDao.selectByIds(attachmentIds));
				}
			}
			return lender;
		}
		return null;
	}

	@Override
	@LogRecord(module=LogRecord.Module.CREDITORMANAGEMENT, operation=LogRecord.Operation.CREDITORMANAGEMENTOPERATION, id="${lender.id}", name="${lender.name}")
	public boolean saveLender(Lender lender) {
		if (lender != null) {
			if (lender.getId() > 0) {
				List<Integer> attachmentIds = new ArrayList<Integer>();
				if (StringUtils.isNotBlank(lender.getOtherData())) {
					String[] infos = StringUtils.split(lender.getOtherData(), ",");
					if (infos != null && infos.length > 0) {
						for (String info : infos) {
							if (StringUtils.isNotBlank(info)) {
								attachmentIds.add(Integer.parseInt(StringUtils.trim(info)));
							}
						}
					}
				}
				if (lender.getAttachments() != null && lender.getAttachments().size() > 0) {
					String attachmentId = null;
					for (Attachment attachment : lender.getAttachments()) {
						if (attachmentDao.insertSingle(attachment) > 0) {
							attachmentIds.add(attachment.getId());
						}
					}
					if (attachmentIds != null && attachmentIds.size() > 0) {
						attachmentId = Arrays.toString(attachmentIds.toArray());
						attachmentId = StringUtils.substring(attachmentId, 1, StringUtils.length(attachmentId)-1);
						lender.setOtherData(StringUtils.trim(attachmentId));
					}
				}
				return lenderDao.updateLender(lender) > 0 ? true :false;
			} else {
				if (lender.getAttachments() != null && lender.getAttachments().size() > 0) {
					List<Integer> ids = new ArrayList<Integer>();
					String attachmentId = null;
					for (Attachment attachment : lender.getAttachments()) {
						if (attachmentDao.insertSingle(attachment) > 0) {
							ids.add(attachment.getId());
						}
					}
					if (ids != null && ids.size() > 0) {
						attachmentId = Arrays.toString(ids.toArray());
						attachmentId = StringUtils.substring(attachmentId, 1, StringUtils.length(attachmentId)-1);
						lender.setOtherData(StringUtils.trim(attachmentId));
					}
				}
				String uuid = UUID.randomUUID().toString().replace("-", "");
				lender.setOrderNO(uuid);
				return lenderDao.insert(lender) > 0 ? true : false;
			}
		}
		return false;
	}

	@Override
	public int count(int projectType, String productStatue, int payChannel, String name, String productName, int timeCategory, String fromDate, String toDate) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("timeCategory", timeCategory);
		params.put("projectType", projectType);
		params.put("productStatue", productStatue);
		params.put("payChannel", payChannel);
		if (StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		if (StringUtils.isNotBlank(productName)) {
			params.put("productName", productName);
		}
		if (StringUtils.isNotBlank(fromDate) && StringUtils.isNotBlank(toDate)) {
			params.put("fromDate", fromDate);
			params.put("toDate", toDate);
		}
		return merchantOrderDao.queryWaitPayPaymentForCount(params);
	}

	@Override
	public List<ProductEntity> list(String projectTimeType,int projectType, int orderStatus, int payChannel, String name, String productName, int orderType, String fromDate, String toDate, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("size", size);
		params.put("orderStatus", orderStatus);
		params.put("projectType", projectType);
		params.put("orderType", orderType);
		params.put("payChannel", payChannel);
		if (StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		if (StringUtils.isNotBlank(productName)) {
			params.put("productName", productName);
		}
		if (StringUtils.isNotBlank(fromDate) && StringUtils.isNotBlank(toDate)) {
			params.put("fromDate", fromDate);
			params.put("toDate", toDate);
			params.put("projectTimeType", projectTimeType);
		}
		if(orderType == 1){
			if(orderStatus == 2){
				return merchantOrderDao.queryProductPaymentedForList(params);
			}else{
				return merchantOrderDao.queryProductPaymentingForList(params);
			}
		}else {
			return merchantOrderDao.queryProductForList(params);
		}
	}

	@Override
	public List<ProductEntity> list(int projectType, String productStatue, int payChannel, String name, String productName, int timeCategory, String fromDate, String toDate, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("size", size);
		params.put("timeCategory", timeCategory);
		params.put("projectType", projectType);
		params.put("productStatue", productStatue);
		params.put("payChannel", payChannel);
		if (StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		if (StringUtils.isNotBlank(productName)) {
			params.put("productName", productName);
		}
		if (StringUtils.isNotBlank(fromDate) && StringUtils.isNotBlank(toDate)) {
			params.put("fromDate", fromDate);
			params.put("toDate", toDate);
		}
		return merchantOrderDao.queryWaitPaymentForList(params);
	}

	@Override
	public double sumWaitpaymentMoney(int projectType, String productStatue, String name, String productName, int timeCategory, String fromDate, String toDate) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("timeCategory", timeCategory);
		params.put("projectType", projectType);
		params.put("productStatue", productStatue);
		if (StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		if (StringUtils.isNotBlank(productName)) {
			params.put("productName", productName);
		}
		if (StringUtils.isNotBlank(fromDate) && StringUtils.isNotBlank(toDate)) {
			params.put("fromDate", fromDate);
			params.put("toDate", toDate);
		}
		return merchantOrderDao.sumWaitpaymentMoney(params);
	}

	@Override
	public Double sumPaymentMoney(String projectTimeType,int projectType, String productStatue, String name, String productName,int orderType, String fromDate, String toDate) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("orderType", orderType);
		params.put("projectType", projectType);
		params.put("productStatue", productStatue);
		if (StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		if (StringUtils.isNotBlank(productName)) {
			params.put("productName", productName);
		}
		if (StringUtils.isNotBlank(fromDate) && StringUtils.isNotBlank(toDate)) {
			params.put("fromDate", fromDate);
			params.put("toDate", toDate);
			params.put("projectTimeType", projectTimeType);
		}
		return merchantOrderDao.sumPaymentMoney(params);
	}

	@Override
	public Double sumShouldPaybackmentMoney(String projectTimeType,int projectType, String productStatue, String name, String productName, int orderType, String fromDate, String toDate) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("orderType", orderType);
		params.put("projectType", projectType);
		params.put("productStatue", productStatue);
		if (StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		if (StringUtils.isNotBlank(productName)) {
			params.put("productName", productName);
		}
		if (StringUtils.isNotBlank(fromDate) && StringUtils.isNotBlank(toDate)) {
			params.put("fromDate", fromDate);
			params.put("toDate", toDate);
			params.put("projectTimeType", projectTimeType);
		}
		return merchantOrderDao.sumShouldPaybackmentMoney(params);
	}

	@Override
	public double sumTradeAmount(int projectType, String productStatue, String name, String productName, String fromDate, String toDate) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("projectType", projectType);
		params.put("productStatue", productStatue);
		if (StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		if (StringUtils.isNotBlank(productName)) {
			params.put("productName", productName);
		}
		if (StringUtils.isNotBlank(fromDate) && StringUtils.isNotBlank(toDate)) {
			params.put("fromDate", fromDate);
			params.put("toDate", toDate);
		}
		return merchantOrderDao.sumTradeAmount(params);
	}

	@Override
	public double sumServiceCharge(int projectType, String productStatue, String name, String productName, int timeCategory, String fromDate, String toDate) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("timeCategory", timeCategory);
		params.put("projectType", projectType);
		params.put("productStatue", productStatue);
		if (StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		if (StringUtils.isNotBlank(productName)) {
			params.put("productName", productName);
		}
		if (StringUtils.isNotBlank(fromDate) && StringUtils.isNotBlank(toDate)) {
			params.put("fromDate", fromDate);
			params.put("toDate", toDate);
		}
		Double serviceCharge = merchantOrderDao.sumServiceCharge(params);
		return serviceCharge == null ? 0 : serviceCharge;
	}

	@Override
	public int count(String projectTimeType,int projectType, int orderStatus, int payChannel, String name, String productName, int orderType, String fromDate, String toDate) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("orderStatus", orderStatus);
		params.put("projectType", projectType);
		params.put("orderType", orderType);
		params.put("payChannel", payChannel);
		if (StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		if (StringUtils.isNotBlank(productName)) {
			params.put("productName", productName);
		}
		if (StringUtils.isNotBlank(fromDate) && StringUtils.isNotBlank(toDate)) {
			params.put("fromDate", fromDate);
			params.put("toDate", toDate);
			params.put("projectTimeType", projectTimeType);
		}
		return merchantOrderDao.queryProductForCount(params);
	}


	@Override
	public List<Lender> listLenders(int productId, int projectType) {
		return lenderDao.selectByProductId(productId, projectType);
	}

	@Override
	public Merchant getMerchantData(int merchantIdData) {
		return merchantDao.selectById(merchantIdData);
	}

	@Override
	public int queryLenderLoanCount(Integer lenderId) {
		return lenderDao.queryLenderLoanCount(lenderId);
	}

	@Override
	public List<Lender> listLenders(Integer productId) {
		return lenderDao.selectAllByProductId(productId);
	}

	@Override
	public double queryTotalMoney(Integer type, String name, String cellphone, String startAmount, String endAmount) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(type+"")) {
			params.put("type", type);
		}
		if(StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		if(StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		if(StringUtils.isNotBlank(startAmount)&&StringUtils.isNotBlank(endAmount)) {
			params.put("startAmount", startAmount);
			params.put("endAmount", endAmount);
		}
		return merchantDao.queryTotalMoney(params);
	}

	@Override
	public SmsChannel getSmsChannel(int parseInt) {
		
		return  smsChannelDao.selectById(parseInt);
	}

	@Override
	public List<RoleResource> listRoleResource(int roleId) {
		return resourceDao.listRoleResource(roleId);
	}

	@Override
	public List<InviteesEntity> queryInviteesEntities(String cellphone ,Integer inviterLevel ,int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		params.put("inviterLevel", inviterLevel);
		params.put("offset", offset);
		params.put("size", size);
		return inviterRewardDao.queryInviteesEntities(params);
		
	}

	@Override
	public int queryBeInviterCount(String cellphone,Integer inviterLevel) {
		return inviterRewardDao.countBeInviterByCellphone(cellphone,inviterLevel);
	}
}
