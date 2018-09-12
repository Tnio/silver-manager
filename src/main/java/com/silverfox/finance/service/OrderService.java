package com.silverfox.finance.service;

import java.util.List;
import java.util.Map;

import com.silverfox.finance.domain.AbnormalOrder;
import com.silverfox.finance.domain.Channel;
import com.silverfox.finance.domain.ChannelOrder;
import com.silverfox.finance.domain.CustomerBalanceLog;
import com.silverfox.finance.domain.CustomerOrder;
import com.silverfox.finance.domain.MerchantOrder;

public interface OrderService {

	Map<String, Object> getOrderInfo(String productName, String name, String phone, int channelId, String orderNO, String payType, int orderType, String beginTime, String endTime, int amountFrom, int amountTo);
	List<CustomerOrder> list(String productName, String name, String phone, int channelId, String orderNO, String payType, int orderType, String beginTime, String endTime, int amountFrom, int amountTo, int offset, int size);
	int count(int type, int mothed, String userName, String cellphone, String startDate, String endDate);
	List<CustomerBalanceLog> list(int type, int method, String userName, String cellphone, String startDate, String endDate, int offset, int size);
	List<Map<String, Object>> sum(int type, int method, String userName, String cellphone, String startDate, String endDate);
	int count(Integer type, Integer loanType, String orderNO, String fromDate, String toDate, String trimToEmpty,String trimToEmpty2);
	List<MerchantOrder> list(Integer type, Integer loanType, String orderNO, String fromDate, String toDate,String trimToEmpty, String trimToEmpty2, int offset, int pageSize);
	double sum(Integer type, Integer loanType, String orderNO, String fromDate, String toDate, String trimToEmpty,String trimToEmpty2);
	List<String> getLoanNames();
	public List<Channel> listForUsed();
	int count(String requestNO, String cellphone, int channelID);
	List<ChannelOrder> list(String requestNO, String cellphone, int channelID, int offset, int size);
	public int count(int type, int orderStatus, String productName, String name, String phone, int channelId, String orderNO, int payType, int moneyFrom, int moneyTo, String beginTime, String endTime);
	public List<AbnormalOrder> list(int type, int orderStauts, String productName, String name, String phone, int channelId, String orderNO, int payType, int moneyFrom, int moneyTo, String beginTime, String endTime, int offset, int size);
	public int sum(int type, int orderStatus, String productName, String name, String phone, int channelId, String orderNO, int payType, int moneyFrom, int moneyTo, String beginTime, String endTime);

}
