package com.silverfox.finance.controller;

import static com.silverfox.finance.util.ConstantUtil.BACK_SLASH;
import static com.silverfox.finance.util.ConstantUtil.COMMA;
import static com.silverfox.finance.util.ConstantUtil.EMPTY;
import static com.silverfox.finance.util.ConstantUtil.LEFT_SQUARE_BRACKET;
import static com.silverfox.finance.util.ConstantUtil.NORMAL_DATE_FORMAT;
import static com.silverfox.finance.util.ConstantUtil.RIGHT_SQUARE_BRACKET;
import static com.silverfox.finance.util.ConstantUtil.SEMICOLON;
import static com.silverfox.finance.util.ConstantUtil.SLASH;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Serializable;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.silverfox.finance.domain.Coupon;
import com.silverfox.finance.domain.CouponCardLog;
import com.silverfox.finance.domain.CouponExchange;
import com.silverfox.finance.domain.CouponVip;
import com.silverfox.finance.domain.CustomerCoupon;
import com.silverfox.finance.domain.DispatchingBonusLog;
import com.silverfox.finance.domain.DispatchingCouponRule;
import com.silverfox.finance.domain.GoodsCouponCode;
import com.silverfox.finance.domain.InviteActivity;
import com.silverfox.finance.domain.InviteActivityLog;
import com.silverfox.finance.domain.InviteActivityRule;
import com.silverfox.finance.domain.RuleCoupon;
import com.silverfox.finance.domain.SmsTemplate;
import com.silverfox.finance.domain.User;
import com.silverfox.finance.entity.ArrayObjectEntity;
import com.silverfox.finance.entity.BonusRecordEntity;
import com.silverfox.finance.entity.CouponStatisticsEntity;
import com.silverfox.finance.entity.CouponVipEntity;
import com.silverfox.finance.entity.CouponVipExclusive;
import com.silverfox.finance.entity.InviterRecordEntity;
import com.silverfox.finance.enumeration.CouponCategoryEnum;
import com.silverfox.finance.enumeration.CouponRuleSourceEnum;
import com.silverfox.finance.enumeration.GenericEnableEnum;
import com.silverfox.finance.enumeration.ProductCategoryPropertyEnum;
import com.silverfox.finance.enumeration.UsedStatusEnum;
import com.silverfox.finance.service.ClientService;
import com.silverfox.finance.service.CouponService;
import com.silverfox.finance.service.SilverService;
import com.silverfox.finance.util.ConstantUtil;
import com.silverfox.finance.util.ExcelUtil;
import com.silverfox.finance.util.ValidatorUtil;

@Controller
@RequestMapping("/coupon")
public class CouponController extends BaseController{
	@Autowired
	private CouponService couponService;
	@Autowired
	private ClientService clientService;
	@Autowired
	private SilverService silverService;
	
	@RequestMapping("/coupon/list")
	public String listCoupon(Integer type,  String name, Integer size, Integer page, Model model,RedirectAttributes redirectAttributes){
		type=type != null ? type : 1;
		int total = couponService.count(type,  -1, name, GenericEnableEnum.ALL.value(), -1);
		if (total > 0) {
			model.addAttribute("total", total);
		    model.addAttribute("coupons", couponService.list(type ,  -1, name, GenericEnableEnum.ALL.value(), -1, this.getOffset(page, size), this.getPageSize(size)));
		} else {
			model.addAttribute("total", 0); 
			model.addAttribute("coupons", new Coupon[0]);
		}
		this.getParam(model, 10, 10);
		model.addAttribute("type", type);
		model.addAttribute("name", name);
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "coupon/coupon/list";
	}
	
	private Model getParam(Model model, int cate, int sou){		
		Map<Integer, String> categorys = new LinkedHashMap<Integer, String>();
		for(CouponCategoryEnum category : CouponCategoryEnum.values()){
			if(cate == 1){
				if(category.getCategory() == 1){
					categorys.put(category.getValue(), category.getMsg());
				}
			}else if(cate == 2){
				if(category.getCategory() == 2){
					categorys.put(category.getValue(), category.getMsg());
				}
			}else{
				categorys.put(category.getValue(), category.getMsg());
			}
		}
		model.addAttribute("categorys", categorys);
		
		Map<Integer, String> sources = new LinkedHashMap<Integer, String>();
		for(CouponRuleSourceEnum s : CouponRuleSourceEnum.values()){
			if(sou == 3){
				if(s.getValue() == 3){
					sources.put(s.getValue(), s.getMsg());
				}
			}else{
				sources.put(s.getValue(), s.getMsg());
			}
			
		}
		model.addAttribute("sources", sources);
		
		Map<String, String> propertys = new LinkedHashMap<String, String>();
		for(ProductCategoryPropertyEnum p : ProductCategoryPropertyEnum.values()){
			if (!StringUtils.equals(p.name(), ProductCategoryPropertyEnum.TREASURE.name())) {
				propertys.put(p.name(), p.toString());
			}
		}
		model.addAttribute("propertys", propertys);
		return  model;
    }
	
	@RequestMapping(value="/coupon/add/{type:\\d+}", method=RequestMethod.GET)
	public String toCouponAdd(@PathVariable("type")Integer type, Model model){
		this.getParam(model, 1, 0);
		model.addAttribute("type", type);
		return "coupon/coupon/add";
	}
	
	@RequestMapping(value="/coupon/save", method=RequestMethod.POST)
	public String saveCoupon(Coupon coupon,Integer type, String expiresPointTime, Integer amountFrom, Integer amountTo, Integer tradeAmountSington, Integer tradeAmountCount, RedirectAttributes redirectAttributes){
		if(coupon != null){
			if(type==1){
				if(coupon.getAmountCategory() == 1){
					coupon.setCategory(CouponCategoryEnum.PROBABILITY.getValue());
					coupon.setAmount(amountFrom +"-"+amountTo);
				}else {
					coupon.setCategory(CouponCategoryEnum.FIXATION.getValue());
				}
				coupon.setIncreaseDays(0);
			}else{
				coupon.setCategory(CouponCategoryEnum.COUPON.getValue());
				coupon.setAmountCategory(0);
			}
			int lifeCycle=coupon.getLifeCycle();
			if(lifeCycle == 0){
				coupon.setExpiresPoint(EMPTY);
			}
			if(lifeCycle == 1){
				coupon.setExpiresPoint(expiresPointTime);
			}
			if(coupon.getMoneyLimit() == 0){
				coupon.setTradeAmount(0);
			}
			if(coupon.getMoneyLimit() == 1){
				coupon.setTradeAmount(tradeAmountSington);
			}
			if(coupon.getMoneyLimit() == 2){
				coupon.setTradeAmount(tradeAmountCount);
			}
			couponService.save(coupon);
		}
		redirectAttributes.addAttribute("type", type);
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/coupon/coupon/list";
	}
	
	@RequestMapping(value="/coupon/detail/{couponId:\\d+}/{type:\\d+}", method=RequestMethod.GET)
	public String toCouponDetail(@PathVariable("couponId")int couponId, @PathVariable("type")int type, Model model){
		int category = 1;
		if(couponId > 0){
			Coupon coupon = couponService.get(couponId);
			if (coupon != null && coupon.getCategory() == 4) {
				category = 2;
			}
			model.addAttribute("coupon", coupon);
		}
		model.addAttribute("operation",ConstantUtil.DETAIL);
		this.getParam(model, 4, 0);
		model.addAttribute("type", category);
		return "coupon/coupon/edit";
	}
	
