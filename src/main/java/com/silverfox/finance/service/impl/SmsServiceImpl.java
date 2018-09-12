//package com.silverfox.finance.service.impl;
//
//import com.alibaba.fastjson.JSON;
//import com.alibaba.fastjson.JSONObject;
//import com.silverfox.finance.domain.SmsChannel;
//import com.silverfox.finance.enumeration.GenericEnableEnum;
//import com.silverfox.finance.enumeration.SmsCategoryEnum;
//import com.silverfox.finance.service.SmsService;
//import net.sf.json.xml.XMLSerializer;
//import org.apache.commons.lang.StringUtils;
//import org.apache.commons.lang.math.RandomUtils;
//import org.apache.commons.logging.Log;
//import org.apache.commons.logging.LogFactory;
//import org.apache.http.NameValuePair;
//import org.apache.http.client.entity.UrlEncodedFormEntity;
//import org.apache.http.client.methods.CloseableHttpResponse;
//import org.apache.http.client.methods.HttpPost;
//import org.apache.http.impl.client.CloseableHttpClient;
//import org.apache.http.impl.client.HttpClients;
//import org.apache.http.message.BasicNameValuePair;
//import org.apache.http.util.EntityUtils;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.List;
//import java.util.concurrent.TimeUnit;
//import java.util.regex.Matcher;
//import java.util.regex.Pattern;
//
//import static com.silverfox.finance.util.ConstantUtil.*;
//import static com.silverfox.finance.util.ConstantUtil.EMAY_RESULT_KEY;
//import static com.silverfox.finance.util.ConstantUtil.SUCCEED_SMS_JSON;
//
//@Service
//public class SmsServiceImpl implements SmsService {
//    private static final Log LOG = LogFactory.getLog(SmsServiceImpl.class);
//    /*@Autowired
//    private RedisStringService redisStringService;
//    @Autowired
//    private RedisLockService redisLockService;*/
//    @Autowired
//    private ChannelService channelService;
//    @Autowired
//    private ZookeeperService zookeeperService;
//
//    @Override
//    public JSONObject send(String text, String mobile, String encoding) {
//        JSONObject result = new JSONObject();
//        if(StringUtils.isNotBlank(text) && StringUtils.isNotBlank(mobile)) {
//            String response = handleSMS(text, mobile, encoding);
//            if(StringUtils.isNotBlank(response)) {
//                result = JSON.parseObject(response);
//                if(result.containsKey(CODE) &&  result.getIntValue(CODE) == 0) {
//                    result.put(CODE, 201);
//                } else {
//                    LOG.error("send sms[" + text + "] to " + mobile + " failure.");
//                }
//            } else {
//                result.put(CODE, 404);
//                result.put(MSG, "sms uri sayen,huaxing,monternet not available.");
//            }
//        } else {
//            result.put(CODE, 406);
//            result.put(MSG, "not acceptable.");
//        }
//        return result;
//    }
//
//    @Override
//    public JSONObject send(String text, String mobile, String encoding, long timeout, TimeUnit unit) {
//        JSONObject result = new JSONObject();
//        if(!StringUtils.isNotBlank(text) && !StringUtils.isNotBlank(mobile)) {
//			/*String cacheCode = redisStringService.get(PREFIX_SMS+mobile);
//			if(StringUtils.isNotBlank(cacheCode)) {
//				result.put(CODE, 304);
//				result.put(MSG, "sms code not modified.");//sms code[" + cacheCode + "] not modified.
//			} else {*/
//            String response = handleSMS(text, mobile, encoding);
//            if(StringUtils.isNotBlank(response)) {
//                result = JSON.parseObject(response);
//                if(result.containsKey(CODE) &&  result.getIntValue(CODE) == 0) {
//                    result.put(CODE, 201);
//                } else {
//                    LOG.error("send sms[" + text + "] to " + mobile + " failure.");
//                }
//            } else {
//                result.put(CODE, 404);
//                result.put(MSG, "sms uri sayen,huaxing,monternet not available.");
//            }
//            //}
//        } else {
//            result.put(CODE, 406);
//            result.put(MSG, "not acceptable.");
//        }
//        return result;
//    }
//
//    @Override
//    public JSONObject send(String text, String mobile, int seed, String encoding, long timeout, TimeUnit unit) {
//        JSONObject result = new JSONObject();
//		/*String cacheCode = redisStringService.get(PREFIX_SMS+mobile);
//		if(StringUtils.isNotBlank(cacheCode)) {
//			result.put(CODE, 304);
//			result.put(MSG, "sms code not modified.");//sms code[" + cacheCode + "] not modified.
//		} else {*/
//        String code = this.getSmsCode(seed);
//        text = String.format(text, code);
//        String response = handleSMS(text, mobile, encoding);
//        if(StringUtils.isNotBlank(response)) {
//            result = JSON.parseObject(response);
//            if(result.containsKey(CODE) &&  result.getIntValue(CODE) == 0) {
//                //redisStringService.set(PREFIX_SMS+mobile, code, timeout, unit);
//                result.put(CODE, 201);
//            } else {
//                LOG.error("send sms[" + text + "] to " + mobile + " failure.");
//            }
//        } else {
//            result.put(CODE, 404);
//            result.put(MSG, "sms uri sayen,huaxing,monternet not available.");
//        }
//        //}
//        return result;
//    }
//
//    @Override
//    public JSONObject sendValidateCode(String text, String type, String mobile, int seed, String encoding, long timeout, TimeUnit unit) {
//        JSONObject result = new JSONObject();
//        if(!isAllowSend(mobile, type)){
//            result.put(CODE, 301);
//            result.put(MSG, "send sms must be 24 hours per time.");
//            return result;
//        }
//        String cache_key = SMS_DUPLICATE_SUBMIT+mobile;
//        //try {
//			/*redisLockService.lock(cache_key, mobile);
//			String cache = redisStringService.get(PREFIX_SMS_VALIDATE + CODE + type + mobile);
//			if(StringUtils.isNotBlank(cache)) {
//				result.put(CODE, 301);
//				result.put(MSG, "resend sms must be 1 minutes per time.");
//			} else {*/
//        //String cacheCode = redisStringService.get(PREFIX_SMS_VALIDATE + type + mobile);
//				/*if(StringUtils.isNotBlank(cacheCode)) {
//					result.put(CODE, 304);
//					result.put(MSG, "sms code not modified.");
//				} else {*/
//        String code = this.getSmsCode(seed);
//        text = String.format(text, code);
//        String response = handleSMS(text, mobile, encoding);
//        if(StringUtils.isNotBlank(response)) {
//            result = JSON.parseObject(response);
//            if(result.containsKey(CODE) &&  result.getIntValue(CODE) == 0) {
//                //	redisStringService.set(PREFIX_SMS_VALIDATE + CODE + type + mobile, mobile,SIXTY_SECONDS,TimeUnit.SECONDS);
//                //	redisStringService.set(PREFIX_SMS_VALIDATE + type + mobile, code, timeout, unit);
//                result.put(CODE, 201);
//            } else {
//                LOG.error("send sms[" + text + "] to " + mobile + " failure.");
//            }
//        } else {
//            result.put(CODE, 404);
//            result.put(MSG, "sms uri sayen,huaxing,monternet not available.");
//        }
//        //}
//		/*	}
//		}finally{
//			redisLockService.unlock(cache_key, mobile);
//		}*/
//
//        return result;
//    }
//
//    @Override
//    public JSONObject resendValidateCode(String text, String type, String mobile, int seed, String encoding, long timeout, TimeUnit unit) {
//        JSONObject result = new JSONObject();
//        if(!isAllowSend(mobile, type)){
//            result.put(CODE, 301);
//            result.put(MSG, "send sms must be  24 hours per time.");
//            return result;
//        }
//        String cache_key = SMS_DUPLICATE_SUBMIT+mobile;
//        try {
//			/*redisLockService.lock(cache_key, mobile);
//			String cache = redisStringService.get(PREFIX_SMS_VALIDATE + CODE + type + mobile);
//			if(StringUtils.isNotBlank(cache)) {
//				result.put(CODE, 301);
//				result.put(MSG, "resend sms must be  1 minutes per time.");
//			} else {*/
//            String code = this.getSmsCode(seed);
//            text = String.format(text, code);
//            String response = handleSMS(text, mobile, encoding);
//            if(StringUtils.isNotBlank(response)) {
//                result = JSON.parseObject(response);
//                if(result.containsKey(CODE) && result.getIntValue(CODE) == 0) {
//                    //redisStringService.set(PREFIX_SMS_VALIDATE + CODE + type + mobile,mobile,SIXTY_SECONDS,TimeUnit.SECONDS);
//                    //redisStringService.del(PREFIX_SMS_VALIDATE + type + mobile);
//                    //redisStringService.set(PREFIX_SMS_VALIDATE + type + mobile, code, timeout, unit);
//                    result.put(CODE, 201);
//                } else {
//                    LOG.error("resend sms[" + text + "] to " + mobile + " failure.");
//                }
//            } /* else {
//					result.put(CODE, 404);
//					result.put(MSG, "sms uri sayen,huaxing,monternet not available.");
//				}
//			}*/
//        }finally{
//            //redisLockService.unlock(cache_key, mobile);
//        }
//
//        return result;
//    }
//
//    @Override
//    public void smsOrderMessage(String text, String mobile) {
//        this.handleSMS(text, mobile, UTF_8);
//    }
//
//    @Override
//    public String smsPayback(String text, String mobile) {
//        return this.handleSMS(text, mobile, UTF_8);
//    }
//
//    private String handleSMS(String text, String mobile, String encoding){
//        String uri = zookeeperService.getConfigData("plugin.uri");
//        String sayenSuffix = zookeeperService.getConfigData("sayen.sms.send");
//        String huaxingSuffix = zookeeperService.getConfigData("huaxing.sms.send");
//        String monternetSuffix = zookeeperService.getConfigData("monternet.sms.send");
//        String emaySuffix = zookeeperService.getConfigData("emay.sms.send");
//
//        List<NameValuePair> nvps = new ArrayList<NameValuePair>();
//        nvps.add(new BasicNameValuePair(SAYEN_SMS_TEXT, text));
//        nvps.add(new BasicNameValuePair(SAYEN_SMS_MOBILE, mobile ));
//
//        List<SmsChannel> smsChannels = channelService.getByEnable((short) GenericEnableEnum.ENABLE.value());
//        if(smsChannels.size() > 0){
//            for(SmsChannel smsChannel : smsChannels){
//                if(smsChannel.getId() == 1){
//                    String sayenResult = this.execute(uri + sayenSuffix, nvps, encoding);
//                    try {
//                        if(StringUtils.isNotBlank(sayenResult) && sayenResponse2JSON(sayenResult).containsKey(CODE) && sayenResponse2JSON(sayenResult).getIntValue(CODE) == 0 ) {
//                            return sayenResponse2JSON(sayenResult).toJSONString();
//                        }else{
//                            continue;
//                        }
//                    } catch (Exception e) {
//                    }
//                }else if(smsChannel.getId() == 2){
//                    String	signature = zookeeperService.getConfigData("huaxing.user.signature");
//                    nvps = new ArrayList<NameValuePair>();
//                    nvps.add(new BasicNameValuePair(HUAXING_SMS_TEXT, signature + text));
//                    nvps.add(new BasicNameValuePair(HUAXING_SMS_MOBILE, mobile));
//                    String huaxingResult = this.execute(uri + huaxingSuffix, nvps, encoding);
//                    try {
//                        if(StringUtils.isNotBlank(huaxingResult) && huaxingResponse2JSON(huaxingResult).containsKey(CODE) && huaxingResponse2JSON(huaxingResult).getIntValue(CODE) == 0) {
//                            return huaxingResponse2JSON(huaxingResult).toJSONString();
//                        } else {
//                            continue;
//                        }
//                    } catch (Exception e) {
//                    }
//                }else if(smsChannel.getId() == 3){
//                    nvps = new ArrayList<NameValuePair>();
//                    nvps.add(new BasicNameValuePair(MONTERNET_SMS_TEXT, text));
//                    nvps.add(new BasicNameValuePair(MONTERNET_SMS_MOBILE, mobile));
//                    String monternetResult = this.execute(uri + monternetSuffix, nvps, encoding);
//                    try {
//                        if(StringUtils.isNotBlank(monternetResult) && monternetResponse2JSON(monternetResult).containsKey(CODE) && monternetResponse2JSON(monternetResult).getIntValue(CODE) == 0) {
//                            return monternetResponse2JSON(monternetResult).toJSONString();
//                        }else{
//                            continue;
//                        }
//                    } catch (Exception e) {
//                    }
//                }else if(smsChannel.getId() == 4){
//                    nvps = new ArrayList<NameValuePair>();
//                    nvps.add(new BasicNameValuePair(EMAY_SMS_TEXT, text));
//                    nvps.add(new BasicNameValuePair(EMAY_SMS_MOBILE, mobile));
//                    String emayResult = this.execute(uri + emaySuffix, nvps, encoding);
//                    try {
//                        if(StringUtils.isNotBlank(emayResult) && emayResponse2JSON(emayResult).containsKey(CODE) && emayResponse2JSON(emayResult).getIntValue(CODE) == 0) {
//                            return emayResponse2JSON(emayResult).toJSONString();
//                        }else{
//                            continue;
//                        }
//                    } catch (Exception e) {
//                    }
//                }else{
//                }
//                break;
//            }
//        }
//        return null;
//    }
//
//    private String execute(String uri, List<NameValuePair> nvps, String encoding) {
//        CloseableHttpClient closeableHttpClient = HttpClients.createDefault();
//        HttpPost httpPost = new HttpPost(uri);
//        try {
//            if(nvps != null && nvps.size() > 0) {
//                httpPost.setEntity(new UrlEncodedFormEntity(nvps, encoding));
//            }
//            CloseableHttpResponse httpResponse = closeableHttpClient.execute(httpPost);
//            int statusCode = httpResponse.getStatusLine().getStatusCode();
//            if(statusCode == 200) {
//                return EntityUtils.toString(httpResponse.getEntity(), encoding);
//            }
//        } catch (IOException e) {
//            LOG.error(e.getMessage(), e);
//        } finally {
//            httpPost.releaseConnection();
//        }
//        return null;
//    }
//
//
//    private JSONObject monternetResponse2JSON(String response) {
//        String result = FAILED_SMS_JSON;
//        Pattern p = Pattern.compile(MONTERNET_REX_RESPONSE);
//        Matcher m = p.matcher(response);
//        if(m.find()) {
//            if(m.group(1).length() > MONTERNET_RESULT_MIN_LENGTH) {
//                result = SUCCEED_SMS_JSON;
//            }
//        }
//        return  JSON.parseObject(result);
//    }
//
//    private JSONObject sayenResponse2JSON(String response) {
//        String result = FAILED_SMS_JSON;
//        if(StringUtils.isNotBlank(response)){
//            try {
//                if((response.split(","))[1].equals("0")){
//                    result = SUCCEED_SMS_JSON;
//                }
//            } catch(Exception e) {
//
//            }
//        }
//        return JSON.parseObject(result);
//    }
//
//    private JSONObject huaxingResponse2JSON(String response) {
//        String result = FAILED_SMS_JSON;
//        if(StringUtils.isNotBlank(response)) {
//            JSONObject json = JSON.parseObject(response);
//            if(StringUtils.equals(json.getString("returnstatus"), "Success")) {
//                result = SUCCEED_SMS_JSON;
//            }
//        }
//        return JSON.parseObject(result);
//    }
//
//    private static JSONObject emayResponse2JSON(String response) {
//        String result = FAILED_SMS_JSON;
//        if(StringUtils.isNotBlank(response)) {
//            String xml = response.trim();
//            if (StringUtils.startsWithIgnoreCase(xml, EMAY_XML_LABEL)) {
//                XMLSerializer xmlSerializer = new XMLSerializer();
//                String emayResult = xmlSerializer.read(xml).toString();
//                if(JSON.parseObject(emayResult) != null && JSON.parseObject(emayResult).containsKey(EMAY_RESULT_KEY) && JSON.parseObject(emayResult).getIntValue(EMAY_RESULT_KEY)==0){
//                    result = SUCCEED_SMS_JSON;
//                }
//            }
//        }
//        return JSON.parseObject(result);
//    }
//
//
//    private String getSmsCode(int seed) {
//        return StringUtils.leftPad(String.valueOf(RandomUtils.nextInt(seed)), String.valueOf(seed).length(), String.valueOf(RandomUtils.nextInt(9)));
//    }
//
//    private boolean isAllowSend(String mobile, String type) {
//        if (!StringUtils.equals(type, SmsCategoryEnum.REG.toString())) {
//            return true;
//        }
//		/*String cache= redisStringService.get(PREFIX_ALLOW_SEND + type + mobile);
//		if(StringUtils.isNotBlank(cache)) {
//			int sendCount = Integer.parseInt(cache);
//			if(sendCount < SMS_MAXIMUM) {
//				redisStringService.incr(PREFIX_ALLOW_SEND + type + mobile);
//				return true;
//			}
//			return false;
//		} else {
//			 redisStringService.set(PREFIX_ALLOW_SEND + type + mobile, String.valueOf(ONE), TWENTY_FOUR, TimeUnit.HOURS);
//		}*/
//        return true;
//    }
//}
