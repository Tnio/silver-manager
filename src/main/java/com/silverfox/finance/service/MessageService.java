package com.silverfox.finance.service;

import java.util.List;

import com.silverfox.finance.domain.NewsBulletin;
import com.silverfox.finance.domain.NewsMaterial;
import com.silverfox.finance.domain.Product;
import com.silverfox.finance.domain.PushMessage;
import com.silverfox.finance.domain.SmsTemplate;

public interface MessageService {
	//public List<CustomerMessage> list(String account, int minute);
	/*public List<CustomerMessage> list(String account, int offset, int size);
	public int count(String account, int status);*/
	
	public boolean saveNews(NewsMaterial news);
	public boolean removeNews(int id);
	
	boolean savePushMessage(PushMessage pushMessage);
	boolean auditPushMessage(int id);
	public void pushMessage(String uri, PushMessage msg);

	public List<SmsTemplate> listSmsTemplate(int status, int offset, int pageSize);
	public int count(int status);
	public SmsTemplate get(int smsTemplateId);
	public boolean auditSmsTemplate(Integer id, Short status);
	public boolean save(SmsTemplate smsTemplate);
	public void saveNewsBulletin(NewsBulletin newsBulletin);
	public boolean saveNewsBulletins(NewsBulletin newsBulletin);
	
	
	public int count(String beginTime, String endTime);
	
	
	
	public PushMessage getPushMessage(int id);
	public NewsMaterial getNews(int id);
	
	
	public int countNews();
	public Object listNews(int offset, int size);
	
	
	public List<PushMessage> list(String beginTime, String endTime, int offset,
			int pageSize);
	public Product getProductById(int productId);
	public NewsBulletin getNewsBulletinByid(int id);
	public int countNewsBulletin(String title, int type, int status);
	public List<NewsBulletin> listNewsBulletin(String title, int type, int status, int offset, int size);
	public NewsBulletin getNewsBulletin(int id);
	public boolean deleteNewsBulletin(int id);
	public boolean changeNewsBulletinSort(List<NewsBulletin> notices);
	public SmsTemplate getSmsTemplate(int parseInt);
}