package com.silverfox.finance.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.silverfox.finance.domain.AbnormalOrder;
import com.silverfox.finance.domain.Channel;
import com.silverfox.finance.domain.ChannelOrder;
import com.silverfox.finance.domain.CustomerBalanceLog;
import com.silverfox.finance.domain.CustomerOrder;
import com.silverfox.finance.domain.MerchantOrder;
import com.silverfox.finance.orm.AbnormalOrderDao;
import com.silverfox.finance.orm.ChannelDao;
import com.silverfox.finance.orm.ChannelOrderDao;
import com.silverfox.finance.orm.CustomerBalanceLogDao;
import com.silverfox.finance.orm.CustomerOrderDao;
import com.silverfox.finance.orm.MerchantOrderDao;
import com.silverfox.finance.service.OrderService;
import com.silverfox.finance.util.ConstantUtil;

@Service
public class OrderServiceImpl implements OrderService {
	@Autowired
	private CustomerOrderDao customerOrderDao;
	@Autowired
	private CustomerBalanceLogDao customerBalanceLogDao;
	@Autowired
	private MerchantOrderDao merchantOrderDao;
	@Autowired
	private ChannelDao channelDao;
	@Autowired
	private ChannelOrderDao channelOrderDao;
	@Autowired
	private AbnormalOrderDao abnormalOrderDao;
	
	@Override
	public Map<String, Object> getOrderInfo(String productName, String name, String phone, int channelId, String orderNO, String payType, int orderType, String beginTime, String endTime, int amountFrom, int amountTo) {
		Map<String, Object> params = this.getOrderParam(name, phone, orderNO, payType, beginTime, endTime);
		if (StringUtils.isNotBlank(productName)) {
			params.put("productName", productName);
		}
		params.put("channelId", channelId);
		params.put("orderType", orderType);
		params.put("amountFrom", amountFrom);
		params.put("amountTo", amountTo);
		return customerOrderDao.getOrderInfo(params);
	}
	
	private Map<String, Object> getOrderParam(String name, String account, String orderNO, String payType, String beginTime, String endTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		if (StringUtils.isNotBlank(payType)) {
			params.put("payType", payType);
		}
		if (StringUtils.isNotBlank(account)) {
			params.put("cellphone", account);
		}
		if (StringUtils.isNotBlank(orderNO)) {
			params.put("orderNO", orderNO);
		}
		if (StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(endTime)) {
			params.put("beginTime", beginTime);
			params.put("endTime", endTime);
		}
		return params;
	}
	
	@Override
	public List<CustomerOrder> list(String productName, String name, String phone, int channelId, String orderNO,
			String payType, int orderType, String beginTime, String endTime, int amountFrom, int amountTo, int offset,
			int size) {
		Map<String, Object> params = this.getOrderParam(name, phone, orderNO, payType, beginTime, endTime);
		params.put("channelId", channelId);
		params.put("orderType", orderType);
		params.put("amountFrom", amountFrom);
		params.put("amountTo", amountTo);
		if (StringUtils.isNotBlank(productName)) {
			params.put("productName", productName);
		}
		params.put("offset", offset);
		params.put("size", size);
		return customerOrderDao.queryForList(params);
	}
	
	@Override
	public int count(int type, int method, String userName, String cellphone, String startDate, String endDate) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		params.put("method", method);
		if (StringUtils.isNotBlank(userName)) {
			params.put("userName", userName);
		}
		if (StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		if (StringUtils.isNotBlank(startDate) && StringUtils.isNotBlank(endDate)) {
			params.put("startDate", startDate+ConstantUtil.MIN_TIME);
			params.put("endDate", endDate+ConstantUtil.MAX_TIME);
		}
		return customerBalanceLogDao.queryForCount(params);
	}
	
	@Override
	public List<CustomerBalanceLog> list(int type, int method, String userName, String cellphone, String startDate, String endDate, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		params.put("method", method);
		if (StringUtils.isNotBlank(userName)) {
			params.put("userName", userName);
		}
		if (StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		if (StringUtils.isNotBlank(startDate) && StringUtils.isNotBlank(endDate)) {
			params.put("startDate", startDate+ConstantUtil.MIN_TIME);
			params.put("endDate", endDate+ConstantUtil.MAX_TIME);
		}
		params.put("offset", offset);
		params.put("size", size);
		return customerBalanceLogDao.queryForList(params);
	}
	
	@Override
	public List<Map<String, Object>> sum(int type, int method, String userName, String cellphone, String startDate, String endDate) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		params.put("method", method);
		if (StringUtils.isNotBlank(userName)) {
			params.put("userName", userName);
		}
		if (StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		if (StringUtils.isNotBlank(startDate) && StringUtils.isNotBlank(endDate)) {
			params.put("startDate", startDate+ConstantUtil.MIN_TIME);
			params.put("endDate", endDate+ConstantUtil.MAX_TIME);
		}
		return customerBalanceLogDao.queryForSum(params);
	}
	
	@Override
	public int count(Integer type, Integer loanType, String orderNO, String fromDate, String toDate, String productName, String loanName) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		params.put("loanType", loanType);
		if (StringUtils.isNotBlank(orderNO)) {
			params.put("orderNO", orderNO);
		}
		if (StringUtils.isNotBlank(productName)) {
			params.put("productName", productName);
		}
		if (StringUtils.isNotBlank(loanName)) {
			params.put("loanName", loanName);
		}
		if (StringUtils.isNotBlank(fromDate) && StringUtils.isNotBlank(toDate)) {
			params.put("fromDate", fromDate);
			params.put("toDate", toDate);
		}
		return merchantOrderDao.queryOrderForCount(params);
	}

