package com.silverfox.finance.controller;

import static com.silverfox.finance.util.ConstantUtil.BACK_SLASH;
import static com.silverfox.finance.util.ConstantUtil.PAGE_SIZE;
import static com.silverfox.finance.util.ConstantUtil.SLASH;

import java.io.Serializable;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.silverfox.finance.config.AplicationResourceProperties;
import com.silverfox.finance.domain.AbnormalOrder;
import com.silverfox.finance.domain.CustomerBalanceLog;
import com.silverfox.finance.domain.CustomerOrder;
import com.silverfox.finance.domain.MerchantOrder;
import com.silverfox.finance.enumeration.TypeEnum;
import com.silverfox.finance.service.OrderService;
import com.silverfox.finance.util.ConstantUtil;
import com.silverfox.finance.util.ExcelUtil;
import com.silverfox.finance.util.ValidatorUtil;

@Controller
@RequestMapping("/trade")
public class OrderController extends BaseController{
	
	@Autowired
	private OrderService orderService;
	@Autowired
	protected AplicationResourceProperties properties;
	@RequestMapping("/customer/{category}/{page:\\d+}/{type:\\d+}")
	public String listCustomerOrder(String productName, String name, String phone, Integer areaNO, String orderNO, String payType, String beginTime, String endTime, String amountFrom, String amountTo, Integer size, 
			@PathVariable("category")String category, @PathVariable("type")int type, @PathVariable("page")int page, Model model) {
		int moneyFrom = 0;
		if (StringUtils.isNotBlank(amountFrom)) {
			moneyFrom = Integer.parseInt(amountFrom);
			if(moneyFrom == 0) {
				moneyFrom = ConstantUtil.ONE;
			}
		}
		int moneyTo = 0;
		if (StringUtils.isNotBlank(amountTo)) {
			moneyTo = Integer.parseInt(amountTo);
			if(moneyTo == 0) {
				moneyTo = ConstantUtil.ONE;
			}
		}
		if(areaNO == null) {
			areaNO = -1;
		}
		phone = StringUtils.trimToEmpty(phone);
		if(!ValidatorUtil.isMobile(phone)){
			phone = "";
		}
		if (StringUtils.isNotBlank(category)) {
			Map<String, Object> info = orderService.getOrderInfo(StringUtils.trim(productName), StringUtils.trim(name), StringUtils.trim(phone), areaNO, StringUtils.trimToEmpty(orderNO), payType, type, beginTime, endTime, moneyFrom, moneyTo);
			int total = 0;
			double totalMoney = 0.0;
			if (info != null && info.containsKey("orders") && info.containsKey("money")) {
				try {
					total = Integer.parseInt(String.valueOf(info.get("orders")));
				} catch (Exception e) {
					total = 0;
				}
				try {
					totalMoney = Double.parseDouble(String.valueOf(info.get("money")));
				} catch (Exception e) {
					totalMoney = 0;
				}
			}
			if (type == TypeEnum.IN.value() || type == TypeEnum.OVERDUE.value()) { 
				if(total > 0) {
					 model.addAttribute("total", total);
					model.addAttribute("orders", orderService.list(StringUtils.trim(productName), StringUtils.trim(name), StringUtils.trim(phone), areaNO, StringUtils.trimToEmpty(orderNO), payType, type, beginTime, endTime, moneyFrom, moneyTo, this.getOffset(page, size), this.getPageSize(size)));
					model.addAttribute("totalMoney", totalMoney);
				} else {
					model.addAttribute("total", 0);
					model.addAttribute("orders", new CustomerOrder[0]);
					model.addAttribute("totalMoney",0);
				}
			} else if (type == TypeEnum.OUT.value()) {
				if(total > 0) {
					model.addAttribute("total", total);
					model.addAttribute("outOrders", orderService.list(StringUtils.trim(productName), StringUtils.trim(name), StringUtils.trim(phone), areaNO, StringUtils.trimToEmpty(orderNO), payType, type, beginTime, endTime, moneyFrom, moneyTo, this.getOffset(page, size), this.getPageSize(size)));
					model.addAttribute("totalMoney", totalMoney);
				} else {
					model.addAttribute("total", 0);
					model.addAttribute("outOrders", new CustomerOrder[0]);
					model.addAttribute("totalMoney",0);
				}
			}
			
			model.addAttribute("channels", orderService.listForUsed());
			model.addAttribute("category", StringUtils.trimToEmpty(category));
			model.addAttribute("amountFrom", StringUtils.trimToEmpty(amountFrom));
			model.addAttribute("amountTo", StringUtils.trimToEmpty(amountTo));
			model.addAttribute("type", type);
			model.addAttribute("name", StringUtils.trimToEmpty(name));
			model.addAttribute("productName", StringUtils.trimToEmpty(productName));
			model.addAttribute("phone", StringUtils.trimToEmpty(phone));
			model.addAttribute("areaNO",areaNO);
			model.addAttribute("orderNO", StringUtils.trimToEmpty(orderNO));
			model.addAttribute("payType", StringUtils.trimToEmpty(payType));
			model.addAttribute("beginTime", StringUtils.trimToEmpty(beginTime));
			model.addAttribute("endTime", StringUtils.trimToEmpty(endTime));
			model.addAttribute("size", this.getPageSize(size));
			model.addAttribute("page", this.getPage(page));
			model.addAttribute("pages", this.getTotalPage(total, size));
		}
		return "trade/customer";
	}
	@RequestMapping("/abnormal/{page:\\d+}/{type:\\d+}")
	public String listAbnormalOrder(String productName, String name, String phone, Integer areaNO, String orderNO, Integer payType, String beginTime, String endTime, Integer size, 
			String amountFrom, String amountTo, @PathVariable("type")int type, @PathVariable("page")int page, Model model) {
		if(areaNO == null) {
			areaNO = -1;
		}
		if(payType == null) {
			payType = -1;
		}
		int moneyFrom = 0;
		if (StringUtils.isNotBlank(amountFrom)) {
			moneyFrom = Integer.parseInt(amountFrom);
			if(moneyFrom == 0) {
				moneyFrom =ConstantUtil.ONE;
			}
		}
		int moneyTo = 0;
		if (StringUtils.isNotBlank(amountTo)) {
			moneyTo = Integer.parseInt(amountTo);
			if(moneyTo == 0) {
				moneyTo = ConstantUtil.ONE;
			}
		}
		int total = orderService.count(type, 4, productName, name, phone, areaNO, StringUtils.trimToEmpty(orderNO), payType, moneyFrom, moneyTo, beginTime, endTime);
		if(total > 0) {
			model.addAttribute("total", total);
			model.addAttribute("closedOrders", orderService.list(type, 4, productName, name, phone, areaNO, orderNO, payType, moneyFrom, moneyTo, beginTime, endTime, this.getOffset(page, size), this.getPageSize(size)));
			model.addAttribute("totalMoney",orderService.sum(type, 4, productName, name, phone, areaNO, orderNO, payType, moneyFrom, moneyTo, beginTime, endTime));
		} else {
			model.addAttribute("total", 0);
			model.addAttribute("closedOrders", new AbnormalOrder[0]);
			model.addAttribute("totalMoney",0);
		}
		
		model.addAttribute("channels", orderService.listForUsed());
		model.addAttribute("type", type);
		model.addAttribute("category", type);
		model.addAttribute("name", StringUtils.trimToEmpty(name));
		model.addAttribute("productName", StringUtils.trimToEmpty(productName));
		model.addAttribute("phone", StringUtils.trimToEmpty(phone));
		model.addAttribute("areaNO",areaNO);
		model.addAttribute("orderNO", StringUtils.trimToEmpty(orderNO));
		model.addAttribute("payType", payType);
		model.addAttribute("amountFrom", StringUtils.trimToEmpty(amountFrom));
		model.addAttribute("amountTo", StringUtils.trimToEmpty(amountTo));
		model.addAttribute("beginTime", StringUtils.trimToEmpty(beginTime));
		model.addAttribute("endTime", StringUtils.trimToEmpty(endTime));
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		if (type == 3) {
			return "trade/baobao";
		} else {
			return "trade/customer";
		}
	}
	@RequestMapping("/customer/export/{category}/{type:\\d+}")
	@ResponseBody
	public ResponseEntity<byte[]> exportCustomerOrder(String productName, String name, String phone, Integer areaNO, String orderNO, String payType, String beginTime, String endTime, String amountFrom, String amountTo, Integer size, 
			@PathVariable("category")String category, @PathVariable("type")int type, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("");
		realPath = StringUtils.replace(realPath, BACK_SLASH, SLASH) + properties.getTemplatePath();
		
		if(areaNO == null){
			areaNO = -1;
		}
		int moneyFrom = 0;
		if (StringUtils.isNotBlank(amountFrom)) {
			moneyFrom = Integer.parseInt(amountFrom);
			if(moneyFrom == 0) {
				moneyFrom = ConstantUtil.ONE;
			}
		}
		int moneyTo = 0;
		if (StringUtils.isNotBlank(amountTo)) {
			moneyTo = Integer.parseInt(amountTo);
			if(moneyTo == 0) {
				moneyTo = ConstantUtil.ONE;
			}
		}
		List<CustomerOrder> orders = orderService.list(StringUtils.trim(productName), StringUtils.trim(name), StringUtils.trim(phone), areaNO, StringUtils.trimToEmpty(orderNO), payType, type, beginTime, endTime, moneyFrom, moneyTo, 0, 0);
		String fileName = properties.getCustomerOrderExcelName();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		String errorMessage = "";
		if(orders != null && orders.size()> 0) {
			String finalFileName = "";
			List<Serializable> list = new LinkedList<Serializable>();
			for(CustomerOrder order: orders) {
				list.add(order);
			}
			if (TypeEnum.IN.value() == type) {
				fileName = properties.getCustomerOrderInExcelName();
				finalFileName = ExcelUtil.writeToExcel(list, messageSource.getMessage("template.xls.customer.order.in", null, null), realPath, fileName, TypeEnum.IN);
			} /*else if (TypeEnum.OUT.value() == type) {
				fileName = ApplicationConfigUtil.get("customer.order.out.excel.name");
				finalFileName = ExcelUtil.writeToExcel(list, this.getMessage("template.xls.customer.order.out", null, null), realPath, fileName, TypeEnum.OUT);
			}*/
			
			if(StringUtils.isNotBlank(finalFileName)) {
				return this.export(realPath, fileName, request);
			}  
			errorMessage = "no file find!";
		}
		errorMessage = "this is empty!";
		headers.setContentDispositionFormData("attachment", fileName);
		return new ResponseEntity<byte[]>(errorMessage.getBytes(), headers, HttpStatus.OK); 
	}
	
