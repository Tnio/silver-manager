package com.silverfox.finance.service;

import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.silverfox.finance.domain.CellphoneLog;
import com.silverfox.finance.domain.EBankLog;
import com.silverfox.finance.domain.Faq;
import com.silverfox.finance.domain.Feedback;
import com.silverfox.finance.domain.NewsBulletin;
import com.silverfox.finance.domain.PayBank;
import com.silverfox.finance.domain.User;
import com.silverfox.finance.entity.LostUserEntity;
import com.silverfox.finance.entity.UninvestEntity;
import com.silverfox.finance.enumeration.PayChannelEnum;

public interface PostmarketingService {
	int countFeedback(String contact, String content, String beginTime, String endTime);
	
	List<Feedback> listFeedback(String contact, String content, String beginTime, String endTime, int offset, int size);
	
	List<PayBank> getBankList(PayChannelEnum channelEnum, int enable);
	PayBank get(int id);
	boolean savePayBank(PayBank payBank);
	boolean enable(int id, int enable);
	
	List<Faq> listFaq();
    boolean saveFaq(Faq faq);
	boolean duplicateName(int id, String name);
	Faq getFaq(int id);
	public boolean deleteFaq(int id);
	public boolean saveFaqs(Faq faq);
	public boolean changeFaqSort(List<Faq> faqs);
	int countCellphone(String oldCellphone);
	List<CellphoneLog> listCellphoneLog(String oldCellphone,int offset, int size);
	int countNewsBulletin(String title, int type, int status);
	List<NewsBulletin> listNewsBulletin(String title, int type, int status, int offset, int size);
    boolean saveNewsBulletin(NewsBulletin newsBulletin);
	NewsBulletin getNewsBulletin(int id);
	boolean deleteNewsBulletin(int id);
	boolean saveNewsBulletins(NewsBulletin notice);
	boolean changeNewsBulletinSort(List<NewsBulletin> notices);

	List<EBankLog> listEBankLog(int offset, int size);
    
	int countEBankLog();

	EBankLog getEBankLog(int ebankLogId);

    boolean audit(int id, int result, String remark);

    public boolean duplicate(int id, String name);
    JSONObject send(String text, String mobile, String encoding);

	CellphoneLog getCellphoneLog(int id);

	public User getByCellphone(String cellphone);

    boolean audit(int id,short status);

	int countUninvestlist(String userName, String cellphone, String startTime, String endTime);

	List<UninvestEntity> uninvestList(String userName, String cellphone, String startTime, String endTime, int offset, int pageSize);

	int countlostcustomers(String userName, String cellphone, String startTime, String endTime);

	List<LostUserEntity> lostcustomerList(String userName, String cellphone, String startTime, String endTime, int offset,int pageSize);
}