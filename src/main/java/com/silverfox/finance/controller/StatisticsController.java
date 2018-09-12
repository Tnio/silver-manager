package com.silverfox.finance.controller;

import static com.silverfox.finance.util.ConstantUtil.NORMAL_DATE_FORMAT;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.silverfox.finance.domain.Customer;
import com.silverfox.finance.domain.CustomerSilverLog;
import com.silverfox.finance.entity.EarningEntity;
import com.silverfox.finance.entity.OpexEntity;
import com.silverfox.finance.entity.PaybackCalenderEntity;
import com.silverfox.finance.entity.ProductTradeEntity;
import com.silverfox.finance.entity.ReceivablesEntity;
import com.silverfox.finance.entity.StatisticsEntity;
import com.silverfox.finance.enumeration.ProductPeriodEnum;
import com.silverfox.finance.enumeration.SilverGainSourceEnum;
import com.silverfox.finance.enumeration.SilverUsedSourceEnum;
import com.silverfox.finance.service.TradeService;

@Controller
@RequestMapping("/statistics")
public class StatisticsController extends BaseController {
	private static final double SERVICE_MIN_COST = 0.03;
	private static final double SERVICE_COST = 0.04;
	private static final double SERVICE_MAX_COST = 0.05;
	@Autowired
	private TradeService tradeService;

	@RequestMapping("/lossing/customer/list/{paybackDate}/{page:\\d+}")
	public String listLossingCustomers(String sort, Integer size, @PathVariable("paybackDate")String paybackDate, @PathVariable("page")Integer page, Model model) {
		int total = tradeService.countLossing(paybackDate);
		if(StringUtils.isBlank(sort)){
			sort = "tradeMoney";
		}
		if (total > 0) {
			model.addAttribute("total", total);
			model.addAttribute("customers", tradeService.getLossing(sort, paybackDate, this.getOffset(page, size), this.getPageSize(size)));
		} else {
			model.addAttribute("total", 0);
			model.addAttribute("customers", new Customer[0]);
		}
		model.addAttribute("paybackDate", StringUtils.trimToEmpty(paybackDate));
		model.addAttribute("sort", sort);
		
		
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "statistics/lossing-list";
	}
	
