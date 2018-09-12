package com.silverfox.finance.service.impl;

import static com.silverfox.finance.util.ConstantUtil.CODE;
import static com.silverfox.finance.util.ConstantUtil.DOMAIN;
import static com.silverfox.finance.util.ConstantUtil.MSG;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
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

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.silverfox.finance.config.AplicationResourceProperties;
import com.silverfox.finance.domain.CellphoneLog;
import com.silverfox.finance.domain.Customer;
import com.silverfox.finance.domain.CustomerBank;
import com.silverfox.finance.domain.EBankLog;
import com.silverfox.finance.domain.Faq;
import com.silverfox.finance.domain.Feedback;
import com.silverfox.finance.domain.NewsBulletin;
import com.silverfox.finance.domain.PayBank;
import com.silverfox.finance.domain.PaymentOut;
import com.silverfox.finance.domain.SmsChannel;
import com.silverfox.finance.domain.User;
import com.silverfox.finance.entity.LostUserEntity;
import com.silverfox.finance.entity.PayBackEntity;
import com.silverfox.finance.entity.UninvestEntity;
import com.silverfox.finance.enumeration.GenericEnableEnum;
import com.silverfox.finance.enumeration.PayChannelEnum;
import com.silverfox.finance.orm.CellphoneLogDao;
import com.silverfox.finance.orm.CustomerCouponDao;
import com.silverfox.finance.orm.CustomerDao;
import com.silverfox.finance.orm.EBankLogDao;
import com.silverfox.finance.orm.FaqDao;
import com.silverfox.finance.orm.FeedbackDao;
import com.silverfox.finance.orm.NewsBulletinDao;
import com.silverfox.finance.orm.PayBankDao;
import com.silverfox.finance.orm.PaymentOutDao;
import com.silverfox.finance.orm.SmsChannelDao;
import com.silverfox.finance.orm.UserDao;
import com.silverfox.finance.service.PostmarketingService;
import com.silverfox.finance.util.ConstantUtil;
import com.silverfox.finance.util.LogRecord;
import com.silverfox.finance.util.ValidatorUtil;

import net.sf.json.xml.XMLSerializer;

public class PostmarketingServiceImpl implements PostmarketingService {
	private static final Log LOG = LogFactory.getLog(PostmarketingServiceImpl.class);
	private static final int COUNT = 20;
	@Autowired
	private FaqDao faqDao;
	@Autowired
	private NewsBulletinDao newsBulletinDao;
	@Autowired
	private FeedbackDao feedbackDao;
	@Autowired
	private PayBankDao payBankDao;
    @Autowired
    private EBankLogDao ebankLogDao;
    @Autowired
    private CustomerDao customerDao;
    @Autowired
    private PaymentOutDao paymentOutDao;
    @Autowired
    private CellphoneLogDao cellphoneLogDao;
	@Autowired
	private SmsChannelDao smsChannelDao;
	@Autowired
	private AplicationResourceProperties properties;
	@Autowired
	private UserDao userDao;
	@Autowired
	private CustomerCouponDao customerCoponDao;