	@RequestMapping(value="/coupon/edit/{couponId:\\d+}/{type:\\d+}", method=RequestMethod.GET)
	public String toCouponEdit(@PathVariable("couponId")int couponId, @PathVariable("type")int type, Model model){
		if(couponId > 0){
			Coupon coupon = couponService.get(couponId);
			model.addAttribute("coupon", coupon);
		}
		model.addAttribute("operation",ConstantUtil.EDIT);
		model.addAttribute("type",type);
		this.getParam(model,4,0);
		return "coupon/coupon/edit";
	}
	
	@RequestMapping("/bonus/rule/list")
	public String listRule(Model model){
		List<DispatchingCouponRule> rules = couponService.ruleList();
		List<DispatchingCouponRule> list =new ArrayList<DispatchingCouponRule>();
		
		if (rules != null && rules.size() > 0) {
			for (DispatchingCouponRule rule : rules) {
				if(rule.getSource()==CouponRuleSourceEnum.CHANNEL_ONE.getValue() 
						|| rule.getSource()==CouponRuleSourceEnum.CHANNEL_TWO.getValue()
						|| rule.getSource()==CouponRuleSourceEnum.CHANNEL_THREE.getValue()){
					continue;
				}
				list.add(rule);
			}
		}
		if(list !=null && list.size()>0){
			for (DispatchingCouponRule rule : list) {
				if(rule.getSource() == CouponRuleSourceEnum.VIP_EXCLUSIVE.getValue() ){
					List<CouponVipEntity> vipBirthdayBouns = couponService.selectByCouponType(ConstantUtil.VIP_EXCLUSIVE_COUPON);
					String couponIds = "";
					String couponAmounts = "";
					String couponAmount="";
					for (int i = 0; i < vipBirthdayBouns.size(); i++) {
						if(vipBirthdayBouns.get(i).getCoupon() != null){
							if(vipBirthdayBouns.get(i).getCoupon().getCategory()==CouponCategoryEnum.FIXATION.getValue()){
							    couponAmount= vipBirthdayBouns.get(i).getCoupon().getAmount()+ConstantUtil.YUAN;
							}
							if(vipBirthdayBouns.get(i).getCoupon().getCategory()==CouponCategoryEnum.COUPON.getValue()){
								couponAmount=vipBirthdayBouns.get(i).getCoupon().getAmount()+ConstantUtil.PERCENT +"("+vipBirthdayBouns.get(i).getCoupon().getIncreaseDays()+"天)";
							}
							if (i == 0) {
								couponIds += vipBirthdayBouns.get(i).getCoupon().getId();
								couponAmounts += couponAmount;
							} else {
								couponIds += (COMMA + vipBirthdayBouns.get(i).getCoupon().getId());
								couponAmounts += (COMMA + couponAmount);
							}
						}
					}
					rule.setCouponIds(couponIds);
					rule.setCouponAmounts(couponAmounts);
				  }
				if(rule.getSource() == CouponRuleSourceEnum.BIRTHDAY.getValue() ){
					List<CouponVipEntity> vipBirthdayBouns = couponService.selectByCouponType(ConstantUtil.VIP_BIRTHDAY_COUPON);
					String couponIds = "";
					String couponAmounts = "";
					String couponAmount="";
					for (int i = 0; i < vipBirthdayBouns.size(); i++) {
						if(vipBirthdayBouns.get(i).getCoupon() != null){
							if(vipBirthdayBouns.get(i).getCoupon().getCategory()==CouponCategoryEnum.FIXATION.getValue()){
							    couponAmount= vipBirthdayBouns.get(i).getCoupon().getAmount()+ConstantUtil.YUAN;
							}
							if (i == 0) {
								couponIds += vipBirthdayBouns.get(i).getCoupon().getId();
								couponAmounts += couponAmount;
							} else {
								couponIds += (COMMA + vipBirthdayBouns.get(i).getCoupon().getId());
								couponAmounts += (COMMA + couponAmount);
							}
						}
					}
					rule.setCouponIds(couponIds);
					rule.setCouponAmounts(couponAmounts);
				}
			
				if (rule.getSource() == CouponRuleSourceEnum.PAYBACK_COUPON.getValue()) {
					if(rule.getQuantity()>0){
						rule.setQuantity(0);
					}
					List<RuleCoupon> ruleCoupons = couponService.list(rule.getId());
					String couponIds = "";
					String couponAmounts = "";
					for (int i = 0; i < ruleCoupons.size(); i++) {
						if (i == 0) {
							couponIds += ruleCoupons.get(i).getCouponIds();
							couponAmounts += ruleCoupons.get(i).getCouponAmounts();
						} else {
							couponIds += (COMMA + ruleCoupons.get(i).getCouponIds());
							couponAmounts += (COMMA + ruleCoupons.get(i).getCouponAmounts());
						}
					}
					
					rule.setCouponAmounts(couponAmounts);
					rule.setCouponIds(couponIds);
				}
			}
		}
		model.addAttribute("dispatchingBonusLogs", list);
		Map<Integer, String> sources = new LinkedHashMap<Integer, String>();
		for(CouponRuleSourceEnum s : CouponRuleSourceEnum.values()){
			if(s.getValue()==CouponRuleSourceEnum.CHANNEL_ONE.getValue() 
					|| s.getValue()==CouponRuleSourceEnum.CHANNEL_TWO.getValue()
					|| s.getValue()==CouponRuleSourceEnum.CHANNEL_THREE.getValue()){
				continue;
			}
			sources.put(s.getValue(), s.getMsg());
		}
		model.addAttribute("sources", sources);
		return "coupon/bonus/rule/list";
	}
	
	@RequestMapping("/bonus/rule/{type}/{ruleId:\\d+}")
	public String editRule(@PathVariable("type")String type, @PathVariable("ruleId")int ruleId, Model model){
		Map<Integer, String> sources = new LinkedHashMap<Integer, String>();
		Map<Integer, String> vipLevels = new LinkedHashMap<Integer, String>();
		if(ruleId > 0){
			DispatchingCouponRule rule = couponService.getRule(ruleId);
			if(rule.getSource()== CouponRuleSourceEnum.BIRTHDAY.getValue()){
				List<CouponVipEntity> couponLists = couponService.selectByCouponType(ConstantUtil.VIP_BIRTHDAY_COUPON);
				model.addAttribute("couponLists", JSON.toJSON(couponLists));
				sources.put(CouponRuleSourceEnum.BIRTHDAY.getValue(), CouponRuleSourceEnum.BIRTHDAY.getMsg());
				model.addAttribute("sources", sources);
				model.addAttribute("rule", rule);
				model.addAttribute("vipLevels", vipLevels);
				model.addAttribute("operation",type);
				return "coupon/bonus/rule/vipedit";
			}
			if(rule.getSource()== CouponRuleSourceEnum.VIP_EXCLUSIVE.getValue()){
				List<CouponVipEntity> couponLists = couponService.selectByCouponType(ConstantUtil.VIP_EXCLUSIVE_COUPON);
				model.addAttribute("couponLists",JSON.toJSON(couponLists));
				sources.put(CouponRuleSourceEnum.VIP_EXCLUSIVE.getValue(), CouponRuleSourceEnum.VIP_EXCLUSIVE.getMsg());
				model.addAttribute("sources", sources);
				model.addAttribute("vipLevels", vipLevels);
				model.addAttribute("rule", rule);
				model.addAttribute("operation",type);
				return "coupon/bonus/rule/vipedit";
			    
			}
			List<Coupon> coupons = new LinkedList<Coupon>();
			model.addAttribute("ruleCoupons", JSON.toJSON(couponService.list(ruleId)));
			if(rule != null){
				String[] couponIds = null;
				String[] couponAmounts = null;
				if(StringUtils.isNotBlank(rule.getCouponIds())){
					couponIds = rule.getCouponIds().split(COMMA);
				}
				if(StringUtils.isNotBlank(rule.getCouponAmounts())){
					couponAmounts = rule.getCouponAmounts().split(COMMA);
				}
				if(StringUtils.isNotBlank(rule.getCouponIds())){
					if(couponIds.length > 0 && couponAmounts.length > 0){
						if(couponIds.length == couponAmounts.length){
							for(int i =0; i<couponIds.length; i++){
								Coupon coupon = new Coupon();
								coupon.setAmount(couponAmounts[i]);
								coupon.setId(Integer.parseInt(couponIds[i]));
								coupons.add(coupon);
							}
						}
					}
				}
			}
			for(CouponRuleSourceEnum s : CouponRuleSourceEnum.values()){
				sources.put(s.getValue(), s.getMsg());
			}
			model.addAttribute("sources", sources);
			model.addAttribute("coupons",coupons);
			model.addAttribute("rule", rule);
		}
		model.addAttribute("operation",type);
		return "coupon/bonus/rule/edit";
	}
	
