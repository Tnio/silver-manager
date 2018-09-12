package com.silverfox.finance.controller;

import static com.silverfox.finance.util.ConstantUtil.BACK_SLASH;
import static com.silverfox.finance.util.ConstantUtil.CODE;
import static com.silverfox.finance.util.ConstantUtil.DATA;
import static com.silverfox.finance.util.ConstantUtil.MINUSONE;
import static com.silverfox.finance.util.ConstantUtil.NORMAL_DATE_FORMAT;
import static com.silverfox.finance.util.ConstantUtil.PAGE_SIZE;
import static com.silverfox.finance.util.ConstantUtil.SLASH;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.alibaba.fastjson.JSONObject;
import com.silverfox.finance.domain.Admin;
import com.silverfox.finance.domain.Attachment;
import com.silverfox.finance.domain.CardBin;
import com.silverfox.finance.domain.Customer;
import com.silverfox.finance.domain.CustomerBalanceLog;
import com.silverfox.finance.domain.CustomerBank;
import com.silverfox.finance.domain.CustomerCoupon;
import com.silverfox.finance.domain.CustomerOrder;
import com.silverfox.finance.domain.Lender;
import com.silverfox.finance.domain.Merchant;
import com.silverfox.finance.domain.MerchantOrder;
import com.silverfox.finance.domain.Role;
import com.silverfox.finance.domain.RoleResource;
import com.silverfox.finance.domain.UnionPayCNCode;
import com.silverfox.finance.domain.UnionPayVoucher;
import com.silverfox.finance.domain.User;
import com.silverfox.finance.domain.UserBank;
import com.silverfox.finance.domain.VipLevelChangeLog;
import com.silverfox.finance.entity.ArrayObjectEntity;
import com.silverfox.finance.entity.InviteesEntity;
import com.silverfox.finance.entity.SecurityEntity;
import com.silverfox.finance.entity.UserEntity;
import com.silverfox.finance.enumeration.AuthorisationCategoryEnum;
import com.silverfox.finance.enumeration.CustomerBalanceTypeEnum;
import com.silverfox.finance.enumeration.CustomerBankStatusEnum;
import com.silverfox.finance.enumeration.GenericEnableEnum;
import com.silverfox.finance.enumeration.MainPageStatisticsEnum;
import com.silverfox.finance.enumeration.PayChannelEnum;
import com.silverfox.finance.service.BonusService;
import com.silverfox.finance.service.ChannelService;
import com.silverfox.finance.service.ClientService;
import com.silverfox.finance.service.CouponService;
import com.silverfox.finance.service.PayBankService;
import com.silverfox.finance.service.ProductService;
import com.silverfox.finance.service.SystemService;
import com.silverfox.finance.service.TradeService;
import com.silverfox.finance.util.ConstantUtil;
import com.silverfox.finance.util.ExcelUtil;
import com.silverfox.finance.util.LogRecord;

@Controller
@RequestMapping("/client")
public class ClientController extends BaseController {
//    private final float COMMISSION_RATE = Float.parseFloat(ApplicationConfigUtil.get("commission.rate"));
    @Autowired
    private ProductService productService;
    @Autowired
    private ClientService clientService;
    @Autowired
    private PayBankService payBankService;
    @Autowired
    private ChannelService channelService;
    @Autowired
    private SystemService systemService;
//    @Autowired
//    private SmsService smsService;
    @Autowired
    private CouponService couponService;
    @Autowired
    private TradeService tradeService;
    @Autowired
    private BonusService bonusService;

//    @RequestMapping(value="payment/send/smscode")
//    @ResponseBody
//    public JSONObject sendSmsCode(int adminId) {
//        JSONObject result = new JSONObject();
//        this.init();
//        Admin admin = systemService.getAdmin(adminId);
//        if (admin != null && admin.getId() > 0 && StringUtils.isNotBlank(admin.getCellphone())) {
//            result = smsService.sendValidateCode(smsPaymentCode, SmsCategoryEnum.PAYMENT.toString(), admin.getCellphone(), Integer.parseInt(seed), FORMAT_UTF8, Long.parseLong(timeout), TimeUnit.MINUTES);
//        }
//        return result;
//    }
//
//    @RequestMapping(value="payment/resend/smscode")
//    @ResponseBody
//    public JSONObject resendSmsCode(int adminId) {
//        JSONObject result = new JSONObject();
//        this.init();
//        Admin admin = systemService.getAdmin(adminId);
//        if (admin != null && admin.getId() > 0 && StringUtils.isNotBlank(admin.getCellphone())) {
//            result = smsService.resendValidateCode(smsPaymentCode, SmsCategoryEnum.PAYMENT.toString(), admin.getCellphone(), Integer.parseInt(seed), FORMAT_UTF8, Long.parseLong(timeout), TimeUnit.MINUTES);
//        }
//        return result;
//    }

    @RequestMapping(value="/code/gauth", method= RequestMethod.POST)
    @ResponseBody
    public boolean authorize(String userName, String authCode, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Admin admin = systemService.getAdmin(userName);
        if(admin != null) {
            List<NameValuePair> nvps = new ArrayList<NameValuePair>();
            nvps.add(new BasicNameValuePair("userName", userName));
            nvps.add(new BasicNameValuePair("authCode", authCode));
            String result = this.invokeHttp(properties.getAuthUrl()+messageSource.getMessage("gauth.authorize.path", null, null), nvps);
            if(StringUtils.isNotBlank(result)) {
                JSONObject json = JSONObject.parseObject(result);
                if(json != null && json.containsKey(CODE)) {
                    if(StringUtils.equals(json.getString(CODE), String.valueOf(HttpServletResponse.SC_OK))) {
                        return true;
                    }
                }
            }
        }

        return false;
    }

    @RequestMapping(value="/merchant/loan/bank/city/{code}", method=RequestMethod.GET)
    @ResponseBody
    public List<UnionPayCNCode> cityOfBank(@PathVariable("code")String code) {
        return payBankService.getCityList(code);
    }

    @RequestMapping(value="/merchant/loan/bank/voucher/{provinceCode}/{bankCode}", method=RequestMethod.GET)
    @ResponseBody
    public List<UnionPayVoucher> bankVoucher(String city, @PathVariable("provinceCode")String provinceCode, @PathVariable("bankCode")String bankCode) {
        return payBankService.getBankVoucher(provinceCode, city, bankCode);
    }

