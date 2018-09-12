package com.silverfox.finance.service.impl;

import static com.silverfox.finance.util.ConstantUtil.COMMA;
import static com.silverfox.finance.util.ConstantUtil.NORMAL_DATETIME_FORMAT;
import static com.silverfox.finance.util.ConstantUtil.PUSH_MSG_ASSOCIATE_NEWS;
import static com.silverfox.finance.util.ConstantUtil.PUSH_MSG_ASSOCIATE_PRODUCT;
import static com.silverfox.finance.util.ConstantUtil.PUSH_MSG_CONTENT;
import static com.silverfox.finance.util.ConstantUtil.PUSH_MSG_EQUIPMENTS;
import static com.silverfox.finance.util.ConstantUtil.PUSH_MSG_SEND_TARGET;
import static com.silverfox.finance.util.ConstantUtil.PUSH_MSG_SEND_TIME;
import static com.silverfox.finance.util.ConstantUtil.PUSH_MSG_SEND_TYPE;
import static com.silverfox.finance.util.ConstantUtil.PUSH_MSG_TITLE;
import static com.silverfox.finance.util.ConstantUtil.PUSH_OS_TYPE;
import static com.silverfox.finance.util.ConstantUtil.UTF_8;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.silverfox.finance.domain.Bonus;
import com.silverfox.finance.domain.BonusStrategy;
import com.silverfox.finance.domain.NewsBulletin;
import com.silverfox.finance.domain.NewsMaterial;
import com.silverfox.finance.domain.Product;
import com.silverfox.finance.domain.ProductContract;
import com.silverfox.finance.domain.ProductDetail;
import com.silverfox.finance.domain.PushMessage;
import com.silverfox.finance.domain.SmsTemplate;
import com.silverfox.finance.enumeration.NewsTypeEnum;
import com.silverfox.finance.orm.AttachmentDao;
import com.silverfox.finance.orm.BonusStrategyDao;
import com.silverfox.finance.orm.NewsBulletinDao;
import com.silverfox.finance.orm.NewsMaterialDao;
import com.silverfox.finance.orm.ProductContractDao;
import com.silverfox.finance.orm.ProductDao;
import com.silverfox.finance.orm.ProductDetailDao;
import com.silverfox.finance.orm.PushMessageDao;
import com.silverfox.finance.orm.SmsTemplateDao;
import com.silverfox.finance.service.MessageService;
import com.silverfox.finance.util.LogRecord;
import com.silverfox.finance.util.ValidatorUtil;


@Service
public class MessageServiceImpl implements MessageService {
	private static final Log LOG = LogFactory.getLog(MessageServiceImpl.class);
 
	@Autowired
	private PushMessageDao pushMessageDao;
	@Autowired
	private NewsMaterialDao  newsMaterialDao;
	@Autowired
	private SmsTemplateDao smsTemplateDao;
	@Autowired
	private NewsBulletinDao newsBulletinDao;
	@Autowired
	private ProductDao productDao;
	@Autowired
	private AttachmentDao attachmentDao;
	@Autowired
	private ProductDetailDao productDetailDao;
	@Autowired
	private ProductContractDao productContractDao;
	@Autowired
	private BonusStrategyDao bonusStrategyDao;
	

	@Override
	@LogRecord(module=LogRecord.Module.PUSHMESSAGE, operation=LogRecord.Operation.PUSHMESSAGESAVE, id="", name="${pushMessage.title}")
	public boolean savePushMessage(PushMessage pushMessage) {
		boolean result = false;
		boolean checkResult = checkedParam(pushMessage);
		if (checkResult) {
			if (pushMessage.getId() == 0) {
				result = pushMessageDao.insert(pushMessage) > 0 ? true : false;
			} else {
				result = pushMessageDao.update(pushMessage) > 0 ? true : false;
			}
		}else{
			return result;
		}
		return result;
	}

