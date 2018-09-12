package com.silverfox.finance.orm;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.Attachment;

public interface AttachmentDao {
	List<Attachment> selectByIds(@Param("ids")List<Integer> ids);
	Attachment selectByAttachmentId(int attachmentId);
	int insert(List<Attachment> attachments);
	int insertSingle(Attachment attachment);
	int deleteMore(@Param("ids")List<Integer> ids);
	List<Attachment> selectByProductId(@Param("productId")int productId);
	int delete(@Param("attachmentId")int attachmentId);
}