    @RequestMapping(value="/product/get/{productId:\\d+}", method=RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getProduct(@PathVariable("productId")int productId, HttpServletRequest request) {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("product", productService.get(productId));
        List<CustomerOrder> orders = tradeService.listCustomerOrder(productId);
        double customerPoundage = 0.0;
        double customerProfit = 0.0;
        for (CustomerOrder order : orders) {

            if (order.getPrincipal() * Float.parseFloat(properties.getCommissionRate()) >= 1) {//COMMISSION_RATE
                customerPoundage += order.getPrincipal() * Float.parseFloat(properties.getCommissionRate());//COMMISSION_RATE
            } else {
                customerPoundage += 1;
            }
            customerPoundage += 1;
            if (order.getProduct() != null) {
                customerProfit += order.getProduct().getFinancePeriod()*order.getPrincipal()*(order.getProduct().getYearIncome()+order.getProduct().getIncreaseInterest())/36500;
            }
        }
        result.put("customerPoundage", customerPoundage);
        result.put("customerProfit", customerProfit);
        return result;
    }

    @RequestMapping(value="/merchant/loan/bank/voucher/{provinceCode}", method=RequestMethod.GET)
    @ResponseBody
    public List<UnionPayVoucher> bankVoucher(String city, @PathVariable("provinceCode")String provinceCode) {
        return payBankService.getBankVoucherList(provinceCode, city);
    }

    @RequestMapping(value="/merchant/money/{merchantId:\\d+}", method=RequestMethod.GET)
    @ResponseBody
    public int getMoney(@PathVariable("merchantId")int merchantId) {
        return clientService.getCanBorrowMoney(merchantId);
    }

    @RequestMapping(value="/merchant/add/{page:\\d+}", method=RequestMethod.POST)
    public String forwardToCreation(String searchName, Integer size, @PathVariable("page")Integer page, HttpServletRequest request) {
        this.getMerchantParam(searchName, page, size, request);
        request.setAttribute("unionPayBanks", payBankService.getBankList(PayChannelEnum.UNION_ENTERPRISE_EBANK, GenericEnableEnum.ENABLE.value()));
        request.setAttribute("provinces", payBankService.getProvinceList());
        return "client/merchant/add";
    }

    @RequestMapping(value="/merchant/edit/{id:\\d+}/{page:\\d+}", method=RequestMethod.POST)
    public String forwardToModification(String searchName, Integer size, @PathVariable("id")Integer id, @PathVariable("page")Integer page, HttpServletRequest request,Model model) {
        request = this.getMerchantParam(searchName, page, size, request);
        request.setAttribute("merchant", clientService.getMerchant(id));
        request.setAttribute("unionPayBanks", payBankService.getBankList(PayChannelEnum.UNION_ENTERPRISE_EBANK, GenericEnableEnum.ENABLE.value()));
        request.setAttribute("provinces", payBankService.getProvinceList());
        request.setAttribute("operation",EDIT);

        List<String> arrayList = new ArrayList<String>();
        String data = clientService.selectOtherDataByMerchantId(id);
        if(StringUtils.isNotBlank(data)){
            String[] split = data.split(",");
            for (String str : split) {
                int attachmentId  = Integer.parseInt(str);
                Attachment att = clientService.selectByAttachmentId(attachmentId);
                arrayList.add(att.getUrl());
            }
        }

        model.addAttribute("merchantOtherData", arrayList);
        return "client/merchant/edit";
    }

    @RequestMapping(value="/merchant/detail/{id:\\d+}/{page:\\d+}", method=RequestMethod.POST)
    public String forwardToDetail(String name, Integer size, @PathVariable("id")Integer id, @PathVariable("page")Integer page, Model model, HttpServletRequest request) {
        request = this.getMerchantParam(name, page, size, request);
        model.addAttribute("merchant", clientService.getMerchant(id));
        model.addAttribute("unionPayBanks", payBankService.getBankList(PayChannelEnum.UNION_ENTERPRISE_EBANK, GenericEnableEnum.ENABLE.value()));
        model.addAttribute("provinces", payBankService.getProvinceList());
        model.addAttribute("operation",DETAIL);
		/*String data = clientServiceApi.selectOtherDataByMerchantId(id);
		List<String> arrayList = new ArrayList<String>();
		if(StringUtils.isNotBlank(data)){
			String[] split = data.split(",");
			for (String str : split) {
				arrayList.add(str);
			}
		}*/
        List<String> arrayList = new ArrayList<String>();
        String data = clientService.selectOtherDataByMerchantId(id);
        if(StringUtils.isNotBlank(data)){
            String[] split = data.split(",");
            for (String str : split) {
                int attachmentId  = Integer.parseInt(str);
                Attachment att = clientService.selectByAttachmentId(attachmentId);
                arrayList.add(att.getUrl());
            }
        }
        model.addAttribute("merchantOtherData", arrayList);
        return "client/merchant/edit";
    }

    @RequestMapping(value="/merchant/audit/{id:\\d+}/{status:\\d+}", method=RequestMethod.POST)
    public String audit(String name, Integer page, @PathVariable("id")Integer id, @PathVariable("status")Integer status, HttpServletRequest request) {
        request.setAttribute("name", name);
        clientService.audit(id, status);
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/client/merchant/list/"+this.getPage(page);
    }

    @RequestMapping(value="/merchant/list/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> listMerchant(String name, @PathVariable("size") Integer size, @PathVariable("page")Integer page, Model model) {
        try {
            name=java.net.URLDecoder.decode(name,"UTF-8");
        } catch (UnsupportedEncodingException e) {
            LOGGER.info(e.getMessage());
        }
        int total = clientService.count(name, 1);
        Map<String, Object> result = new HashMap<String, Object>();
        if (total > 0) {
            result.put("merchantTotal", total);
            result.put("companies", clientService.list(name, 1, this.getOffset(page, size), this.getPageSize(size)));
        } else {
            result.put("merchantTotal", 0);
            result.put("companies", new Merchant[0]);
        }
        result.put("name", StringUtils.trimToEmpty(name));
        result.put("merchantSize", this.getPageSize(size));
        result.put("merchantPage", this.getPage(page));
        result.put("merchantPages", this.getTotalPage(total, size));
        return result;
    }

    @RequestMapping(value="/merchant/duplicate/license", method=RequestMethod.GET)
    @ResponseBody
    public String checkCode(int id, String fieldId, String fieldValue) {
        if (id >= 0 && StringUtils.isNotBlank(fieldId) && StringUtils.isNotBlank(fieldId)) {
            ArrayObjectEntity json = new ArrayObjectEntity();
            boolean result = clientService.duplicate(id, StringUtils.trim(fieldValue));
            json.setObject(fieldId);
            json.setSuccess(result);
            if (result) {
                json.setMessage(properties.getLicensenoPass());//ApplicationConfigUtil.get("licenseno.pass")
            } else {
                json.setMessage(properties.getAppNameNoPass());//ApplicationConfigUtil.get("licenseno.no.pass")
            }
            return json.toString();
        }
        return null;
    }

    @RequestMapping("/borrowerCredit/list/{page:\\d+}")
    public String borrowerCreditList(Integer type,String searchName,String cellphone,String startAmount,String endAmount, Integer size, @PathVariable("page")Integer page, Model model,HttpServletRequest request) {
        int total = clientService.queryForBorrowerCreditCount(type, searchName, cellphone,startAmount, endAmount);
        if (total > 0) {
            model.addAttribute("total", total);
            //model.addAttribute("companies", clientService.list(searchName, -1, this.getOffset(page, size), this.getPageSize(size)));
            List<Lender> list = clientService.queryForBorrowerCreditList(type,searchName, cellphone,startAmount, endAmount, this.getOffset(page, size), this.getPageSize(size));
            Integer totalMoney = clientService.queryForBorrowerTotalMoney(type, searchName, cellphone,startAmount, endAmount);
            model.addAttribute("companies",list);
            if(totalMoney==null){
                model.addAttribute("totalMoney",0);
            }else{
                model.addAttribute("totalMoney",totalMoney);
            }
        } else {
            model.addAttribute("total", 0);
            model.addAttribute("companies", new Merchant[0]);
            model.addAttribute("totalMoney",0);
        }
        if(type == 2){
        	model.addAttribute("addFunctionPermit",getAddFunctionPermit(request));
        }
        model.addAttribute("merchants", clientService.queryForBorrowerCreditList(0, null, null, null,null,0,0));
        model.addAttribute("type", type);
        model.addAttribute("searchName", StringUtils.trimToEmpty(searchName));
        model.addAttribute("cellphone", cellphone);
        model.addAttribute("startAmount", startAmount);
        model.addAttribute("endAmount", endAmount);
        model.addAttribute("size", this.getPageSize(size));
        model.addAttribute("page", this.getPage(page));
        model.addAttribute("pages", this.getTotalPage(total, size));


        return "client/merchant/list";
    }


	@RequestMapping("/merchant/list/{page:\\d+}")
    public String list(Integer type,String searchName,String cellphone,String startAmount,String endAmount, Integer size, @PathVariable("page")Integer page, Model model) throws ParseException {
        type = type==null?0:type;
        int total = clientService.queryForCount(type, searchName, cellphone,startAmount, endAmount, -1);
        if (total > 0) {
            model.addAttribute("total", total);
            //model.addAttribute("companies", clientService.list(searchName, -1, this.getOffset(page, size), this.getPageSize(size)));
            List<Merchant> list = clientService.queryForlist(type,searchName, cellphone,startAmount, endAmount, -1, this.getOffset(page, size), this.getPageSize(size));

            double totalMoney = clientService.queryTotalMoney(type, searchName, cellphone,startAmount, endAmount);
            model.addAttribute("companies",list);
            model.addAttribute("totalMoney",totalMoney);
        } else {
            model.addAttribute("total", 0);
            model.addAttribute("companies", new Merchant[0]);
            model.addAttribute("totalMoney",0);
        }
        model.addAttribute("merchants", clientService.list(null, 1, 0, 0));
        model.addAttribute("type", type);
        model.addAttribute("searchName", StringUtils.trimToEmpty(searchName));
        model.addAttribute("cellphone", cellphone);
        model.addAttribute("startAmount", startAmount);
        model.addAttribute("endAmount", endAmount);
        model.addAttribute("size", this.getPageSize(size));
        model.addAttribute("page", this.getPage(page));
        model.addAttribute("pages", this.getTotalPage(total, size));
        return "client/merchant/list";
    }

    @RequestMapping("/merchant/record/{merchantId:\\d+}")
    public String merchantRecord(String name, @PathVariable("merchantId")Integer merchantId, Model model) throws ParseException {
        List<MerchantOrder> outOrders = clientService.list(merchantId, 1);
        List<MerchantOrder> inOrders = clientService.list(merchantId, 0);
        int totalAmount = 0;
        SimpleDateFormat dateFormat = new SimpleDateFormat(NORMAL_DATE_FORMAT);
        List<MerchantOrder> orders = new ArrayList<MerchantOrder>();
        for (MerchantOrder order : outOrders) {
            if (order != null && order.getStatus() < 3) {
                totalAmount += order.getPrincipal();
                if (order.getProduct() != null) {
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(dateFormat.parse(order.getProduct().getInterestDate()));
                    calendar.add(Calendar.DAY_OF_YEAR, order.getProduct().getFinancePeriod()-1);
                    order.setTradeTime(calendar.getTime());
                    for (MerchantOrder inOrder : inOrders) {
                        if (inOrder.getProduct() != null && StringUtils.equals(String.valueOf(order.getProduct().getId()), String.valueOf(inOrder.getProduct().getId()))) {
                            order.setStatus(inOrder.getStatus());
                            order.setType(inOrder.getType());
                        }
                    }
                }
                orders.add(order);
            }

        }

        model.addAttribute("name", name);
        model.addAttribute("merchantId", merchantId);
        model.addAttribute("orders", orders);
        model.addAttribute("totalAmount", totalAmount);
        return "client/merchant/detail";
    }

    @RequestMapping(value="/merchant/{id:\\d+}", method=RequestMethod.GET)
    @ResponseBody
    public Merchant get(@PathVariable("id")int id) {
        return clientService.getMerchant(id);
    }
    @RequestMapping("merchant/checklicenseNO")
    @ResponseBody
    public Map<String,Object> getLicenseNO(String licenseNO) {
        Map<String,Object> map = new HashMap<String,Object>();
        List<Merchant> list  =  clientService.getLicenseNO(licenseNO);
        if(list.size() > 0){
            map.put("message",false);
            map.put("list",list.get(0));
        }else{
            map.put("message",true);
        }
        return map;
    }

    @RequestMapping("/merchant/borrowCountDetail/{page:\\d+}")
    public String get(String idcard,String type,Integer status, @PathVariable("page")Integer page, Integer size,Model model) {
        if(status == null){
            status = 8;
        }
        int total = clientService.queryForBorrowCountDetailCount(idcard,status);
        if (total > 0) {
            model.addAttribute("total", total);
            List<Lender> list = clientService.queryForBorrowCountDetailList(type,idcard,status, this.getOffset(page, size), this.getPageSize(size));
            int totalMoney = clientService.queryForBorrowCountDetailTotalMoney(type,idcard,status);
            model.addAttribute("Lender",list);
            model.addAttribute("totalMoney",totalMoney);
        } else {
            model.addAttribute("total", 0);
            model.addAttribute("Lender", new Lender[0]);
            model.addAttribute("totalMoney",0);
        }
        model.addAttribute("type", type);
        model.addAttribute("idcard", idcard);
        model.addAttribute("status", status);
        model.addAttribute("size", this.getPageSize(size));
        model.addAttribute("page", this.getPage(page));
        model.addAttribute("pages", this.getTotalPage(total, size));
        return "client/merchant/borrowCountDetail";
    }
    @RequestMapping(value="/merchant/save", method=RequestMethod.POST)
    public String save(Merchant merchant, String name, String[] commitment, String removeAttachments, String searchName, Integer page, Integer size, HttpServletRequest request, RedirectAttributesModelMap redirectAttributesModelMap, Model model) {
        Map<String, String> result = upload(request);
        List<Attachment> attachments = new ArrayList<Attachment>();
        String otherData = "";
        for(String key : result.keySet()) {
            if (StringUtils.contains(key, "commitment")){

                otherData = otherData + result.get(key)+",";
            }
            if (StringUtils.contains(key, "letterOf")) {
                Attachment attachment = new Attachment();
                attachment.setCategory(4);
                attachment.setProductId(0);
                attachment.setGuaranteeId(0);
                attachment.setUrl(result.get(key));
                attachments.add(attachment);
            }
            if (StringUtils.contains(key, properties.getLicenses())) {//ApplicationConfigUtil.get("licenses")
                merchant.setLicense(result.get(key));
            }
            if (StringUtils.contains(key, "legalPersonIdcards")) {
                merchant.setLegalPersonIdcard(result.get(key));
            }
            if (StringUtils.contains(key, "licenceImgs")) {
                merchant.setLicenceImg(result.get(key));
            }
            if (StringUtils.contains(key, "realDiagrams")) {
                merchant.setRealDiagram(result.get(key));
            }
        }
        if (commitment != null){
            for (String string : commitment) {
                if(StringUtils.isNotBlank(otherData)){
                    otherData = otherData + string + ",";
                }else{
                    otherData = otherData + string + "," ;
                }
            }
            merchant.setOtherData(otherData);
        }else{
            if(StringUtils.isNotBlank(otherData)){
                merchant.setOtherData(otherData);
            }else{
                merchant.setOtherData(null);
            }
        }

        merchant.setAttachments(attachments);
        clientService.saveMerchant(merchant);
        redirectAttributesModelMap.addAttribute("name", name);
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/client/merchant/list/"+this.getPage(page);
    }
    @RequestMapping("/merchant/auditing")
    public String changeStatus(Integer rowId,Integer status) {
        clientService.audit(rowId, status);
        return "redirect:/client/merchant/list/1";
    }
    @RequestMapping(value="/merchant/voucher/{orderId:\\d+}", method=RequestMethod.POST)
    public String saveVoucher(@PathVariable("orderId")Integer orderId, Integer page, HttpServletRequest request, Model model) {
        Map<String, String> result = upload(request);
        String voucher = null;
        for(String key : result.keySet()) {
            if (StringUtils.contains(key, "voucherImg")) {
                voucher = result.get(key);
            }
        }
        clientService.addVoucher(voucher, orderId);
        if(page == null){
            page = 1;
        }
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/trade/merchant/order/2/"+page;
    }

    @RequestMapping(value="/merchant/loan/add/{page:\\d+}", method=RequestMethod.POST)
    public String forwardToCreation(Integer size,   @PathVariable("page")Integer page, HttpServletRequest request) {
        request.setAttribute("unionPayBanks", payBankService.getBankList(PayChannelEnum.UNION_ENTERPRISE_EBANK, GenericEnableEnum.ENABLE.value()));
        request.setAttribute("provinces", payBankService.getProvinceList());
        int total = clientService.count("", -1);
        this.getMerchantParam(total, request);
        return "client/merchant/loan/add";
    }

    @RequestMapping(value="/merchant/loan/contract/delete", method=RequestMethod.POST)
    @ResponseBody
    public boolean deleteContract(String name, HttpServletRequest request) {
        String resourcePath = getResourcePath(request);
        return FileUtils.deleteQuietly(new File(resourcePath+name));
    }

	private String getResourcePath(HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("");
		realPath = StringUtils.replace(realPath, ConstantUtil.BACK_SLASH, ConstantUtil.SLASH);
		String resourcePath = properties.getUploadPath();
		
		return realPath+resourcePath;
	}

    @RequestMapping(value="/merchant/sms/status", method=RequestMethod.POST)
    @ResponseBody
    public boolean closeNotice(int merchantId, int status) {
        if(merchantId > 0){
            Merchant merchant = clientService.getMerchant(merchantId);
            if(merchant != null){
                merchant.setCloseNotice(status);
                return clientService.saveMerchant(merchant);
            }
        }
        return false;
    }


    @RequestMapping("/customer/coupons/{customerId:\\d+}/{page:\\d+}")
    public String customerCoupons(Integer status, @PathVariable("customerId")Integer customerId, @PathVariable("page")int page, Model model){
        if(status == null){
            status = -1;
        }
        if(customerId == null){
            customerId = 0;
        }
        int total = couponService.countCoupons(customerId, status);
        if(total > 0){
            model.addAttribute("total", total);
            model.addAttribute("coupons", couponService.listCoupons(customerId, status, this.getOffset(page, PAGE_SIZE), this.getPageSize(PAGE_SIZE)));
        }else{
            model.addAttribute("total", 0);
            model.addAttribute("coupons", new CustomerCoupon[0]);
        }
        model.addAttribute("customerId", customerId);
        model.addAttribute("status", status);
        model.addAttribute("size", this.getPageSize(PAGE_SIZE));
        model.addAttribute("page", this.getPage(page));
        model.addAttribute("pages", this.getTotalPage(total, PAGE_SIZE));
        return "client/customer/coupons";
    }

    @RequestMapping("/customer/list/{page:\\d+}")
    public String list(Integer vipLevel, String name, String cellphone, String idcard, String timeType, Integer channelId, String beginTime, String endTime, Integer startAmount, Integer endAmount, Integer size, String sort, @PathVariable("page")int page, Model model){
        if(channelId == null){
            channelId = MINUSONE;
        }
        if(vipLevel == null){
        	vipLevel = -1;
        }
        int total = clientService.count(vipLevel, StringUtils.trimToEmpty(name), StringUtils.trimToEmpty(cellphone),
                StringUtils.trimToEmpty(idcard), timeType, channelId, beginTime, endTime, startAmount != null ? startAmount : -1, endAmount != null ? endAmount : -1);
        if(total > 0){
            model.addAttribute("total", total);
            model.addAttribute("customers", clientService.list(vipLevel, StringUtils.trimToEmpty(name), StringUtils.trimToEmpty(cellphone),
                    StringUtils.trimToEmpty(idcard), timeType, channelId, beginTime, endTime, startAmount != null ? startAmount : -1, endAmount != null ? endAmount : - 1, sort, this.getOffset(page, size), this.getPageSize(size)));
        }else{
            model.addAttribute("total", 0);
            model.addAttribute("customers", new Customer[0]);
        }
        model.addAttribute("channels", channelService.listForUsed());
        model.addAttribute("name", StringUtils.trimToEmpty(name));
        model.addAttribute("cellphone", StringUtils.trimToEmpty(cellphone));
        model.addAttribute("idcard", StringUtils.trimToEmpty(idcard));
        model.addAttribute("timeType", StringUtils.trimToEmpty(timeType));
        model.addAttribute("channelId", channelId);
        model.addAttribute("beginTime", StringUtils.trimToEmpty(beginTime));
        model.addAttribute("endTime", StringUtils.trimToEmpty(endTime));
        model.addAttribute("startAmount", startAmount);
        model.addAttribute("endAmount", endAmount);
        model.addAttribute("sort", StringUtils.trimToEmpty(sort));
        model.addAttribute("size", this.getPageSize(size));
        model.addAttribute("page", this.getPage(page));
        model.addAttribute("pages", this.getTotalPage(total, size));
        model.addAttribute("vipLevel", vipLevel);
        return "client/customer/list";
    }

    @RequestMapping("/lender/period/list/{page:\\d+}")
    @ResponseBody
    public Map<String, Object> listProductLender(Integer loanPeriod, Integer projectType, Integer size, @PathVariable("page")int page){
        Map<String, Object> result = new HashMap<String, Object>();
        if(size == null || size == 0) {
			size = 30;
		}
        int total = clientService.countLender(loanPeriod, projectType, 0);
        if(total > 0){
            result.put("total", total);
            result.put("lenders", clientService.listLender(loanPeriod, projectType, 0, this.getOffset(page, size), this.getPageSize(size)));
        }else{
            result.put("total", 0);
            result.put("lenders", new ArrayList<Lender>());
        }
        result.put("size", this.getPageSize(size));
        result.put("page", this.getPage(page));
        result.put("pages", this.getTotalPage(total, size));
        return result;
    }

    @RequestMapping("/lender/list/{page:\\d+}")
    public String list(Integer size, @PathVariable("page")int page, Model model){
        int total = clientService.countLender(0, 2, -1);
        if(total > 0){
            model.addAttribute("total", total);
            model.addAttribute("lenders", clientService.listLender(0, 2, -1, this.getOffset(page, size), this.getPageSize(size)));
        }else{
            model.addAttribute("total", 0);
            model.addAttribute("lenders", new Lender[0]);
        }
        model.addAttribute("size", this.getPageSize(size));
        model.addAttribute("page", this.getPage(page));
        model.addAttribute("pages", this.getTotalPage(total, size));
        return "client/lender/list";
    }

    @RequestMapping(value="customer/reset/{id:\\d+}/turnout/bank", method=RequestMethod.POST)
    @ResponseBody
    public boolean resetTurnOutBank(@PathVariable("id") int id) {
        return clientService.resetTurnOutBank(id);
    }

    @RequestMapping(value="customer/set/vip/{id:\\d+}", method=RequestMethod.POST)
    @ResponseBody
    public boolean setVip(@PathVariable("id") int id) {
        return clientService.setVip(id);
    }

    @RequestMapping(value="/customer/{customerId:\\d+}", method=RequestMethod.GET)
    @ResponseBody
    public User getCustomer(@PathVariable("customerId") int customerId ) {
        return clientService.get(customerId);
    }

    @RequestMapping(value="/customer/card/{customerId:\\d+}", method=RequestMethod.GET)
    @ResponseBody
    public List<CustomerBank> getCustomerCards(@PathVariable("customerId") Integer customerId) {
        return clientService.listBanks(customerId, CustomerBankStatusEnum.NOCANCELLATION.value());
    }

    @RequestMapping(value="/customer/list/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> listCustomer(String idcard, @PathVariable("size")int size, @PathVariable("page")int page){
        Map<String, Object> result = new HashMap<String, Object>();
        int total = clientService.count(-1, null, null, idcard, null, 0, null, null, -1, -1);
        if(total > 0){
            result.put("customerTotal", total);
            result.put("customers", clientService.list(-1, null, null, idcard, null, 0, null, null, 0, 0, null, this.getOffset(page, size), this.getPageSize(size)));

        }else{
            result.put("customerTotal", 0);
            result.put("customers", new Customer[0]);
        }
        result.put("idcard", StringUtils.trimToEmpty(idcard));
        result.put("customerSize", this.getPageSize(size));
        result.put("customerPage", this.getPage(page));
        result.put("customerPages", this.getTotalPage(total, size));
        return result;
    }

    @RequestMapping("/customer/export")
    @LogRecord(module=LogRecord.Module.CUSTOMER, operation=LogRecord.Operation.EXPORT, id="", name="name")
    @ResponseBody
    public ResponseEntity<byte[]> exportOrder(String name, String cellphone, String idcard, String timeType, Integer channelId, String beginTime, String endTime, Integer startAmount, Integer endAmount, Integer size, String sort, HttpServletRequest request, HttpServletResponse response) {
        String realPath = request.getSession().getServletContext().getRealPath("");
        realPath = StringUtils.replace(realPath, BACK_SLASH, SLASH) + properties.getTemplatePath();//ApplicationConfigUtil.get("template.path")
        String fileName = properties.getCustomerExcelName();//ApplicationConfigUtil.get("customer.excel.name");
        List<UserEntity> customers = clientService.list(-1, name, cellphone, idcard, timeType, channelId, beginTime, endTime, startAmount != null ? startAmount : -1, endAmount != null ? endAmount : - 1, sort, 0, 0);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        List<Serializable> list = new LinkedList<Serializable>();
        for(UserEntity user : customers) {
            list.add(user);
        }
        String errorMessage = "";
        if (list != null && list.size() > 0) {
            String finalFileName = ExcelUtil.writeToExcel(list, messageSource.getMessage("template.xls.customer", null, null), realPath, fileName, null);
            if (StringUtils.isNotBlank(finalFileName)) {
                return this.export(realPath, fileName, request);
            }
            errorMessage = "no file find!";
        }
        errorMessage = "this is empty!";
        headers.setContentDispositionFormData("attachment", fileName);
        return new ResponseEntity<byte[]>(errorMessage.getBytes(), headers, HttpStatus.OK);
    }

    @RequestMapping("/customer/{customerId:\\d+}/trade/{page:\\d+}")
    public String getTrade(String beginTime, String endTime, String orderNO, Integer isPayback, Integer couponType, Integer size, @PathVariable("customerId")int customerId, @PathVariable("page")int page, Model model) {
        SimpleDateFormat sdf = new SimpleDateFormat(NORMAL_DATE_FORMAT);
        int total = tradeService.countTrade(beginTime, endTime, orderNO, isPayback != null ? isPayback : 0, couponType != null ? couponType : 0, sdf.format(new Date()), customerId);
        if(total > 0) {
            model.addAttribute("total", total);
            model.addAttribute("customerOrders", tradeService.listTrade(beginTime, endTime, orderNO, isPayback != null ? isPayback : 0, couponType != null ? couponType : 0, sdf.format(new Date()), customerId, this.getOffset(page, size), this.getPageSize(size)));
        } else {
            model.addAttribute("total", 0);
            model.addAttribute("customerOrders", new CustomerOrder[0]);
        }
        model.addAttribute("beginTime", StringUtils.trimToEmpty(beginTime));
        model.addAttribute("endTime", StringUtils.trimToEmpty(endTime));
        model.addAttribute("customerId", customerId);
        model.addAttribute("orderNO",orderNO);
        model.addAttribute("isPayback",isPayback);
        model.addAttribute("couponType",couponType);
        model.addAttribute("systemTime", sdf.format(new Date()));
        model.addAttribute("size", this.getPageSize(size));
        model.addAttribute("page", this.getPage(page));
        model.addAttribute("pages", this.getTotalPage(total, size));
        return "client/customer/detail";
    }

    @RequestMapping(value="/customer/card/list/{customerId:\\d+}")
    public String customerCardsList(@PathVariable("customerId") Integer customerId, Model model) {
        model.addAttribute("customerCards", clientService.listBanks(customerId, CustomerBankStatusEnum.ALL.value()));
        model.addAttribute("customerId", customerId);
        return "client/customer/cards";
    }

    @RequestMapping(value="/customer/card/reset")
    @ResponseBody
    public  boolean customerCardsReset(int id, Model model) {
        if(id > 0){
            CustomerBank bank = clientService.getBank(id);
            if(bank != null){
                bank.setStatus(0);

                return clientService.save(id,bank);
            }
        }
        return false;
    }

    @RequestMapping(value="/user/detail/{id:\\d+}", method=RequestMethod.GET)
    public String detail(@PathVariable("id")Integer id, String name, String cellphone, String idcard, String timeType, Integer channelId, String beginTime, String endTime, Integer startAmount, Integer endAmount, String sort, Model model) {
        User user = clientService.get(id);
        if(user != null){
            Customer customer = clientService.getCustomer(id);
            if (customer != null && customer.getTotalTradeAmount() > 0) {
                model.addAttribute("collectPrincipal", clientService.getCollectPrincipal(id));
            }
            model.addAttribute("freezingAmount", clientService.getfreezingAmountByCustomerId(id));
            model.addAttribute("bank", clientService.getBankByCustomerId(id));
            double balance = 0.00d;
            if(StringUtils.isNotBlank(user.getAccountId())){
                balance = getbalance(id);
            }
            model.addAttribute("balance", balance);
            model.addAttribute("user", user);
            model.addAttribute("inviteNumber", clientService.countInviteNumber(user.getCellphone()));
            double cumulative = 0;
            double reward = clientService.countReward(user.getCellphone());
            CustomerCoupon coupon = bonusService.getCumulativeCoupon(id);
            if(coupon != null){
                cumulative=coupon.getAmount();
            }
            model.addAttribute("customer", customer);
            model.addAttribute("reward", reward);
            model.addAttribute("unUsedCoupons", couponService.countCustomerCouponsByUse(id, 0));
            model.addAttribute("usedCumulativeRebate", reward - cumulative);
            model.addAttribute("name", StringUtils.trimToEmpty(name));
            model.addAttribute("cellphone", StringUtils.trimToEmpty(cellphone));
            model.addAttribute("idcard", StringUtils.trimToEmpty(idcard));
            model.addAttribute("timeType", StringUtils.trimToEmpty(timeType));
            model.addAttribute("channelId", channelId);
            model.addAttribute("beginTime", StringUtils.trimToEmpty(beginTime));
            model.addAttribute("endTime", StringUtils.trimToEmpty(endTime));
            model.addAttribute("startAmount", startAmount);
            model.addAttribute("endAmount", endAmount);
            model.addAttribute("qq", clientService.getWithAccount(AuthorisationCategoryEnum.QQ, id));
            model.addAttribute("wechat", clientService.getWithAccount(AuthorisationCategoryEnum.WCHAT, id));
            model.addAttribute("sort", StringUtils.trimToEmpty(sort));
        }
        return "user/detail";
    }


    @RequestMapping(value="/card/bind/query", method=RequestMethod.POST)
    @ResponseBody
    public String cardBindQuery(int userId, String accountId,String cardNo){
        if(accountId == null){
            return cardNo;
        }
        UserBank bank = clientService.getBankByCustomerId(userId);
        if (bank == null || StringUtils.isBlank(bank.getCardNo())) {
            return cardNo;
        }
        cardNo = bank.getCardNo();
        User user = clientService.get(userId);
        if (user == null || StringUtils.isBlank(user.getAccountId())) {
            return cardNo;
        }
        accountId = user.getAccountId();
        Calendar calendar = Calendar.getInstance();
        SimpleDateFormat dateFormat = new SimpleDateFormat(ConstantUtil.NUMBER_DATE_FORMAT);
        SimpleDateFormat timeFormat = new SimpleDateFormat(ConstantUtil.NUMBER_TIME_FORMAT);
        String txDate = dateFormat.format(calendar.getTime());
        String txTime = timeFormat.format(calendar.getTime());
        if (StringUtils.length(String.valueOf(seqNO)) > 6) {
            seqNO = 1;
        }
        String seqNo = StringUtils.leftPad(String.valueOf(++seqNO), 6, '0');
        List<NameValuePair> nvps = new ArrayList<NameValuePair>();
        nvps.add(new BasicNameValuePair("version",messageSource.getMessage("bank.version", null, Locale.getDefault())));
        nvps.add(new BasicNameValuePair("txCode",messageSource.getMessage("bank.cardBindQuery", null, Locale.getDefault())));
        nvps.add(new BasicNameValuePair("instCode",messageSource.getMessage("bank.instCode", null, Locale.getDefault())));
        nvps.add(new BasicNameValuePair("bankCode",messageSource.getMessage("bank.bankCode", null, Locale.getDefault())));
        nvps.add(new BasicNameValuePair("txDate",txDate));
        nvps.add(new BasicNameValuePair("txTime",txTime));
        nvps.add(new BasicNameValuePair("seqNo",seqNo));
        nvps.add(new BasicNameValuePair("channel",messageSource.getMessage("bank.channel", null, Locale.getDefault())));
        nvps.add(new BasicNameValuePair("accountId",accountId));
        nvps.add(new BasicNameValuePair("state",messageSource.getMessage("bank.cardBindQuery.state", null, Locale.getDefault())));
        String result = this.invokeHttp(properties.getPluginUrl()+messageSource.getMessage("bank.card.query.url", null, Locale.getDefault()), nvps);
        LOGGER.info("invoke result:"+result);
        JSONObject json = JSONObject.parseObject(result);
        if(json != null && json.containsKey("retCode") && json.containsKey("subPacks") && json.getString("retCode").equals("00000000")){
            List<JSONObject> jsonArray= JSONObject.parseArray(json.getString("subPacks"), JSONObject.class);
            if(jsonArray.size()==1 && jsonArray.get(0).containsKey("cardNo") && !jsonArray.get(0).getString("cardNo").equals("")){
                String newCard = jsonArray.get(0).getString("cardNo");
                if(!cardNo.equals(newCard)){
                    CardBin cb = clientService.get(newCard.substring(0, 6));
                    if(cb != null){
                        if(clientService.cardRefresh(jsonArray.get(0).getString("cardNo"),cb.getBankName(), cb.getBankCode(), cardNo, userId));
                        return jsonArray.get(0).getString("cardNo");
                    }
                }

            }
        }
        return cardNo;
    }

    @RequestMapping(value="/validate/customer/{cellphone}", method=RequestMethod.POST)
    @ResponseBody
    public boolean validateCustomer(@PathVariable("cellphone")String cellphone,Model model) {
        User user = clientService.getByCellphone(cellphone);
        if(user != null && user.getId() > 0){
            return true;
        }
        return false;
    }

    @RequestMapping(value="user/{all}/{type}", method=RequestMethod.GET)
    @ResponseBody
    public List<Integer> count(@PathVariable("all")String all, @PathVariable("type")String type) {
        if (StringUtils.equals(type, MainPageStatisticsEnum.TODAY.toString())) {
            //return clientService.list(all, Calendar.getInstance());
        }
        if (StringUtils.equals(type, MainPageStatisticsEnum.YESTODAY.toString())) {
            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.DATE, -1);
            //return clientService.list(all, calendar);
        }
        return null;
    }

