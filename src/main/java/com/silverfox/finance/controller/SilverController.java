package com.silverfox.finance.controller;

import static com.silverfox.finance.util.ConstantUtil.BACK_SLASH;
import static com.silverfox.finance.util.ConstantUtil.BLANK;
import static com.silverfox.finance.util.ConstantUtil.COMMA;
import static com.silverfox.finance.util.ConstantUtil.ONE;
import static com.silverfox.finance.util.ConstantUtil.SLASH;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.silverfox.finance.domain.Coupon;
import com.silverfox.finance.domain.CustomerGoodsOrder;
import com.silverfox.finance.domain.CustomerSilverLog;
import com.silverfox.finance.domain.DispatchingBonusLog;
import com.silverfox.finance.domain.DispatchingLog;
import com.silverfox.finance.domain.EarnSilver;
import com.silverfox.finance.domain.Goods;
import com.silverfox.finance.domain.GoodsCouponCode;
import com.silverfox.finance.domain.RaceLog;
import com.silverfox.finance.domain.SignIn;
import com.silverfox.finance.domain.SignInPrize;
import com.silverfox.finance.domain.SilverStrategy;
import com.silverfox.finance.entity.SignInPrizesEntity;
import com.silverfox.finance.enumeration.GenericEnableEnum;
import com.silverfox.finance.service.ClientService;
import com.silverfox.finance.service.SilverService;
import com.silverfox.finance.util.ExcelUtil;


@Controller
@RequestMapping("/silver")
public class SilverController extends BaseController {
    private  static final String GIVETYPE="giveType";
    private  static final String RIGHTANSWER="rightAnswer";
    @Autowired
    private SilverService silverService;
    @Autowired
    private ClientService clientService;

    @RequestMapping("/sign")
    public String forwardToModification(HttpServletRequest request){
        request.setAttribute("signIn", silverService.getSignIn(1));
        return "silver/sign";
    }

    @RequestMapping(value="/give/user/count/{dispatchingId:\\d+}", method= RequestMethod.POST )
    @ResponseBody
    public JSONObject countGiveUser(@PathVariable("dispatchingId")int dispatchingId) {
        JSONObject result = new JSONObject();
//        DispatchingBonusLog log = couponService.getDispatchingBonusLog(dispatchingId);
        DispatchingBonusLog log = clientService.getDispatchingBonusLog(dispatchingId);
        if(log != null){
            if(log.getChoiceType() == 0){
//                result.put("count", clientServiceApi.countGiveUser(log));
                result.put("count", clientService.countGiveUser(log));
            }else{
                result.put("count", log.getUserNum());
            }
        }
        return result;
    }

    @RequestMapping(value="/give/user/{dispatchingId:\\d+}", method=RequestMethod.POST )
    @ResponseBody
    public boolean giveSilver(@PathVariable("dispatchingId")int dispatchingId) {
//        DispatchingBonusLog log = couponService.getDispatchingBonusLog(dispatchingId);
        DispatchingBonusLog log = clientService.getDispatchingBonusLog(dispatchingId);
        if (log != null) {
            return clientService.giveSilverInBatch(dispatchingId);
        }
        return false;
    }

