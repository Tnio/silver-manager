package com.silverfox.finance.controller;

import static com.silverfox.finance.enumeration.AddFunctionPermitEnum.INVITER_LOOK_DETAIL;
import static com.silverfox.finance.util.ConstantUtil.COMMA;
import static com.silverfox.finance.util.ConstantUtil.DATA;
import static com.silverfox.finance.util.ConstantUtil.NORMAL_DATETIME_FORMAT;
import static com.silverfox.finance.util.ConstantUtil.ONE;
import static com.silverfox.finance.util.ConstantUtil.ZERO_;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.collections.CollectionUtils;
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

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.silverfox.finance.domain.Activity;
import com.silverfox.finance.domain.CouponActivity;
import com.silverfox.finance.domain.InviterReward;
import com.silverfox.finance.entity.ArrayObjectEntity;
import com.silverfox.finance.entity.InviterEntity;
import com.silverfox.finance.entity.InviterRewardEntity;
import com.silverfox.finance.enumeration.GenericAuditStatusEnum;
import com.silverfox.finance.enumeration.GenericEnableEnum;
import com.silverfox.finance.service.ActivityService;

@Controller
@RequestMapping("/activity")
public class ActivityController extends BaseController {
    @Autowired
    private ActivityService activityService;

    @RequestMapping(value="/list/{page:\\d+}")
    public String list(@PathVariable("page") int page, Integer size, HttpServletRequest request) {
        int total = activityService.count(GenericEnableEnum.ALL.value());
        if(total > 0) {
            request.setAttribute("total", total);
            request.setAttribute("activitys",activityService.list(GenericEnableEnum.ALL.value(), this.getOffset(page, size), this.getPageSize(size)));
        } else {
            request.setAttribute("total", 0);
            request.setAttribute("messages", new Activity[0]);
        }
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("pages", this.getTotalPage(total, size));
        return "activity/activity/list";
    }

    @RequestMapping(value="/save", method= RequestMethod.POST)
    public String save(@Valid Activity activity, BindingResult validResult, int page, int size, HttpServletRequest request) {
        if(!validResult.hasErrors()){
            Map<String, String> result =upload(request);
            String url = StringUtils.substring(result.values().toString(), 1, result.values().toString().length() - 1);
            if (StringUtils.isNotBlank(url)) {
                activity.setImgUrl(url);
            }
            activityService.save(activity);
        }
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/activity/list/"+this.getPage(page);
    }

    @RequestMapping(value="/add/{page:\\d+}/{size:\\d+}",method=RequestMethod.GET)
    public String add(@PathVariable("page")int page,@PathVariable("size")int size, HttpServletRequest request){
        request.setAttribute("page", page);
        request.setAttribute("size", size);
        return "activity/activity/add";
    }

    @RequestMapping(value="/edit/{id:\\d+}/{page:\\d+}/{size:\\d+}",method=RequestMethod.GET)
    public String edit(@PathVariable("id")int id,@PathVariable("page")int page,@PathVariable("size")int size, HttpServletRequest request){
        request.setAttribute("activity", activityService.get(id));
        request.setAttribute("page", page);
        request.setAttribute("size", size);
        request.setAttribute("operation", EDIT);
        return "activity/activity/edit";
    }

    @RequestMapping(value="/detail/{id:\\d+}/{page:\\d+}/{size:\\d+}",method=RequestMethod.GET)
    public String detail(@PathVariable("id")int id,@PathVariable("page")int page,@PathVariable("size")int size, HttpServletRequest request){
        request.setAttribute("activity", activityService.get(id));
        request.setAttribute("page", page);
        request.setAttribute("size", size);
        request.setAttribute("operation", DETAIL);
        return "activity/activity/edit";
    }

    @RequestMapping(value="/enable/{id:\\d+}/{status:\\d+}", method=RequestMethod.GET)
    @ResponseBody
    public boolean enable(@PathVariable("id")int id, @PathVariable("status")int status) {
        return activityService.enable(id, status);
    }

    @RequestMapping(value="/recommend/{id:\\d+}/{recommend:\\d+}", method=RequestMethod.GET)
    @ResponseBody
    public boolean recommend(@PathVariable("id")int id, @PathVariable("recommend")int recommend) {
        return activityService.recommend(id, recommend);
    }

    @RequestMapping(value="/remove/{id:\\d+}", method=RequestMethod.GET)
    @ResponseBody
    public boolean remove(@PathVariable("id")int id) {
        return activityService.remove(id);
    }

    @RequestMapping(value="/exist/title", method=RequestMethod.GET)
    @ResponseBody
    public boolean isExists(int id, String title) {
        if(StringUtils.isNotBlank(title)) {
            return activityService.isExists(id, title);
        }
        return false;
    }