    @RequestMapping("/customer/{userId:\\d+}/balance/{page:\\d+}")
    public String getTrade(Integer type, Integer size, @PathVariable("userId")int userId, @PathVariable("page")int page, Model model) {
        int total = tradeService.countBalance(type != null ? type : 0, userId);
        if(total > 0) {
            model.addAttribute("total", total);
            model.addAttribute("balances", tradeService.listBalance(type != null ? type : 0, userId, this.getOffset(page, size), this.getPageSize(size)));
        } else {
            model.addAttribute("total", 0);
            model.addAttribute("balances", new CustomerBalanceLog[0]);
        }

        Map<Integer, String> types = new LinkedHashMap<Integer, String>();
        for(CustomerBalanceTypeEnum s : CustomerBalanceTypeEnum.values()){
            types.put(s.getType(), s.getMsg());
        }
        model.addAttribute("types", types);

        model.addAttribute("userId", userId);
        model.addAttribute("type", type);
        model.addAttribute("size", this.getPageSize(size));
        model.addAttribute("page", this.getPage(page));
        model.addAttribute("pages", this.getTotalPage(total, size));
        return "client/customer/balance";
    }

    @RequestMapping("/customer/{userId:\\d+}/frozen/{page:\\d+}")
    public String getFrozenOrder(Integer size, @PathVariable("userId")int userId, @PathVariable("page")int page, Model model) {
        int isPayback = 4;
        int total = tradeService.countFrozenOrder(userId, isPayback);
        if(total > 0) {
            model.addAttribute("total", total);
            model.addAttribute("frozens", tradeService.listFrozenOrder(userId, isPayback, this.getOffset(page, size), this.getPageSize(size)));
        } else {
            model.addAttribute("total", 0);
            model.addAttribute("frozens", new CustomerOrder[0]);
        }

        model.addAttribute("userId", userId);
        model.addAttribute("size", this.getPageSize(size));
        model.addAttribute("page", this.getPage(page));
        model.addAttribute("pages", this.getTotalPage(total, size));
        return "client/customer/frozen";
    }
    
