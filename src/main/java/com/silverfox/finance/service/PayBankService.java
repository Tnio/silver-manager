package com.silverfox.finance.service;

import com.silverfox.finance.domain.EBankLog;
import com.silverfox.finance.domain.PayBank;
import com.silverfox.finance.domain.UnionPayCNCode;
import com.silverfox.finance.domain.UnionPayVoucher;
import com.silverfox.finance.enumeration.PayChannelEnum;

import java.util.List;

public interface PayBankService {
    String query(String url, String body);
    boolean savePayBank(PayBank payBank);
    List<PayBank> getBankList(String url, String body, PayChannelEnum channelEnum, int enable);

    List<PayBank> getBankList(PayChannelEnum channelEnum, int enable);
//    PayBank getPayBank(PayChannelEnum channelEnum, String bankNO);
//    List<UnionPayCNCode> getCNCodeList();
    List<UnionPayCNCode> getProvinceList();
    List<UnionPayCNCode> getCityList(String provinceCode);
    List<UnionPayVoucher> getBankVoucher(String bankCode);
    List<UnionPayVoucher> getBankVoucherList(String provinceCode, String city);
    List<UnionPayVoucher> getBankVoucher(String provinceCode, String city, String bankCode);
//    void saveVoucherBatch(List<UnionPayVoucher> vouchers);

//    boolean save(PayBank payBank);
    PayBank get(int id);
//    List<PayBank> list(int payChannel, List<String> bankNOs);
    public boolean enable(int id, int value);
//    public boolean duplicate(int id, String name);
//    void saveBankCardQuota(List<PayBank> banks);

    List<EBankLog> listEBankLog(int offset, int size);
    int countEBankLog();
//    EBankLog getEBankLog(int ebankLogId);
    boolean save(EBankLog log);
    boolean audit(int id, int result, String remark);
//    List<EBankLog> listNewCard(int newBankId, int status);
//    List<EBankLog> listOldCard(int oldBankId, int status);
}
