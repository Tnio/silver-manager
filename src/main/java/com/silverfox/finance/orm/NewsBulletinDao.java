package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.NewsBulletin;

public interface NewsBulletinDao {
	List<NewsBulletin> queryForList(Map<String, Object> params);
	NewsBulletin selectById(int id);
	int insert(NewsBulletin newsBulletin);
	int update(NewsBulletin newsBulletin);
	int delete(int id);
	int increaseHits(int id);
	
	int queryForCount(Map<String, Object> params);
	boolean updateSort(@Param("notices") List<NewsBulletin> notices);
}