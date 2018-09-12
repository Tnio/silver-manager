package com.silverfox.finance.service.impl;

import static com.silverfox.finance.util.ConstantUtil.DOMAIN;
import static com.silverfox.finance.util.ConstantUtil.UTF_8;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.silverfox.finance.domain.CustomerBank;
import com.silverfox.finance.domain.EBankLog;
import com.silverfox.finance.domain.PayBank;
import com.silverfox.finance.domain.PaymentOut;
import com.silverfox.finance.domain.UnionPayCNCode;
import com.silverfox.finance.domain.UnionPayVoucher;
import com.silverfox.finance.entity.PayBackEntity;
import com.silverfox.finance.enumeration.PayChannelEnum;
import com.silverfox.finance.orm.CustomerDao;
import com.silverfox.finance.orm.EBankLogDao;
import com.silverfox.finance.orm.LianlianCNCodeDao;
import com.silverfox.finance.orm.LianlianPayVoucherDao;
import com.silverfox.finance.orm.PayBankDao;
import com.silverfox.finance.orm.PaymentOutDao;
import com.silverfox.finance.service.PayBankService;
import com.silverfox.finance.util.LogRecord;

@Service
public class PayBankServiceImpl implements PayBankService {
    protected static final Log LOG = LogFactory.getLog(PayBankServiceImpl.class);
    private static final String BANK_LIMIT_LIST = "bank:limit:list:";
    private static final String BANK_CARD_QUOTA_FLAG = "bank:card:quota:flag";
    private static final String SUCCESS_CODE = "0000";
    private static final String RET_CODE = "ret_code";
    private static final String SUPPORT_BANKLIST = "support_banklist";
    private static final String BANK_CODE = "bank_code";
    private static final String DAY_AMT = "day_amt";
    private static final String MONTH_AMT = "month_amt";
    private static final String SINGLE_AMT = "single_amt";
    private static final String BANK_STATUS = "bank_status";

    @Autowired
    private PayBankDao payBankDao;
    @Autowired
    private EBankLogDao ebankLogDao;
    @Autowired
    private CustomerDao customerDao;
    @Autowired
    private PaymentOutDao paymentOutDao;
    @Autowired
    private LianlianCNCodeDao lianlianCNCodeDao;
    @Autowired
    private LianlianPayVoucherDao lianlianPayVoucherDao;

    @Override
    public List<UnionPayCNCode> getCityList(String provinceCode) {
        return lianlianCNCodeDao.selectCityByProvinceCode(provinceCode);
    }

    @Override
    public List<UnionPayVoucher> getBankVoucher(String bankCode) {
        return lianlianPayVoucherDao.selectByBankCode(bankCode);
    }

    @Override
    public List<UnionPayVoucher> getBankVoucherList(String provinceCode, String city) {
        return lianlianPayVoucherDao.selectByCityCode(provinceCode, city);
    }

    @Override
    public List<UnionPayVoucher> getBankVoucher(String provinceCode, String city, String bankCode) {
        return lianlianPayVoucherDao.selectByCityCodeAndBankCode(provinceCode, city, bankCode);
    }

    @Override
    public List<PayBank> getBankList(PayChannelEnum channelEnum, int enable) {
        return payBankDao.selectBank(channelEnum.value(), enable);
    }