	@RequestMapping("/coupon/rule/status")
	@ResponseBody
	public boolean auditRule(Integer ruleId, int status){
		if(ruleId != null && ruleId > 0 && status >= 0){
			DispatchingCouponRule rule = couponService.getRule(ruleId);
			if(rule != null){
				return couponService.enable(ruleId, status);
			}
		}
		return false;
	}
	
	@RequestMapping(value="/rule/save", method=RequestMethod.POST)
	public String saveCouponRule(DispatchingCouponRule rule, int[] couponIds, String[] couponNames, String[] couponAmounts){
		if(rule != null && CouponRuleSourceEnum.PAYBACK_COUPON.getValue() != rule.getSource()){
			if(couponIds != null && couponIds.length > 0){
				rule.setCouponIds(JSON.toJSONString(couponIds).replace(LEFT_SQUARE_BRACKET, EMPTY).replace(RIGHT_SQUARE_BRACKET, EMPTY));
			}
			if(couponAmounts != null && couponAmounts.length > 0){
				rule.setCouponAmounts(JSON.toJSONString(couponAmounts).replace(LEFT_SQUARE_BRACKET, EMPTY).replace(RIGHT_SQUARE_BRACKET, EMPTY).replaceAll("\"", EMPTY));
			}
		}
		if(rule != null && CouponRuleSourceEnum.VIP_EXCLUSIVE.getValue() == rule.getSource()){
			rule.setCouponIds(ConstantUtil.ZERO);
			rule.setCouponAmounts(ConstantUtil.BLANK);
		}
		if(rule != null && CouponRuleSourceEnum.BIRTHDAY.getValue() == rule.getSource()){
			rule.setCouponIds(ConstantUtil.ZERO);
			rule.setCouponAmounts(ConstantUtil.BLANK);
		}
		couponService.saveRule(rule);
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/coupon/bonus/rule/list";
	}
	
	@RequestMapping(value="/coupon/detail", method=RequestMethod.GET)
	@ResponseBody
	public Coupon couponDetail(int couponId) {
		if(couponId > 0){
			return couponService.get(couponId);
		}
		return null;
	}
	
	@RequestMapping("/bonus/template/list/{page:\\d+}")
	@ResponseBody
	public Map<String, Object> listTemplate(Integer size, @PathVariable("page")int page){
		Map<String, Object> result = new HashMap<String, Object>();
		int total = couponService.countSmsTemplate(1);
		if(total > 0){
			result.put("total", total);
			result.put("templates", couponService.listSmsTemplate(1, this.getOffset(page, size), this.getPageSize(size)));
		}else{
			result.put("total", 0);
			result.put("templates", new SmsTemplate[0]);
		}
		result.put("size", this.getPageSize(size));
		result.put("page", this.getPage(page));
		result.put("pages", this.getTotalPage(total, size));
		return result;
	}
	
	@RequestMapping("/coupon/goods/srource/list/{page:\\d+}")
	@ResponseBody
	public Map<String, Object> listGoodsSrourceCoupon(Integer category, Integer type, Integer size, @PathVariable("page")int page, HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		int total = couponService.count(type != null ? type : 0, category != null ? category : -1, null, GenericEnableEnum.ENABLE.value(), 1);
		if(total > 0){
			result.put("total", total);
			result.put("bonus", couponService.list(type != null ? type : 0, category != null ? category : -1, null, GenericEnableEnum.ENABLE.value(), 1, this.getOffset(page, size), this.getPageSize(size)));
		}else{
			result.put("total", 0);
			result.put("bonus", new ArrayList<DispatchingBonusLog>());
		}
		result.put("size", this.getPageSize(size));
		result.put("page", this.getPage(page));
		result.put("pages", this.getTotalPage(total, size));
		return result;
	}
	
	@RequestMapping("/invite/activity/list/{page:\\d+}")
	public String listInviteActivity(Integer size, @PathVariable("page")int page, Model model){
		SimpleDateFormat sdf = new SimpleDateFormat(NORMAL_DATE_FORMAT);
		int total = couponService.countInviteActivity();
		if(total > 0){
			model.addAttribute("total", total);
			model.addAttribute("activitys", couponService.listInviteActivity(this.getOffset(page, size), this.getPageSize(size)));
		}else{
			model.addAttribute("total", 0);
			model.addAttribute("activitys", new InviteActivity[0]);
		}
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		model.addAttribute("systemTime", sdf.format(new Date()));
		return "coupon/invite/list";
	}
	