	@Override
	@LogRecord(module=LogRecord.Module.PUSHMESSAGE, operation=LogRecord.Operation.AUDIT, id="${id}", name="")
	public boolean auditPushMessage(int id) {
		return pushMessageDao.updateStatus(id) > 0 ? true : false;
	}

	@Override
	@LogRecord(module=LogRecord.Module.PUSHMESSAGE, operation=LogRecord.Operation.PUSHMESSAGE, id="", name="${pushMessage.title}")
	public void pushMessage(String uri, PushMessage pushMessage) {
		final String successCode = "request is : 200";
		String result = execute(uri, pushMessage.getOsType(), pushMessage.getSendTarget(),
					pushMessage.getTitle(), pushMessage.getSendType(), pushMessage.getSendTime()!= null ? pushMessage.getSendTime() : null, pushMessage.getContent(), 
					pushMessage.getProductId(), pushMessage.getNewsId(), pushMessage.getEquipment(), UTF_8);
	    LOG.info("the push result is : " + result);
	    //failure => requestId: 3444180330, errorCode: 40003, errorMessage: iOS Bad Device Token
	    //success => msgId: 5108373882505596300, sendTime: 1443575479
	   //watetime=> request is : 200
	   if(result ==null){
		   pushMessage.setStatus((short)4);
		   if (checkedParam(pushMessage)) {
			   if (pushMessage.getId() == 0) {
				  pushMessageDao.insert(pushMessage);
		       } else {
				  pushMessageDao.update(pushMessage);
		       }
		   }
		   return;
	   }
	   String[] arr = StringUtils.split(result, COMMA);
	   if((arr != null && arr.length == 2) || successCode.equals(result)){
		    pushMessage.setStatus((short)3);
	   } else {
		    pushMessage.setStatus((short)4); //push message fail
	   }
	   if (checkedParam(pushMessage)) {
		   if (pushMessage.getId() == 0) {
			  pushMessageDao.insert(pushMessage);
	       } else {
			  pushMessageDao.update(pushMessage);
	       }
	   }
	}
	
	
	@Override
	@LogRecord(module=LogRecord.Module.NEWS, operation=LogRecord.Operation.NEWSSAVE, id="", name="${news.title}")
	public boolean saveNews(NewsMaterial news) {
		if (news.getId() != null && news.getId() > 0) {
			if (news.getType() == NewsTypeEnum.INNER.value()) {
				news.setLink(StringUtils.EMPTY);
			}
			if (news.getType() == NewsTypeEnum.OUTER.value()) {
				news.setContent(StringUtils.EMPTY);
			}
			return newsMaterialDao.update(news) > 0 ? true : false;
		} else {
			return newsMaterialDao.insert(news) > 0 ? true : false;
		}
	}
	@Override
	@LogRecord(module=LogRecord.Module.NEWS, operation=LogRecord.Operation.REMOVE, id="${id}", name="")
	public boolean removeNews(int id) {
		return newsMaterialDao.delete(id) > 0 ? true : false;
	}



