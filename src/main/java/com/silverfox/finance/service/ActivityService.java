package com.silverfox.finance.service;

import java.util.List;

import com.silverfox.finance.domain.Activity;
import com.silverfox.finance.domain.Coupon;
import com.silverfox.finance.domain.CouponActivity;
import com.silverfox.finance.domain.InviterReward;
import com.silverfox.finance.domain.RoleResource;
import com.silverfox.finance.entity.InviterEntity;
import com.silverfox.finance.entity.InviterRewardEntity;

public interface ActivityService {
    int count(int status);
    Activity get(int id);
    boolean isExists(int id, String title);
    boolean save(Activity activity);
    boolean recommend(int id,int recommend);
    boolean enable(int id,int status);
    boolean remove(int id);
    boolean changeActivitySort(List<Activity> activitys);
    List<Activity> list(int status, int offset, int size);

    boolean saveCouponActivity(CouponActivity couponActivity);
    boolean auditCouponActivity(int id,int status);
    int couponActivityCount(int status);
    List<CouponActivity> CouponActivitylist(int status, int offset, int size);
    List<Coupon> getCoupons(String couponIds, int category, int status);
    boolean validateTime(int id);
    boolean isCouponActivityExists(int id, String title);

    CouponActivity getCouponActivity(int id);
    void saveCouponActivitys(CouponActivity couponActivity);
    
	int countAllinviterlist(String userName, String cellphone, String startTime, String endTime);
	List<InviterEntity> inviterList(Integer customerId,String userName, String cellphone, String startTime,String endTime,int offset, int pageSize);
	double sumInviterRewardAmount(String userName, String cellphone, String startTime,String endTime);
	List<InviterRewardEntity> inviterRewardEntities(int id);
	InviterReward getInviterRewardByid(int id);
	List<InviterRewardEntity> getInviterRewardEntitieByOrderNo(String orderNo);
	List<InviterRewardEntity> getLevelTwoInviterRewardEntities(int id);
	double getSumInviteAmount(Integer userId);
}