    @RequestMapping(value=("/sign/save"), method=RequestMethod.POST)
    public String save(SignIn signIn, SignInPrizesEntity signInPrizesEntity, HttpServletRequest request){
        Enumeration<String> paramNames = request.getParameterNames();
        List<SignInPrize> signInPrizes = new LinkedList<SignInPrize>();
        List<Integer> giveTypes = new LinkedList<Integer>();
        List<Integer> rightAnswers = new LinkedList<Integer>();
        List<String> giveTypesSort = new ArrayList<String>();
        List<String> rightAnswersSort = new ArrayList<String>();

        while(paramNames.hasMoreElements()){
            String element = paramNames.nextElement();
            if(element.startsWith(GIVETYPE)){
                giveTypesSort.add(element);
            }
            if(element.startsWith(RIGHTANSWER)){
                rightAnswersSort.add(element);
            }
        }
        Collections.sort(giveTypesSort);
        for(int i =0; i<giveTypesSort.size(); i++){
            giveTypes.add(Integer.parseInt(request.getParameter(giveTypesSort.get(i))));
        }
        Collections.sort(rightAnswersSort);
        for(int i =0; i<rightAnswersSort.size(); i++){
            rightAnswers.add(Integer.parseInt(request.getParameter(rightAnswersSort.get(i))));
        }

        Integer[] gives = new Integer[giveTypes.size()];
        if(giveTypes.size() > 0){
            for(int i =0; i < giveTypes.size(); i++){
                gives[i] = giveTypes.get(i);
            }
        }
        Integer[] answers = new Integer[rightAnswers.size()];
        if(rightAnswers.size() > 0){
            for(int i =0; i < giveTypes.size(); i++){
                answers[i] = rightAnswers.get(i);
            }
        }

        if(giveTypes.size() > 0 && rightAnswers.size() > 0 && giveTypes.size() == rightAnswers.size()){
            signInPrizesEntity.setGiveType(gives);
            signInPrizesEntity.setRightAnswer(answers);
        }
        if(giveTypes.size() > 0 && rightAnswers.size() > 0 && giveTypes.size() == rightAnswers.size()){
            for(int i = 0; i < giveTypes.size(); i++){
                if(signInPrizesEntity != null){
                    SignInPrize signInPrize = new SignInPrize();
                    if(signInPrizesEntity.getSignInPrizesId().length > 0){
                        signInPrize.setId(signInPrizesEntity.getSignInPrizesId()[i]);
                    }

                    if(signInPrizesEntity.getAnswerA().length > 0){
                        signInPrize.setAnswerA(signInPrizesEntity.getAnswerA()[i]);
                    }
                    if(signInPrizesEntity.getAnswerB() .length > 0){
                        signInPrize.setAnswerB(signInPrizesEntity.getAnswerB()[i]);
                    }
                    if(signInPrizesEntity.getAnswerC().length > 0){
                        signInPrize.setAnswerC(signInPrizesEntity.getAnswerC()[i]);
                    }

                    if(signInPrizesEntity.getAnswerD().length > 0){
                        signInPrize.setAnswerD(signInPrizesEntity.getAnswerD()[i]);
                    }
                    if(signInPrizesEntity.getRightAnswer().length > 0){
                        signInPrize.setRightAnswer(signInPrizesEntity.getRightAnswer()[i]);
                    }
                    if(signInPrizesEntity.getGiveType().length > 0){
                        signInPrize.setGiveType(signInPrizesEntity.getGiveType()[i]);
                        if(signInPrizesEntity.getGiveType()[i] == 1){
                            if(signInPrizesEntity.getGiveSilver()[i] != null){
                                signInPrize.setGiveNum(signInPrizesEntity.getGiveSilver()[i]);
                            }
                            Coupon coupon = new Coupon();
                            coupon.setId(0);
                            signInPrize.setCoupon(coupon);
                        }else if(signInPrizesEntity.getGiveType()[i] == 2){
                            if(signInPrizesEntity.getGiveBonus()[i] != null){
                                signInPrize.setGiveNum(signInPrizesEntity.getGiveBonus()[i]);
                            }
                            Coupon coupon = new Coupon();
                            if(signInPrizesEntity.getCouponId()[i] != null){
                                coupon.setId(signInPrizesEntity.getCouponId()[i]);
                            }
                            signInPrize.setCoupon(coupon);
                        }else if(signInPrizesEntity.getGiveType()[i] == 3){
                            if(signInPrizesEntity.getGiveCoupon()[i] != null){
                                signInPrize.setGiveNum(signInPrizesEntity.getGiveCoupon()[i]);
                            }
                            Coupon coupon = new Coupon();
                            if(signInPrizesEntity.getCouponId()[i] != null){
                                coupon.setId(signInPrizesEntity.getCouponId()[i]);
                            }
                            signInPrize.setCoupon(coupon);
                        }else{
                            Coupon coupon = new Coupon();
                            coupon.setId(0);
                            signInPrizes.get(i).setCoupon(coupon);
                        }
                    }else{
                        Coupon coupon = new Coupon();
                        coupon.setId(0);
                        signInPrize.setCoupon(coupon);
                    }
                    if(signInPrizesEntity.getDays().length > 0){
                        signInPrize.setDays(signInPrizesEntity.getDays()[i]);
                    }
                    if(signInPrizesEntity.getQuestion().length > 0){
                        signInPrize.setQuestion(signInPrizesEntity.getQuestion()[i]);
                    }
                    signInPrizes.add(signInPrize);
                }
            }
        }
        silverService.saveSignInPrizes(signInPrizes, signIn);
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/silver/sign";
    }