    @Override
    public List<UnionPayCNCode> getProvinceList() {
        return lianlianCNCodeDao.selectProvince();
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
    public boolean save(EBankLog log) {
        if (log != null && log.getId() == 0) {
            return ebankLogDao.insert(log) > 0 ? true : false;
        }
        return false;
    }

    @Override
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
    public String query(String url, String body) {
        CloseableHttpClient closeableHttpClient = HttpClients.createDefault();
        if(StringUtils.isNotBlank(body) && StringUtils.isNotBlank(url)){
            HttpPost httpPost = new HttpPost(url);
            StringEntity stringEntity = new StringEntity(body, UTF_8);
            stringEntity.setContentEncoding(new BasicHeader(HTTP.CONTENT_ENCODING, UTF_8));
            httpPost.setEntity(stringEntity);
            try {
                CloseableHttpResponse httpResponse = closeableHttpClient.execute(httpPost);
                int statusCode = httpResponse.getStatusLine().getStatusCode();
                if (statusCode == 200) {
                    return EntityUtils.toString(httpResponse.getEntity(), UTF_8);
                }
            } catch (IOException e) {
                LOG.error(e.getMessage(), e);
            } finally {
                httpPost.releaseConnection();
            }
        }
        return null;
    }

    @Override
    public List<PayBank> getBankList(String url, String body, PayChannelEnum channelEnum, int enable) {
        //String flag = redisStringService.get(BANK_CARD_QUOTA_FLAG);
        ///if(flag == null){
        CloseableHttpClient closeableHttpClient = HttpClients.createDefault();
        if(StringUtils.isNotBlank(body) && StringUtils.isNotBlank(url)){
            HttpPost httpPost = new HttpPost(url);
            StringEntity stringEntity = new StringEntity(body,UTF_8);
            stringEntity.setContentEncoding(new BasicHeader(HTTP.CONTENT_ENCODING, UTF_8));
            httpPost.setEntity(stringEntity);
            try {
                CloseableHttpResponse httpResponse = closeableHttpClient.execute(httpPost);
                int statusCode = httpResponse.getStatusLine().getStatusCode();
                if (statusCode == 200) {
                    String params = EntityUtils.toString(httpResponse.getEntity(), UTF_8);
                    JSONObject result =(JSONObject) JSONObject.parse(params);
                    if(result != null && StringUtils.equals(SUCCESS_CODE, result.getString(RET_CODE))) {
                        if(result.containsKey(SUPPORT_BANKLIST)) {
                            JSONArray bankList = result.getJSONArray(SUPPORT_BANKLIST);
                            if(bankList != null && bankList.size() > 0) {
                                List<PayBank> banks = new ArrayList<PayBank>();
                                for(int i=0; i<bankList.size(); i++) {
                                    JSONObject bank = bankList.getJSONObject(i);
                                    if(bank != null) {
                                        PayBank payBank = new PayBank();
                                        payBank.setBankNO(bank.getString(BANK_CODE));
                                        payBank.setDayLimit(Integer.parseInt(bank.getString(DAY_AMT)));
                                        payBank.setMonthLimit(Integer.parseInt(bank.getString(MONTH_AMT)));
                                        payBank.setSingleLimit(Integer.parseInt(bank.getString(SINGLE_AMT)));
                                        if(Integer.parseInt(bank.getString(BANK_STATUS)) == 0){
                                            payBank.setEnable(1);
                                        }else if(Integer.parseInt(bank.getString(BANK_STATUS)) == 2){
                                            payBank.setEnable(2);
                                        }else{
                                            // do nothing
                                        }


                                        banks.add(payBank);
                                    }
                                }
                                if(banks != null && banks.size() > 0) {
//                                    payBankServiceConsumer.saveBankCardQuota(banks);
                                    payBankDao.updateBatch(banks);
                                }
                            }
                        }
                    } else {
                        LOG.error("refresh pay voucher error["+ result +"]");
                    }
                }
            } catch (IOException e) {
                LOG.error(e.getMessage(), e);
            } finally {
                httpPost.releaseConnection();
            }
        }
        //redisStringService.set(BANK_CARD_QUOTA_FLAG, "1", 5, TimeUnit.MINUTES);
        //}
//        return payBankServiceConsumer.getPayBankList(channelEnum, enable);
        return payBankDao.selectBank(channelEnum.value(), enable);
    }

    @Override
    @LogRecord(module=LogRecord.Module.BANK_LIMIT, operation=LogRecord.Operation.BANK_LIMIT_SAVE, id="", name="${payBank.bankName}")
    public boolean savePayBank(PayBank payBank) {
//        boolean result = payBankServiceConsumer.save(payBank);
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
    @LogRecord(module=LogRecord.Module.BANK_LIMIT, operation=LogRecord.Operation.ENABLE, id="${id}", name="")
    public boolean enable(int id, int enable) {
        return payBankDao.enable(id, enable) > 0 ? true : false;
    }

    @Override
    public PayBank get(int id) {
        return payBankDao.selectById(id);
    }
}
