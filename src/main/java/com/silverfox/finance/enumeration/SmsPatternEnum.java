package com.silverfox.finance.enumeration;
import com.silverfox.finance.enumeration.SmsCategoryEnum;

public enum SmsPatternEnum {
	REGISTER(SmsCategoryEnum.REG.value(), "\u60a8\u7684\u6ce8\u518c\u9a8c\u8bc1\u7801\u4e3a\uff1a\u0025\u0073\uff08\u0032\u0030\u5206\u949f\u5185\u6709\u6548\uff09\uff0c\u6b22\u8fce\u60a8\u6ce8\u518c\u94f6\u72d0\u8d22\u5bcc\uff01"),
	RESET_LOGIN_PASSWORD(SmsCategoryEnum.RESET_LOGIN_PASSWORD.value(),"\u9a8c\u8bc1\u7801\uff1a\u0025\u0073\uff08\u0032\u0030\u5206\u949f\u5185\u6709\u6548\uff09\u3002\u60a8\u6b63\u5728\u627e\u56de\u767b\u5f55\u5bc6\u7801\uff0c\u8bf7\u5c3d\u5feb\u5b8c\u6210\u64cd\u4f5c\uff0c\u5207\u52ff\u5411\u4ed6\u4eba\u63d0\u4f9b\u9a8c\u8bc1\u7801\u3002"),
	PURCHASE_SUCCESS(SmsCategoryEnum.PURCHASE_SUCCESS.value(),"\u5c0a\u656c\u7684\u7528\u6237\uff0c\u60a8\u5df2\u6210\u529f\u8d2d\u4e70\u0020\u0025\u0073\u0020\u4ea7\u54c1\uff0c\u672c\u91d1\uff1a\u0025\u0073\u0020\u5143\uff0c\u9884\u671f\u6536\u76ca\uff1a\u0025\u0073\u5143\uff0c\u53ef\u8fdb\u5165\u201c\u6211\u7684\u8d44\u4ea7\u201d\u67e5\u770b\u4ea4\u6613\u8be6\u60c5\u3002"),
	INTEREST_ACCRUAL_START(SmsCategoryEnum.INTEREST_ACCRUAL_START.value(),"\u5c0a\u656c\u7684\u7528\u6237\uff0c\u60a8\u8d2d\u4e70\u7684\u0020\u0025\u0073\u0020\u4ea7\u54c1\u4eca\u5929\u5f00\u59cb\u8d77\u606f\u5566\u007e"),
	PAYBACK_SUCCESS(SmsCategoryEnum.PAYBACK_SUCCESS.value(),"\u5c0a\u656c\u7684\u7528\u6237\uff0c\u60a8\u8d2d\u4e70\u7684\u0020\u0025\u0073\u0020\u5143\u0020\u0025\u0073\u0020\u4ea7\u54c1\u5df2\u5230\u671f\uff0c\u8d44\u91d1\u5df2\u56de\u6b3e\u81f3\u60a8\u7684\u6c5f\u897f\u94f6\u884c\u5b58\u7ba1\u8d26\u6237\uff0c\u6b22\u8fce\u518d\u6b21\u8d2d\u4e70\u3002"),
	LIANLIAN_PAYBACK_SUCCESS(SmsCategoryEnum.LIANLIAN_PAYBACK_SUCCESS.value(),"\u4eb2\u7231\u7684\u7528\u6237\uff0c\u60a8\u4e8e%s\u8d2d\u4e70\u7684%s\u4ea7\u54c1\u5df2\u5230\u671f\uff0c\u603b\u8ba1\u672c\u606f%s\u5143\u5df2\u56de\u6b3e\u81f3\u60a8\u5c3e\u53f7%s\u7684%s\u8d26\u6237\u3002\u6b22\u8fce\u60a8\u518d\u6b21\u8d2d\u4e70\u94f6\u72d0\u8d22\u5bcc\u4ea7\u54c1\u3002"),
	CHANGE_CELLPHONE_OLD(SmsCategoryEnum.CHANGE_CELLPHONE_OLD.value(), "\u9a8c\u8bc1\u7801\uff1a\u0025\u0073\uff08\u0032\u0030\u5206\u949f\u5185\u6709\u6548\uff09\uff0c\u60a8\u6b63\u5728\u7533\u8bf7\u66f4\u6362\u624b\u673a\u53f7\uff0c\u5982\u975e\u672c\u4eba\u64cd\u4f5c\uff0c\u8bf7\u5ffd\u7565\u3002"),
	CHANGE_CELLPHONE_NEW(SmsCategoryEnum.CHANGE_CELLPHONE_NEW.value(), "\u9a8c\u8bc1\u7801\uff1a\u0025\u0073\uff08\u0032\u0030\u5206\u949f\u5185\u6709\u6548\uff09\uff0c\u60a8\u6b63\u5728\u9a8c\u8bc1\u65b0\u624b\u673a\u53f7\uff0c\u5982\u975e\u672c\u4eba\u64cd\u4f5c\uff0c\u8bf7\u5ffd\u7565\u3002"),
    CHANGE_CELLPHONE_AUDIT_SUCCESS(SmsCategoryEnum.CHANGE_CELLPHONE_AUDIT_SUCCESS.value(),"\u5c0a\u656c\u7684\u7528\u6237\uff0c\u60a8\u63d0\u4ea4\u7684\u66f4\u6362\u624b\u673a\u53f7\u7533\u8bf7\u5df2\u88ab\u786e\u8ba4\u901a\u8fc7\uff0c\u8bf7\u8fdb\u5165\u94f6\u72d0\u8d22\u5bcc\u0041\u0050\u0050\u6216\u7f51\u7ad9\u5b8c\u6210\u66f4\u6362\u3002"),
    CHANGE_CELLPHONE_AUDIT_FAILURE(SmsCategoryEnum.CHANGE_CELLPHONE_AUDIT_FAILURE.value(),"\u5c0a\u656c\u7684\u7528\u6237\uff0c\u60a8\u63d0\u4ea4\u7684\u66f4\u6362\u624b\u673a\u53f7\u7533\u8bf7\u672a\u901a\u8fc7\uff0c\u8bf7\u91cd\u65b0\u4e0a\u4f20\u8d44\u6599\u3002\u5982\u6709\u7591\u95ee\u8bf7\u8054\u7cfb\u5ba2\u670d\uff1a\u0034\u0030\u0030\u002d\u0030\u0032\u0031\u002d\u0038\u0038\u0035\u0035\u3002"),
    CHANGE_CELLPHONE_INFO_UPLOAD(SmsCategoryEnum.CHANGE_CELLPHONE_INFO_UPLOAD.value(),"\u5c0a\u656c\u7684\u7528\u6237\uff0c\u60a8\u5df2\u6210\u529f\u63d0\u4ea4\u66f4\u6362\u624b\u673a\u53f7\u7684\u7533\u8bf7\uff0c\u5ba2\u670d\u4eba\u5458\u5c06\u5728\u0033\u4e2a\u5de5\u4f5c\u65e5\u5185\u5b8c\u6210\u5ba1\u6838\u3002\u5982\u975e\u672c\u4eba\u64cd\u4f5c\uff0c\u8bf7\u8054\u7cfb\u5ba2\u670d\uff1a\u0034\u0030\u0030\u002d\u0030\u0032\u0031\u002d\u0038\u0038\u0035\u0035\u3002"),
    MERCHANT_LOGIN(SmsCategoryEnum.MERCHANT_LOGIN.value(),"\u9a8c\u8bc1\u7801\uff1a\u0025\u0073\uff08\u0032\u0030\u5206\u949f\u5185\u6709\u6548\uff09\u3002\u60a8\u6b63\u5728\u767b\u5f55\u94f6\u72d0\u8d22\u5bcc\u5546\u6237\u540e\u53f0\uff0c\u8bf7\u5c3d\u5feb\u5b8c\u6210\u64cd\u4f5c\uff0c\u5207\u52ff\u5411\u4ed6\u4eba\u63d0\u4f9b\u9a8c\u8bc1\u7801\u3002"),
    MERCHANT_PAYMENT(SmsCategoryEnum.MERCHANT_PAYMENT.value(),"\u5c0a\u656c\u7684\u5546\u6237\uff0c\u60a8\u5728\u94f6\u72d0\u8d22\u5bcc\u5e73\u53f0\u7684\u501f\u6b3e\u5df2\u5230\u8d26\uff0c\u8bf7\u767b\u5f55\u5546\u6237\u540e\u53f0\u63d0\u73b0\u3002"),
    MERCHANT_PAYBACK(SmsCategoryEnum.MERCHANT_PAYBACK.value(),"\u5c0a\u656c\u7684\u5546\u6237\uff0c\u60a8\u6709\u4e00\u7b14\u501f\u6b3e\u5373\u5c06\u5230\u671f\uff0c\u6700\u540e\u8fd8\u6b3e\u65e5\uff1a\u0025\u0073\uff0c\u8fd8\u6b3e\u91d1\u989d\u0020\u0025\u0073\u0020\u5143\uff0c\u8bf7\u53ca\u65f6\u81f3\u94f6\u72d0\u8d22\u5bcc\u5546\u6237\u540e\u53f0\u8fd8\u6b3e\u3002"),
    FINANCIAL_REBATE(SmsCategoryEnum.FINANCIAL_REBATE.value(),"\u606d\u559c\u60a8\u6295\u8d44\u6210\u529f\uff0c\u83b7\u5f97\u4e00\u5f20%s\u3002\u5361\u53f7\uff1a%s\uff0c\u5bc6\u7801\uff1a%s\uff0c\u91d1\u989d\uff1a%s"),
    DONATION_COUPON_PUSH_MESSAGE(SmsCategoryEnum.DONATION_COUPON_PUSH_MESSAGE.value(),"\u60A8\u7684\u597D\u53CB\u0025\u0073\u7ED9\u60A8\u8D60\u9001\u4E86\u4E00\u4E2A\u0025\u0073\u5143\u7EA2\u5305\uFF0C\u5FEB\u53BB\u770B\u770B\u5427"),
    DONATION_INTEREST_PUSH_MESSAGE(SmsCategoryEnum.DONATION_INTEREST_PUSH_MESSAGE.value(),"\u60A8\u7684\u597D\u53CB\u0025\u0073\u7ED9\u60A8\u8D60\u9001\u4E86\u4E00\u4E2A\u0025\u0073%\u52A0\u606F\u5238\uFF0C\u5FEB\u53BB\u770B\u770B\u5427"),
    DONATION_PUSH_TITLE(SmsCategoryEnum.DONATION_PUSH_TITLE.value(), "\u94F6\u72D0\u8D22\u5BCC"),
    RECALL("recall", "\u5c0a\u656c\u7684\u7528\u6237\u60a8\u597d\uff0c\u60a8\u7684\u597d\u53cb%s\u9080\u8bf7\u60a8\u4e00\u8d77\u53c2\u4e0e\u96c6\u788e\u7247\u5206\u4eab100\u4e07\uff0c\u5e76\u5411\u60a8\u629b\u6765%s\u5143\u7ea2\u5305\uff0c\u8bf7\u8fdb\u5165\u8d26\u6237\u9886\u53d6\u5fc3\u610f\u3002\u56deTD\u9000\u8ba2\u3002"),
	TRADE(SmsCategoryEnum.TRADE.value(),"\u9a8c\u8bc1\u7801\uff1a%s\uff0810\u5206\u949f\u5185\u6709\u6548\uff09\u3002\u60a8\u6b63\u5728\u627e\u56de\u4ea4\u6613\u5bc6\u7801\uff0c\u8bf7\u5c3d\u5feb\u5b8c\u6210\u64cd\u4f5c\uff0c\u5207\u52ff\u5411\u4ed6\u4eba\u63d0\u4f9b\u9a8c\u8bc1\u7801\u3002");	
	
	private SmsPatternEnum(String key, String pattern) {
		this.key = key;
		this.pattern = pattern;
	}
	

	public String getPattern() {
		return this.pattern;
	}
	
	public String getKey(){
		return this.key;
	}
	
	public static SmsPatternEnum getPatternByKey(String key) {
        for (SmsPatternEnum v : SmsPatternEnum.values()) {
            if (v.getKey().equals(key)) {
                return v;
            }
        }
        return SmsPatternEnum.REGISTER;
    }
	
	private String key;
	
	private String pattern;
}