    @RequestMapping("/invitation")
    public String InvitationDetail(HttpServletRequest request){
        SilverStrategy silverStrategy = silverService.get(ONE);
        request.setAttribute("silver", silverStrategy);
        return "silver/invitation";
    }

    @RequestMapping(value=("/invitation/save"), method=RequestMethod.POST)
    public String save(SilverStrategy silverStrategy, HttpServletRequest request){
        if (silverStrategy != null) {
            if(silverService.saveSilverStrategy(silverStrategy)){
                request.setAttribute("saveSuccess", true);
            }else{
                request.setAttribute("saveSuccess", false);
            }
        }
        return this.InvitationDetail(request);
    }

    @RequestMapping(value=("/invitation/audit"), method=RequestMethod.POST)
    @ResponseBody
    public boolean audit(int id, short enable, HttpServletRequest request){
        if(id > 0){
            return silverService.audit(id, enable);
        }else{
            return false;
        }
    }

    @RequestMapping("{customerId:\\d+}/detail/{page:\\d+}")
    public String silverLog(Integer size, @PathVariable("customerId")Integer customerId, @PathVariable("page")int page, Model model){
        int total = clientService.countRecentSilverLog(customerId, DEFAULT_MESSAGE);
        if(total > 0){
            model.addAttribute("total", total);
            model.addAttribute("silvers", clientService.listSilverLog(customerId, DEFAULT_MESSAGE, this.getOffset(page, size), this.getPageSize(size)));
        }else{
            model.addAttribute("total", 0);
            model.addAttribute("silvers", new CustomerSilverLog[0]);
        }
        model.addAttribute("customerId", customerId);
        model.addAttribute("size", this.getPageSize(size));
        model.addAttribute("page", this.getPage(page));
        model.addAttribute("pages", this.getTotalPage(total, size));
        return "client/customer/silver";
    }

    @RequestMapping("/goods/list")
    public String list(Integer achieveAmount, Integer size, Integer page, HttpServletRequest request){
        if(achieveAmount == null){
            achieveAmount = -1;
        }
        int total = silverService.countGoods(achieveAmount, 5, -1 ,null);
        if(total > 0){
            request.setAttribute("total", total);
            request.setAttribute("goodses", silverService.listGoods(achieveAmount, 5, -1, this.getOffset(page, size), this.getPageSize(size)));
        }else{
            request.setAttribute("total", 0);
            request.setAttribute("goodses", new Goods[0]);
        }
        request.setAttribute("achieveAmount", achieveAmount);
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("pages", this.getTotalPage(total, size));
        return "silver/goods/list";
    }