	@Override
	public List<MerchantOrder> list(Integer type, Integer loanType, String orderNO, String fromDate, String toDate, String productName, String loanName, int offset, int size){
			Map<String, Object> params = new HashMap<String, Object>();
	params.put("type", type);
	params.put("loanType", loanType);
	if (StringUtils.isNotBlank(orderNO)) {
		params.put("orderNO", orderNO);
	}
	if (StringUtils.isNotBlank(productName)) {
		params.put("productName", productName);
	}
	if (StringUtils.isNotBlank(loanName)) {
		params.put("loanName", loanName);
	}
	if (StringUtils.isNotBlank(fromDate) && StringUtils.isNotBlank(toDate)) {
		params.put("fromDate", fromDate);
		params.put("toDate", toDate);
	}
	params.put("offset", offset);
	params.put("size", size);
	return merchantOrderDao.queryOrderForList(params);
	}

	@Override
	public double sum(Integer type, Integer loanType, String orderNO, String fromDate, String toDate, String productName, String loanName) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		params.put("loanType", loanType);
		if (StringUtils.isNotBlank(orderNO)) {
			params.put("orderNO", orderNO);
		}
		if (StringUtils.isNotBlank(productName)) {
			params.put("productName", productName);
		}
		if (StringUtils.isNotBlank(loanName)) {
			params.put("loanName", loanName);
		}
		if (StringUtils.isNotBlank(fromDate) && StringUtils.isNotBlank(toDate)) {
			params.put("fromDate", fromDate);
			params.put("toDate", toDate);
		}
		Double amount = merchantOrderDao.countTotalAmountForOrder(params);
		return amount == null ? 0 : amount;
	}

	@Override
	public List<String> getLoanNames() {
		return merchantOrderDao.selectLoanNames();
	}
	@Override
	public List<Channel> listForUsed() {
		return channelDao.queryUsedForList();
	}
	@Override
	public int count(String requestNO, String cellphone, int channelID) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("cellphone", cellphone);
		params.put("channelID", channelID);
		params.put("requestNO", requestNO);
		return channelOrderDao.queryRequestNoForCount(params);
	}
	@Override
	public List<ChannelOrder> list(String requestNO, String cellphone,int channelID, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("requestNO", requestNO);
		params.put("cellphone", cellphone);
		params.put("channelID", channelID);
		params.put("offset", offset);
		params.put("size", size);
		return channelOrderDao.queryForList(params);
	}
	@Override
	public int count(int type, int orderStatus, String productName, String name, String phone, int channelId,
			String orderNO, int payType, int moneyFrom, int moneyTo, String beginTime, String endTime) {
		Map<String, Object> param = getOrderParam(productName, name, phone, channelId, orderNO, payType, beginTime, endTime);
		param.put("orderStatus", orderStatus);
		param.put("type", type);
		param.put("amountFrom", moneyFrom);
		param.put("amountTo", moneyTo);
		return abnormalOrderDao.queryForCount(param);
	}
	@Override
	public List<AbnormalOrder> list(int type, int orderStatus, String productName, String name, String phone, int channelId,
			String orderNO, int payType, int moneyFrom, int moneyTo, String beginTime, String endTime, int offset, int size) {
		Map<String, Object> param = getOrderParam(productName, name, phone, channelId, orderNO, payType, beginTime, endTime);
		param.put("orderStatus", orderStatus);
		param.put("type", type);
		param.put("amountFrom", moneyFrom);
		param.put("amountTo", moneyTo);
		param.put("offset", offset);
		param.put("size", size);
		return abnormalOrderDao.queryForOrderList(param);
	}
	@Override
	public int sum(int type, int orderStatus, String productName, String name, String phone, int channelId,
			String orderNO, int payType, int moneyFrom, int moneyTo, String beginTime, String endTime) {
		Map<String, Object> param = getOrderParam(productName, name, phone, channelId, orderNO, payType, beginTime, endTime);
		param.put("orderStatus", orderStatus);
		param.put("type", type);
		param.put("amountFrom", moneyFrom);
		param.put("amountTo", moneyTo);
		return abnormalOrderDao.queryForSum(param);
	}
	private Map<String, Object> getOrderParam(String productName, String name, String phone, int channelId,
			String orderNO, int payType, String beginTime, String endTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(productName)) {
			params.put("productName", productName);
		}
		if(StringUtils.isNotBlank(phone)) {
			params.put("cellphone", phone);
		}
		if(StringUtils.isNotBlank(orderNO)) {
			params.put("orderNO", orderNO.trim());
		}
		if(StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		params.put("channelId", channelId);
		params.put("payType", payType);
		if(StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(endTime)) {
			params.put("beginTime", beginTime);
			params.put("endTime", endTime);
		}
		return params;
	}
	
}
