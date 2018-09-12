package com.silverfox.finance.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.silverfox.finance.domain.*;
import com.silverfox.finance.orm.*;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.silverfox.finance.entity.EarningEntity;
import com.silverfox.finance.entity.EsignEntity;
import com.silverfox.finance.entity.LoanEntity;
import com.silverfox.finance.entity.OpexEntity;
import com.silverfox.finance.entity.PaybackCalenderEntity;
import com.silverfox.finance.entity.ProductTradeEntity;
import com.silverfox.finance.entity.ReceivablesEntity;
import com.silverfox.finance.entity.ReinvestEntity;
import com.silverfox.finance.entity.StatisticsEntity;
import com.silverfox.finance.enumeration.TypeEnum;
import com.silverfox.finance.service.ThreadService;
import com.silverfox.finance.service.TradeService;
import com.silverfox.finance.util.ConstantUtil;
import com.silverfox.finance.util.LogRecord;

@Service
public class TradeServiceImpl extends ThreadService  implements TradeService {
	private static final Log LOGGER = LogFactory.getLog(TradeServiceImpl.class);
	@Autowired
	private CustomerDao customerDao;
	@Autowired
	private CustomerOrderDao customerOrderDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private MerchantDao merchantDao;
	@Autowired
	private CustomerMessageDao customerMessageDao;
	@Autowired
	private MerchantOrderDao merchantOrderDao;
	@Autowired
	private PayBankDao payBankDao;
	@Autowired
	private LogPaymentDao logPaymentDao;
	@Autowired
	private LenderDao lenderDao;
	@Autowired
	private ProductDetailDao productDetailDao;
	@Autowired
	private AttachmentDao attachmentDao;
	@Autowired
	private CouponDao couponDao;
	@Autowired
	private CustomerSilverLogDao customerSilverLogDao;
	@Autowired
	private ProductDao productDao;
    @Autowired
    private CustomerBalanceLogDao customerBalanceLogDao;
	@Autowired
	private SignatureDao signatureDao;
	@Autowired
	private ProductProtocolDao productProtocolDao;
	@Autowired
	private VipLevelChangeLogDao vipLevelChangeLogDao;
	