    @RequestMapping("/give/list")
    public String listGive(String cellphone, Integer size, Integer page, Model model){
//        int total = couponService.count(cellphone, 1);
        int total = clientService.count(cellphone, 1);
        if (total > 0) {
            model.addAttribute("total", total);
//            model.addAttribute("dispatchingBonusLogs", couponService.listDispatchingBonusLog(cellphone, 1, this.getOffset(page, size), this.getPageSize(size)));
            model.addAttribute("dispatchingBonusLogs", clientService.listDispatchingBonusLog(cellphone, 1, this.getOffset(page, size), this.getPageSize(size)));
        } else {
            model.addAttribute("total", 0);
            model.addAttribute("dispatchingBonusLogs", new ArrayList<DispatchingBonusLog>());
        }
        model.addAttribute("cellphone", cellphone);
        model.addAttribute("size", this.getPageSize(size));
        model.addAttribute("page", this.getPage(page));
        model.addAttribute("pages", this.getTotalPage(total, size));
        return "silver/give/list";
    }

    @RequestMapping("/race/list")
    public String listRace(Integer size, Integer page, HttpServletRequest request){
        int total = silverService.countGoods(-1, 5, 4, null);
        if(total > 0){
            request.setAttribute("total", total);
            request.setAttribute("goodses", silverService.listGoods(-1, 5, 4, this.getOffset(page, size), this.getPageSize(size)));
        }else{
            request.setAttribute("total", 0);
            request.setAttribute("goodses", new Goods[0]);
        }
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("pages", this.getTotalPage(total, size));
        return "silver/race/list";
    }

    @RequestMapping(value="/goods/save", method=RequestMethod.POST)
    public String saveGoods(Goods goods, Integer goodsAchieveAmount,  String removeImg, Integer page,Integer size, HttpServletRequest request, RedirectAttributesModelMap redirectAttributesModelMap) {
        Map<String, String> filesMap = upload(request);
        List<GoodsCouponCode> codes = new ArrayList<GoodsCouponCode>();
        if(goods.getId() <= 0){
            String urlstr = "";
            if(filesMap.size() > 0){
                for(String key : filesMap.keySet()){
                    if (StringUtils.contains(key, "codeFile")) {
                        codes = JSON.parseArray(filesMap.get(key), GoodsCouponCode.class);
                    }else{
                        if(key.length()<5){
                            goods.setUrl(filesMap.get(key));
                        }else{
                            urlstr+=filesMap.get(key)+";";
                        }
                    }
                }
                if(StringUtils.isNotBlank(urlstr)){
                    urlstr=urlstr.substring(0,urlstr.length()-1);
                    if(StringUtils.isNotBlank(urlstr)){
                        goods.setLargerUrl(urlstr);
                    }
                }
            }
        }else{
            Goods oldGoods = silverService.getGoods(goods.getId());
            String urlstr = "";
            if(oldGoods != null && oldGoods.getLargerUrl() != null){
                String [] oldGoodsImgUrls = oldGoods.getLargerUrl().split(";");
                for(int i = 0;i<oldGoodsImgUrls.length; i++){
                    String[] removeImgs = removeImg.split(";");
                    int flag = 0;
                    if(removeImgs.length > 0){
                        for(int j = 0; j< removeImgs.length;j++){
                            if(oldGoodsImgUrls[i].equals(removeImgs[j])){
                                flag ++;
                            }
                        }
                    }
                    if(flag == 0){
                        urlstr += oldGoodsImgUrls[i]+";";
                    }
                }
            }
            if(filesMap.size() > 0){
                for(String key : filesMap.keySet()){
                    if (StringUtils.contains(key, "codeFile")) {
                        codes = JSON.parseArray(filesMap.get(key), GoodsCouponCode.class);
                    }else if(StringUtils.contains(key, "largerUrls")){
                        urlstr+=filesMap.get(key)+";";
                    }else{
                        goods.setUrl(filesMap.get(key));
                    }
                }
                if(StringUtils.isNotBlank(urlstr)){
                    urlstr=urlstr.substring(0,urlstr.length()-1);
                }
            }
            goods.setLargerUrl(urlstr);
        }
        if(StringUtils.equals(goods.getBeginDate(),"")){
            goods.setBeginDate(null);
        }
        if(StringUtils.equals(goods.getEndDate(),"")){
            goods.setEndDate(null);
        }
        silverService.save(goods, codes);
        redirectAttributesModelMap.addAttribute("achieveAmount", goodsAchieveAmount);
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/silver/goods/list";
    }

