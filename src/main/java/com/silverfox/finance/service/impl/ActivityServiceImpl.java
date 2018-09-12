package com.silverfox.finance.service.impl;

import static com.silverfox.finance.util.ConstantUtil.COMMA;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.silverfox.finance.domain.Activity;
import com.silverfox.finance.domain.Coupon;
import com.silverfox.finance.domain.CouponActivity;
import com.silverfox.finance.domain.InviterReward;
import com.silverfox.finance.entity.InviterEntity;
import com.silverfox.finance.entity.InviterRewardEntity;
import com.silverfox.finance.orm.ActivityDao;
import com.silverfox.finance.orm.CouponActivityDao;
import com.silverfox.finance.orm.CouponDao;
import com.silverfox.finance.orm.InviterRewardDao;
import com.silverfox.finance.service.ActivityService;
import com.silverfox.finance.util.LogRecord;

@Service
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private ActivityDao activityDao;
    @Autowired
    private CouponActivityDao couponActivityDao;
    @Autowired
    private CouponDao couponDao;
    @Autowired
    private InviterRewardDao inviterRewardDao;


    @Override
    public CouponActivity getCouponActivity(int id) {
        return couponActivityDao.selectById(id);
    }

    @Override
    public int count(int status) {
        return activityDao.queryForCount(status);
    }

    @Override
    public Activity get(int id) {
        return activityDao.selectById(id);
    }

    @Override
    public boolean isExists(int id, String title) {
        return activityDao.selectByTitle(id, title) > 0 ? true : false;
    }

    @Override
    @LogRecord(module=LogRecord.Module.ACTIVITY, operation=LogRecord.Operation.ACTIVITYSAVE, id="", name="${activity.title}")
    public boolean save(Activity activity) {
        if(activity!=null) {
            if(activity.getId() > 0) {
                return activityDao.update(activity) > 0 ? true : false;
            } else {
                return activityDao.insert(activity) > 0 ? true : false;
            }
        }
        return false;
    }

    @Override
    @LogRecord(module=LogRecord.Module.ACTIVITY, operation=LogRecord.Operation.RECOMMEND, id="${id}", name="")
    public boolean recommend(int id, int recommend) {
        return activityDao.updateRecommend(id, recommend) > 0 ? true : false;
    }

    @Override
    @LogRecord(module=LogRecord.Module.ACTIVITY, operation=LogRecord.Operation.ENABLE, id="${id}", name="")
    public boolean enable(int id, int enable) {
        return activityDao.updateStatus(id, enable) > 0 ? true : false;
    }

    @Override
    @LogRecord(module=LogRecord.Module.ACTIVITY, operation=LogRecord.Operation.REMOVE, id="${id}", name="")
    public boolean remove(int id) {
        return activityDao.delete(id) > 0 ? true : false;
    }

    @Override
    public boolean changeActivitySort(List<Activity> activitys) {
        return activityDao.updateSort(activitys);
    }

    @Override
    public List<Activity> list(int status, int offset, int size) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("status", status);
        params.put("offset", offset);
        params.put("size", size);
        return activityDao.queryForList(params);
    }

    @Override
    @LogRecord(module=LogRecord.Module.COUPONACTIVITY, operation=LogRecord.Operation.COUPONACTIVITYSAVE, id="", name="${couponActivity.name}")
    public boolean saveCouponActivity(CouponActivity couponActivity) {
        if(couponActivity != null) {
            if(couponActivity.getId() > 0) {
                return couponActivityDao.update(couponActivity) > 0 ? true : false;
            }else{
                return couponActivityDao.insert(couponActivity) > 0 ? true : false;
            }
        }
        return false;
    }

    @Override
    @LogRecord(module=LogRecord.Module.COUPONACTIVITY, operation=LogRecord.Operation.AUDIT_STATUS, id="${id}", name="")
    public boolean auditCouponActivity(int id, int status) {
        return couponActivityDao.updateStatus(id, status) > 0 ? true : false;
    }

    @Override
    public int couponActivityCount(int status) {
        return couponActivityDao.queryForCount(status);
    }

    @Override
    public List<CouponActivity> CouponActivitylist(int status, int offset, int size) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("status", status);
        params.put("offset", offset);
        params.put("size", size);
        return couponActivityDao.queryForList(params);
    }

    @Override
    public List<Coupon> getCoupons(String couponIds, int category, int status) {
        List<Integer> cIds = new ArrayList<Integer>();
        List<String> couponIdsStr = Arrays.asList(StringUtils.split(couponIds, COMMA));
        for (String couponId : couponIdsStr) {
            try {
                cIds.add(Integer.parseInt(couponId));
            } catch (Exception e) {
                continue;
            }
        }
        return this.getAllCoupons(couponDao.queryCoupons(couponIds, category, status), cIds);
    }

    @Override
    public boolean validateTime(int id) {
        CouponActivity couponActivity = couponActivityDao.selectById(id);
        if(couponActivity != null && couponActivity.getId() > 0){
            return couponActivityDao.selectOverlapTime(couponActivity.getBeginTime(), couponActivity.getEndTime()) > 0 ? false : true;
        }
        return false;
    }

    @Override
    public boolean isCouponActivityExists(int id, String title) {
        return couponActivityDao.selectByName(id, title) > 0 ? true : false;
    }

    private List<Coupon> getAllCoupons(List<Coupon> coupons, List<Integer> couponIds) {
        List<Coupon> allCoupons = new ArrayList<Coupon>();
        if(coupons.size() > 0){
            for(int i =0; i< coupons.size(); i++){
                int quantity = 0;
                for(int j =0; j<couponIds.size(); j++){
                    if(coupons.get(i).getId() == couponIds.get(j)){
                        quantity = quantity + 1;
                    }
                }
                if(quantity > 0){
                    for(int k = 0; k < quantity; k++){
                        Coupon coupon =new Coupon();
                        coupon = coupons.get(i);
                        allCoupons.add(coupon);
                    }
                }
            }
        }
        return allCoupons;
    }

    @Override
    @LogRecord(module=LogRecord.Module.COUPONACTIVITY, operation=LogRecord.Operation.COUPONACTIVITYOPERATION, id="${couponActivity.id}", name="${couponActivity.name}")
    public void saveCouponActivitys(CouponActivity couponActivity) {
        if(couponActivity != null) {
            if(couponActivity.getId() > 0) {
                couponActivityDao.update(couponActivity);
            }else{
                couponActivityDao.insert(couponActivity);
            }
        }

    }

	@Override
	public int countAllinviterlist(String userName, String cellphone, String startTime, String endTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(userName)) {
			params.put("userName", userName);
		}
		if(StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		if(StringUtils.isNotBlank(startTime)&&StringUtils.isNotBlank(endTime)) {
			params.put("startTime", startTime);
			params.put("endTime", endTime);
		}
		return inviterRewardDao.queryForCount(params);
	}

	@Override
	public List<InviterEntity> inviterList(Integer customerId,String userName,String cellphone, String startTime, String endTime, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(userName)) {
			params.put("userName", userName);
		}
		if(StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		if(customerId != null) {
			params.put("customerId", customerId);
		}
		if(StringUtils.isNotBlank(startTime)&&StringUtils.isNotBlank(endTime)) {
			params.put("startTime", startTime);
			params.put("endTime", endTime);
		}
        params.put("offset", offset);
        params.put("size", size);
		return inviterRewardDao.queryInviterRewardList(params);
	}

	@Override
	public double sumInviterRewardAmount(String userName, String cellphone, String startTime, String endTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(userName)) {
			params.put("userName", userName);
		}
		if(StringUtils.isNotBlank(cellphone)) {
			params.put("cellphone", cellphone);
		}
		if(StringUtils.isNotBlank(startTime)&&StringUtils.isNotBlank(endTime)) {
			params.put("startTime", startTime);
			params.put("endTime", endTime);
		}
		return inviterRewardDao.queryForSum(params);
	}

	
	@Override
	public List<InviterRewardEntity> inviterRewardEntities(int id) {
		return inviterRewardDao.queryInviterRewardEntities(id);
	}

	@Override
	public InviterReward getInviterRewardByid(int id) {
		return inviterRewardDao.queryInviterRewardByid( id );
	}

	@Override
	public List<InviterRewardEntity> getInviterRewardEntitieByOrderNo(String orderNo) {
		return inviterRewardDao.queryInviterRewardEntitieByOrderNo(orderNo);
	}

	@Override
	public List<InviterRewardEntity> getLevelTwoInviterRewardEntities(int id) {
		return inviterRewardDao.queryLevelTwoInviterRewardEntities(id);
	}

	@Override
	public double getSumInviteAmount(Integer userId) {
		return inviterRewardDao.querySumInviteAmount(userId);
	}
	
}