	@RequestMapping(value="/invite/activity/add/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
	public String inviteActivityForwardToCreation(@PathVariable("page")int page, @PathVariable("size")int size, HttpServletRequest request){
		request.setAttribute("page", page);
		request.setAttribute("size", size);
		return "coupon/invite/add";
	}
	
	@RequestMapping(value="/invite/activity/save", method=RequestMethod.POST)
	public String saveInviteActivity(InviteActivity inviteActivity, String ruleStr, int page, int size, Model model) {
		if (StringUtils.isNotBlank(ruleStr)) {
			if (ValidatorUtil.isDate(inviteActivity.getBeginDate()) && ValidatorUtil.isDate(inviteActivity.getEndDate())) {
				couponService.saveInviteActivity(inviteActivity, ruleStr);
			}
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/coupon/invite/activity/list/"+page;
	}
	
	@RequestMapping(value="/invite/activity/rule/list/{activityId:\\d+}", method=RequestMethod.GET)
	@ResponseBody
	public List<InviteActivityRule> listLotteryPrize(@PathVariable("activityId")int activityId){
		if (activityId > 0) {
			return couponService.selectRuleById(activityId);
		} else {
			return new ArrayList<InviteActivityRule>(0);
		}
	}
	
	@RequestMapping(value="/invite/activity/{id:\\d+}/edit/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
	public String inviteActivityForwardToModification(@PathVariable("id")int id, @PathVariable("page")int page, @PathVariable("size")int size,HttpServletRequest request){
		request.setAttribute("activity", couponService.getInviteActivity(id)); 
		request.setAttribute("page", page);
		request.setAttribute("size", size);
		request.setAttribute("operation",ConstantUtil.EDIT);
		return "coupon/invite/edit";
	}
	
	@RequestMapping(value="/invite/activity/{id:\\d+}/detail/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
	public String inviteActivityDetailForwardToModification(@PathVariable("id")int id, @PathVariable("page")int page, @PathVariable("size")int size,HttpServletRequest request){
		request.setAttribute("activity", couponService.getInviteActivity(id)); 
		request.setAttribute("page", page);
		request.setAttribute("size", size);
		request.setAttribute("operation",ConstantUtil.DETAIL);
		return "coupon/invite/edit";
	}
	
	@RequestMapping("/invite/activity/detail/list/{activityId:\\d+}")
	public String listLotteryLog(@PathVariable("activityId")int activityId, String inviteCellphone, String cellphone, String type, Integer period, String beginTime, String endTime, Integer page, Integer size, Model model){
		if (activityId <= 0) {
			model.addAttribute("total", 0);
			model.addAttribute("logs", new InviteActivityLog[0]);
			return "coupon/invite/detail";
		}
		if(period == null){
			period = 0;
		}
		int total = couponService.countInviteActivityLogs(activityId, inviteCellphone, cellphone, type, period, beginTime, endTime);
		if(total > 0){
			List<InviteActivityLog> logs = couponService.getInviteActivityLogs(activityId, inviteCellphone, cellphone, type, period, beginTime, endTime, this.getOffset(page, size), this.getPageSize(size));
			model.addAttribute("total", total);
			model.addAttribute("logs",logs);
		}else{
			model.addAttribute("total", 0);
			model.addAttribute("logs", new InviteActivityLog[0]);
		}
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		model.addAttribute("activityId", activityId);
		model.addAttribute("cellphone", cellphone);
		model.addAttribute("inviteCellphone", inviteCellphone);
		model.addAttribute("type", type);
		model.addAttribute("period", period);
		model.addAttribute("beginTime", beginTime);
		model.addAttribute("endTime", endTime);
		return "coupon/invite/detail";
	}
	
	@RequestMapping(value="/invite/activity/validate/time/{id:\\d+}", method=RequestMethod.POST)
	@ResponseBody
	public boolean validateTime(@PathVariable("id")int id) {
		return couponService.validateTime(id);
	}
	
	@RequestMapping(value="/invite/activity/status", method=RequestMethod.POST)
	@ResponseBody
	public boolean auditActivity(int id, int status) {
		return couponService.auditActivity(id, status);
	}
	
	@RequestMapping("/bonus/aggregate/list")
	public String listAggregate(Integer category, Integer source, String cellphone, String sort, Integer size, Integer page, Model model){
		int total = couponService.count(0, CouponCategoryEnum.AGGREGATE.getValue(), null, GenericEnableEnum.ALL.value(), -1);
		if (total > 0) {
			model.addAttribute("total", total);
		    model.addAttribute("coupons", couponService.list(0, CouponCategoryEnum.AGGREGATE.getValue(), null, GenericEnableEnum.ALL.value(), -1,  0, 15));
		} else {
			model.addAttribute("total", 0);
			model.addAttribute("coupons", new Coupon[0]);
		}
		
		int totalCustomerAggregate = couponService.countCustomerAggregate(CouponCategoryEnum.AGGREGATE.getValue(), source != null ? source  : -1, StringUtils.trimToEmpty(cellphone));
		if(totalCustomerAggregate > 0){
			model.addAttribute("totalCustomerAggregate", totalCustomerAggregate);
		    model.addAttribute("bonusAggregates", couponService.listCustomerAggregate(CouponCategoryEnum.AGGREGATE.getValue(), source != null ? source  : -1, StringUtils.trimToEmpty(cellphone), sort, this.getOffset(page, size), this.getPageSize(size)));
		}else{
			model.addAttribute("totalCustomerAggregate", 0);
		    model.addAttribute("bonusAggregates", new CouponStatisticsEntity[0]);

		}
		
		Map<Integer, String> sources = new LinkedHashMap<Integer, String>();
		for(CouponRuleSourceEnum s : CouponRuleSourceEnum.values()){
			sources.put(s.getValue(), s.getMsg());
		}
		
		model.addAttribute("sources", sources);
		model.addAttribute("cellphone", StringUtils.trimToEmpty(cellphone));
		model.addAttribute("sort", sort);
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(totalCustomerAggregate, size));
		return "coupon/bonus/aggregate/list";
	}
	
	@RequestMapping("/bonus/aggregate/detail/{bonusId:\\d+}")
	public String detailAggregate(@PathVariable("bonusId")int bonusId, Model model){
		if(bonusId > 0){
			Coupon bonus = couponService.get(bonusId);
			model.addAttribute("bonus", bonus);
		}
		this.getParam(model,2,3);
		model.addAttribute("operation",ConstantUtil.DETAIL);
		return "coupon/bonus/aggregate/edit";
	}
	
	@RequestMapping("/bonus/aggregate/edit/{bonusId:\\d+}")
	public String editAggregate(@PathVariable("bonusId")int bonusId, Model model){
		if(bonusId > 0){
			Coupon bonus = couponService.get(bonusId);
			model.addAttribute("bonus", bonus);
		}
		this.getParam(model, 2, 3);
		model.addAttribute("operation",ConstantUtil.EDIT);
		return "coupon/bonus/aggregate/edit";
	}
	
	@RequestMapping(value="/bonus/aggregate/save", method=RequestMethod.POST)
	public String saveAggregate(Coupon coupon, Integer tradeAmountSington){
		if(coupon.getMoneyLimit() == 1){
			coupon.setTradeAmount(tradeAmountSington);
		}else{
			coupon.setTradeAmount(0);
		}
		coupon.setIncreaseDays(0);
		couponService.save(coupon);
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/coupon/bonus/aggregate/list";
	}
	
	@RequestMapping("/bonus/aggregate/detail/customer/{customerId:\\d+}")
	public String detailCustomerAggregate(Integer bonusSize, Integer bonusPage, Integer inviterSize, Integer inviterPage, String category, @PathVariable("customerId")Integer customerId, Model model){
		if(customerId != null){
			int bonusTotal = couponService.countBonusRecord(customerId);
			if(bonusTotal > 0){
				model.addAttribute("bonusTotal", bonusTotal);
				model.addAttribute("bonusRecords", couponService.listBonusRecord(customerId, this.getOffset(bonusPage, bonusSize), this.getPageSize(bonusSize)));
			}else{
				model.addAttribute("bonusTotal", 0);
				model.addAttribute("bonusRecords", new BonusRecordEntity[0]);
			}
			User user = couponService.getUser(customerId);
			int inviterTotal = 0;
			if (user != null) {
				inviterTotal = couponService.countInviterRecord(user.getCellphone());
				if(inviterTotal > 0){
					model.addAttribute("inviterTotal", inviterTotal);
					model.addAttribute("inviterRecords", couponService.listInviterRecord(user.getCellphone(), this.getOffset(inviterPage, inviterSize), this.getPageSize(inviterSize)));
				}else{
					model.addAttribute("inviterTotal", 0);
					model.addAttribute("inviterRecords", new InviterRecordEntity[0]);
				}
			}
			
			model.addAttribute("customerId", customerId);
			//model.addAttribute("cellphone", cellphone);
			model.addAttribute("category", category);
			model.addAttribute("bonusSize", this.getPageSize(bonusSize));
			model.addAttribute("bonusPage", this.getPage(bonusPage));
			model.addAttribute("bonusPages", this.getTotalPage(bonusTotal, bonusSize));
			model.addAttribute("inviterSize", this.getPageSize(inviterSize));
			model.addAttribute("inviterPage", this.getPage(inviterPage));
			model.addAttribute("inviterPages", this.getTotalPage(inviterTotal, inviterSize));
		}
		return "coupon/bonus/aggregate/detail";
	}
	
	@RequestMapping("/bonus/give/list")
	public String listGive(Integer size, Integer page, Model model){
		int total = couponService.count(null, 0);
		if (total > 0) {
			model.addAttribute("total", total);
		    model.addAttribute("dispatchingBonusLogs", couponService.list(null, 0, this.getOffset(page, size), this.getPageSize(size)));
		} else {
			model.addAttribute("total", 0);
			model.addAttribute("dispatchingBonusLogs", new ArrayList<DispatchingBonusLog>(0));
		}
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "coupon/bonus/give/list";
	}
	
	@RequestMapping(value="/bonus/give/add", method=RequestMethod.GET)
	public String toGiveAdd(Model model){
		return "coupon/bonus/give/add";
	}
	
	@RequestMapping(value="/bonus/give/save", method=RequestMethod.POST)
	public String saveGive(DispatchingBonusLog dispatchingBonusLog, String datePoint, int[] couponIds, String[] couponAmounts, String[] coupons){
		if (dispatchingBonusLog != null && dispatchingBonusLog.getSatisfyType() == null) {
			dispatchingBonusLog.setSatisfyType(0);
		}
		if (dispatchingBonusLog != null && dispatchingBonusLog.getSatisfyType() == 5) {
			dispatchingBonusLog.setEndDate(datePoint);
		}
		couponDispatchingBonusLog(dispatchingBonusLog, couponIds, couponAmounts);
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/coupon/bonus/give/list";
	}
	
	private void couponDispatchingBonusLog(DispatchingBonusLog dispatchingBonusLog, int[] couponIds, String[] couponAmounts){
		if(dispatchingBonusLog != null){
			if(couponIds != null && couponIds.length > 0){
				dispatchingBonusLog.setCouponIds(JSON.toJSONString(couponIds).replace(LEFT_SQUARE_BRACKET, EMPTY).replace(RIGHT_SQUARE_BRACKET, EMPTY));
			}
			
			if(couponAmounts.length > 0){
				dispatchingBonusLog.setCouponAmounts(JSON.toJSONString(couponAmounts).replace(LEFT_SQUARE_BRACKET, EMPTY).replace(RIGHT_SQUARE_BRACKET, EMPTY).replaceAll("\"", EMPTY));
			}
		}
		couponService.saveDispatchingBonusLog(dispatchingBonusLog);
	}
	
	@RequestMapping(value="/user/exist", method=RequestMethod.POST )
	@ResponseBody
	public JSONObject checkUser(String cellphones) {
		String[] cellphoneArry = StringUtils.split(cellphones, SEMICOLON);
		List<String> list = Arrays.asList(cellphoneArry);
		return clientService.getCellphones(list);
	}
	
	@RequestMapping("/bonus/give/detail/{dispatchingBonusLogId:\\d+}")
	public String detailGive(@PathVariable("dispatchingBonusLogId")int dispatchingBonusLogId, Model model){
		if(dispatchingBonusLogId > 0){
			DispatchingBonusLog dispatchingBonusLog = couponService.getDispatchingBonusLog(dispatchingBonusLogId);
			List<Coupon> coupons = new LinkedList<Coupon>();
			if(dispatchingBonusLog != null){
				String[] couponIds = null;
				String[] couponAmounts = null;
				if(dispatchingBonusLog.getCouponIds() != null){
					couponIds = dispatchingBonusLog.getCouponIds().split(COMMA);
				}
				if(dispatchingBonusLog.getCouponAmounts() != null){
					couponAmounts = dispatchingBonusLog.getCouponAmounts().split(COMMA);
				}
				if(couponIds != null && couponIds.length > 0 && couponAmounts != null && couponAmounts.length > 0){
					if(couponIds.length == couponAmounts.length){
						for(int i =0; i<couponIds.length; i++){
							Coupon coupon = new Coupon();
							coupon.setAmount(couponAmounts[i]);
							coupon.setId(Integer.parseInt(couponIds[i]));
							coupons.add(coupon);
						}
					}
				}
			}
			model.addAttribute("dispatchingBonusLog", dispatchingBonusLog);
		}
		this.getParam(model,2,3);
		model.addAttribute("operation",DETAIL);
		return "coupon/bonus/give/edit";
	}
	
	@RequestMapping("/bonus/give/edit/{dispatchingBonusLogId:\\d+}")
	public String editGive(@PathVariable("dispatchingBonusLogId")int dispatchingBonusLogId, Model model){
		if(dispatchingBonusLogId > 0){
			DispatchingBonusLog dispatchingBonusLog = couponService.getDispatchingBonusLog(dispatchingBonusLogId);
			List<Coupon> coupons = new LinkedList<Coupon>();
			if(dispatchingBonusLog != null){
				String[] couponIds = null;
				String[] couponAmounts = null;
				if(dispatchingBonusLog.getCouponIds() != null){
					couponIds = dispatchingBonusLog.getCouponIds().split(COMMA);
				}
				if(dispatchingBonusLog.getCouponAmounts() != null){
					couponAmounts = dispatchingBonusLog.getCouponAmounts().split(COMMA);
				}
				if(couponIds != null && couponIds.length > 0 && couponAmounts != null && couponAmounts.length > 0){
					if(couponIds.length == couponAmounts.length){
						for(int i =0; i<couponIds.length; i++){
							Coupon coupon = new Coupon();
							coupon.setAmount(couponAmounts[i]);
							coupon.setId(Integer.parseInt(couponIds[i]));
							coupons.add(coupon);
						}
					}
				}
			}
			
			model.addAttribute("dispatchingBonusLog", dispatchingBonusLog);
		}
		model.addAttribute("operation",EDIT);
		return "coupon/bonus/give/edit";
	}
	
	@RequestMapping("/bonus/give/status")
	@ResponseBody
	public boolean auditGiveBonus(Integer dispatchingBonusLogId, Short status, Integer initStatus){
		if(dispatchingBonusLogId != null && dispatchingBonusLogId > 0 && status > 0){
			DispatchingBonusLog dispatchingBonusLog = couponService.getDispatchingBonusLog(dispatchingBonusLogId);
			if(dispatchingBonusLog != null && dispatchingBonusLog.getStatus() == initStatus){
				if(initStatus <= 1 && status == 2 && dispatchingBonusLog.getCouponIds() != null){
					List<Coupon> coupons = couponService.getDispatchingBonusLogCoupon(dispatchingBonusLogId);
					int flag = 0;
					for(Coupon c : coupons){
						if(c.getStatus() != GenericEnableEnum.ENABLE.value()){
							flag ++;
						}
					}
					if(flag <= 0){
						dispatchingBonusLog.setStatus(status);
						return couponService.saveDispatchingBonusLogs(dispatchingBonusLog);
					}
				}else{
					dispatchingBonusLog.setStatus(status);
					return couponService.saveDispatchingBonusLogs(dispatchingBonusLog);
				}
			}
		}
		return false;
	}
	
	@RequestMapping(value="/give/user/{dispatchingId:\\d+}", method=RequestMethod.POST )
	@ResponseBody
	public boolean giveCoupon(@PathVariable("dispatchingId")int dispatchingId) {
		if(dispatchingId > 0){
			return clientService.giveCouponInBatch(dispatchingId);
		}
		return false;
	}
	
	@RequestMapping(value="/dispatching/log/{dispatchingBonusLogId:\\d+}", method=RequestMethod.GET )
	@ResponseBody
	public DispatchingBonusLog getDispatchingBonusLog(@PathVariable("dispatchingBonusLogId")int dispatchingBonusLogId) {
		return couponService.getDispatchingBonusLog(dispatchingBonusLogId);
	}
	
	@RequestMapping("/bonus/{type}/record/{dispatchingBonusLogId:\\d+}")
	public String listCoupon(Integer category,  String cellphone, Integer used, Integer size, Integer page, @PathVariable("type")String type, @PathVariable("dispatchingBonusLogId")Integer dispatchingBonusLogId, Model model){
		category = category != null ? category : -1;
		used = used !=null ? used : UsedStatusEnum.ALL.getValue();
		int total = couponService.countByDispatchingBonusLogId(category, cellphone, used, dispatchingBonusLogId);
		if (total > 0) {
			model.addAttribute("total", total);
			List<CustomerCoupon> list = couponService.getByDispatchingBonusLogId(category, cellphone, used, dispatchingBonusLogId, this.getOffset(page, size), this.getPageSize(size));
		    model.addAttribute("customerCoupons", list);
		} else {
			model.addAttribute("total", 0); 
			model.addAttribute("customerCoupons", new ArrayList<CustomerCoupon>());
		}
		model.addAttribute("type", type);
		model.addAttribute("category", category);
		model.addAttribute("cellphone", cellphone);
		model.addAttribute("used", used);
		model.addAttribute("dispatchingBonusLogId", dispatchingBonusLogId);
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "coupon/bonus/record";
	}
	
	@RequestMapping(value="/exchange/add", method=RequestMethod.GET)
	public String toExchangeAdd(Model model){
		return "coupon/exchange/add";
	}
	
	@RequestMapping("/exchange/list")
	public String listExchange(Integer category, Integer source, String cellphone, String sort, Integer size, Integer page, Model model){
		int total = couponService.countExchange();
		if (total > 0) {
			model.addAttribute("total", total);
		    model.addAttribute("exchanges", couponService.listExchange(this.getOffset(page, size), this.getPageSize(size)));
		} else {
			model.addAttribute("total", 0); 
			model.addAttribute("exchanges", new Coupon[0]);
		}
		SimpleDateFormat sdf = new SimpleDateFormat(NORMAL_DATE_FORMAT);
		model.addAttribute("systemTime", sdf.format(new Date()));
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "coupon/exchange/list";
	}
	
	@RequestMapping(value="/exchange/save", method=RequestMethod.POST)
	public String saveExchange(CouponExchange couponExchange, String code){
		if(couponExchange != null){
			couponService.saveCouponExchange(couponExchange, code);
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/coupon/exchange/list";
	}
	
	@RequestMapping("/bonus/give/srource/list/{page:\\d+}")
	@ResponseBody
	public Map<String, Object> listGive(Integer category, String name, Integer size, @PathVariable("page")int page, HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		int total = couponService.count(1,category == null ? -1 : category, name, GenericEnableEnum.ENABLE.value(), 1);
		if(total > 0){
			result.put("total", total);
			result.put("bonus", couponService.list(1,category == null ? -1 : category, name, GenericEnableEnum.ENABLE.value(),1, this.getOffset(page, size), this.getPageSize(size)));
		}else{
			result.put("total", 0);
			result.put("bonus", new ArrayList<DispatchingBonusLog>());
		}
		result.put("size", this.getPageSize(size));
		result.put("page", this.getPage(page));
		result.put("pages", this.getTotalPage(total, size));
		return result;
	}

	@RequestMapping(value="/exchange/detail/{couponExchangeId:\\d+}", method=RequestMethod.GET)
	public String toCouponExchangeDetail(@PathVariable("couponExchangeId")int couponExchangeId, Model model){
		if(couponExchangeId > 0){
			CouponExchange couponExchange = couponService.getCouponExchange(couponExchangeId);
			model.addAttribute("couponExchange", couponExchange);
		}
		model.addAttribute("operation",DETAIL);
		return "coupon/exchange/edit";
	}

	@RequestMapping(value="/exchange/edit/{couponExchangeId:\\d+}", method=RequestMethod.GET)
	public String toCouponExchangeEdit(@PathVariable("couponExchangeId")int couponExchangeId, Model model){
		if(couponExchangeId > 0){
			CouponExchange couponExchange = couponService.getCouponExchange(couponExchangeId);
			model.addAttribute("couponExchange", couponExchange);
		}
		model.addAttribute("operation",EDIT);
		return "coupon/exchange/edit";
	}

	@RequestMapping("/exchange/status")
	@ResponseBody
	public boolean auditExchange(Integer couponExchangeCodeId, Integer status, Integer initStatus){
		if(couponExchangeCodeId != null && couponExchangeCodeId > 0 && status > 0){
			CouponExchange couponExchange = couponService.getCouponExchange(couponExchangeCodeId);
			if(couponExchange != null && couponExchange.getStatus() == initStatus){
				couponExchange.setStatus(status);
				return couponService.changeStatus(couponExchange);
			}
		}
		return false;
	}
	
	@RequestMapping("/exchange/codes/{couponExchangeId:\\d+}")
	public String listGoodsCodes(@PathVariable("couponExchangeId") int couponExchangeId, String beginTime, String endTime, Integer type, Integer used, Integer size, Integer page, Model model){
			int total = couponService.countCouponExchange(couponExchangeId, beginTime, endTime, type != null ? type : -1 , used != null ? used : -1);
			if(total > 0){
				model.addAttribute("total", total);
				model.addAttribute("customerCoupons", couponService.listCouponExchange(couponExchangeId, beginTime, endTime, type != null ? type : 0 , used != null ? used : -1, this.getOffset(page, size), this.getPageSize(size)));
			}else{
				model.addAttribute("total", 0);
				model.addAttribute("customerCoupons", new CustomerCoupon[0]);
			}
			model.addAttribute("couponExchangeId", couponExchangeId);
			model.addAttribute("beginTime", StringUtils.trimToEmpty(beginTime));
			model.addAttribute("endTime", StringUtils.trimToEmpty(endTime));
			model.addAttribute("type", type);
			model.addAttribute("used", used);
			model.addAttribute("size", this.getPageSize(size));
			model.addAttribute("page", this.getPage(page));
			model.addAttribute("pages", this.getTotalPage(total, size));
			return "coupon/exchange/codes";
	}
	
	@RequestMapping("/card/list")
	public String listCouponCard(String cardNO, String cellphone, Integer used, Integer size, Integer page, Model model){
		int total = couponService.countCouponCard(cardNO, cellphone, used != null ? used : -1);
		if (total > 0) {
			model.addAttribute("total", total);
		    model.addAttribute("couponCards", couponService.listCouponCard(cardNO, cellphone, used != null ? used : -1, this.getOffset(page, size), this.getPageSize(size)));
		} else {
			model.addAttribute("total", 0); 
			model.addAttribute("couponCards", new CouponCardLog[0]);
		}
		model.addAttribute("cardNO", cardNO);
		model.addAttribute("cellphone", cellphone);
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "coupon/card/list";
	}
	
	@RequestMapping(value="/card/import", method=RequestMethod.POST)
	@ResponseBody
	public JSONObject cardImport(HttpServletRequest request) {
		JSONObject saveResult = new JSONObject();
		List<CouponCardLog> couponCardLogs = this.importCard(request);
		if(couponCardLogs.size() > 0){
			saveResult = couponService.saveCouponCards(couponCardLogs);
			if(saveResult.containsKey("code") && saveResult.containsKey("msg")){
				int code = saveResult.getIntValue("code");
				if(code == 200){
					return saveResult;
				}
				if(code == 500){
					String msg = saveResult.getString("msg");
					int i=msg.indexOf("Duplicate entry");
					int j=msg.indexOf("for key");
					if(i != -1 && j != -1){
						saveResult.put("msg", msg.substring(i+15, j).trim().replaceAll("'", ""));
					}else{
						saveResult.put("code", 501);
					}
				}
			}
			return saveResult;
		}else{
			saveResult.put("code", 502);
		}
		return saveResult;
	}
	
	private List<CouponCardLog> importCard(HttpServletRequest request){
		List<CouponCardLog> couponCardLogs = new LinkedList<CouponCardLog>();
		CommonsMultipartResolver multipartResolver  = new CommonsMultipartResolver(request.getSession().getServletContext());
    	if(multipartResolver.isMultipart(request)){
    		MultipartHttpServletRequest  multiRequest = (MultipartHttpServletRequest)request;
    	    Iterator<String>  iterator = multiRequest.getFileNames();
    		 while(iterator.hasNext()){
 		    	MultipartFile file = multiRequest.getFile(iterator.next());
 				BufferedReader br=null;
 				try {
 					InputStreamReader isr = new InputStreamReader(file.getInputStream(),ConstantUtil.GBK);
 					br = new BufferedReader(isr);
 					String line = "";
 					int index = 0;
 					int row = 0;
 		            while ((line = br.readLine()) != null) {
 		            	index ++;
 		            	if(index == 1){
 		            		continue;
 		            	}
 		            	if(StringUtils.isNotBlank(line)){
 		            		if(line.split(COMMA).length == 4){
 		            			if(StringUtils.isBlank(line.split(COMMA)[0])){
 		            				continue;
 		            			}
 		            			//Pattern pattern = Pattern.compile("[\u4e00-\u9fa5]");
 		            			//Matcher matcherCardNo = pattern.matcher(line.split(COMMA)[1]);  
 		            			if(StringUtils.isBlank(line.split(COMMA)[1]) /*||matcherCardNo.find()*/ || line.split(COMMA)[1].length() > 30){
 		            				continue;
 		            			}
 		            			//Matcher matcherPassword = pattern.matcher(line.split(COMMA)[2]);  
 		            			if(StringUtils.isBlank(line.split(COMMA)[2]) /*|| matcherPassword.find()*/ || line.split(COMMA)[2].length() > 30){
 		            				continue;
 		            			}
 		            			if(StringUtils.isBlank(line.split(COMMA)[3])){
 		            				continue;
 		            			}
 		            			if(Float.parseFloat(line.split(COMMA)[3]) <= 0f){
 		            				continue;
 		            			}
 		            			CouponCardLog cardLog = new CouponCardLog();
 		            			cardLog.setName(line.split(COMMA)[0].trim());
 		            			cardLog.setCardNO(line.split(COMMA)[1].trim());
 		            			cardLog.setPassword(line.split(COMMA)[2].trim());
 		            			cardLog.setAmount(Float.parseFloat(line.split(COMMA)[3].trim()));
 		            			cardLog.setCellphone(ConstantUtil.BLANK);
 		            			cardLog.setOrderNO(ConstantUtil.BLANK);
 		            			cardLog.setCreateTime(null);
 		            			couponCardLogs.add(cardLog);
 		        				row ++;
 		        				if(row > 999){
 		        					break;
 		        				}
 		            		}
 		            	}
 		            }
 				} catch (Exception e) {
 					e.printStackTrace();
 					LOGGER.info(e.getMessage());
 				}finally{
 					if(br!=null){
 						try{
 							br.close();
 							br=null;
 						}catch(IOException e){
 							e.printStackTrace();
 							LOGGER.info(e.getMessage());
 						}
 					}
 				}
 		    }
    	}
		return couponCardLogs;
	}
	
	@RequestMapping("/card/record/{page:\\d+}")
	public String couponCardRecord(String cardNO, String name, Float amount, @PathVariable("page")Integer page, Integer size, Model model){
		int total = couponService.countCouponCardRecord(cardNO, null, name, amount != null ? amount : 0, 0, null, null);
		if (total > 0) {
			model.addAttribute("total", total);
			model.addAttribute("couponCards", couponService.listCouponCardRecord(cardNO, null, name, amount != null ? amount : 0, 0, null, null, this.getOffset(page, size), this.getPageSize(size)));
		} else {
			model.addAttribute("total", 0); 
			model.addAttribute("couponCards", new CouponCardLog[0]);
		}
		model.addAttribute("cardNO", cardNO);
		model.addAttribute("name", name);
		model.addAttribute("amount", amount);
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "coupon/card/stock";
	}
	
	@RequestMapping("/card/used/record")
	public String usedRecord(String cardNO, String cellphone, Integer used, String beginTime, String endTime, Integer size, Integer page, Model model){
		int total = couponService.countCouponCardRecord(cardNO, cellphone, null, 0, used != null ? used : 1, beginTime, endTime);
		if (total > 0) {
			model.addAttribute("total", total);
		    model.addAttribute("couponCards", couponService.listCouponCardRecord(cardNO, cellphone, null, 0, used != null ? used : 1, beginTime, endTime, this.getOffset(page, size), this.getPageSize(size)));
		} else {
			model.addAttribute("total", 0); 
			model.addAttribute("couponCards", new CouponCardLog[0]);
		}
		model.addAttribute("beginTime", beginTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("cardNO", cardNO);
		model.addAttribute("cellphone", cellphone);
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "coupon/card/record";
	}
	
	@RequestMapping("/card/grant/{id:\\d+}/{cellphone}")
	@ResponseBody
	public boolean grantCard(@PathVariable("id")Integer id, @PathVariable("cellphone")String cellphone){
		if(id != null && id > 0 && StringUtils.isNotBlank(cellphone)){
			return couponService.grantCard(id, cellphone);
		}
		return false;
	}

	@RequestMapping("/card/group/list/{page:\\d+}")
	@ResponseBody
	public Map<String, Object> groupListCouponCard(Integer size, @PathVariable("page")int page, HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		int total = couponService.countCouponCard(null, null, 0);
		if(total > 0){
			result.put("total", total);
			result.put("couponCards", couponService.listCouponCard(null, null, 0, this.getOffset(page, size), this.getPageSize(size)));
		}else{
			result.put("total", 0);
			result.put("couponCards", new ArrayList<CouponCardLog>());
		}
		result.put("size", this.getPageSize(size));
		result.put("page", this.getPage(page));
		result.put("pages", this.getTotalPage(total, size));
		return result;
	}

	@RequestMapping("/grab/record/{couponActivityId:\\d+}")
	public String couponActivityRecord(String cellphone, Integer used, Integer size, Integer page, @PathVariable("couponActivityId")int couponActivityId, Model model){
		used = used !=null ? used : UsedStatusEnum.ALL.getValue();
		int total = couponService.countCouponActivityRecord(cellphone, used, couponActivityId);
		if(total > 0){
			model.addAttribute("total", total);
			model.addAttribute("customerCoupons", couponService.listCouponActivityRecord(cellphone, used, couponActivityId, this.getOffset(page, size), this.getPageSize(size)));
		}else{
			model.addAttribute("total", 0);
			model.addAttribute("customerCoupons", new ArrayList<CustomerCoupon>());
		}
		model.addAttribute("couponActivityId", couponActivityId);
		model.addAttribute("cellphone", cellphone);
		model.addAttribute("used", used);
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "activity/activity/grab/record";
	}

	@RequestMapping(value="/invite/activity/validate/name", method=RequestMethod.GET)
	@ResponseBody
	public String duplicateLotteryName(String fieldId, String fieldValue, int id) {
		if (id >= 0 && StringUtils.isNotBlank(fieldId) && StringUtils.isNotBlank(fieldValue)) {
			ArrayObjectEntity json = new ArrayObjectEntity();
			if (couponService.duplicateInviteActivityName(id, fieldValue)) {
				json.setObject(fieldId);
				json.setSuccess(false);
				json.setMessage(messageSource.getMessage("bonus.occupy", null, Locale.getDefault())); 
			} else {
				json.setObject(fieldId);
				json.setSuccess(true);
				json.setMessage(messageSource.getMessage("bonus.leisure", null, Locale.getDefault())); 
			}
			return json.toString(); 
		}
		return null;	
	}
	
	@RequestMapping("/exchange/codes/export")
	@ResponseBody
	public ResponseEntity<byte[]> exportCodes(int couponExchangeId, HttpServletRequest request, HttpServletResponse response) {
		String realPath = request.getSession().getServletContext().getRealPath("");
		realPath = StringUtils.replace(realPath, BACK_SLASH, SLASH) + properties.getTemplatePath();
   		String fileName = properties.getCouponCodeExcelName();
   		List<GoodsCouponCode> couponCodes = silverService.listCodes(0, couponExchangeId, 0, silverService.countCode(0, couponExchangeId));
   		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
   		List<Serializable> list = new LinkedList<Serializable>();
		for(GoodsCouponCode code: couponCodes) {
			list.add(code);
		}
		String errorMessage = "";
		if (list != null && list.size() > 0) {
			String finalFileName = ExcelUtil.writeToExcel(list, messageSource.getMessage("template.xls.coupon.code", null, null), realPath, fileName, null);
			if (StringUtils.isNotBlank(finalFileName)) {
				return this.export(realPath, fileName, request);
			} 
			errorMessage = "no file find!";
		}
		errorMessage = "this is empty!";
		headers.setContentDispositionFormData("attachment", fileName);
		return new ResponseEntity<byte[]>(errorMessage.getBytes(), headers, HttpStatus.OK);
	}
	
	@RequestMapping("/coupon/check/status")
	@ResponseBody
	public boolean  checkCouponStatus(Integer couponId, Integer initStatus){
		if(couponId != null && couponId >= 0){
			Coupon bonus = couponService.get(couponId);
			if(bonus != null && bonus.getStatus() == initStatus){
				return true;
			}
		}
		return false;
	}
	
	@RequestMapping("/bonus/source/select")
	@ResponseBody
	public Map<Integer, String>  sourceSelect(Integer categoryId){
		Map<Integer, String> sources = new LinkedHashMap<Integer, String>();
		for(CouponRuleSourceEnum s : CouponRuleSourceEnum.values()){
			if(categoryId == 2){
				if(s.getValue() == 3){
					sources.put(s.getValue(), s.getMsg());
				}
			}else if(categoryId == 3){
				if(s.getCategory() == categoryId){
					sources.put(s.getValue(), s.getMsg());
				}
			}else if(categoryId == 4){
				if(s.getCategory() == 0){
					sources.put(s.getValue(), s.getMsg());
				}
				if(s.getCategory() == 4){
					sources.put(s.getValue(), s.getMsg());
				}
            }else if(categoryId == 5){
            	if(s.getCategory() == 5){
					sources.put(s.getValue(), s.getMsg());
				}
            }else if(s.getCategory() == categoryId || s.getCategory() == 20){
				if(s.getValue() != 10){
					sources.put(s.getValue(), s.getMsg());
				}
			}
		}
		return sources;
	}

	@RequestMapping("/coupon/select")
	@ResponseBody
	public Coupon selectCoupon(Integer couponId, HttpServletResponse response){
		if(couponId != null && couponId > 0){
			Coupon coupon = couponService.get(couponId);
			if(coupon != null && coupon.getName() != null){
				return coupon;
			}
		}
		return new Coupon();
	}

	@RequestMapping("/bonus/status")
	@ResponseBody
	public boolean auditBonus(Integer bonusId, Integer status, Integer initStatus){
		if(bonusId != null && bonusId > 0){
			Coupon bonus = couponService.get(bonusId);
			if(bonus != null && bonus.getStatus() == initStatus){
				bonus.setStatus(status);
				return couponService.save(bonus);
			}
		}
		return false;
	}
	
	@RequestMapping("/can/disable")
	@ResponseBody
	public boolean canDisable(int couponId){
		return couponService.canDisable(couponId);
	}
	@RequestMapping("/coupon/voucher/exchange/record/{couponId:\\d+}")
	public String listCouponVoucherExchangeRecord(String cellphone, Integer status, Integer page, Integer size, @PathVariable("couponId")int couponId, Model model){
		int total = couponService.countCustomerCoupons(couponId ,cellphone, status != null ? status : -1);
		if(total > 0){
			model.addAttribute("total", total);
			model.addAttribute("customerCoupons", couponService.listCustomerCoupons(couponId, cellphone, status != null ? status : -1, this.getOffset(page, size), this.getPageSize(size)));
		}else{
			model.addAttribute("total", 0);
			model.addAttribute("customerCoupons", new DispatchingBonusLog[0]);
		}
		model.addAttribute("couponId", couponId);
		model.addAttribute("status", status);
		model.addAttribute("cellphone", cellphone);
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "coupon/coupon/voucher/detail";
	}
	
	@RequestMapping("/bonus/voucher/exchange/record/{couponId:\\d+}")
	public String listBonusVoucherExchangeRecord(String cellphone, Integer status, Integer page, Integer size, @PathVariable("couponId")int couponId, Model model){
		int total = couponService.countCustomerCoupons(couponId ,cellphone, status != null ? status : -1);
		if(total > 0){
			model.addAttribute("total", total);
			model.addAttribute("customerCoupons", couponService.listCustomerCoupons(couponId, cellphone, status != null ? status : -1, this.getOffset(page, size), this.getPageSize(size)));
		}else{
			model.addAttribute("total", 0);
			model.addAttribute("customerCoupons", new ArrayList<CustomerCoupon>());
		}
		model.addAttribute("couponId", couponId);
		model.addAttribute("status", status);
		model.addAttribute("cellphone", cellphone);
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "coupon/bonus/voucher/detail";
	}
	
	@RequestMapping(value="/exchange/validate/code", method=RequestMethod.GET)
	@ResponseBody
	public String validateExchangeCode(String fieldId, String fieldValue, int id) {
		if (StringUtils.isNotBlank(fieldId) && StringUtils.isNotBlank(fieldValue)) {
			ArrayObjectEntity json = new ArrayObjectEntity();
			if (!silverService.validateExchangeCode(id, fieldValue)){
				json.setObject(fieldId);
				json.setSuccess(false);
				json.setMessage(messageSource.getMessage("coupon.code.occupy", null, Locale.getDefault())); 
			} else {
				json.setObject(fieldId);
				json.setSuccess(true);
				json.setMessage(messageSource.getMessage("coupon.code.leisure", null, Locale.getDefault())); 
			}
			return json.toString(); 
		}
		return null;
	}
	
	@RequestMapping(value="/bonus/vip/birthday")
	public String  selectByCouponType(Model model){
		List<CouponVipEntity> couponLists = couponService.selectByCouponType(ConstantUtil.VIP_BIRTHDAY_COUPON);
		model.addAttribute("couponLists", couponLists);
		
		return "coupon/vip/birthday/list";
	}
	
	@RequestMapping(value="/bonus/vip/birthday/save")
	public String saveVipBirthdayBouns(@RequestBody String couponVips){
		String jsonString = URLDecoder.decode(couponVips).replaceAll("=","");
		List<CouponVip> vipCoupons=new ArrayList<CouponVip>();
	    vipCoupons = JSONObject.parseArray(jsonString, CouponVip.class);
		if(vipCoupons!=null){
			couponService.save(vipCoupons,ConstantUtil.VIP_BIRTHDAY_COUPON );
		}
		return "";
	}
	
	@RequestMapping(value="/bonus/vip/save" )
	public String addVipBirthdayBouns(@RequestBody String couponVipMap){
		String jsonString = URLDecoder.decode(couponVipMap).replaceAll("=","");
		List<CouponVipExclusive> vipCoupons=new ArrayList<CouponVipExclusive>();
	    vipCoupons = JSONObject.parseArray(jsonString, CouponVipExclusive.class);
		if(vipCoupons!= null){
			couponService.save(ConstantUtil.VIP_EXCLUSIVE_COUPON,vipCoupons); 
		}
		return null;
	}
		
}