    @RequestMapping(value="/goods/change/sort", method=RequestMethod.POST)
    @ResponseBody
    public boolean changeGoodsSort(String ids, String sorts) {
        List<String> goodsIds = new LinkedList<String>();
        List<String> goodsSorts = new LinkedList<String>();
        if(StringUtils.isNotBlank(ids) && StringUtils.isNotBlank(sorts)){
            CollectionUtils.addAll(goodsIds, ids.split(COMMA));
            CollectionUtils.addAll(goodsSorts, sorts.split(COMMA));
        }
        List<Goods> goodes = new ArrayList<Goods>();
        if(goodsIds.size() > 0 && goodsSorts.size() > 0 && goodsIds.size() == goodsSorts.size()){
            List<Integer> gs = JSON.parseArray(goodsSorts.toString(), Integer.class);
            Collections.sort(gs);
            Collections.reverse(gs);
            for(int i =0; i < goodsIds.size(); i++){
                Goods goods = new Goods();
                goods.setId(Integer.parseInt(goodsIds.get(i)));
                goods.setSortNumber(gs.get(i));
                goodes.add(goods);
            }
        }
        return silverService.changeGoodsSort(goodes);
    }

    @RequestMapping(value="/race/save", method=RequestMethod.POST)
    public String saveRace(Goods goods, HttpServletRequest request){
        Map<String, String> result =upload(request);
        String url = StringUtils.substring(result.values().toString(), 1, result.values().toString().length() - 1);
        if (StringUtils.isNotBlank(url)) {
            goods.setUrl(url);
        }
        silverService.save(goods, null);
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/silver/race/list";
    }

    @RequestMapping(value="/give/save", method=RequestMethod.POST)
    public String saveGive(DispatchingBonusLog dispatchingBonusLog, Integer amount, Integer accumulativeAmount, Integer singleAmount){
        if(amount == null){
            amount = 0;
        }
        if(accumulativeAmount == null){
            accumulativeAmount = 0;
        }
        if(singleAmount == null){
            singleAmount = 0;
        }
        if(amount == 0){
            dispatchingBonusLog.setSatisfyType(2);
            dispatchingBonusLog.setSatisfyInitialAmount(accumulativeAmount);
            dispatchingBonusLog.setSatisfyEndAmount(accumulativeAmount * 1000);
        }
        if(amount == 1){
            dispatchingBonusLog.setSatisfyType(1);
            dispatchingBonusLog.setSatisfyInitialAmount(singleAmount);
            dispatchingBonusLog.setSatisfyEndAmount(singleAmount * 1000);
        }
        if(dispatchingBonusLog.getChoiceType() == 0){
            dispatchingBonusLog.setCellphones(BLANK);
        }
        if(dispatchingBonusLog.getChoiceType() == 1){
            dispatchingBonusLog.setBeginDate(BLANK);
            dispatchingBonusLog.setEndDate(BLANK);
            dispatchingBonusLog.setSatisfyInitialAmount(0);
            dispatchingBonusLog.setSatisfyEndAmount(0);
        }
//        couponService.saveDispatchingBonusLog(dispatchingBonusLog);
        clientService.saveDispatchingBonusLog(dispatchingBonusLog);
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/silver/give/list";
    }


    @RequestMapping(value="/goods/add", method=RequestMethod.GET)
    public String toGoodsAdd(Integer page,Integer size, HttpServletRequest request) {
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("page", this.getPage(page));
        return "silver/goods/add";
    }

    @RequestMapping(value="/race/add", method=RequestMethod.GET)
    public String toRaceAdd(Integer page,Integer size, HttpServletRequest request) {
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("page", this.getPage(page));
        return "silver/race/add";
    }

    @RequestMapping(value="/give/add", method=RequestMethod.GET)
    public String toGiveAdd(Model model){
        return "silver/give/add";
    }