	@Override
	public List<SmsTemplate> listSmsTemplate(int status, int offset, int pageSize) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("size", pageSize);
		params.put("status", status);
		return smsTemplateDao.queryForList(params);
	}

	@Override
	public int count(int status) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("status", status);
		return smsTemplateDao.queryForCount(params);
	}
	
	@Override
	public SmsTemplate get(int smsTemplateId) {
		return smsTemplateDao.selectById(smsTemplateId);
	}
	
	@Override
	@LogRecord(module=LogRecord.Module.SMSTEMPLATE, operation=LogRecord.Operation.ENABLE, id="${id}", name="")
	public boolean auditSmsTemplate(Integer id, Short status) {
		SmsTemplate smsTemplate = new SmsTemplate();
		smsTemplate.setId(id);
		smsTemplate.setStatus(status);
		return smsTemplateDao.update(smsTemplate) > 0 ? true : false;
	}

	@Override
	@LogRecord(module=LogRecord.Module.SMSTEMPLATE, operation=LogRecord.Operation.SMSTEMPLATESAVE, id="", name="${smsTemplate.content}")
	public boolean save(SmsTemplate smsTemplate) {
		return smsTemplateDao.insert(smsTemplate) > 0 ? true : false;
	}
	
	private String execute(String uri, int osType, int sendTarget, String title, int sentType, Date sendTime, String content, int productId, int newsId, String equipments, String encoding) {
		CloseableHttpClient closeableHttpClient = HttpClients.createDefault();
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair(PUSH_OS_TYPE, String.valueOf(osType)));
		nvps.add(new BasicNameValuePair(PUSH_MSG_TITLE, title));
		nvps.add(new BasicNameValuePair(PUSH_MSG_SEND_TYPE, String.valueOf(sentType)));
		if(sendTime != null){
			nvps.add(new BasicNameValuePair(PUSH_MSG_SEND_TIME, new SimpleDateFormat(NORMAL_DATETIME_FORMAT).format(sendTime)));
		}else{
			nvps.add(new BasicNameValuePair(PUSH_MSG_SEND_TIME, null));
		}
		nvps.add(new BasicNameValuePair(PUSH_MSG_CONTENT, content));
		nvps.add(new BasicNameValuePair(PUSH_MSG_ASSOCIATE_PRODUCT, String.valueOf(productId)));
		nvps.add(new BasicNameValuePair(PUSH_MSG_ASSOCIATE_NEWS, String.valueOf(newsId)));
		nvps.add(new BasicNameValuePair(PUSH_MSG_SEND_TARGET, String.valueOf(sendTarget)));
		nvps.add(new BasicNameValuePair(PUSH_MSG_EQUIPMENTS, equipments));
		
		HttpPost httpPost = new HttpPost(uri);
		try {
			if(nvps != null && nvps.size() > 0) {
				httpPost.setEntity(new UrlEncodedFormEntity(nvps, encoding));
			}
			CloseableHttpResponse httpResponse = closeableHttpClient.execute(httpPost);
			int statusCode = httpResponse.getStatusLine().getStatusCode();
			if(statusCode == 200) {
				return EntityUtils.toString(httpResponse.getEntity(), encoding);
			} else {
				return EntityUtils.toString(httpResponse.getEntity(), encoding);
			}
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		} finally {
			httpPost.releaseConnection();
		}
		return null;
	}

	@Override
	@LogRecord(module=LogRecord.Module.APPMESSAGE, operation=LogRecord.Operation.EDIT, id="${newsBulletin.news.id}", name="")
	public void saveNewsBulletin(NewsBulletin newsBulletin) {
		
		if(newsBulletin != null){
			if(newsBulletin.getId() > 0){
				newsBulletinDao.update(newsBulletin);
			}else{
				newsBulletin.setCreateTime(Calendar.getInstance().getTime());
				newsBulletinDao.insert(newsBulletin);
			}
		}
		
	}

	@Override
	@LogRecord(module=LogRecord.Module.APPMESSAGE, operation=LogRecord.Operation.AUDIT, id="${newsBulletin.news.id}", name="")
	public boolean saveNewsBulletins(NewsBulletin newsBulletin) {
		if(newsBulletin != null){
			if(newsBulletin.getId() > 0){
				return newsBulletinDao.update(newsBulletin) > 0 ? true : false;
			}else{
				newsBulletin.setCreateTime(Calendar.getInstance().getTime());
				return newsBulletinDao.insert(newsBulletin) > 0 ? true : false;
			}
		}
		return false;
	
	}


	private Map<String, Object> getParams(String beginTime, String endTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(endTime)) {
			params.put("beginTime", beginTime);
			params.put("endTime", endTime);
		}
		return params;
	}
	private boolean checkedParam(PushMessage pushMessage){
		if(pushMessage != null){
			if(!ValidatorUtil.StrNotNull(pushMessage.getTitle())){
				return false;
			}
			if(!ValidatorUtil.StrNotNull(pushMessage.getContent())){
				return false;
			}
			if(!(pushMessage.getOsType() >= 0)){
				return false;
			}
			if(!(pushMessage.getSendType() >= 0)){
				return false;
			}
			if(!(pushMessage.getSendTarget() >= 0)){
				return false;
			}
			return true;
		}else{
			return false;
		}
	}

	@Override
	public Object listNews(int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("size", size);
		return newsMaterialDao.queryForList(params);
	}

	@Override
	public int countNews() {
		return newsMaterialDao.queryForCount();
	}

	@Override
	public NewsMaterial getNews(int id) {
		return newsMaterialDao.selectById(id);
	}

	@Override
	public PushMessage getPushMessage(int id) {
		return pushMessageDao.selectById(id);
	}

	@Override
	public int count(String beginTime, String endTime) {
		Map<String, Object> params = this.getParams(beginTime, endTime);
		return pushMessageDao.queryForCount(params);
		
	}

	@Override
	public List<PushMessage> list(String beginTime, String endTime, int offset,
			int pageSize) {
	      Map<String, Object> params = this.getParams(beginTime, endTime);
	      params.put("offset", offset);
	      params.put("size", pageSize);
	
		  return pushMessageDao.queryForList(params);
	}


	@Override
	public Product getProductById(int id) {
		Product product = productDao.selectById(id);
		if (product != null) {
			ProductDetail detail = productDetailDao.selectById(id);
			if (detail != null && detail.getProject() != null) {
	    		if (StringUtils.isNotBlank(detail.getProject().getBuyBackAttachment())) {
	    			List<Integer> attachmentIds = new ArrayList<Integer>();
	    			String[] infos = StringUtils.split(detail.getProject().getBuyBackAttachment(), COMMA);
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
	    			String[] infos = StringUtils.split(detail.getProject().getGuaranteeAttachment(), COMMA);
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
			ProductDetail productDetail=detail;
			
			
			if (productDetail != null) {
				if(productDetail.getContract() != null && productDetail.getContract().getId() > 0){
					ProductContract contract = productContractDao.selectById(productDetail.getContract().getId());
					if(contract != null){
						productDetail.setContract(contract);
					}
				}
				product.setProductDetail(productDetail);
			}
			
			if(product.getBonus() != null && product.getBonus().getId() > 0){
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("bonusId", product.getBonus().getId());
				List<BonusStrategy> bonusStrategy = bonusStrategyDao.queryForList(params);
				Bonus bonus = product.getBonus();
				bonus.setBonusStrategy(bonusStrategy);
				product.setBonus(bonus);
			}
		}
		return product;
		
	}

	@Override
	public NewsBulletin getNewsBulletinByid(int id) {
		return newsBulletinDao.selectById(id);
	}

	@Override
	public int countNewsBulletin(String title, int type, int status) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(title)) {
			params.put("title", title);
		}
		if(status >= 0){
			params.put("status", status);
		}
		if(type >= 0){
			params.put("type", type);
		}
		return newsBulletinDao.queryForCount(params);
	}

	@Override
	public List<NewsBulletin> listNewsBulletin(String title, int type,
			int status, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(title)) {
			params.put("title", title);
		}
		if(type >= 0){
			params.put("type", type);
		}
		if(status >= 0){
			params.put("status", status);
		}
		params.put("offset", offset);
		params.put("size", size);
		return newsBulletinDao.queryForList(params);
	}

	@Override
	public NewsBulletin getNewsBulletin(int id) {
		return newsBulletinDao.selectById(id);
	}

	@Override
	public boolean deleteNewsBulletin(int id) {
		return newsBulletinDao.delete(id) > 0 ? true : false;
	}

	@Override
	public boolean changeNewsBulletinSort(List<NewsBulletin> notices) {
		return newsBulletinDao.updateSort(notices);
	}

	@Override
	public SmsTemplate getSmsTemplate(int parseInt) {
		return smsTemplateDao.selectById(parseInt);
	}

	
	
}