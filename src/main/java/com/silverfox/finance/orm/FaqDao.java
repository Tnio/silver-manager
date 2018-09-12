package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.Faq;

public interface FaqDao {
	List<Faq> queryForList();
	List<Faq> queryForWebList(Map<String, Object> params);
	Faq selectById(int id);
	int insert(Faq faq);
	int update(Faq faq);
	int delete(int id);
	int checkName(@Param("id")int id, @Param("name")String name);
	boolean updateSort(@Param("faqs")List<Faq> faqs);
}