    @RequestMapping(value=("/goods/edit/{id:\\d+}"), method=RequestMethod.GET)
    public String toGoodsEdit(Integer achieveAmount, Integer size, Integer page, @PathVariable("id") int id, HttpServletRequest request) {
        request.setAttribute("goods", silverService.getGoods(id));
        request.setAttribute("achieveAmount", achieveAmount);
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("operation",EDIT);
        return "silver/goods/edit";
    }

    @RequestMapping(value=("/race/edit/{id:\\d+}"), method=RequestMethod.GET)
    public String toRaceEdit(Integer size, Integer page, @PathVariable("id") int id, HttpServletRequest request) {
        request.setAttribute("goods", silverService.getGoods(id));
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("operation",EDIT);
        return "silver/race/edit";
    }

    @RequestMapping("/give/edit/{dispatchingBonusLogId:\\d+}")
    public String editGive(@PathVariable("dispatchingBonusLogId")int dispatchingBonusLogId, Model model){
        if(dispatchingBonusLogId > 0){
//            DispatchingBonusLog dispatchingBonusLog = couponService.getDispatchingBonusLog(dispatchingBonusLogId);
            DispatchingBonusLog dispatchingBonusLog = clientService.getDispatchingBonusLog(dispatchingBonusLogId);
            model.addAttribute("dispatchingBonusLog", dispatchingBonusLog);
        }
        model.addAttribute("operation",EDIT);
        return "silver/give/edit";
    }

    @RequestMapping("/give/status")
    @ResponseBody
    public boolean auditGiveSilver(Integer dispatchingBonusLogId, Short status, Integer initStatus){
        if(dispatchingBonusLogId != null && dispatchingBonusLogId > 0 && status > 0){
//            DispatchingBonusLog dispatchingBonusLog = couponService.getDispatchingBonusLog(dispatchingBonusLogId);
            DispatchingBonusLog dispatchingBonusLog = clientService.getDispatchingBonusLog(dispatchingBonusLogId);
            if(dispatchingBonusLog != null && dispatchingBonusLog.getStatus() == initStatus){
                dispatchingBonusLog.setStatus(status);
//                return couponService.saveDispatchingBonusLog(dispatchingBonusLog);
                return clientService.saveDispatchingBonusLog(dispatchingBonusLog);
            }
        }
        return false;
    }

    @RequestMapping(value=("/goods/detail/{id:\\d+}"), method=RequestMethod.GET)
    public String toGoodDetail(Integer achieveAmount, Integer size, Integer page, @PathVariable("id") int id, HttpServletRequest request) {
        request.setAttribute("goods", silverService.getGoods(id));
        request.setAttribute("achieveAmount", achieveAmount);
        request.setAttribute("operation",DETAIL);
        return "silver/goods/edit";
    }

    @RequestMapping(value=("/race/detail/{id:\\d+}"), method=RequestMethod.GET)
    public String toRaceDetail(Integer size, Integer page, @PathVariable("id") int id, HttpServletRequest request) {
        request.setAttribute("goods", silverService.getGoods(id));
        request.setAttribute("operation",DETAIL);
        return "silver/race/edit";
    }

    @RequestMapping("/give/detail/{dispatchingBonusLogId:\\d+}")
    public String detailGive(@PathVariable("dispatchingBonusLogId")int dispatchingBonusLogId, Model model){
        if(dispatchingBonusLogId > 0){
//            DispatchingBonusLog dispatchingBonusLog = couponService.getDispatchingBonusLog(dispatchingBonusLogId);
            DispatchingBonusLog dispatchingBonusLog = clientService.getDispatchingBonusLog(dispatchingBonusLogId);
            model.addAttribute("dispatchingBonusLog", dispatchingBonusLog);
        }
        model.addAttribute("operation",DETAIL);
        return "silver/give/edit";
    }

