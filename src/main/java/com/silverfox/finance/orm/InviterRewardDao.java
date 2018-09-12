package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.InviterReward;
import com.silverfox.finance.entity.InviteesEntity;
import com.silverfox.finance.entity.InviterEntity;
import com.silverfox.finance.entity.InviterRewardEntity;

public interface InviterRewardDao {

	int queryForCount(Map<String, Object> params);
	
	List<InviterEntity> queryInviterRewardList(Map<String, Object> params);
	
	List<InviterRewardEntity> queryInviterRewardEntities(int id);
	
	List<InviteesEntity> queryInviteesEntities(Map<String, Object> params);
	
	Double queryForSum(Map<String, Object> params);
	
	InviterReward queryInviterRewardByid(int id);

	List<InviterRewardEntity> queryInviterRewardEntitieByOrderNo(String orderNo);

	List<InviterRewardEntity> queryLevelTwoInviterRewardEntities(int id);

	Double querySumInviteAmount(Integer userId);

	int countBeInviterByCellphone(@Param("cellphone")String cellphone,@Param("inviterLevel")Integer inviterLevel);


}
