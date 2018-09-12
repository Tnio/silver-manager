package com.silverfox.finance.util;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target({ ElementType.METHOD, ElementType.PARAMETER })
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface LogRecord {
	public static enum Module {
		FAQ("常见问题管理"),
		ROLE("角色管理"),
		REBATE("返利活动管理"),
		ADMIN("操作员管理"),
		NEWS("新闻素材管理"),
		NEWS_BULLETIN("新闻公告管理"),
		IMAGE("广告图管理"),
		CHANNEL("渠道管理"),
		SMSCHANNEL("短信渠道管理"),
		LOTTERY("抽奖管理"),
		PRODUCT("产品管理"),
		COUPON("优惠券管理"),
		INVITEMANAGEMENT("邀请赠送管理"),
		COUPONRULE("优惠券规则"),
		SECURITIES("劵码库"),
		EARNMONEY("赚银子"),
		DISPATCHINGBONUSLOG("优惠劵赠送管理"),
		THIRD_PARTY_CARD("第三方卡卷管理"),
		GOODS("银子商城管理"),
		MERCHANT("商户管理"),
		CUSTOMER("投资客管理"),
		APPVERSION("版本管理"),
		PUSHMESSAGE("App推送管理"),
		PAYMENTCARD("支付卡管理"),
		RECONCILIATION("对账单"),
		APPMESSAGE("APP消息管理"),
		SMSTEMPLATE("短信模板管理"),
		BANK_LIMIT("银行限额管理"),
		START_CHART("启动图管理"),
		MERCHANTLOAN("商户借款管理"),
		PRODUCTCATEGORY("产品分类管理"),
		PRODUCTCONTRACT("产品合同管理"),
		UNBUNDLINGCARD("解绑/换卡管理"),
		PRODUCTATTACHMENT("产品附件管理"),
		ACTIVITY("活动管理"),
		COUPONACTIVITY("抢红包活动"),
		SILVER("银子管理"),
		SIGNIN("签到"),
		SILVERGIVE("银子赠送管理"),
		PHOTOALBUM("企业相册管理"),
		PRODUCT_AD("APP图片管理"),
		WEB_IMAGE("网站图片管理"),
		CELLPHONE_LOG("更换手机号"),
		PROJECT_MANAGEMENT("项目管理"),
		EXCHANGE_VOUCHER("兑换券管理"),
		CREDITORMANAGEMENT("债权管理"),
		USERMANAGEMENT("用户管理"),
		UNINVEST("2-7天为投资用户"),
		LOSTCUSTOMER("流失用户管理"),
		CUSTOMER_CARD("投资客银行卡管理");

		private Module(String value) {
			this.value = value;
		}

		@Override
		public String toString() {
			return this.value;
		}

		private String value;
	}

	public static enum Operation {
		RECALL("撤回"),
		AUDIT("审核"),
		ADD("新增"),
		EDIT("编辑"),
		EXPORT("导出"),
		REMOVE("删除"),
		RESET("重置状态"),
		PUSHMESSAGE("推送"),
		SMSCHANNELSAVE("编辑"),
		AUTHORIZATION("角色授权"),
		RESETPASSWORD("重置密码"),
		MODEFIYPASSWORD("更改密码"),
		MERCHANTLOANPAYMENT("付款"),
		SETVIP("设置为高级用户"),
		FULL_SCALE("设为满标"),
		GIVE_CARD("发送卡卷"),
		IMAGEOPERATION("<#if pictrueLibrary.id=0>新增<#else>编辑</#if>"),
		APPMESSAGEOPERATION("<#if newsBulletin.id=0>新增<#else>编辑</#if>"),
		EXCHANGEVOUCHEROPERATION("<#if couponExchange.id=0>新增<#else>编辑</#if>"),
		PROJECTMANAGEMENTOPERATION("<#if project.id=0>新增<#else>编辑</#if>"),
		CREDITORMANAGEMENTOPERATION("<#if lender.id=0>新增<#else>编辑</#if>"),
		COUPONACTIVITYOPERATION("<#if couponActivity.id=0>新增<#else>编辑</#if>"),
		SECURITIESOPERATION("<#if coupon.id=0>新增<#else>编辑</#if>"),
		GERNATECARD("新增${quantity}张支付卡"),
		TOTP("<#if totp=0>解绑<#else>绑定</#if>"),
		LOCKED("<#if status=0>解锁<#else>锁定</#if>"),
		ENABLE("<#if enable=0>禁用<#else>启用</#if>"),
		IMAGEENABLE("<#if status=0>禁用<#else>启用</#if>"),
		NEWSBULLETINOPERATION("<#if newsBulletin.status=0>禁用<#else>启用</#if>"),
		COUPONRULEENABLE("<#if status=0>禁用<#else>启用</#if>"),
		AUDIT_STATUS("<#if status=1>审核通过<#elseif status=2>审核不通过<#else>待审核</#if>"),
		RECOMMEND("<#if recommend=0>取消推荐<#else>推荐</#if>"),
		FAQSAVE("<#if faq.id=0>新增<#else>编辑</#if>"),
		FAQENABLE("<#if faq.enable=0>禁用<#else>启用</#if>"),
		AUDITING("<#if value>0>通过<#else>不通过</#if>"),
		ROLESAVE("<#if role.id=0>新增<#else>编辑</#if>"),
		BANK_LIMIT_SAVE("<#if payBank.id=0>新增<#else>编辑</#if>"),
		START_CHART_SAVE("<#if startChart.id=0>新增<#else>编辑</#if>"),
		NEWSSAVE("<#if news.id=0>新增<#else>编辑</#if>"),
		SMSTEMPLATESAVE("<#if smsTemplate.id=0>新增<#else>编辑</#if>"),
		ADMINSAVE("<#if admin.id=0>新增<#else>编辑</#if>"),
		GOODSSAVE("<#if goods.id=0>新增<#else>编辑</#if>"),
		REBATESAVE("<#if bonus.id=0>新增<#else>编辑</#if>"),
		CHANNELSAVE("<#if channel.id=0>新增<#else>编辑</#if>"),
		NEWS_BULLETIN_SAVE("<#if newsBulletin.id=0>新增<#else>编辑</#if>"),
		PRODUCTSAVE("<#if product.id=0>新增<#else>编辑</#if>"),
		COUPONSAVE("<#if coupon.id=0>新增<#else>编辑</#if>"),
		LOTTERYSAVE("<#if lottery.id=0>新增<#else>编辑</#if>"),
		MERCHANTSAVE("<#if merchant.id=0>新增<#else>编辑</#if>"),
		IMAGEAPPSAVE("<#if imageApp.id=0>新增<#else>编辑</#if>"),
		IMAGEWEBSAVE("<#if imageWeb.id=0>新增<#else>编辑</#if>"),
		APPMESSAGESAVE("<#if appMessage.id=0>新增<#else>编辑</#if>"),
		APPVERSIONSAVE("<#if appVersion.id=0>新增<#else>编辑</#if>"),
		APPVERSIONPATCHSAVE("新增补丁${appVersion.patchNO}"),
		PUSHMESSAGESAVE("<#if pushMessage.id=0>新增<#else>编辑</#if>"),
		MERCHANTLOANSAVE("<#if merchantLoan.id=0>新增<#else>编辑</#if>"),
		UNBUNDLINGCARDSAVE("<#if card.type=UNBUNDLING>解绑<#else>换卡</#if>"),
		PRODUCTCATEGORYSAVE("<#if productCategory.id=0>新增<#else>编辑</#if>"),
		PRODUCTCONTRACTSAVE("<#if productContract.id=0>新增<#else>编辑</#if>"),
		MERCHANTLOANSTATUS("<#if status=1>待打款<#elseif status=2>审核未通过<#elseif status=3>打款中,等待结果<#elseif status=4>打款成功" + "<#elseif status=5>打款失败<#elseif status=6>已关闭<#elseif status=7>已还款<#else>待审核</#if>"),
		ACTIVITYSAVE("<#if activity.id=0>新增<#else>编辑</#if>"),
		COUPONACTIVITYSAVE("<#if couponActivity.id=0>新增<#else>编辑</#if>"),
		DISPATCHINGBONUSLOGSAVE("<#if dispatchingBonusLog.id=0>新增<#else>编辑</#if>"),
		INVITEACTIVITYSAVE("<#if inviteActivity.id=0>新增<#else>编辑</#if>"),
		PHOTOSAVE("<#if productAd.id=0>新增<#else>编辑</#if>"),
		PHOTO_ALBUM("<#if photoAlbum.id=0>新增<#else>编辑</#if>"),
		GOODSUD("<#if status=0>下架<#else>上架</#if>"),
		PHOTO_ENABLE("<#if status=0>禁用<#else>启用</#if>"),
		SIGNINSAVE("<#if signIn.id = 0>新增<#else>修改</#if>"),
		INVITATION("邀请好友赠送银子规则编辑"),
		CARDRESET("注销");

		private Operation(String value) {
			this.value = value;
		}

		@Override
		public String toString() {
			return this.value;
		}

		private String value;
	}

	Module module();

	Operation operation();

	String id() default "";

	String name() default "";

	String remark() default "";
}