    @RequestMapping("/give/user/detail/{dispatchingBonusLogId:\\d+}")
    public String giveUserDetail(@PathVariable("dispatchingBonusLogId")int dispatchingBonusLogId, String cellphone, String beginDate, String endDate, Integer page, Integer size, Model model){
        int total = silverService.giveUserCount(dispatchingBonusLogId, cellphone, beginDate, endDate);
        if(total > 0){
            model.addAttribute("total", total);
            model.addAttribute("dispatchingLogs", silverService.giveUserList(dispatchingBonusLogId, cellphone, beginDate, endDate, this.getOffset(page, size), this.getPageSize(size)));
        }else{
            model.addAttribute("total", 0);
            model.addAttribute("dispatchingLogs", new DispatchingLog[0]);
        }
        model.addAttribute("dispatchingBonusLogId", dispatchingBonusLogId);
        model.addAttribute("cellphone", cellphone);
        model.addAttribute("beginDate", beginDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("size", this.getPageSize(size));
        model.addAttribute("page", this.getPage(page));
        model.addAttribute("pages", this.getTotalPage(total, size));
        return "silver/give/detail";
    }

    @RequestMapping("/goods/{id:\\d+}/{status:\\d+}")
    @ResponseBody
    public boolean changeStatus(String category, Integer size, Integer page, @PathVariable("id") int id, @PathVariable("status") int status, HttpServletRequest request) {
        if(id > 0 && (status == 0 || status == 1 || status == 2 || status == 3)){
            Goods goods = new Goods();
            goods = silverService.getGoods(id);
            if(goods != null){
                if(category.equals("status")){
                    if(status == 0){
                        goods.setHot(status);
                    }
                    goods.setStatus(status);
                }
                if(category.equals("hot")){
                    goods.setHot(status);
                }

            }
            return silverService.save(goods,null);
        }
        return false;
    }

    @RequestMapping("/goods/exchange/record")
    public String listGoodsOrder(String goodsName, String cellphone, String beginDate, String endDate, Integer type, Integer achieveAmount, Integer size, Integer page, HttpServletRequest request){
        int total = silverService.count(goodsName, cellphone, beginDate, endDate, type != null ? type : 0);
        if(total > 0){
            request.setAttribute("total", total);
            List<CustomerGoodsOrder> list = silverService.list(goodsName, cellphone, beginDate, endDate, type != null ? type : 0, this.getOffset(page, size), this.getPageSize(size));
            for (CustomerGoodsOrder exchange : list) {
                if (exchange.getGoods() != null) {
                    exchange.getGoods().setConsumeSilver(new Double(Math.ceil(exchange.getGoods().getConsumeSilver()*exchange.getGoods().getDiscount()/10)).intValue());
                }
            }
            request.setAttribute("convertibilitys", list);
        }else{
            request.setAttribute("total", 0);
            request.setAttribute("convertibilitys", new Goods[0]);
        }
        request.setAttribute("cellphone", StringUtils.trimToEmpty(cellphone));
        request.setAttribute("beginDate", StringUtils.trimToEmpty(beginDate));
        request.setAttribute("endDate", StringUtils.trimToEmpty(endDate));
        request.setAttribute("goodsName", StringUtils.trimToEmpty(goodsName));
        request.setAttribute("achieveAmount", achieveAmount);
        request.setAttribute("type", type != null ? type : 0);
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("pages", this.getTotalPage(total, size));
        return "silver/goods/exchange";
    }

    @RequestMapping("/race/exchange/record/{goodsId:\\d+}")
    public String listRaceExchange(String cellphone, Integer size, Integer page, @PathVariable("goodsId") int goodsId, HttpServletRequest request){
        int total = silverService.count(goodsId, cellphone);
        if(total > 0){
            request.setAttribute("total", total);
            request.setAttribute("raceLogs", silverService.list(goodsId, cellphone, this.getOffset(page, size), this.getPageSize(size)));
        }else{
            request.setAttribute("total", 0);
            request.setAttribute("raceLogs", new ArrayList<RaceLog>());
        }
        request.setAttribute("cellphone", StringUtils.trimToEmpty(cellphone));
        request.setAttribute("goodsId", goodsId);
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("pages", this.getTotalPage(total, size));
        return "silver/race/exchange";
    }

    @RequestMapping("/goods/codes/detail/{goodsId:\\d+}")
    public String listGoodsCodes(@PathVariable("goodsId") int goodsId, Integer size, Integer page, HttpServletRequest request){
        int total = silverService.countCode(goodsId, 0);
        if(total > 0){
            request.setAttribute("total", total);
            request.setAttribute("goodsCouponCodes", silverService.listCodes(goodsId, 0, this.getOffset(page, size), this.getPageSize(size)));
        }else{
            request.setAttribute("total", 0);
            request.setAttribute("goodsCouponCodes", new GoodsCouponCode[0]);
        }
        request.setAttribute("goodsId", goodsId);
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("pages", this.getTotalPage(total, size));
        return "silver/goods/codes";
    }

    @RequestMapping("/goods/exchange/export")
    @ResponseBody
    public ResponseEntity<byte[]> exportCustomerOrder(String goodsName, String cellphone, String beginDate, String endDate, Integer type, HttpServletRequest request) {
        String realPath = request.getSession().getServletContext().getRealPath("");
        realPath = StringUtils.replace(realPath, BACK_SLASH, SLASH) + properties.getTemplatePath();//ApplicationConfigUtil.get("template.path")

        List<CustomerGoodsOrder> orders = silverService.list(goodsName, cellphone, beginDate, endDate, type != null ? type : 0, 0, 0);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        String errorMessage = "";
        String fileName = messageSource.getMessage("goods.exchange.excel.name", null, null);
        if(orders != null && orders.size()> 0) {
            String finalFileName = "";
            List<Serializable> list = new LinkedList<Serializable>();
            for(CustomerGoodsOrder order: orders) {
                list.add(order);
            }
            finalFileName = ExcelUtil.writeToExcel(list, messageSource.getMessage("template.xls.goods.exchange", null, null), realPath, fileName, null);
            if(StringUtils.isNotBlank(finalFileName)) {
                return this.export(realPath, fileName, request);
            }
            errorMessage = "no file find!";
        }
        errorMessage = "this is empty!";
        headers.setContentDispositionFormData("attachment", fileName);
        return new ResponseEntity<byte[]>(errorMessage.getBytes(), headers, HttpStatus.OK);
    }

    @RequestMapping("/earn")
    public String listEarnSilver(HttpServletRequest request){
        request.setAttribute("earnSilvers", silverService.listEarnSilver((short) GenericEnableEnum.ALL.value()));
        return "silver/earn/list";
    }

    @RequestMapping(value=("/earn/detail/{id:\\d+}"), method=RequestMethod.GET)
    public String earnSilverLog(@PathVariable("id") int id, HttpServletRequest request) {
        request.setAttribute("earnSilver", silverService.getEarnSilver(id));
        request.setAttribute("operation",DETAIL);
        return "silver/earn/edit";
    }

    @RequestMapping(value=("/earn/edit/{id:\\d+}"), method=RequestMethod.GET)
    public String earnSilverEdit(@PathVariable("id") int id, HttpServletRequest request) {
        request.setAttribute("earnSilver", silverService.getEarnSilver(id));
        request.setAttribute("operation",EDIT);
        return "silver/earn/edit";
    }

    @RequestMapping(value="/earn/save", method=RequestMethod.POST)
    public String save(EarnSilver earnSilver, HttpServletRequest request) {
        silverService.saveEarnSilver(earnSilver);
        return listEarnSilver(request);
    }

    @RequestMapping(value="/earn/enable/{id:\\d+}/{enable:\\d+}", method=RequestMethod.POST)
    @ResponseBody
    public boolean enableEarnSilver(@PathVariable("id")int id, @PathVariable("enable")short enable, HttpServletRequest request) throws IOException {
        if (id > 0) {
            return silverService.enableEarnSilver(id, enable);
        }
        return false;
    }

}
