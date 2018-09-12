(function($) {
	$.fn.validationEngineLanguage = function() {
	};
	$.validationEngineLanguage = {
		newLang : function() {
			$.validationEngineLanguage.allRules = {
				"required" : { // Add your regex rules here, you can take
								// telephone as an example
					"regex" : "none",
					"alertText" : "* 此处不可空白",
					"alertTextCheckboxMultiple" : "* 请选择一个项目",
					"alertTextCheckboxe" : "* 您必须钩选此栏",
					"alertTextDateRange" : "* 日期范围不可空白"
				},
				"requiredInFunction" : {
					"func" : function(field, rules, i, options) {
						return (field.val() == "test") ? true : false;
					},
					"alertText" : "* Field must equal test"
				},
				"dateRange" : {
					"regex" : "none",
					"alertText" : "* 无效的 ",
					"alertText2" : " 日期范围"
				},
				"dateTimeRange" : {
					"regex" : "none",
					"alertText" : "* 无效的 ",
					"alertText2" : " 时间范围"
				},
				"minSize" : {
					"regex" : "none",
					"alertText" : "* 最少 ",
					"alertText2" : " 个字符"
				},
				"maxSize" : {
					"regex" : "none",
					"alertText" : "* 最多 ",
					"alertText2" : " 个字符"
				},
				"groupRequired" : {
					"regex" : "none",
					"alertText" : "* 你必需选填其中一个栏位"
				},
				"min" : {
					"regex" : "none",
					"alertText" : "* 最小值為 "
				},
				"dayLimitMin" : {
					"regex" : "none",
					"alertText" : "* 最小值不能小于单笔限额 "
				},
				"monLimitMin" : {
					"regex" : "none",
					"alertText" : "* 最小值不能小于单日限额  "
				},
				"max" : {
					"regex" : "none",
					"alertText" : "* 最大值为 "
				},
				"limitMax" : {
					"regex" : "none",
					"alertText" : "* 最大值不能大于单日限额  "
				},
				"dayLimitMax" : {
					"regex" : "none",
					"alertText" : "* 最大值不能大于单月限额  "
				},
				"past" : {
					"regex" : "none",
					"alertText" : "* 日期必需早于 "
				},
				"future" : {
					"regex" : "none",
					"alertText" : "* 日期必需晚于 "
				},
				"maxCheckbox" : {
					"regex" : "none",
					"alertText" : "* 最多选取 ",
					"alertText2" : " 个项目"
				},
				"minCheckbox" : {
					"regex" : "none",
					"alertText" : "* 请选择 ",
					"alertText2" : " 个项目"
				},
				"equals" : {
					"regex" : "none",
					"alertText" : "* 请输入与上面相同的密码"
				},
				"passwordSp" : {
					"regex" : "none",
					"alertText" : "* 密码不正确"
				},
				"idcardEqu" : {
					"regex" : "none",
					"alertText" : "* 身份证不正确"
				},
				"nameEqu" : {
					"regex" : "none",
					"alertText" : "* 姓名不正确"
				},
				"creditCard" : {
					"regex" : "none",
					"alertText" : "* 无效的信用卡号码"
				},
				"phone" : {
					// credit: jquery.h5validate.js / orefalo
					"regex" : /^\d+(-\d+)*$/,
					"alertText" : "* 无效的电话号码"
				},
				"cellphone" : {
					// credit: jquery.h5validate.js / orefalo
					// "regex": /^1[3|4|5|8][0-9]\d{4,8}$/,
					"regex" : /^1[3|4|5|8|7][0-9]\d{8}$/,
					"alertText" : "* 无效的手机号码"
				},
				"email" : {
					// Shamelessly lifted from Scott Gonzalez via the
					// Bassistance Validation plugin
					// http://projects.scottsplayground.com/email_address_validation/
					"regex" : /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i,
					"alertText" : "* 邮件地址无效"
				},
				"bankCode" : {
					// Shamelessly lifted from Scott Gonzalez via the
					// Bassistance Validation plugin
					// http://projects.scottsplayground.com/email_address_validation/
					"regex" : /^[0-9]\d{3,19}$/,
					"alertText" : "* 银行卡号无效"
				},
				"accountIdCode" : {
					// Shamelessly lifted from Scott Gonzalez via the
					// Bassistance Validation plugin
					// http://projects.scottsplayground.com/email_address_validation/
					"regex" : /^[0-9]\d{15,18}$/,
					"alertText" : "* 电子账户无效"
				},
				"idcard" : {
					"regex" : /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/,
					"alertText" : "* 身份证无效"
				},
				"integer" : {
					"regex" : /^[\-\+]?\d+$/,
					"alertText" : "* 不是有效的整数"
				},
				"number" : {
					// Number, including positive, negative, and floating
					// decimal. credit: orefalo
					"regex" : /^[\-\+]?((([0-9]{1,3})([,][0-9]{3})*)|([0-9]+))?([\.]([0-9]+))?$/,
					"alertText" : "* 无效的数字"
				},
				"numberSp" : {
					// Number, including positive, negative, and floating
					// decimal. credit: orefalo
					"regex" : /^[\-\+]?((([0-9]{1,3})([,][0-9]{3})*)|([0-9]+))?([\.]([0-9]\d{0,1}))?$/,
					"alertText" : "* 小数点后最多只能输入两位数字"
				},
				"validateNumber" : {
					// Number, including positive, negative, and floating
					// decimal. credit: orefalo
					"regex" : /^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))?$/,
					"alertText" : "* 无效的数字或小数点位数不能超过两位"
				},
				"numberPercentage" : {
					// Number, including positive, negative, and floating
					// decimal. credit: orefalo
					"regex" : /^[\-\+]?((([0-9]{1,3})([,][0-9]{3})*)|([0-9]+))?([\.]([0-9]\d{0,2}))?$/,
					"alertText" : "* 小数点后最多只能输入三位数字"
				},
				"numberPercentageOne" : {
					// Number, including positive, negative, and floating
					// decimal. credit: orefalo
					"regex" : /^[\-\+]?((([0-9]{1,3})([,][0-9]{3})*)|([0-9]+))?([\.]([0-9]\d{0}))?$/,
					"alertText" : "* 最多只能保留一位小数点"
				},
				"date" : {
					"regex" : /^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$/,
					"alertText" : ""
				},
				"ipv4" : {
					"regex" : /^((([01]?[0-9]{1,2})|(2[0-4][0-9])|(25[0-5]))[.]){3}(([0-1]?[0-9]{1,2})|(2[0-4][0-9])|(25[0-5]))$/,
					"alertText" : "* 无效的 IP 地址"
				},
				"url" : {
					"regex" : /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i,
					"alertText" : "* 无效的URL"
				},
				"onlyNumberSp" : {
					"regex" : /^[0-9\ ]+$/,
					"alertText" : "* 只能填数字"
				},
				"codeSp" : {
					"regex" : /^\d+(-\d+)*$/,
					"alertText" : "* 只能输入数字，支持“-”符号"
				},
				"numberSemicolon" : {
					"regex" : /^\d+(;\d+)*$/,
					"alertText" : "* 只能输入数字和英文“;”符号,<br>“;”不能处于最前和最后"
				},
				"onlyLetterSp" : {
					"regex" : /^[a-zA-Z\ \']+$/,
					"alertText" : "* 只接受英文字母大小写"
				},
				"onlyLetterAccentSp" : {
					"regex" : /^[a-z\u00C0-\u017F\ ]+$/i,
					"alertText" : "* 只接受英文字母大小写"
				},
				"onlyLetterNumber" : {
					"regex" : /^[0-9a-zA-Z]+$/,
					"alertText" : "* 只接受数字、字母"
				},
				"anotherNotSpecialCharacter" : {
					"regex" : /^[\u4E00-\u9FA5A-Za-z0-9_]+$/,
					"alertText" : "* 请输入中文、字母或数字及其组合"
				},
				"notSpecialCharacter" : {
					"regex" : /^([\u4e00-\u9fa5]+|[a-zA-Z0-9]+)$/,
					"alertText" : "* 不接受特殊字符"
				},
				"notSpecialCharacterAndChinese" : {
					"regex" : /^([a-zA-Z0-9]+)$/,
					"alertText" : "* 不接受特殊字符和中文"
				},
				"chinese" : {
					"regex" : /[\u4E00-\u9FA5\uF900-\uFA2D]/,
					"alertText" : "* 只能输入中文"
				},
				// --- CUSTOM RULES -- Those are specific to the demos, they can
				// be removed or changed to your likings
				"ajaxUserCall" : {
					"url" : "ajaxValidateFieldUser",
					// you may want to pass extra data on the ajax call
					"extraData" : "name=eric",
					"alertText" : "* 此名称已被其他人使用",
					"alertTextLoad" : "* 正在确认名称是否有其他人使用，请稍等。"
				},
				"ajaxBankName" : {
					"url" : "/unionpay/bank/duplicate/name",
					"extraDataDynamic" : ['#id'],
					"alertText" : "* 此名称已被使用",
					"alertTextLoad" : "* 正在确认名称是否已被使用，请稍等。"
				},
				"ajaxChecklicenseNO" : {
					"url" : "/client/merchant/duplicate/license",
					"extraDataDynamic" : ['#id'],
					"alertText" : "* 此营业执照号已被其他人使用",
					"alertTextLoad" : "* 正在确认营业执照号是否有其他人使用，请稍等。"
				},
				"ajaxCheckCard" : {
					"url" : "/thirdparty/card/exist",
					"extraDataDynamic" : ['#customerId'],
					"alertText" : "* 该用户并未绑定此银行卡",
					"alertTextLoad" : "* 正在确认此银行卡是否已被该用户绑定，请稍等。"
				},
				"ajaxCheckTaxRegistrationCode" : {
					"url" : "/client/merchant/duplicate/tax",
					"extraDataDynamic" : ['#id'],
					"alertText" : "* 此税务登记代码已被其他人使用",
					"alertTextLoad" : "* 正在确认税务登记代码是否有其他人使用，请稍等。"
				},
				"ajaxUserCallPhp" : {
					"url" : "phpajax/ajaxValidateFieldUser.php",
					"extraData" : "name=eric",
					"alertTextOk" : "* 此帐号名称可以使用",
					"alertText" : "* 此名称已被其他人使用",
					"alertTextLoad" : "* 正在确认帐号名称是否有其他人使用，请稍等。"
				},
				"ajaxValidateName" : {
					"url" : "/bonus/validate/name",
					"extraDataDynamic" : ['#id'],
					"alertTextOk" : "* 此名称可以使用",
					"alertText" : "* 此名称已被其他人使用",
					"alertTextLoad" : "* 正在确认名称是否有其他人使用，请稍等。"
				},
				"ajaxValidateActivityCouponName" : {
					"url" : "/activity/grab/exist/name",
					"extraDataDynamic" : ['#id'],
					"alertTextOk" : "* 此名称可以使用",
					"alertText" : "* 此名称已被其他人使用",
					"alertTextLoad" : "* 正在确认名称是否有其他人使用，请稍等。"
				},
				"ajaxValidateLotteryName" : {
					"url" : "/bonus/lottery/validate/name",
					"extraDataDynamic" : ['#id'],
					"alertTextOk" : "* 此名称可以使用",
					"alertText" : "* 此名称已被其他人使用",
					"alertTextLoad" : "* 正在确认名称是否有其他人使用，请稍等。"
				},
				"ajaxValidateInviteActivityName" : {
					"url" : "/coupon/invite/activity/validate/name",
					"extraDataDynamic" : ['#id'],
					"alertTextOk" : "* 此名称可以使用",
					"alertText" : "* 此名称已被其他人使用",
					"alertTextLoad" : "* 正在确认名称是否有其他人使用，请稍等。"
				},
				"ajaxValidateLoginName" : {
					"url" : "/system/admin/validate/name",
					"alertTextOk" : "* 账户输入正确!",
					"alertText" : "* 账户不存在,请您重新确认!",
					"alertTextLoad" : "* 正在确认账户是否存在，请稍等。"
				},
				"ajaxAppName" : {
					"url" : "/banner/duplicate/name",
					"extraDataDynamic" : ['#id'],
					"alertTextOk" : "* 此名称可以使用",
					"alertText" : "* 此名称已被其他人使用",
					"alertTextLoad" : "* 正在确认名称是否已被使用，请稍等。"
				},
				"ajaxProductCategoryName" : {
					"url" : "/product/category/duplicate/name",
					"extraDataDynamic" : ['#id'],
					"alertTextOk" : "* 此名称可以使用",
					"alertText" : "* 此名称已被其他人使用",
					"alertTextLoad" : "* 正在确认名称是否已被使用，请稍等。"
				},
				"ajaxVersionNumber" : {
					"url" : "/upgrade/version/duplicate/number",
					"extraDataDynamic" : ['#id'],
					"alertTextOk" : "* 此版本号可以使用",
					"alertText" : "* 此版本号已被其他人使用",
					"alertTextLoad" : "* 正在确认版本号是否已被使用，请稍等。"
				},
				"ajaxAdminPasswords" : {
					"url" : "/system/admin/validate/password",
					"extraDataDynamic" : ['#adminId'],
					"alertTextOk" : "* 密码正确",
					"alertText" : "* 密码不正确"// ,
					// "alertTextLoad": "* 正在检查密码是否正确，请稍等。"
				},
				"ajaxValidateRoleName" : {
					"url" : "/system/role/validate/name",
					"extraDataDynamic" : ['#id'],
					"alertTextOk" : "* 此名称可以使用",
					"alertText" : "* 此角色名称已被其他人使用",
					"alertTextLoad" : "* 正在确认角色名称是否有其他人使用，请稍等。"
				},
				"ajaxValidateAdminName" : {
					"url" : "/system/admin/validate/name",
					"extraDataDynamic" : ['#id'],
					"alertTextOk" : "* 此名称可以使用",
					"alertText" : "* 此管理员名称已被其他人使用",
					"alertTextLoad" : "* 正在确认管理员名称是否有其他人使用，请稍等。"
				},
				"ajaxValidateAdminCellphone" : {
					"url" : "/system/admin/validate/cellphone",
					"extraDataDynamic" : ['#id'],
					"alertTextOk" : "* 此手机号可以使用",
					"alertText" : "* 此手机号已被占用",
					"alertTextLoad" : "* 正在确认手机号是否有其他人使用，请稍等。"
				},
				"checkCouponCode" : {
					"url" : "/coupon/exchange/validate/code",
					"extraDataDynamic" : ['#id'],
					"alertTextOk" : "* 此兑换码可以使用",
					"alertText" : "*此兑换码已被使用过",
					"alertTextLoad" : "* 正在确认此兑换码是否被使用过，请稍等。"
				},
				"ajaxNameCall" : {
					// remote json service location
					"url" : "ajaxValidateFieldName",
					// error
					"alertText" : "* 此名称可以使用",
					// if you provide an "alertTextOk", it will show as a green
					// prompt when the field validates
					"alertTextOk" : "* 此名称已被其他人使用",
					// speaks by itself
					"alertTextLoad" : "* 正在确认名称是否有其他人使用，请稍等。"
				},
				"checkProductName" : {
					// remote json service location
					"url" : "/product/check/name",
					"extraDataDynamic" : ['#id'],
					// error
					"alertText" : "* 此名称可以使用",
					// if you provide an "alertTextOk", it will show as a green
					// prompt when the field validates
					"alertTextOk" : "* 此名称已被使用请重新输入",
					// speaks by itself
					"alertTextLoad" : "* 正在确认名称是否已被使用，请稍等.........."
				},
				"checkGoodsName" : {
					// remote json service location
					"url" : "/bonus/mall/goods/check/name",
					"extraDataDynamic" : ['#id'],
					// error
					"alertText" : "* 此名称可以使用",
					// if you provide an "alertTextOk", it will show as a green
					// prompt when the field validates
					"alertTextOk" : "* 此名称已被使用请重新输入",
					// speaks by itself
					"alertTextLoad" : "* 正在确认名称是否已被使用，请稍等.........."
				},
				"ajaxcontractName" : {
					// remote json service location
					"url" : "/product/contract/duplicate/name",
					"extraDataDynamic" : ['#id'],
					// error
					"alertText" : "* 此名称已被其他人使用",
					// speaks by itself
					"alertTextLoad" : "* 正在确认名称是否有其他人使用，请稍等。"
				},
				"ajaxprotocolName" : {
					// remote json service location
					"url" : "/product/protocol/duplicate/name",
					"extraDataDynamic" : ['#id'],
					// error
					"alertText" : "* 此名称已被其他人使用",
					// speaks by itself
					"alertTextLoad" : "* 正在确认名称是否有其他人使用，请稍等。"
				},
				"ajaxguaranteeName" : {
					// remote json service location
					"url" : "/product/guarantee/duplicate/name",
					"extraDataDynamic" : ['#id'],
					// error
					"alertText" : "* 此名称已被其他人使用",
					// speaks by itself
					"alertTextLoad" : "* 正在确认名称是否有其他人使用，请稍等。"
				},
				"ajaxFaqName" : {
					"url" : "/faq/duplicate/name",
					"extraDataDynamic" : ['#id'],
					"alertTextOk" : "* 此名称可以使用",
					"alertText" : "* 此名称已被其他人使用",
					"alertTextLoad" : "* 正在确认名称是否已被使用，请稍等。"
				},
				"ajaxCheckExchangeCode" : {
					"url" : "/coupon/coupon/check/exchange/code",
					"extraDataDynamic" : ['#id'],
					"alertTextOk" : "* 此名称可以使用",
					"alertText" : "* 此名称已被其他人使用",
					"alertTextLoad" : "* 正在确认名称是否已被使用，请稍等。"
				},
				"ajaxNameCallPhp" : {
					// remote json service location
					"url" : "phpajax/ajaxValidateFieldName.php",
					// error
					"alertText" : "* 此名称已被其他人使用",
					// speaks by itself
					"alertTextLoad" : "* 正在确认名称是否有其他人使用，请稍等。"
				},
				"validate2fields" : {
					"alertText" : "* 请输入 HELLO"
				},
				// tls warning:homegrown not fielded
				"dateFormat" : {
					"regex" : /^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$|^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(?:(?:0?[1-9]|1[0-2])(\/|-)(?:0?[1-9]|1\d|2[0-8]))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(0?2(\/|-)29)(\/|-)(?:(?:0[48]00|[13579][26]00|[2468][048]00)|(?:\d\d)?(?:0[48]|[2468][048]|[13579][26]))$/,
					"alertText" : "* 无效的日期格式"
				},
				// tls warning:homegrown not fielded
				"dateTimeFormat" : {
					"regex" : /^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])\s+(1[012]|0?[1-9]){1}:(0?[1-5]|[0-6][0-9]){1}:(0?[0-6]|[0-6][0-9]){1}\s+(am|pm|AM|PM){1}$|^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^((1[012]|0?[1-9]){1}\/(0?[1-9]|[12][0-9]|3[01]){1}\/\d{2,4}\s+(1[012]|0?[1-9]){1}:(0?[1-5]|[0-6][0-9]){1}:(0?[0-6]|[0-6][0-9]){1}\s+(am|pm|AM|PM){1})$/,
					"alertText" : "* 无效的日期或时间格式",
					"alertText2" : "可接受的格式： ",
					"alertText3" : "mm/dd/yyyy hh:mm:ss AM|PM 或 ",
					"alertText4" : "yyyy-mm-dd hh:mm:ss AM|PM"
				}/*
					 * , "dateTimeFormat2": { "regex":
					 * /^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])\s+(1[012]|0?[1-9]){1}:(0?[1-5]|[0-6][0-9]){1}:(0?[0-6]|[0-6][0-9]){1}$|^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^((1[012]|0?[1-9]){1}\/(0?[1-9]|[12][0-9]|3[01]){1}\/\d{2,4}\s+(1[012]|0?[1-9]){1}:(0?[1-5]|[0-6][0-9]){1}:(0?[0-6]|[0-6][0-9]){1}$/,
					 * "alertText": "* 无效的日期或时间格式", "alertText2": "可接受的格式： ",
					 * "alertText4": "yyyy-mm-dd hh:mm:ss" }
					 */
			};

		}
	};
	$.validationEngineLanguage.newLang();
})(jQuery);