	@RequestMapping("/customer/repeat/invest")
	public String statisticsRepeatInvest(String paybackDate, Model model) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DAY_OF_YEAR, -1);
		SimpleDateFormat dateFormat = new SimpleDateFormat(NORMAL_DATE_FORMAT);
		if (StringUtils.isBlank(paybackDate)) {
			paybackDate = dateFormat.format(calendar.getTime());
		}
		
		if (StringUtils.equals(paybackDate, dateFormat.format(calendar.getTime()))) {
			model.addAttribute("hasNext", 0);
		} else {
			model.addAttribute("hasNext", 1);
		}
		
		model.addAttribute("row", tradeService.getReinvest(paybackDate));
		model.addAttribute("paybackDate", paybackDate);
		return "statistics/repeatinvest";  
	}
	
	@RequestMapping("/customer/reinvest/data")
	@ResponseBody
	public JSONObject reinvestData(String paybackDate) {
		JSONObject result = new JSONObject();
 		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DAY_OF_YEAR, -1);
		SimpleDateFormat dateFormat = new SimpleDateFormat(NORMAL_DATE_FORMAT);
		if (StringUtils.isBlank(paybackDate)) {
			paybackDate = dateFormat.format(calendar.getTime());
		}
		
		if (StringUtils.equals(paybackDate, dateFormat.format(calendar.getTime()))) {
			result.put("hasNext", 0);
		} else {
			result.put("hasNext", 1);
		}
		result.put("data", tradeService.getReinvest(paybackDate));
		return result;  
	}
	
	@RequestMapping("/customer/lossing")
	public String statisticsLossingCustomer(String paybackDate, Model model) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DAY_OF_YEAR, -30);
		SimpleDateFormat dateFormat = new SimpleDateFormat(NORMAL_DATE_FORMAT);
		if (StringUtils.isBlank(paybackDate)) {
			paybackDate = dateFormat.format(calendar.getTime());
		}
		
		if (StringUtils.equals(paybackDate, dateFormat.format(calendar.getTime()))) {
			model.addAttribute("hasNext", 0);
		} else {
			model.addAttribute("hasNext", 1);
		}
		model.addAttribute("row", tradeService.getNotReinvest(paybackDate));
		model.addAttribute("paybackDate", paybackDate);
		return "statistics/lossing";  
	}
	
	@RequestMapping("/customer/lossing/data")
	@ResponseBody
	public JSONObject lossingData(String paybackDate) {
		JSONObject result = new JSONObject();
 		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DAY_OF_YEAR, -30);
		SimpleDateFormat dateFormat = new SimpleDateFormat(NORMAL_DATE_FORMAT);
		if (StringUtils.isBlank(paybackDate)) {
			paybackDate = dateFormat.format(calendar.getTime());
		}
		
		if (StringUtils.equals(paybackDate, dateFormat.format(calendar.getTime()))) {
			result.put("hasNext", 0);
		} else {
			result.put("hasNext", 1);
		}
		result.put("data", tradeService.getNotReinvest(paybackDate));
		return result;  
	}
	
	@RequestMapping("/payback/calender")
	public String showPaybackCalender(Integer type, Integer backChannel, String beginDate, String endDate, Model model) {
		if(type == null){
			type = 1;
		}
		if(backChannel == null){
			backChannel = 0;
		}
		if (StringUtils.isBlank(beginDate) || StringUtils.isBlank(endDate)) {
			SimpleDateFormat dateFormat = new SimpleDateFormat(NORMAL_DATE_FORMAT);
			beginDate = dateFormat.format(Calendar.getInstance().getTime());
			endDate = dateFormat.format(Calendar.getInstance().getTime());
		}
		List<PaybackCalenderEntity> paybackCalenderEntities = tradeService.paybackCalender(type, backChannel, beginDate, endDate);
		double couponAmount = 0;
		double interestCouponAmount = 0;
		double interestAmount = 0;
		double vipInterestAmount = 0;
		double paybackAmount = 0;
		double merchantBackCharges = 0;
		double serviceCharges = 0;
		int actualAmount = 0;
		DecimalFormat df = new DecimalFormat("######0.00");  
		for (PaybackCalenderEntity paybackCalenderEntity : paybackCalenderEntities) {
			paybackCalenderEntity.setCouponAmount(Double.parseDouble(df.format(paybackCalenderEntity.getCouponAmount())));
			paybackCalenderEntity.setInterestCouponAmount(Double.parseDouble(df.format(paybackCalenderEntity.getInterestCouponAmount())));
			paybackCalenderEntity.setInterestAmount(Double.parseDouble(df.format(paybackCalenderEntity.getInterestAmount())));
			paybackCalenderEntity.setVipInterestAmount(Double.parseDouble(df.format(paybackCalenderEntity.getVipInterestAmount())));
			paybackCalenderEntity.setMerchantBackCharge(Double.parseDouble(df.format(paybackCalenderEntity.getMerchantBackCharge())));
			paybackCalenderEntity.setServiceCharge(Double.parseDouble(df.format(paybackCalenderEntity.getServiceCharge())));
			paybackCalenderEntity.setPaybackAmount(Double.parseDouble(df.format(paybackCalenderEntity.getPaybackAmount())));
			couponAmount += paybackCalenderEntity.getCouponAmount();
			interestCouponAmount += paybackCalenderEntity.getInterestCouponAmount();
			actualAmount += paybackCalenderEntity.getActualAmount();
			interestAmount += paybackCalenderEntity.getInterestAmount();
			vipInterestAmount += paybackCalenderEntity.getVipInterestAmount();
			merchantBackCharges += paybackCalenderEntity.getMerchantBackCharge()+paybackCalenderEntity.getServiceCharge();
			serviceCharges += paybackCalenderEntity.getMerchantBackCharge();
			paybackAmount += paybackCalenderEntity.getActualAmount()+paybackCalenderEntity.getServiceCharge()+paybackCalenderEntity.getCouponAmount()+
		    paybackCalenderEntity.getInterestCouponAmount()+paybackCalenderEntity.getInterestAmount()+paybackCalenderEntity.getVipInterestAmount();
		}
		model.addAttribute("beginDate", beginDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("type", type);
		model.addAttribute("backChannel", backChannel);
		model.addAttribute("actualAmount", actualAmount);
		model.addAttribute("couponAmount", couponAmount+interestCouponAmount);
		model.addAttribute("interestAmount", interestAmount);
		model.addAttribute("vipInterestAmount", vipInterestAmount);
		model.addAttribute("merchantBackCharges", merchantBackCharges);
		model.addAttribute("serviceCharges", serviceCharges);
		model.addAttribute("paybackAmount", paybackAmount);
		model.addAttribute("paybackMsgs", paybackCalenderEntities);
		return "statistics/payback";
	}
	
	@RequestMapping("/old/earning")
	public String oldEarning(String beginDate, String endDate, Model model) {
		if (StringUtils.isBlank(beginDate) || StringUtils.isBlank(endDate)) {
			SimpleDateFormat dateFormat = new SimpleDateFormat(NORMAL_DATE_FORMAT);
			beginDate = dateFormat.format(Calendar.getInstance().getTime());
			endDate = dateFormat.format(Calendar.getInstance().getTime());
		}
		List<EarningEntity> earningEntitys = tradeService.oldEarning(beginDate, endDate);
		double totalOperatingCost = 0.00;
		double totalPaymentCost = 0.00;
		double totalCompanyEarning = 0.00;
		double totalCompanyProfit = 0.00;
		DecimalFormat df = new DecimalFormat("######0.00");  
		for (EarningEntity earningEntity : earningEntitys) {
			earningEntity.setCouponAmount(Double.parseDouble(df.format(earningEntity.getCouponAmount())));
			earningEntity.setInterestCouponAmount(Double.parseDouble(df.format(earningEntity.getInterestCouponAmount())));
			earningEntity.setInterestAmount(Double.parseDouble(df.format(earningEntity.getInterestAmount())));
			earningEntity.setYearIncome(Double.parseDouble(df.format(earningEntity.getYearIncome())));
			earningEntity.setPaymentCost(Double.parseDouble(df.format(earningEntity.getPaymentCost())));
			
			earningEntity.setOperatingCost(earningEntity.getCouponAmount() + earningEntity.getInterestCouponAmount() + earningEntity.getInterestAmount());
			double serviceCost = 0.00;
			if(earningEntity.getFinancePeriod() <= ProductPeriodEnum.MID.getPeriod()){
				serviceCost = SERVICE_MAX_COST;
			}else if(earningEntity.getFinancePeriod() > ProductPeriodEnum.LONG.getPeriod()){
				serviceCost = SERVICE_MIN_COST;
			}else{
				serviceCost = SERVICE_COST;
			}
			earningEntity.setCompanyEarning(Double.parseDouble(df.format(earningEntity.getActualAmount() * serviceCost * earningEntity.getFinancePeriod() /365)));
			totalOperatingCost += earningEntity.getOperatingCost();
			totalPaymentCost += earningEntity.getPaymentCost();
			totalCompanyEarning += earningEntity.getCompanyEarning();
			totalCompanyProfit += earningEntity.getCompanyEarning() - earningEntity.getOperatingCost() - earningEntity.getPaymentCost();
		}
		model.addAttribute("beginDate", beginDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("totalOperatingCost", totalOperatingCost);
		model.addAttribute("totalPaymentCost", totalPaymentCost);
		model.addAttribute("totalCompanyEarning", totalCompanyEarning);
		model.addAttribute("totalCompanyProfit", totalCompanyProfit);
		model.addAttribute("earnings", earningEntitys);
		return "statistics/oldearning";  
	}
	
	@RequestMapping("/new/earning")
	public String newEarningCalender(String beginDate, String endDate, Model model) {
		if (StringUtils.isBlank(beginDate) || StringUtils.isBlank(endDate)) {
			SimpleDateFormat dateFormat = new SimpleDateFormat(NORMAL_DATE_FORMAT);
			beginDate = dateFormat.format(Calendar.getInstance().getTime());
			endDate = dateFormat.format(Calendar.getInstance().getTime());
		}
		List<EarningEntity> earningEntitys = tradeService.newEarning(beginDate, endDate);
		double totalOperatingCost = 0.00;
		double totalPaymentCost = 0.00;
		double totalCompanyEarning = 0.00;
		double totalCompanyProfit = 0.00;
		double totalOverrangingProfit =0.00;
		DecimalFormat df = new DecimalFormat("######0.00");  
		for (EarningEntity earningEntity : earningEntitys) {
			earningEntity.setCouponAmount(Double.parseDouble(df.format(earningEntity.getCouponAmount())));
			earningEntity.setInterestCouponAmount(Double.parseDouble(df.format(earningEntity.getInterestCouponAmount())));
			earningEntity.setInterestAmount(Double.parseDouble(df.format(earningEntity.getInterestAmount())));
			earningEntity.setYearIncome(Double.parseDouble(df.format(earningEntity.getYearIncome())));
			earningEntity.setBorrowInterest(Double.parseDouble(df.format(earningEntity.getBorrowInterest())));
			earningEntity.setPaymentCost(Double.parseDouble(df.format(earningEntity.getPaymentCost())));
			earningEntity.setOperatingCost(Double.parseDouble(df.format(earningEntity.getCouponAmount() + earningEntity.getInterestCouponAmount() + earningEntity.getInterestAmount())));
			if(earningEntity.getBorrowAmount() > 0 && earningEntity.getActualAmount() > earningEntity.getBorrowAmount()){				
				earningEntity.setOverrangingProfit(Double.parseDouble(df.format((earningEntity.getActualAmount()-earningEntity.getBorrowAmount())*earningEntity.getYearIncome()*earningEntity.getFinancePeriod()/36500)));				
			}
			earningEntity.setBorrowProfit(Double.parseDouble(df.format(earningEntity.getBorrowAmount()*earningEntity.getBorrowInterest()*earningEntity.getFinancePeriod()/36500)));
			earningEntity.setCustomerProfit(Double.parseDouble(df.format(earningEntity.getActualAmount()*earningEntity.getYearIncome()*earningEntity.getFinancePeriod()/36500)));
			earningEntity.setCompanyEarning(Double.parseDouble(df.format(earningEntity.getBorrowProfit()-earningEntity.getCustomerProfit())));
			
			totalOperatingCost += earningEntity.getOperatingCost();
			totalPaymentCost += earningEntity.getPaymentCost();
			totalCompanyEarning += earningEntity.getCompanyEarning();
			totalCompanyProfit += earningEntity.getCompanyEarning() - earningEntity.getOperatingCost() - earningEntity.getPaymentCost() - earningEntity.getOverrangingProfit();
			totalOverrangingProfit += earningEntity.getOverrangingProfit();
		}
		model.addAttribute("beginDate", beginDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("totalOverrangingProfit", totalOverrangingProfit);
		model.addAttribute("totalOperatingCost", totalOperatingCost);
		model.addAttribute("totalPaymentCost", totalPaymentCost);
		model.addAttribute("totalCompanyEarning", totalCompanyEarning);
		model.addAttribute("totalCompanyProfit", totalCompanyProfit);
		model.addAttribute("earnings", earningEntitys);
		return "statistics/newearning";
	}
	
	@RequestMapping("/opex/list/{page:\\d+}")
	public String listOpex(String beginDate, String endDate, Integer size, @PathVariable("page")Integer page, Model model) {
		if (StringUtils.isBlank(beginDate) || StringUtils.isBlank(endDate)) {
			SimpleDateFormat dateFormat = new SimpleDateFormat(NORMAL_DATE_FORMAT);
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DAY_OF_YEAR, -1);
			endDate = dateFormat.format(calendar.getTime());
			calendar.add(Calendar.DAY_OF_YEAR, -30);
			beginDate = dateFormat.format(calendar.getTime());
		}
		int total = tradeService.countOpex(beginDate, endDate);
		if (total > 0) {
			double coupons = 0.0;
			double couponInterests = 0.0;
			double interests = 0.0;
			double fees = 0.0;
			model.addAttribute("total", total);
			List<OpexEntity> entities = tradeService.listOpex(beginDate, endDate, 0, 0);
			model.addAttribute("opexs", entities);
			for (OpexEntity entity : entities) {
				coupons += entity.getCouponAmount();
				couponInterests += entity.getCouponInterest();
				interests += entity.getInterestAmount();
				fees += entity.getFeeAmount();
			}
			model.addAttribute("coupons", coupons);
			model.addAttribute("couponInterests", couponInterests);
			model.addAttribute("interests", interests);
			model.addAttribute("fees", fees);
		} else {
			model.addAttribute("total", 0);
			model.addAttribute("opexs", new OpexEntity[0]);
			model.addAttribute("coupons", 0);
			model.addAttribute("interests", 0);
			model.addAttribute("fees", 0);
		}
		model.addAttribute("beginDate", StringUtils.trimToEmpty(beginDate));
		model.addAttribute("endDate", StringUtils.trimToEmpty(endDate));
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "statistics/opex";
	}
	
	@RequestMapping("/basic/information")
	public String basicInformation(Model model) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");		
		model.addAttribute("allCustomerAtToday", tradeService.countInSomeday(format.format(Calendar.getInstance().getTime())));
		model.addAttribute("todayCustomer", tradeService.countCustomerInSomeday(format.format(Calendar.getInstance().getTime())));
		model.addAttribute("currentCommonOrder", tradeService.countOrderInSomeday(format.format(Calendar.getInstance().getTime())));
		model.addAttribute("currentCommonMoney", tradeService.sumOrderInSomeday(format.format(Calendar.getInstance().getTime())));
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.HOUR_OF_DAY, 1);
		model.addAttribute("hourPoint", calendar.get(Calendar.HOUR_OF_DAY));
		return "statistics/base";
	}
	
	@RequestMapping("/silver")
	public String statisticsSilver(String beginTime, String endTime, Model model){

		List<CustomerSilverLog> list = tradeService.statisticsSilver(beginTime, endTime);
		List<CustomerSilverLog> consumeSilvers = new LinkedList<CustomerSilverLog>();
		List<CustomerSilverLog> obtainSilvers = new LinkedList<CustomerSilverLog>();
		CustomerSilverLog exchangeLog = new CustomerSilverLog();
		int obtainTotal = 0;
		int consumeTotal = 0;
		if(list != null && list.size() > 0){
			for(CustomerSilverLog log : list){
				if(log.getAmount() > 0){
					log.setChannel(SilverGainSourceEnum.getChannelByValue(log.getSourceId()));
					obtainSilvers.add(log);
					obtainTotal += log.getAmount();
				}else{
					log.setChannel(SilverUsedSourceEnum.getChannelByValue(log.getSourceId()));
					consumeSilvers.add(log);
					consumeTotal += log.getAmount();
				}
			}
		}
		if (exchangeLog != null && exchangeLog.getId() > 0) {
			consumeSilvers.add(exchangeLog);
		}
		model.addAttribute("obtainTotal", obtainTotal);
		model.addAttribute("consumeTotal", consumeTotal);
		model.addAttribute("consumeSilvers", JSONObject.toJSON(consumeSilvers));
		model.addAttribute("obtainSilvers", JSONObject.toJSON(obtainSilvers));
		model.addAttribute("beginTime", beginTime);
		model.addAttribute("endTime", endTime);
		return "statistics/silver";
	}

	@RequestMapping("/increase")
	public String statisticsIncreaseCoupon(String beginTime, String endTime, Model model){
		Calendar oneTime = Calendar.getInstance();
		if(StringUtils.isBlank(endTime)){
			 endTime  = new SimpleDateFormat(NORMAL_DATE_FORMAT).format(oneTime.getTime());
			 oneTime.add(Calendar.MONTH, -1); 
		}
		if(StringUtils.isBlank(beginTime)){
			beginTime = new SimpleDateFormat(NORMAL_DATE_FORMAT).format(oneTime.getTime());
		}
		List<StatisticsEntity> list = tradeService.statisticsIncreaseCoupon(beginTime, endTime);
		
		model.addAttribute("increaseCoupons", JSONObject.toJSON(list));
		model.addAttribute("beginTime", beginTime);
		model.addAttribute("endTime", endTime);
		return "statistics/increase_coupon";
	}
	
	@RequestMapping("/increase/{source:\\d+}")
	public String statisticsIncreaseCouponDetail(@PathVariable("source")int source, String beginTime, String endTime, Model model){
		List<StatisticsEntity> list = tradeService.statisticsBonus(1, source, beginTime, endTime);
		model.addAttribute("increaseCoupons", JSONObject.toJSON(list));
		model.addAttribute("beginTime", beginTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("source", source);
		return "statistics/increase-detail";
	}
	
	@RequestMapping("/bonus")
	public String statisticsBonus(String beginTime, String endTime, Model model){
		Calendar oneTime = Calendar.getInstance();
		if(StringUtils.isBlank(endTime)){
			 endTime  = new SimpleDateFormat(NORMAL_DATE_FORMAT).format(oneTime.getTime());
			 oneTime.add(Calendar.MONTH, -1); 
		}
		if(StringUtils.isBlank(beginTime)){
			beginTime = new SimpleDateFormat(NORMAL_DATE_FORMAT).format(oneTime.getTime());
		}
		List<StatisticsEntity> result = new ArrayList<StatisticsEntity>();
		List<StatisticsEntity> count = new ArrayList<StatisticsEntity>();
		List<StatisticsEntity> list = tradeService.statisticsBonus(beginTime, endTime);
		if(list.size() > 0){
			Iterator<StatisticsEntity> iList = list.iterator();
			while(iList.hasNext()){
				StatisticsEntity entity = iList.next();
				if(entity != null && entity.getSource() == 6){
					count.add(entity);
					iList.remove();
				}
				if(entity != null && entity.getSource() == 17){
					count.add(entity);
					iList.remove();
				}
			}
			StatisticsEntity entity = new StatisticsEntity();
			if(count.size() > 0){
				for(int i =0; i<count.size(); i++){
					entity.setTotalAmount(entity.getTotalAmount() + count.get(i).getTotalAmount());
					entity.setUsedAmount(entity.getUsedAmount() + count.get(i).getUsedAmount());
					entity.setSource(6);
				}
			}
			for(int i =0; i<list.size(); i++){
				if(list.get(i).getSource() != 6 && list.get(i).getSource() != 17){
					result.add(list.get(i));
				}
			}
			if(entity != null && entity.getSource() > 0){
				result.add(entity);
			}
			
		}
		
		model.addAttribute("bonuses", JSONObject.toJSON(result));
		model.addAttribute("beginTime", beginTime);
		model.addAttribute("endTime", endTime);
		return "statistics/bonus";
	}
	
	@RequestMapping("/bonus/{source:\\d+}")
	public String statisticsBonusDetail(@PathVariable("source")int source, String beginTime, String endTime, Model model){
		List<StatisticsEntity> list = tradeService.statisticsBonus(0, source, beginTime, endTime);
		model.addAttribute("bonuses", JSONObject.toJSON(list));
		model.addAttribute("beginTime", beginTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("source", source);
		return "statistics/bonus-detail";
	}
	
	@RequestMapping("/receivables/list/{id:\\d+}/{page:\\d+}")
	public String receivables(Integer size, @PathVariable("page")Integer page,@PathVariable("id")Integer id, Model model) {
		List<ReceivablesEntity> receivablesEntityList=new ArrayList<ReceivablesEntity>();
		if (id==0) {
			id = 1;
		}
		List<ReceivablesEntity> payAmountList=tradeService.getMerchantTradeAmount(id, 1); 
		List<ReceivablesEntity> backAmountList=tradeService.getMerchantTradeAmount(id, 0);              
		List<ReceivablesEntity> productIncomeAmountList=tradeService.getProductIncomeAmountByMonths(id,this.getOffset(page, size), getPageSize(size)); 		
		int total=productIncomeAmountList.size();
		for(int i=0;i<productIncomeAmountList.size();i++){
			ReceivablesEntity receivablesEntity=productIncomeAmountList.get(i);
			for (int j = 0; j< payAmountList.size(); j++) {
				if (StringUtils.equals(payAmountList.get(j).getDueDate(), receivablesEntity.getDueDate())){
					receivablesEntity.setPayAmount(payAmountList.get(j).getPayAmount());
				}
			}
			for (int k= 0; k < backAmountList.size(); k++) {
				if (StringUtils.equals(backAmountList.get(k).getDueDate(), receivablesEntity.getDueDate())) {
					receivablesEntity.setBackAmount(backAmountList.get(k).getPayAmount());
				}
			}
			receivablesEntity.setMonthReceivables(receivablesEntity.getProductIncome() +receivablesEntity.getPayAmount()-receivablesEntity.getBackAmount());
			receivablesEntityList.add(receivablesEntity);
		}
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE,   -1);
		String yesterday = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
		float inAmount=tradeService.getInAmount(id,yesterday);
		float productIncome=tradeService.getProductIncomeById(id,yesterday);
//		float inAmount=clientServiceApi.getInAmount(id,yesterday);
//		float productIncome=productServiceApi.getProductIncomeById(id,yesterday);
		float totalIncome=productIncome+inAmount;
		model.addAttribute("id", id);
		model.addAttribute("receivablesEntityList", receivablesEntityList);
		model.addAttribute("totalIncome", totalIncome);
		model.addAttribute("yesterday", yesterday);
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		
		return "statistics/receivables";
	}
	
	@RequestMapping("/product/trade")
	public String product(Integer type, String beginTime, String endTime, Model model) {
		if(type == null){
			type = 1;
		}
		
		if(type == 1 && (StringUtils.isBlank(beginTime) || StringUtils.isBlank(endTime))){
			 Calendar oneTime = Calendar.getInstance();
			 endTime  = new SimpleDateFormat(NORMAL_DATE_FORMAT).format(oneTime.getTime());
			 oneTime.add(Calendar.MONTH, -1);
			 beginTime = new SimpleDateFormat(NORMAL_DATE_FORMAT).format(oneTime.getTime());
		}
		if(type == 2 && (StringUtils.isBlank(beginTime.trim()) || StringUtils.isBlank(endTime.trim()))){
			 Calendar oneTime = Calendar.getInstance();
			 beginTime  = new SimpleDateFormat(NORMAL_DATE_FORMAT).format(oneTime.getTime());
			 oneTime.add(Calendar.MONTH, 1);
			 endTime = new SimpleDateFormat(NORMAL_DATE_FORMAT).format(oneTime.getTime());
		}
		model.addAttribute("beginTime", beginTime);
		model.addAttribute("endTime", endTime);
		List<ProductTradeEntity> inMoneys = new LinkedList<ProductTradeEntity>(); 
		if(type == 1){
			inMoneys = tradeService.getInMoneys(beginTime, endTime);
		}
		List<ProductTradeEntity> outMoneys = tradeService.getOutMoneys(type, beginTime, endTime);
		
		List<ProductTradeEntity> inTotals = new LinkedList<ProductTradeEntity>();
		if(type == 1){
			inTotals = tradeService.getInTotals(beginTime, endTime);
		}
		List<ProductTradeEntity> outTotals = tradeService.getOutTotals(type, beginTime, endTime);
		
		List<ProductTradeEntity> inPeoples = new LinkedList<ProductTradeEntity>();
		if(type == 1){
			inPeoples = tradeService.getInPeoples(beginTime, endTime);
		}
		List<ProductTradeEntity> outPeoples = tradeService.getOutPeoples(type, beginTime, endTime);
		
		List<ProductTradeEntity> productTradeEntitys = new LinkedList<ProductTradeEntity>();
		for(int i = 1; i < 5; i++){
			ProductTradeEntity tradeEntity = new ProductTradeEntity();
			tradeEntity.setAid(i);
			if(inMoneys.size() > 0){
				int inMoney = 0;
				for(int j = 0;j<inMoneys.size();j++){
					if(inMoneys.get(j).getAid() == i){
						tradeEntity.setInMoney(inMoneys.get(j).getInMoney());
						inMoney ++;
					}
				}
				if(inMoney <= 0){
					tradeEntity.setInMoney(0d);
				}
			}else{
				tradeEntity.setInMoney(0d);
			}
			if(outMoneys.size() > 0){
				int outMoney = 0;
				for(int j = 0;j<outMoneys.size();j++){
					if(outMoneys.get(j).getAid() == i){
						tradeEntity.setOutMoney(outMoneys.get(j).getOutMoney());
						outMoney ++;
					}
				}
				if(outMoney <= 0){
					tradeEntity.setOutMoney(0d);
				}
			}else{
				tradeEntity.setOutMoney(0d);
			}
			if(inTotals.size() > 0){
				int inTotal = 0;
				for(int j = 0;j<inTotals.size();j++){
					if(inTotals.get(j).getAid() == i){
						tradeEntity.setInTotal(inTotals.get(j).getInTotal());
						inTotal ++;
					}
				}
				if(inTotal <= 0){
					tradeEntity.setInTotal(0);
				}
			}else{
				tradeEntity.setInTotal(0);
			}
			if(outTotals.size() > 0){
				int outTotal = 0;
				for(int j = 0;j<outTotals.size();j++){
					if(outTotals.get(j).getAid() == i){
						tradeEntity.setOutTotal(outTotals.get(j).getOutTotal());
						outTotal ++;
					}
				}
				if(outTotal <= 0){
					tradeEntity.setOutTotal(0);
				}
			}else{
				tradeEntity.setOutTotal(0);
			}
			if(inPeoples.size() > 0){
				int inPeople = 0;
				for(int j = 0;j<inPeoples.size();j++){
					if(inPeoples.get(j).getAid() == i){
						tradeEntity.setInPeople(inPeoples.get(j).getInPeople());
						inPeople ++;
					}
				}
				if(inPeople <= 0){
					tradeEntity.setInPeople(0);
				}
			}else{
				tradeEntity.setInPeople(0);
			}
			if(outPeoples.size() > 0){
				int outPeople = 0;
				for(int j = 0;j<outPeoples.size();j++){
					if(outPeoples.get(j).getAid() == i){
						tradeEntity.setOutPeople(outPeoples.get(j).getOutPeople());
						outPeople ++;
					}
				}
				if(outPeople <= 0){
					tradeEntity.setOutPeople(0);
				}
			}else{
				tradeEntity.setOutPeople(0);
			}
			productTradeEntitys.add(tradeEntity);
		}
		model.addAttribute("productTradeEntitys", productTradeEntitys);
		model.addAttribute("type", type);
		return "statistics/product";
	}
}