	private Map<String, Object> getParams(String contact, String content, String beginTime, String endTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(contact)) {
			params.put("contact", contact);
		}
		if(StringUtils.isNotBlank(content)) {
			params.put("content", content);
		}
		if(StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(endTime)) {
			params.put("beginTime", beginTime);
			params.put("endTime", endTime);
		}
		return params;
	}

	@Override
	public List<Feedback> listFeedback(String contact, String content, String beginTime, String endTime, int offset,
			int size) {
		
		Map<String, Object> params = this.getParams(contact, content, beginTime, endTime);
		params.put("offset", offset);
		params.put("size", size);
		return feedbackDao.queryForList(params);
	}

	@Override
	public List<PayBank> getBankList(PayChannelEnum channelEnum, int enable) {
		return payBankDao.selectBank(channelEnum.value(), enable);
	
	}

	@Override
	public PayBank get(int id) {
		
		return payBankDao.selectById(id);
	}

	@Override
	public boolean savePayBank(PayBank payBank) {
	
		if (payBank != null) {
			if (payBank.getId() > 0) {
				return payBankDao.update(payBank) > 0 ? true : false;
			} else {
				return payBankDao.insert(payBank) > 0 ? true : false;
			}
		}
		return false;
	}

	@Override
	public boolean enable(int id, int enable) {
		return payBankDao.enable(id, enable) > 0 ? true : false;
		
	}

	@Override
	public List<Faq> listFaq() {
		
		return faqDao.queryForList();
	}

	@Override
	@LogRecord(module=LogRecord.Module.FAQ, operation=LogRecord.Operation.FAQSAVE, id="", name="${faq.ask}")
	public boolean saveFaq(Faq faq) {
		
		boolean checkedReslut = checkedParam(faq);
		if(checkedReslut){
			if(faq != null){
				if(faq.getId() > 0){
					return faqDao.update(faq) > 0 ? true : false;
				}else{
					return faqDao.insert(faq) > 0 ? true : false;
				}
			}
		}else{
			return false;
		}
		
		return false;
	}
	private boolean checkedParam(Faq faq){
		if(faq != null){
			if(!ValidatorUtil.StrNotNullAndMinAndMax(faq.getAsk(), 3, 20)){
				return false;
			}
			if(!ValidatorUtil.StrNotNullAndMinAndMax(faq.getQuestion(), 1, 500)){
				return false;
			}
			return true;
		}else{
			return false;
		}
	}

	@Override
	public boolean duplicateName(int id, String name) {
		
		return faqDao.checkName(id,name) > 0  ? false : true;
	}

	@Override
	public Faq getFaq(int id) {
		return faqDao.selectById(id);
	}

	@Override
	@LogRecord(module=LogRecord.Module.FAQ, operation=LogRecord.Operation.REMOVE, id="${id}", name="")
	public boolean deleteFaq(int id) {
		return faqDao.delete(id) > 0 ? true : false;
	}

	@Override
	@LogRecord(module=LogRecord.Module.FAQ, operation=LogRecord.Operation.FAQENABLE, id="", name="${faq.ask}")
	public boolean saveFaqs(Faq faq) {
		
		boolean checkedReslut = checkedParam(faq);
		if(checkedReslut){
			if(faq != null){
				if(faq.getId() > 0){
					return faqDao.update(faq) > 0 ? true : false;
				}else{
					return faqDao.insert(faq) > 0 ? true : false;
				}
			}
		}else{
			return false;
		}
		
		return false;
	}


	@Override
	public boolean changeFaqSort(List<Faq> faqs) {
		if(faqs.size() <= COUNT){
			return faqDao.updateSort(faqs);
		}
		List<Faq> firstList=new ArrayList<Faq>();
		List<Faq> LastList=new ArrayList<Faq>();
		for(int i = 0; i < faqs.size();i++){
			if(i < COUNT){
				firstList.add(faqs.get(i));
			}else{
				LastList.add(faqs.get(i));
			}
        }
		faqDao.updateSort(firstList);
		return faqDao.updateSort(LastList);
	}

	/*@Override
	public boolean changeNewsBulletinSort(List<NewsBulletin> notices) {
		
		return newsBulletinDao.updateSort(notices);
	}	
	}
*/
	@Override
	public int countCellphone(String oldCellphone) {
		Map<String, Object> params =  new HashMap<String, Object>();
		if(StringUtils.isNotBlank(oldCellphone)) {
			params.put("oldCellphone", oldCellphone);
		}
		return cellphoneLogDao.queryForCount(params);
	}

	@Override
	public List<CellphoneLog> listCellphoneLog(String oldCellphone, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(oldCellphone)) {
			params.put("oldCellphone", oldCellphone);
		}
		params.put("offset", offset);
		params.put("size", size);
		return cellphoneLogDao.queryForList(params);
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
	public List<NewsBulletin> listNewsBulletin(String title, int type, int status, int offset, int size) {
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
	@LogRecord(module=LogRecord.Module.NEWS_BULLETIN, operation=LogRecord.Operation.NEWS_BULLETIN_SAVE, id="", name="${newsBulletin.news.title}")
	public boolean saveNewsBulletin(NewsBulletin newsBulletin) {
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

	@Override
	public NewsBulletin getNewsBulletin(int id) {
		return newsBulletinDao.selectById(id);
	}

	@Override
	@LogRecord(module=LogRecord.Module.NEWS_BULLETIN, operation=LogRecord.Operation.REMOVE, id="${id}", name="")
	public boolean deleteNewsBulletin(int id) {
		return newsBulletinDao.delete(id) > 0 ? true : false;
	}

	@Override
	@LogRecord(module=LogRecord.Module.NEWS_BULLETIN, operation=LogRecord.Operation.NEWSBULLETINOPERATION, id="", name="${newsBulletin.news.title}")
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

	@Override
	public boolean changeNewsBulletinSort(List<NewsBulletin> notices) {
		return newsBulletinDao.updateSort(notices);
	}

	@Override
	public int countFeedback(String contact, String content, String beginTime, String endTime) {
		
		Map<String, Object> params = this.getParams(contact, content, beginTime, endTime);
		return feedbackDao.queryForCount(params);
	}

	@Override
	public List<EBankLog> listEBankLog(int offset, int size) {
	    
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("size", size);
		return ebankLogDao.queryForList(params);
	}

	@Override
	public int countEBankLog() {
		return ebankLogDao.queryForCount();
	}

	@Override
	public EBankLog getEBankLog(int ebankLogId) {
		return ebankLogDao.selectById(ebankLogId);
	}

	@Override
	@LogRecord(module=LogRecord.Module.CELLPHONE_LOG, operation=LogRecord.Operation.AUDIT_STATUS, id="${id}", name="")	
	public boolean audit(int id, int result, String remark) {
		boolean flag = false;
		EBankLog log = ebankLogDao.selectById(id);
		if (log != null && log.getNewBank() != null && log.getOldBank() != null && log.getOldBank().getCustomer() != null) {
			flag = ebankLogDao.audit(id, result, remark) > 0 ? true : false; 
			if (result != 1) {
				return flag;
			}
			if (!flag) {
				return flag;
			}
			CustomerBank oldwBank = customerDao.selectById(log.getOldBank().getId());
			if (oldwBank == null) {
				return false;
			}
			oldwBank.setStatus(1);
			flag = customerDao.updateBank(oldwBank) > 0 ? true : false;
			if (!flag) {
				return false;
			}
			CustomerBank newBank = customerDao.selectById(log.getNewBank().getId());
			if (newBank == null) {
				return false;
			}
			newBank.setStatus(3);
			flag = customerDao.updateBank(newBank) > 0 ? true : false;
			if (!flag) {
				return false;
			}
			List<PaymentOut> paymentOuts = paymentOutDao.selectEBankMsg(log.getOldBank().getCustomer().getId());
			if (paymentOuts != null && paymentOuts.size() > 0) {
				for (PaymentOut paymentOut : paymentOuts) {
					if (paymentOut != null && StringUtils.isNotBlank(paymentOut.getPayDetail())) {
						PayBackEntity payfor = JSONObject.parseObject(paymentOut.getPayDetail(), PayBackEntity.class);
						payfor.setBankCard(newBank.getCardNO());
						payfor.setBankName(newBank.getBankName());
						payfor.setBankCode(newBank.getBankNO());
						paymentOut.setPayDetail(JSONObject.toJSONString(payfor));
						paymentOut.setSign(DigestUtils.md5Hex(DOMAIN + JSONObject.toJSONString(payfor)));
					}
					if (paymentOut.getCreateTime() == null) {
						paymentOut.setCreateTime(Calendar.getInstance().getTime());
					}
					flag = flag && paymentOutDao.insert(paymentOut) > 0 ? true : false;
				}
			}
		}
		return flag;
	}

	@Override
	public boolean duplicate(int id, String name) {
		return payBankDao.duplicate(id, name) < 1 ? true : false;
	}

	@Override
	public JSONObject send(String text, String mobile, String encoding) {
		JSONObject result = new JSONObject();
		if(StringUtils.isNotBlank(text) && StringUtils.isNotBlank(mobile)) {
			String response = handleSMS(text, mobile, encoding); 
			if(StringUtils.isNotBlank(response)) {
				result = JSON.parseObject(response);
				if(result.containsKey(CODE) &&  result.getIntValue(CODE) == 0) {
					result.put(CODE, 201);
				} else {
					LOG.error("send sms[" + text + "] to " + mobile + " failure.");
				}
			} else {
				result.put(CODE, 404);
				result.put(MSG, "sms uri sayen,huaxing,monternet not available.");
			}
		} else {
			result.put(CODE, 406);
			result.put(MSG, "not acceptable.");
		}
		return result;
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

	@Override
	public CellphoneLog getCellphoneLog(int id) {

         return cellphoneLogDao.selectById(id);
	}

	@Override
	public User getByCellphone(String cellphone) {

         return userDao.selectByCellphone(cellphone);
	}

	@Override
	public boolean audit(int id, short status) {
		CellphoneLog cellphoneLog = cellphoneLogDao.selectById(id);
		if(cellphoneLog != null && status == 1){
			if(cellphoneLog == null || StringUtils.isBlank(cellphoneLog.getOldCellphone()) || StringUtils.isBlank(cellphoneLog.getNewCellphone())){
				return false;
			}
			User user = userDao.selectByCellphone(cellphoneLog.getOldCellphone());
			if(user == null || user.getId() <= 0){
				return false;
			}
			if(StringUtils.isBlank(user.getAccountId())){
				user.setCellphone(cellphoneLog.getNewCellphone());
				boolean updateUser = userDao.update(user) > 0 ? true : false;
				if(!updateUser){
					return false;
				}
				userDao.updateInviteCellphone(cellphoneLog.getNewCellphone(), cellphoneLog.getOldCellphone());
				/*goodsDao.updateCellone(cellphoneLog.getNewCellphone(), cellphoneLog.getOldCellphone());*/
				customerCoponDao.updateInviteCouponCellphone(cellphoneLog.getNewCellphone(), cellphoneLog.getOldCellphone());
				customerCoponDao.updateInviteCouponLogCellphone(cellphoneLog.getNewCellphone(), cellphoneLog.getOldCellphone());
				Customer customer = customerDao.selectByUserId(user.getId());
				if(customer != null){
					customer.setCellphone(cellphoneLog.getNewCellphone());
					customerDao.update(customer);
				}
				cellphoneLog.setStatus((short) 3);
			}else{
				cellphoneLog.setStatus(status);
			}
			return cellphoneLogDao.update(cellphoneLog) > 0 ? true : false;
		}else{
			cellphoneLog = new CellphoneLog();
			cellphoneLog.setId(id);
			cellphoneLog.setStatus(status);
			return cellphoneLogDao.update(cellphoneLog) > 0 ? true : false;
		}	
	}

	@Override
	public int countUninvestlist(String userName, String cellphone, String startTime, String endTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(userName)) {
			params.put("userName", userName);
		}
		if(StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		if(StringUtils.isNotBlank(startTime)&&StringUtils.isNotBlank(endTime)) {
			params.put("startTime", startTime);
			params.put("endTime", endTime);
		}
		return customerDao.queryForUninvestCount(params);
	}
	
	@Override
	public int countlostcustomers(String userName, String cellphone, String startTime, String endTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(userName)) {
			params.put("userName", userName);
		}
		if(StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		if(StringUtils.isNotBlank(startTime)&&StringUtils.isNotBlank(endTime)) {
			params.put("startTime", startTime);
			params.put("endTime", endTime);
		}
		return customerDao.queryForLostcustomerCount(params);
	}

	@Override
	public List<UninvestEntity> uninvestList(String userName, String cellphone, String startTime, String endTime,int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(userName)) {
			params.put("userName", userName);
		}
		if(StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		if(StringUtils.isNotBlank(startTime)&&StringUtils.isNotBlank(endTime)) {
			params.put("startTime", startTime);
			params.put("endTime", endTime);
		}
        params.put("offset", offset);
        params.put("size", size);
		return customerDao.queryUninvestList(params);
	}

	@Override
	public List<LostUserEntity> lostcustomerList(String userName, String cellphone, String startTime, String endTime,int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(userName)) {
			params.put("userName", userName);
		}
		if(StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		if(StringUtils.isNotBlank(startTime)&&StringUtils.isNotBlank(endTime)) {
			params.put("startTime", startTime);
			params.put("endTime", endTime);
		}
        params.put("offset", offset);
        params.put("size", size);
		return customerDao.queryLostcustomers(params);
	}

	
}
