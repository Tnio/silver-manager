package com.silverfox.finance.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.silverfox.finance.domain.Bonus;
import com.silverfox.finance.domain.BonusStrategy;
import com.silverfox.finance.domain.CustomerLotteryLog;
import com.silverfox.finance.domain.Lottery;
import com.silverfox.finance.domain.LotteryPrize;
import com.silverfox.finance.entity.ArrayObjectEntity;
import com.silverfox.finance.enumeration.GenericEnableEnum;
import com.silverfox.finance.enumeration.PrizeCategoryEnum;
import com.silverfox.finance.service.BonusService;
import com.silverfox.finance.service.LotteryService;
import com.silverfox.finance.util.ValidatorUtil;

@Controller
@RequestMapping("/bonus")
public class BonusController extends BaseController {
    private  static final short MAX_FREE_COUNT=10;
    @Autowired
    private BonusService bonusService;
    @Autowired
    private LotteryService lotteryService;

    @RequestMapping("/list/{page:\\d+}")
    public String listRebate(Integer size, @PathVariable("page")int page, Model model){
        int total = bonusService.count();
        if(total > 0){
            model.addAttribute("total", total);
            model.addAttribute("bonuss", bonusService.list(this.getOffset(page, size), this.getPageSize(size)));
        }else{
            model.addAttribute("total", 0);
            model.addAttribute("bonuss", new Bonus[0]);
        }
        model.addAttribute("size", this.getPageSize(size));
        model.addAttribute("page", this.getPage(page));
        model.addAttribute("pages", this.getTotalPage(total, size));
        return "activity/bonus/list";
    }