    @RequestMapping("/customer/{customerId:\\d+}/vipdetails/{page:\\d+}")
	public String queryforvipDetails(Integer size, @PathVariable("customerId")int customerId, @PathVariable("page")int page,HttpServletRequest request){
		int total = tradeService.countvipDetails(customerId);
		if(total>0){
			request.setAttribute("total", total);
			request.setAttribute("vipdetails", tradeService.listvipDetails(customerId, this.getOffset(page, size), this.getPageSize(size)));
		}else{
			request.setAttribute("total", 0);
			request.setAttribute("vipdetails", new VipLevelChangeLog[0]);
		}
		request.setAttribute("customerId", customerId);
		request.setAttribute("size", this.getPageSize(size));
		request.setAttribute("page", this.getPage(page));
		request.setAttribute("pages", this.getTotalPage(total, size));
		return "client/customer/vipdetails";
	}
    
    @RequestMapping("/query/lender/count")
    @ResponseBody
    public Map<String, Object> queryLenderLoanCount(Integer lenderId ){
    	Map<String, Object> result = new HashMap<String, Object>();
    	int total = clientService.queryLenderLoanCount(lenderId);
    	result.put("loanCount", total);
    	return result;
    }
    @RequestMapping("/inviter/detail/{cellphone:\\d+}/{page:\\d+}")
    public String queryinviterDetails(@PathVariable("cellphone")String cellphone,@PathVariable("page")int page,Integer size,  Integer inviterLevel, HttpServletRequest request,Model model){
    	inviterLevel = (inviterLevel==null)? 1 : inviterLevel;
    	int total = clientService.queryBeInviterCount(cellphone,inviterLevel);
    	if (total>0){
    		request.setAttribute("total", total);
    		request.setAttribute("InviteesEntitylist",clientService.queryInviteesEntities(cellphone,inviterLevel,this.getOffset(page, size), this.getPageSize(size)));
    		model.addAttribute("InviteesEntitylist",clientService.queryInviteesEntities(cellphone,inviterLevel,this.getOffset(page, size), this.getPageSize(size)));
    	}else {
    		request.setAttribute("total", 0);
			request.setAttribute("InviteesEntitylist", new InviteesEntity[0]);
    	}
    	request.setAttribute("inviterLevel", inviterLevel);
    	request.setAttribute("cellphone", cellphone);
    	request.setAttribute("size", this.getPageSize(size));
		request.setAttribute("page", this.getPage(page));
		request.setAttribute("pages", this.getTotalPage(total, size));
    	return "client/customer/inviterdetails";
    }
    
