package com.silverfox.finance.service;

import com.alibaba.fastjson.JSONObject;

import java.util.concurrent.TimeUnit;

public interface SmsService {
    JSONObject send(String text, String mobile, String encoding);
    JSONObject send(String text, String mobile, String encoding, long timeout, TimeUnit unit);
    JSONObject send(String text, String mobile, int seed, String encoding, long timeout, TimeUnit unit);
    JSONObject sendValidateCode(String text, String type, String mobile, int seed, String encoding, long timeout, TimeUnit unit);
    JSONObject resendValidateCode(String text, String type, String mobile, int seed, String encoding, long timeout, TimeUnit unit);
    void smsOrderMessage(String text, String mobile);
    String smsPayback(String text, String mobile);
}