	@RequestMapping("/merchant/order/{category:\\d+}/{page:\\d+}")
	public String orderList(Integer type,Integer total , Double totalAmount,  Integer loanType, String orderNO, String fromDate, String toDate, String productName, String loanName, Integer size, @PathVariable("page")Integer page, Map<String, Object> model) {

		total = total == null ? 0 : total;
		totalAmount = totalAmount == null ? 0.00 : totalAmount;
		type = type == null ? 0 : type;
		loanType = loanType == null ? -1 : loanType; 
		if(page==1){
			total = orderService.count(type, loanType, orderNO, fromDate, toDate, StringUtils.trimToEmpty(productName), StringUtils.trimToEmpty(loanName));
            totalAmount = orderService.sum(type, loanType, orderNO, fromDate, toDate, StringUtils.trimToEmpty(productName), StringUtils.trimToEmpty(loanName));
            
		}
		if (total > 0) {
			List<MerchantOrder> orders = orderService.list(type, loanType, orderNO, fromDate, toDate, StringUtils.trimToEmpty(productName), StringUtils.trimToEmpty(loanName), this.getOffset(page, size), this.getPageSize(size));
			model.put("total", total);
			model.put("orders", orders);
		}else{
			model.put("total", 0);
			model.put("orders", new MerchantOrder[0]);
		}
		model.put("now", new Date());
		model.put("totalAmount", totalAmount);
		model.put("type", type);
		model.put("loanType", loanType);
		model.put("orderNO", orderNO);
		model.put("fromDate", StringUtils.trimToEmpty(fromDate));
		model.put("toDate", StringUtils.trimToEmpty(toDate));
		model.put("loanName", StringUtils.trimToEmpty(loanName));
		model.put("loanNames", orderService.getLoanNames());
		model.put("productName", StringUtils.trimToEmpty(productName));
		model.put("size", this.getPageSize(size));
		model.put("page", this.getPage(page));
		model.put("pages", this.getTotalPage(total, size));
		return "client/merchant/order";
	}
	@RequestMapping("/balance/order/{type:\\d+}/{page:\\d+}")
	public String listBalanceOrder(Integer method, String userName, String cellphone, String startDate, String endDate, @PathVariable("type")int type, @PathVariable("page")int page, Model model) {
		method = method == null ? -1 : method;
		int total = orderService.count(type, method, StringUtils.trimToEmpty(userName), StringUtils.trimToEmpty(cellphone), startDate, endDate);
		if(total > 0) {
			model.addAttribute("total", total);
			model.addAttribute("orders", orderService.list(type, method, StringUtils.trimToEmpty(userName), StringUtils.trimToEmpty(cellphone), startDate, endDate, this.getOffset(page, PAGE_SIZE), this.getPageSize(PAGE_SIZE)));
			List<Map<String, Object>> money = orderService.sum(type, method, StringUtils.trimToEmpty(userName), StringUtils.trimToEmpty(cellphone), startDate, endDate);
			double amount = 0;
			double fee = 0;
			if (money != null) {
				for (Map<String, Object> result : money) {
					for (Map.Entry<String, Object> entry : result.entrySet()) {
						if (StringUtils.equals("amount", entry.getKey())) {
							amount = Double.parseDouble(entry.getValue().toString());
						} else if (StringUtils.equals("fee", entry.getKey())) {
							fee = Double.parseDouble(entry.getValue().toString());
						}
		            }
				}
			}
			model.addAttribute("fee", fee);
			model.addAttribute("amount", amount);
		} else {
			model.addAttribute("total", 0);
			model.addAttribute("orders", new CustomerBalanceLog[0]);
			model.addAttribute("fee", 0);
			model.addAttribute("amount", 0);
		}
		
		model.addAttribute("type", type);
		model.addAttribute("method", method);
		model.addAttribute("userName", StringUtils.trimToEmpty(userName));
		model.addAttribute("cellphone", StringUtils.trimToEmpty(cellphone));
		model.addAttribute("startDate", StringUtils.trimToEmpty(startDate));
		model.addAttribute("endDate", StringUtils.trimToEmpty(endDate));
		model.addAttribute("size", this.getPageSize(PAGE_SIZE));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, PAGE_SIZE));
		return "trade/balance";
	}
	
}