    @RequestMapping(value="customer/cellphone", method=RequestMethod.POST)
    @ResponseBody
    public String getCustomer( Integer userId ) {
    	return clientService.get(userId).getCellphone();
    }

    private HttpServletRequest getMerchantParam(int total, HttpServletRequest request) {
        if (total > 0) {
            request.setAttribute("merchantTotal", total);
            request.setAttribute("companies", clientService.list(null, 1, this.getOffset(1, 20), this.getPageSize(20)));
        } else {
            request.setAttribute("merchantTotal", 0);
            request.setAttribute("companies", new Merchant[0]);
        }
        request.setAttribute("merchantSize", this.getPageSize(PAGE_SIZE));
        request.setAttribute("merchantPage", this.getPage(1));
        request.setAttribute("merchantPages", this.getTotalPage(total, PAGE_SIZE));
        return request;
    }

    private HttpServletRequest getMerchantParam(String name, int page, int size, HttpServletRequest request) {
        request.setAttribute("path", properties.getUploadPath());//ApplicationConfigUtil.get("upload.path")
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("searchName", StringUtils.trimToEmpty(name));
        return request;
    }

    private double getbalance(int customerId){
        List<NameValuePair> nvps = new ArrayList<NameValuePair>();
        nvps.add(new BasicNameValuePair("customerId", String.valueOf(customerId)));
        nvps.add(new BasicNameValuePair("channel", "000001"));
//        String result = this.invokeHttp(ApplicationConfigUtil.get("customers.service.url")+ ApplicationConfigUtil.get("customers.account.balance"), nvps);
        String result = this.invokeHttp(properties.getCustomersServiceUrl()+ properties.getCustomersAccountBalance(), nvps);
        if(StringUtils.isNotBlank(result)) {
            JSONObject json = JSONObject.parseObject(result);
            if(json != null && json.containsKey(CODE)) {
                if(StringUtils.equals(json.getString(CODE), "2000") && json.containsKey(DATA)) {
                    return json.getJSONObject(DATA).getDouble("balance");
                }else{
                    return 0.00;
                }
            }
        }
        return 0.00;
    }
    
    private boolean getAddFunctionPermit(HttpServletRequest request) {
    	boolean flag = false;
    	final int addResourceId = 2051;
    	SecurityEntity security = (SecurityEntity) request.getSession().getAttribute(ConstantUtil.SESSION_KEY);
    	if (security != null) {
    		Role role = security.getRole();
    		List<RoleResource> roleResources = clientService.listRoleResource(role.getId());
    		if (roleResources !=null && roleResources.size()>0) {
    			for (RoleResource roleResource : roleResources) {
    				if (addResourceId == roleResource.getResourceId()) {
    					flag = true;
    					break;
    				}
    			}
    		}
    	}
		return flag;
	}
    
}
