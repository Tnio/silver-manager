package com.silverfox.finance.util;

import static com.silverfox.finance.util.ConstantUtil.FIFTY_NINE;
import static com.silverfox.finance.util.ConstantUtil.NUMBER_DATE_FORMAT;
import static com.silverfox.finance.util.ConstantUtil.ONE_THOUSAND;
import static com.silverfox.finance.util.ConstantUtil.TWENTY_THREE;
import static java.util.Calendar.HOUR_OF_DAY;
import static java.util.Calendar.MINUTE;
import static java.util.Calendar.SECOND;

import java.util.Calendar;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;

public class SilverfoxPayUtil {
	private static final String PRIVATE_KEY = "com.cn.silverfox";
	private static final int KEY_LENGTH = 32;

	private SilverfoxPayUtil() {

	}

	public static String getPaySign(String key) {
		String sign = "";
		if (StringUtils.length(key) == KEY_LENGTH) {
			sign = DigestUtils
					.md5Hex(PRIVATE_KEY + key + DateFormatUtils.format(Calendar.getInstance(), NUMBER_DATE_FORMAT));
		}
		return sign;
	}

	public static String getPayReverseKey(String key) {
		return StringUtils.reverse(key);
	}

	public static long getTimeStampToMidnight() {
		Calendar calendar = Calendar.getInstance();
		calendar.set(HOUR_OF_DAY, TWENTY_THREE);
		calendar.set(MINUTE, FIFTY_NINE);
		calendar.set(SECOND, FIFTY_NINE);
		return calendar.getTimeInMillis() / ONE_THOUSAND;
	}
}