    @RequestMapping(value="/validate/name", method= RequestMethod.GET)
    @ResponseBody
    public String duplicateBonusName(String fieldId, String fieldValue, int id) {
        if (id >= 0 && StringUtils.isNotBlank(fieldId) && StringUtils.isNotBlank(fieldValue)) {
            ArrayObjectEntity json = new ArrayObjectEntity();
            if (bonusService.duplicate(id, fieldValue)) {
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

    @RequestMapping(value="/validate/strategy", method=RequestMethod.POST)
    @ResponseBody
    public boolean duplicateBonusStrategy(int bonusId) {
        boolean flag = true;
        if (bonusId >= 0 ) {
            Bonus bonus = bonusService.get(bonusId);
            if(bonus != null && bonus.getBonusStrategy() != null){
                List<BonusStrategy> bonusStrategys = bonus.getBonusStrategy();
                if(bonusStrategys.size() > 0){
                    for(BonusStrategy strategy : bonusStrategys){
                        if(strategy.getCoupon() != null){
                            if(strategy.getCoupon().getLifeCycle() == 1){
                                Calendar cal = Calendar.getInstance();
                                try {
                                    cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(strategy.getCoupon().getExpiresPoint()));
                                    if(new Date().getTime() > cal.getTime().getTime()){
                                        flag = false;
                                    }
                                } catch (ParseException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                    }
                }
            }
        }
        return flag;
    }

    @RequestMapping(value="/add/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
    public String bonusForwardToCreation(@PathVariable("page")int page, @PathVariable("size")int size, HttpServletRequest request) {
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("size", this.getPageSize(size));
        return "activity/bonus/add";
    }

    @RequestMapping(value="/{id:\\d+}/edit/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
    public String bonusForwardToModification(@PathVariable("page")int page, @PathVariable("size")int size, @PathVariable("id") int id, Model model) {
        Bonus bonus = bonusService.get(id);
        model.addAttribute("bonus", bonus);
        model.addAttribute("page", this.getPage(page));
        model.addAttribute("size", this.getPageSize(size));
        model.addAttribute("operation",EDIT);
        if (bonus.getFirstOrder() != null && !"".equals(bonus.getFirstOrder())) {
            String firstOrder=bonus.getFirstOrder();
            String[] firstOrderNum=firstOrder.split("-");
            int firstMinCoins=Integer.parseInt(firstOrderNum[0]);
            int firstMaxCoins=Integer.parseInt(firstOrderNum[1]);
            model.addAttribute("firstSingle", 1);
            model.addAttribute("firstMinCoins",firstMinCoins);
            model.addAttribute("firstMaxCoins",firstMaxCoins);
        }
        return "activity/bonus/edit";
    }

    @RequestMapping(value="/{id:\\d+}/detail/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
    public String bonusForwardToDetail(@PathVariable("page")int page, @PathVariable("size")int size, @PathVariable("id") int id, Model model) {
        Bonus bonus = bonusService.get(id);
        model.addAttribute("bonus", bonus);
        model.addAttribute("page", this.getPage(page));
        model.addAttribute("size", this.getPageSize(size));
        model.addAttribute("operation",DETAIL);
        if (bonus.getFirstOrder() != null && !"".equals(bonus.getFirstOrder())) {
            String firstOrder=bonus.getFirstOrder();
            String[] firstOrderNum=firstOrder.split("-");
            int firstMinCoins=Integer.parseInt(firstOrderNum[0]);
            int firstMaxCoins=Integer.parseInt(firstOrderNum[1]);
            model.addAttribute("firstSingle", 1);
            model.addAttribute("firstMinCoins",firstMinCoins);
            model.addAttribute("firstMaxCoins",firstMaxCoins);
        }

        List<BonusStrategy> strategies= bonusService.getStrategies(id);
        model.addAttribute("strategies",strategies);
        return "activity/bonus/edit";
    }

    @RequestMapping(value="/enable", method=RequestMethod.POST)
    @ResponseBody
    public void enableBonus(int id, short enable, HttpServletRequest request) throws IOException {
        if (id > 0 && (enable == 0 || enable == 1)) {
            bonusService.enable(id, enable);
        }
    }

    @RequestMapping(value="/save", method=RequestMethod.POST)
    public String saveBonus(@Valid Bonus bonus,BindingResult validResult, Integer firstSingle, Integer firstMinCoins, Integer firstMaxCoins, Integer lastMinCoins,  int page, int size) {
    	  
    	if (!validResult.hasErrors()) {
            if(bonus!=null) {
               /* if (firstSingle==1) {
                    bonus.setFirstOrder(firstMinCoins+"-"+firstMaxCoins);
                } else {
                    bonus.setFirstOrder("");
                }*/
            	
                int result = bonusService.saveBonus(bonus);
                bonusService.delete(result);
                if (result > 0 && bonus.getGiveType() > 0) {
                    List<BonusStrategy> ebateStrategy = bonus.getBonusStrategy();
                    for (BonusStrategy es : ebateStrategy) {
                        if (es != null && es.getGiveAmount() != null && es.getQuota() > 0) {
                            es.setBonusId(result);
                            bonusService.save(es);
                        }
                    }
                }
            }
        }
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+this.properties.getHttpsUrl()+"/bonus/list/"+this.getPage(page);
    }

    @RequestMapping("/lottery/list/{page:\\d+}")
    public String listLottery(Integer size, @PathVariable("page")int page, HttpServletRequest request){
        int total = lotteryService.count();
        if(total > 0){
            request.setAttribute("total", total);
            request.setAttribute("lotterys", lotteryService.list(this.getOffset(page, size), this.getPageSize(size)));
        }else{
            request.setAttribute("total", 0);
            request.setAttribute("lotterys", new Lottery[0]);
        }
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("pages", this.getTotalPage(total, size));
        return "activity/lottery/list";
    }

    @RequestMapping(value="/lottery/validate/name", method=RequestMethod.GET)
    @ResponseBody
    public String duplicateLotteryName(String fieldId, String fieldValue, int id) {
        if (id >= 0 && StringUtils.isNotBlank(fieldId) && StringUtils.isNotBlank(fieldValue)) {
            ArrayObjectEntity json = new ArrayObjectEntity();
            if (lotteryService.duplicate(id, fieldValue)) {
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

    @RequestMapping(value="/lottery/add/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
    public String lotteryForwardToCreation(@PathVariable("page")int page, @PathVariable("size")int size, HttpServletRequest request) {
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("size", this.getPageSize(size));
        return "activity/lottery/add";
    }

    @RequestMapping(value="/lottery/{id:\\d+}/edit/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
    public String lotteryForwardToModification(@PathVariable("page")int page, @PathVariable("size")int size, @PathVariable("id") int id, HttpServletRequest request) {
        request.setAttribute("lottery", lotteryService.get(id));
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("operation",EDIT);
        return "activity/lottery/edit";
    }

    @RequestMapping(value="/lottery/{id:\\d+}/detail/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
    public String lotteryForwardToDetail(@PathVariable("page")int page, @PathVariable("size")int size, @PathVariable("id") int id, HttpServletRequest request) {
        Lottery lottery = lotteryService.get(id);
        request.setAttribute("lottery", lottery);
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("operation",DETAIL);
        if(lottery != null && lottery.getId() > 0){
            int participateTime = lotteryService.countParticipateTimeByLotteryId(lottery.getId());
            int countConsume = participateTime;
            if(lottery.getShareGetSilver() <= MAX_FREE_COUNT){
                countConsume = lotteryService.countConsumeLottery(lottery.getId(), lottery.getShareGetSilver());
            }
            request.setAttribute("participatePeoples",lotteryService.countParticipatePeoplesByLotteryId(lottery.getId()));
            request.setAttribute("participateTime",participateTime);
            request.setAttribute("consumeSilverNum",countConsume*lottery.getSilverCost());
        }

        return "activity/lottery/edit";
    }

    @RequestMapping(value="/lottery/prize/list/{lotteryId:\\d+}", method=RequestMethod.GET)
    @ResponseBody
    public List<LotteryPrize> listLotteryPrize(@PathVariable("lotteryId")int lotteryId){
        if (lotteryId > 0) {
            return lotteryService.selectPrizeById(lotteryId);
        } else {
            return new ArrayList<LotteryPrize>(0);
        }
    }

    @RequestMapping(value="/lottery/status", method=RequestMethod.POST)
    @ResponseBody
    public boolean enableLottery(int id, int status, HttpServletResponse res, HttpServletRequest request) throws IOException {
        return lotteryService.audit(id, status);
    }

    @RequestMapping(value="/lottery/save", method=RequestMethod.POST)
    public String saveLottery(@Valid Lottery lottery, BindingResult validResult, String prizeStr, int page, int size, HttpServletRequest request) {
        if (!validResult.hasErrors()) {
            if (StringUtils.isNotBlank(prizeStr)) {
                if (ValidatorUtil.isDate(lottery.getBegin()) && ValidatorUtil.isDate(lottery.getEnd())) {
                    lotteryService.saveLottery(lottery, prizeStr);
                }
            }
        }
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/bonus/lottery/list/"+this.getPage(page);
    }

    @RequestMapping(value="/lottery/detail/list/{lotteryId:\\d+}", method=RequestMethod.POST)
    public String listLotteryLog(@PathVariable("lotteryId")int lotteryId, Integer page, Integer size, String cellphone, Integer prizeId, String beginTime, String endTime, Model model){
        if (lotteryId > 0) {
            prizeId = prizeId != null ? prizeId : 0;
            int total = lotteryService.countDetail(lotteryId, cellphone, prizeId, beginTime, endTime);
            model.addAttribute("prizes", lotteryService.selectPrizeById(lotteryId));
            model.addAttribute("costSilvers", lotteryService.getCostSilvers(lotteryId, cellphone, prizeId, beginTime, endTime));
            model.addAttribute("getSilvers", lotteryService.getSilvers(lotteryId, cellphone, prizeId, beginTime, endTime));
            model.addAttribute("getCoupons", lotteryService.getCoupons(lotteryId, cellphone, prizeId, beginTime, endTime));
            if(total > 0){
                List<CustomerLotteryLog> lotteryLogs = lotteryService.selectDetail(lotteryId, cellphone, prizeId, beginTime, endTime, this.getOffset(page, size), this.getPageSize(size));
                model.addAttribute("total", total);
                if(lotteryLogs.size() > 0){
                    for(int i = 0; i < lotteryLogs.size(); i++){
                        if(lotteryLogs.get(i)!= null && lotteryLogs.get(i).getLotteryPrize() !=null){
                            if(lotteryLogs.get(i).getLotteryPrize().getCategory() > 0){
                                if(lotteryLogs.get(i).getLotteryPrize().getCategory() == PrizeCategoryEnum.SILVER.value()){
                                    if(lotteryLogs.get(i).getLotteryPrize().getSilverQuantity() >= 0){
                                        lotteryLogs.get(i).getLotteryPrize().setPrizeName(String.valueOf(lotteryLogs.get(i).getLotteryPrize().getSilverQuantity()));
                                    }
                                }
                                if(lotteryLogs.get(i).getLotteryPrize().getCategory() == PrizeCategoryEnum.COUPON.value()){
                                    if(lotteryLogs.get(i).getLotteryPrize().getCoupon() != null){
                                        lotteryLogs.get(i).getLotteryPrize().setPrizeName(String.valueOf(lotteryLogs.get(i).getLotteryPrize().getCoupon().getAmount()));
                                    }
                                }
                            }
                        }
                    }
                }
                model.addAttribute("lotteryDetails",lotteryLogs);
            }else{
                model.addAttribute("total", 0);
                model.addAttribute("lotteryDetails", new CustomerLotteryLog[0]);
            }
            Map<Integer, String> prizeCategorys = new LinkedHashMap<Integer, String>();
            for(PrizeCategoryEnum prizeCategoryEnum : PrizeCategoryEnum.values()){
                if(prizeCategoryEnum.value() != 4){
                    prizeCategorys.put(prizeCategoryEnum.value(), prizeCategoryEnum.name());
                }
            }
            model.addAttribute("prizeCategorys", prizeCategorys);
            model.addAttribute("size", this.getPageSize(size));
            model.addAttribute("page", this.getPage(page));
            model.addAttribute("pages", this.getTotalPage(total, size));
            model.addAttribute("lotteryId", lotteryId);
            model.addAttribute("cellphone", cellphone);
            model.addAttribute("prizeId", prizeId);
            model.addAttribute("beginTime", beginTime);
            model.addAttribute("endTime", endTime);
        } else {
            model.addAttribute("total", 0);
            model.addAttribute("lotteryDetails", new CustomerLotteryLog[0]);
        }
        return "activity/lottery/detail";
    }

    @RequestMapping("/lottery/count/enable/{scene:\\d+}")
    @ResponseBody
    public boolean countEnable(@PathVariable("scene")short scene){
        return lotteryService.count(GenericEnableEnum.ENABLE.value(), scene);
    }


    @RequestMapping("/card/add")
    public String addPaymentCard(){

        return "activity/card/add";
    }

}
