package com.silverfox.finance.controller;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.silverfox.finance.domain.ChannelOrder;
import com.silverfox.finance.enumeration.Flow800ResultEnum;
import com.silverfox.finance.enumeration.RechargeTypeEnum;
import com.silverfox.finance.service.OrderService;
import com.silverfox.finance.util.ConstantUtil;

@Controller
@RequestMapping("/channel")
public class OperationChannelConteroller extends BaseController {
	@Autowired
	private OrderService orderService;
	
	@RequestMapping("/order/list/{page:\\d+}")
	public String listChannelOrder(String requestNO, String cellphone, Integer channelID,Integer size,@PathVariable("page")int page, Model model){
		
		if(channelID == null) {
			channelID = ConstantUtil.DEFAULT_CHANNEL_CODE;
		}
		int total = orderService.count(StringUtils.trim(requestNO), StringUtils.trim(cellphone), channelID);
		Map<String,String> flow800Result = new HashMap<String,String>();
		for (Flow800ResultEnum result : Flow800ResultEnum.values()) {
			flow800Result.put(result.getCode(), result.getMsg());
		}
		List<ChannelOrder> orders = orderService.list(StringUtils.trim(requestNO), StringUtils.trim(cellphone), channelID, this.getOffset(page, size), this.getPageSize(size));
		for (ChannelOrder channelOrder : orders) {
			channelOrder.setGoods(RechargeTypeEnum.getValueByCode(channelOrder.getGoods()));
		}
		model.addAttribute("total", total);
		model.addAttribute("orders", orders);
		model.addAttribute("requestNO", requestNO);
		model.addAttribute("cellphone",cellphone);
		model.addAttribute("channelID", channelID);
		model.addAttribute("flow800Result",flow800Result);
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "/channel/order";
	}
}