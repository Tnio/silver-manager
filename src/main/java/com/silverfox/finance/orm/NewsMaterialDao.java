package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import com.silverfox.finance.domain.NewsMaterial;

public interface NewsMaterialDao {
	List<NewsMaterial> queryForList(Map<String, Object> params);
	int queryForCount();
	NewsMaterial selectById(int id);
	int insert(NewsMaterial news);
	int update(NewsMaterial news);
	int delete(int id);
}