	@Override
	public int countLossing(String paybackDate) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(paybackDate)) {
			params.put("beginTime", paybackDate+ConstantUtil.MIN_TIME);
			params.put("endTime", paybackDate+ConstantUtil.MAX_TIME);
		}
		return customerDao.countLossingCustomers(params);
	}

	@Override
	public List<Customer> getLossing(String sort, String paybackDate,
			int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(paybackDate)) {
			params.put("beginTime", paybackDate+ConstantUtil.MIN_TIME);
			params.put("endTime", paybackDate+ConstantUtil.MAX_TIME);
		}
		params.put("sort", sort);
		params.put("offset", offset);
		params.put("size", size);
		return customerDao.selectLossingCustomers(params);
		
	}

	@Override
	public ReinvestEntity getReinvest(String paybackDate) {
		if (StringUtils.isNotBlank(paybackDate)) {
			ReinvestEntity entity = customerOrderDao.selectReinvest(paybackDate+ConstantUtil.MIN_TIME, paybackDate+ConstantUtil.MAX_TIME);
			if (entity != null) {
				entity.setPaybackDate(paybackDate);
				if (entity.getInvestAmount() == null) {
					entity.setInvestAmount(0);
				}
				if (entity.getInvestCustomers() == null) {
					entity.setInvestCustomers(0);
				}
				if (entity.getPaybackAmount() == null) {
					entity.setPaybackAmount(0d);
				}
				if (entity.getPaybackCustomers() == null) {
					entity.setPaybackCustomers(0);
				}
			}
			return entity;
		}
		return null;
	}

	@Override
	public ReinvestEntity getNotReinvest(String paybackDate) {
		if (StringUtils.isNotBlank(paybackDate)) {
			ReinvestEntity entity = customerOrderDao.selectNotReinvest(paybackDate+ConstantUtil.MIN_TIME, paybackDate+ConstantUtil.MAX_TIME);
			if (entity != null) {
				entity.setPaybackDate(paybackDate);
				if (entity.getInvestCustomers() == null) {
					entity.setInvestCustomers(0);
				}
				if (entity.getPaybackCustomers() == null) {
					entity.setPaybackCustomers(0);
				}
			}
			return entity;
		}
		return null;
	}

	@Override
	public List<EarningEntity> oldEarning(String beginDate, String endDate) {
		return customerOrderDao.oldEarning(beginDate, endDate);
	}

	@Override
	public List<EarningEntity> newEarning(String beginDate, String endDate) {
		return customerOrderDao.newEarning(beginDate, endDate);
	}

	@Override
	public List<PaybackCalenderEntity> paybackCalender(Integer type, Integer backChannel, String beginDate, String endDate) {
		beginDate = beginDate + ConstantUtil.MIN_TIME;
		endDate = endDate + ConstantUtil.MAX_TIME;
		return customerOrderDao.paybackCalender(type, backChannel, beginDate, endDate);
	}

	@Override
	public int countOpex(String beginDate, String endDate) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(beginDate) && StringUtils.isNotBlank(endDate)) {
			params.put("beginDate", beginDate);
			params.put("endDate", endDate);
		}
		return customerOrderDao.countOpex(params);
	}

	@Override
	public List<OpexEntity> listOpex(String beginDate, String endDate,
			int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(beginDate) && StringUtils.isNotBlank(endDate)) {
			params.put("beginDate", beginDate);
			params.put("endDate", endDate);
		}
		params.put("offset", offset);
		params.put("size", size);
		return customerOrderDao.listOpex(params);
	}

	@Override
	public int countOrderInSomeday(String systemDate) {
		return customerOrderDao.countOrderInSomeday(systemDate);
	}

	@Override
	public int sumOrderInSomeday(String systemDate) {
		Integer result = customerOrderDao.sumOrderInSomeday(systemDate);
		if (result == null) {
			result = 0;
		}
		return result;
	}

	@Override
	public int countInSomeday(String systemDate) {
		return userDao.countInSomeday(systemDate);
	}

	@Override
	public int  countCustomerInSomeday(String systemDate) {
		return userDao.countCustomerInSomeday(systemDate);
	}

	@Override
	public List<StatisticsEntity> statisticsIncreaseCoupon(String beginTime,
			String endTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(endTime)) {
			params.put("beginTime", beginTime+ConstantUtil.MIN_TIME);
			params.put("endTime", endTime+ConstantUtil.MAX_TIME);
		}
		return couponDao.selectIncreaseCoupon(params);
	}

	@Override
	public List<CustomerSilverLog> statisticsSilver(String beginTime,
			String endTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(endTime)) {
			params.put("beginTime", beginTime+ConstantUtil.MIN_TIME);
			params.put("endTime", endTime+ConstantUtil.MAX_TIME);
		}
		return customerSilverLogDao.selectAll(params);
	}

	@Override
	public List<StatisticsEntity> statisticsBonus(int category, int source,
			String beginTime, String endTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(endTime)) {
			params.put("beginTime", beginTime+ConstantUtil.MIN_TIME);
			params.put("endTime", endTime+ConstantUtil.MAX_TIME);
		}
		params.put("category", category);
		params.put("source", source);
		return couponDao.statisticsCouponsDetail(params);
	}

	@Override
	public List<StatisticsEntity> statisticsBonus(String beginTime,
			String endTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(endTime)) {
			params.put("beginTime", beginTime+ConstantUtil.MIN_TIME);
			params.put("endTime", endTime+ConstantUtil.MAX_TIME);
		}
		
		return couponDao.statisticsCoupons(params);
	}

	@Override
	public List<ReceivablesEntity> getMerchantTradeAmount(Integer id, int type) {
		return merchantOrderDao.selectMerchantTradeAmount(id,type);
	}

	@Override
	public List<ReceivablesEntity> getProductIncomeAmountByMonths(Integer id,
			int offset, int pageSize) {
		SimpleDateFormat format = new SimpleDateFormat(ConstantUtil.NUMBER_MONTH_FORMAT);
		return productDao.queryProductIncomeAmountByMonth(id, format.format(Calendar.getInstance().getTime()), offset, pageSize);
	}

	@Override
	public float getInAmount(Integer id, String yesterday) {
		return merchantOrderDao.selectInAmountById(id,yesterday);
		}

	@Override
	public float getProductIncomeById(Integer id, String yesterday) {
		return productDao.queryProductIncomeById(id,yesterday);
	}

	@Override
	public List<ProductTradeEntity> getInMoneys(String beginTime, String endTime) {
		return productDao.queryInMoneys(beginTime, endTime);
	}

	@Override
	public List<ProductTradeEntity> getOutMoneys(Integer type,
			String beginTime, String endTime) {
		return productDao.queryOutMoneys(type, beginTime, endTime);
	}

	@Override
	public List<ProductTradeEntity> getInTotals(String beginTime, String endTime) {
		return productDao.queryInTotals(beginTime, endTime);
	}

	@Override
	public List<ProductTradeEntity> getOutTotals(Integer type,
			String beginTime, String endTime) {
		return productDao.queryOutTotals(type, beginTime, endTime);
	}

	@Override
	public List<ProductTradeEntity> getInPeoples(String beginTime,
			String endTime) {
		return productDao.queryInPeoples(beginTime, endTime);
	}

	@Override
	public List<ProductTradeEntity> getOutPeoples(Integer type,
			String beginTime, String endTime) {
		return productDao.queryOutPeoples(type, beginTime, endTime);
	}

	@Override
	public List<Long> countAllCustomerInSometime(String systemDate) {
		List<Map<String, Object>> results = userDao.countAllCustomerInSometime(systemDate);
		return getRealData(systemDate, results);
	}
	@Override
	public List<Long> countAllInSometime(String systemDate) {
		List<Map<String, Object>> results = userDao.countAllInSometime(systemDate);
		return getRealData(systemDate, results);
	}
	
	@Override
	public List<Long> countOrderInSometime(String systemDate) {
		List<Map<String, Object>> results = customerOrderDao.countOrderInSometime(systemDate);
		return getRealData(systemDate, results);
	}
	
	@Override
	public List<Long> sumOrderInSometime(String systemDate) {
		List<Map<String, Object>> results = customerOrderDao.sumOrderInSometime(systemDate);
		return getRealData(systemDate, results);
	}

	private List<Long> getRealData(String systemDate,List<Map<String, Object>> results) {
		List<Long> list = new ArrayList<Long>();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat timeFormat = new SimpleDateFormat("HH");
		int length = 24;
		if (StringUtils.equals(systemDate, dateFormat.format(Calendar.getInstance().getTime()))) {
			length = Integer.parseInt(timeFormat.format(Calendar.getInstance().getTime()));
			length++;
		} 
		
		Map<String, Long> keysMap = new HashMap<String, Long>();
		for (Map<String, Object> result : results) {
			String key = null;
			long value = 0;
			for (Map.Entry<String, Object> entry : result.entrySet()) {
				if (StringUtils.equals(ConstantUtil.TIME_POINT_KEY, entry.getKey())) {
					key = entry.getValue().toString();
				} else if (StringUtils.equals(ConstantUtil.VALUE_KEY, entry.getKey())) {
					Double object = Double.parseDouble((entry.getValue().toString()));
					value = object.longValue();
				}
            }
			keysMap.put(key, value);
		}
		
		String[] TIME_POINT=  ConstantUtil.TIME_POINT;
		for (int index = 0; index < length; index++) {
			String key = TIME_POINT[index];
			Set<String> keys = keysMap.keySet();
            if (keys.contains(key)) {
            	list.add(keysMap.get(key));
            } else {
            	list.add(0L);
            }
		}
		return list;
	}
	
	@Override
	public boolean saveLender(int productId, int[] lenderIds) {
		lenderDao.updateProductId(productId);
		return lenderDao.update(productId, lenderIds) > 0 ? true : false;
	}

    @Override
    public List<CustomerOrder> listCustomerOrder(int productId) {
        return customerOrderDao.queryByProductId(productId);
    }

    @Override
    public int countTrade(String beginTime, String endTime, String orderNO, Integer isPayback, Integer couponType, String systemTime, int customerId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("customerId", customerId);
        if(!StringUtils.isBlank(orderNO)){
            params.put("orderNO", orderNO);
        }
        if(isPayback != null && isPayback >= 0){
            params.put("isPayback", isPayback);
        }
        if(couponType != null && couponType >= 0){
            params.put("couponType", couponType);
        }
        if(!StringUtils.isBlank(systemTime)){
            params.put("systemTime", systemTime);
        }
        return customerOrderDao.queryTradeDetailCount(params);
    }

    @Override
    public List<CustomerOrder> listTrade(String beginTime, String endTime, String orderNO, Integer isPayback, Integer couponType, String systemTime, int customerId, int offset, int size) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("customerId", customerId);
        if(!StringUtils.isBlank(orderNO)){
            params.put("orderNO", orderNO);
        }
        if(isPayback != null && isPayback >= 0){
            params.put("isPayback", isPayback);
        }
        if(couponType != null && couponType >= 0){
            params.put("couponType", couponType);
        }
        if(!StringUtils.isBlank(systemTime)){
            params.put("systemTime", systemTime);
        }
        params.put("offset", offset);
        params.put("size", size);
        return customerOrderDao.queryTradeDetailList(params);
    }

    @Override
    public int countBalance(int type, int userId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("userId", userId);
        params.put("type", type);
        return customerBalanceLogDao.queryForUserCount(params);
    }

    @Override
    public List<CustomerBalanceLog> listBalance(int type, int userId, int offset, int size) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("userId", userId);
        params.put("type", type);
        params.put("offset", offset);
        params.put("size", size);
        return customerBalanceLogDao.queryForUserList(params);
    }

    @Override
    public int countFrozenOrder(int customerId, int isPayback) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("isPayback", isPayback);
        params.put("customerId", customerId);
        return customerOrderDao.queryForCount(params);
    }

    @Override
    public List<CustomerOrder> listFrozenOrder(int customerId, int isPayback, int offset, int size) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("customerId", customerId);
        params.put("isPayback", isPayback);
        params.put("offset", offset);
        params.put("size", size);
        return customerOrderDao.queryForList(params);
    }

	@Override
	public MerchantOrder getMerchantOrder(int productId, String systemDate, int type, int status) {
		return merchantOrderDao.selectByProductIdAntDate(productId, systemDate, type, status);
	}

	@Override
	public List<LoanEntity> listLoan(Integer productId) {
		return customerOrderDao.queryLoanList(productId);
	}

	@Override
	public List<Signature> getSignatureList(int productId) {
		return signatureDao.queryForList(productId);
	}

	@Override
	public List<EsignEntity> list(int productId) {
		ProductProtocol protocol = productProtocolDao.selectSignatureProtocolByProductId(productId);
		if (protocol == null) {
			return null;
		}
		List<EsignEntity> entities = customerOrderDao.queryOrderByProductId(productId);
		for (EsignEntity entity : entities) {
			entity.setProtoName(protocol.getName());
		}
		return entities;
	}
	
	@Override
	@LogRecord(module=LogRecord.Module.MERCHANTLOAN, operation=LogRecord.Operation.MERCHANTLOANPAYMENT, id="", name="商户${merchant.name}")
	public boolean saveOrderForMerchant(Product product, Merchant merchant, String orderNO, double orderMoney, double paymentAmount) {
		boolean result = false;
		if (product == null || merchant == null) {
			return result;
		}
		MerchantOrder order = merchantOrderDao.selectByProductIdAntDate(product.getId(), "", 1, 1);
		if (order != null) {
			return false;
		}
		MerchantOrder merchantOrder = this.saveMerchantOrder(product, merchant, orderNO,orderMoney, paymentAmount);
		LOGGER.info("merchant order id:"+ merchantOrder.getId());
		if(merchantOrder != null &&  merchantOrder.getId()>0){
			result = true; 
		}
		return result;
	}

	@Override
	public boolean save(List<Signature> signatures) {
		return signatureDao.insertInBatch(signatures) > 0 ? true : false;
	}
	
	private MerchantOrder saveMerchantOrder(Product product, Merchant merchant, String orderNO, double orderMoney, double paymentAmount) {
		MerchantOrder merchantOrder = new MerchantOrder();
		merchantOrder.setOrderNO(orderNO);
		merchantOrder.setPrincipal(orderMoney);
		merchantOrder.setType((short)TypeEnum.OUT.value());
		merchantOrder.setStatus((short)1);
		merchantOrder.setOrderTime(new Date());
		merchantOrder.setProduct(product);
		merchantOrder.setRepamentAmount(paymentAmount);
		merchantOrder.setLoanName(getLoanName(product, merchant));
		return saveMerchantOrder(merchantOrder);
	}
	
	private MerchantOrder saveMerchantOrder(MerchantOrder merchantOrder){
		if (merchantOrder.getId() >0) {
			return null;
		} else {
			return merchantOrderDao.insert(merchantOrder) > 0 ? merchantOrder : null;
		}
	}
	
	private String getLoanName(Product product, Merchant merchant){
		ProductDetail detail = getProductDetail(product.getId());
		if(detail != null && detail.getProject() != null && detail.getProject().getType() > -1){
			String loanName = null;
			int type = detail.getProject().getType();
			switch (type) {
			case 1 :
			case 2 :
				loanName = lenderDao.selectNameByProductId(product.getId());
				break;
			default:
				loanName = merchant.getName();
				break;
			}
			return loanName;
		}
		return null;
	}
	
	private ProductDetail getProductDetail(Integer id) {
		ProductDetail detail = productDetailDao.selectById(id);
		if (detail != null && detail.getProject() != null) {
    		if (StringUtils.isNotBlank(detail.getProject().getBuyBackAttachment())) {
    			List<Integer> attachmentIds = new ArrayList<Integer>();
    			String[] infos = StringUtils.split(detail.getProject().getBuyBackAttachment(), ConstantUtil.COMMA);
    			if (infos != null && infos.length > 0) {
    				for (String info : infos) {
    					if (StringUtils.isNotBlank(info)) {
    						attachmentIds.add(Integer.parseInt(StringUtils.trim(info)));
    					}
    				}
    				detail.getProject().setAttachments(attachmentDao.selectByIds(attachmentIds));
    			}
    		}
    		if (StringUtils.isNotBlank(detail.getProject().getGuaranteeAttachment())) {
    			List<Integer> attachmentIds = new ArrayList<Integer>();
    			String[] infos = StringUtils.split(detail.getProject().getGuaranteeAttachment(), ConstantUtil.COMMA);
    			if (infos != null && infos.length > 0) {
    				for (String info : infos) {
    					if (StringUtils.isNotBlank(info)) {
    						attachmentIds.add(Integer.parseInt(StringUtils.trim(info)));
    					}
    				}
    				detail.getProject().setGuaranteeAttachments(attachmentDao.selectByIds(attachmentIds));
    			}
    		}
    	}
		return detail;
	}
  //新加
	@Override
	public int countvipDetails(int customerId) {
		 Map<String, Object> params = new HashMap<String, Object>();
	        params.put("customerId", customerId);
	        return vipLevelChangeLogDao.queryForCount(params);
		
	}
//新加
	@Override
	public List<VipLevelChangeLog> listvipDetails(int customerId, int offset, int size) {
		 Map<String, Object> params = new HashMap<String, Object>();
	        params.put("customerId", customerId);
	        params.put("offset", offset);
	        params.put("size", size);
	        return vipLevelChangeLogDao.queryForList(params);
		
	}
}