    @RequestMapping(value="/change/sort", method=RequestMethod.POST)
    @ResponseBody
    public boolean changeActivitySort(String ids, String sorts) {
        List<String> activityIds = new LinkedList<String>();
        List<String> activitySorts = new LinkedList<String>();
        if(StringUtils.isNotBlank(ids) && StringUtils.isNotBlank(sorts)){
            CollectionUtils.addAll(activityIds, ids.split(COMMA));
            CollectionUtils.addAll(activitySorts, sorts.split(COMMA));
        }
        List<Activity> activitys = new ArrayList<Activity>();
        if(activityIds.size() > 0 && activitySorts.size() > 0 && activityIds.size() == activitySorts.size()){
            List<Integer> as = JSON.parseArray(activitySorts.toString(), Integer.class);
            Collections.sort(as);
            Collections.reverse(as);
            for(int i =0; i < activityIds.size(); i++){
                Activity activity = new Activity();
                activity.setId(Integer.parseInt(activityIds.get(i)));
                activity.setSortNumber(as.get(i));
                activitys.add(activity);
            }
        }
        return activityService.changeActivitySort(activitys);
    }

    @RequestMapping(value="/grab/list/{page:\\d+}")
    public String couponActivityList(@PathVariable("page") int page, Integer size, HttpServletRequest request) {
        int total = activityService.couponActivityCount(GenericEnableEnum.ALL.value());
        if(total > 0) {
            List<CouponActivity> couponActivitylist = activityService.CouponActivitylist(GenericEnableEnum.ALL.value(), this.getOffset(page, size), this.getPageSize(size));
            if(couponActivitylist != null && couponActivitylist.size()>0){
                SimpleDateFormat sdf = new SimpleDateFormat(NORMAL_DATETIME_FORMAT);
                Date now = new Date();
                for(CouponActivity couponActivity : couponActivitylist){
                    if(couponActivity.getStatus() == GenericAuditStatusEnum.PASSED.getValue()){
                        try {
                            Date beginTime = sdf.parse(couponActivity.getBeginTime());
                            Date endTime = sdf.parse(couponActivity.getEndTime());
                            if(now.getTime() > endTime.getTime() || couponActivity.getQuantity() == 0){
                                couponActivity.setStatus(5);
                            }else if(now.getTime() < beginTime.getTime()){
                                couponActivity.setStatus(3);
                            }else{
                                couponActivity.setStatus(4);
                            }
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
            request.setAttribute("total", total);
            request.setAttribute("couponActivities", couponActivitylist);
        } else {
            request.setAttribute("total", 0);
            request.setAttribute("messages", new Activity[0]);
        }
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("pages", this.getTotalPage(total, size));
        return "activity/activity/grab/list";
    }

    @RequestMapping(value="/grab/save", method=RequestMethod.POST)
    public String saveCouponActivity(CouponActivity couponActivity, int page, int size, HttpServletRequest request) {
        if(couponActivity.getId() == 0){
            couponActivity.setUrl(properties.getCouponActivityUrl());
        }
        activityService.saveCouponActivitys(couponActivity);
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/activity/grab/list/"+this.getPage(page);
    }

    @RequestMapping(value="/grab/add/{page:\\d+}/{size:\\d+}",method=RequestMethod.GET)
    public String addCouponActivity(@PathVariable("page")int page,@PathVariable("size")int size, HttpServletRequest request){
        request.setAttribute("page", page);
        request.setAttribute("size", size);
        return "activity/activity/grab/add";
    }

    @RequestMapping(value="/grab/{type}/{id:\\d+}/{page:\\d+}/{size:\\d+}",method=RequestMethod.GET)
    public String editCouponActivity(@PathVariable("type")String type, @PathVariable("id")int id, @PathVariable("page")int page, @PathVariable("size")int size, HttpServletRequest request){
        CouponActivity couponActivity = activityService.getCouponActivity(id);
        if(couponActivity != null && StringUtils.isNotBlank(couponActivity.getCouponIds())){
            request.setAttribute("coupons", activityService.getCoupons(couponActivity.getCouponIds(),-1,-1));
        }
        request.setAttribute("couponActivity", couponActivity);
        request.setAttribute("page", page);
        request.setAttribute("size", size);
        request.setAttribute("operation", type);
        return "activity/activity/grab/edit";
    }

    @RequestMapping(value="/grab/audit/{id:\\d+}/{status:\\d+}", method=RequestMethod.POST)
    @ResponseBody
    public boolean auditCouponActivity(@PathVariable("id")int id, @PathVariable("status")int status) {
        return activityService.auditCouponActivity(id, status);
    }

    @RequestMapping(value="/grab/validate/time/{id:\\d+}", method=RequestMethod.POST)
    @ResponseBody
    public boolean validateTime(@PathVariable("id")int id) {
        return activityService.validateTime(id);
    }

    @RequestMapping(value="/grab/exist/name", method=RequestMethod.GET)
    @ResponseBody
    public String isCouponActivityExists(String fieldId, String fieldValue, int id) {
        if (id >= 0 && StringUtils.isNotBlank(fieldId) && StringUtils.isNotBlank(fieldValue)) {
            ArrayObjectEntity json = new ArrayObjectEntity();
            if (activityService.isCouponActivityExists(id, fieldValue)) {
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

    @RequestMapping(value="/grab/change/sort", method=RequestMethod.POST)
    @ResponseBody
    public boolean changeGrabSort(String ids, String sorts) {
        List<String> activityIds = new LinkedList<String>();
        List<String> activitySorts = new LinkedList<String>();
        if(StringUtils.isNotBlank(ids) && StringUtils.isNotBlank(sorts)){
            CollectionUtils.addAll(activityIds, ids.split(COMMA));
            CollectionUtils.addAll(activitySorts, sorts.split(COMMA));
        }
        List<Activity> activitys = new ArrayList<Activity>();
        if(activityIds.size() > 0 && activitySorts.size() > 0 && activityIds.size() == activitySorts.size()){
            List<Integer> as = JSON.parseArray(activitySorts.toString(), Integer.class);
            Collections.sort(as);
            Collections.reverse(as);
            for(int i =0; i < activityIds.size(); i++){
                Activity activity = new Activity();
                activity.setId(Integer.parseInt(activityIds.get(i)));
                activity.setSortNumber(as.get(i));
                activitys.add(activity);
            }
        }
        return activityService.changeActivitySort(activitys);
    }
    
    @RequestMapping(value="/inviter/list/{page:\\d+}")
    public String inviterList(@PathVariable("page") int page,Integer customerId,String userName ,String cellphone, String startTime,String endTime, Integer size, HttpServletRequest request,Model model) {
        int total = activityService.countAllinviterlist(userName,cellphone,startTime,endTime);
        if(total > 0) {
            request.setAttribute("total", total);
            request.setAttribute("inviterRewards", activityService.inviterList(customerId,userName,cellphone,startTime,endTime,this.getOffset(page, size), this.getPageSize(size)));
            model.addAttribute("inviterRewards", activityService.inviterList(customerId,userName,cellphone,startTime,endTime,this.getOffset(page, size), this.getPageSize(size)));
            request.setAttribute("totalAmount", activityService.sumInviterRewardAmount(userName,cellphone,startTime,endTime));
        } else {
            request.setAttribute("total", 0);
            request.setAttribute("inviterRewards", new InviterEntity[0]);
        }
        request.setAttribute("userName", userName);
        request.setAttribute("cellphone", cellphone);
        request.setAttribute("startTime", startTime);
        request.setAttribute("endTime", endTime);
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("page", this.getPage(page));
        request.setAttribute("pages", this.getTotalPage(total, size));
        request.setAttribute("lookDetail", this.getAddFunctionPermit(INVITER_LOOK_DETAIL.getCode(), request));
        return "activity/invite/list";
    }
    
    @RequestMapping(value="/inviter/detail/{id:\\d+}/{page:\\d+}/{orderNo}")
    public String inviterDetail(@PathVariable("id") int id ,@PathVariable("orderNo")String orderNo,@PathVariable("page")int page, String cellphone , HttpServletRequest request,Model model){
    	List<InviterRewardEntity> inviterRewardEntities = new ArrayList<InviterRewardEntity>();
		if (StringUtils.isNotBlank(orderNo)){
			inviterRewardEntities = activityService.getInviterRewardEntitieByOrderNo(orderNo);
		}
		request.setAttribute("page",page);
		request.setAttribute("cellphone",cellphone);
		request.setAttribute("inviterRewardEntities",inviterRewardEntities);
		model.addAttribute("inviterRewardEntities",inviterRewardEntities);
    	return "activity/invite/detail";
    }
    
    @RequestMapping(value="/inviter/detail/{id:\\d+}/{page:\\d+}")
    public String inviterDetails(@PathVariable("id") int id ,@PathVariable("page")int page, String cellphone ,  HttpServletRequest request,Model model){
    	List<InviterRewardEntity> inviterRewardEntities = new ArrayList<InviterRewardEntity>();
    	InviterReward inviterReward = activityService.getInviterRewardByid(id);
    	if(inviterReward.getInviterLevel() == ONE){
    		inviterRewardEntities = activityService.inviterRewardEntities(id);
    	}else {
    		inviterRewardEntities = activityService.getLevelTwoInviterRewardEntities(id);
    	}
    	
    	request.setAttribute("cellphone",cellphone);
		request.setAttribute("page",page);
		request.setAttribute("inviterRewardEntities",inviterRewardEntities);
		model.addAttribute("inviterRewardEntities",inviterRewardEntities);
		return "activity/invite/detail";
    }
    
    @RequestMapping(value="/sum/inviteamount")
    @ResponseBody
    public JSONObject  getSumInviteAmount(Integer userId ){
    	JSONObject result =new JSONObject();
    	if (userId == null){
    		result.put(DATA, ZERO_);
    		return result;
    	}
    	result.put(DATA,activityService.getSumInviteAmount(userId));
		return result;
    }
}
