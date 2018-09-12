package com.silverfox.finance.orm;

import com.silverfox.finance.domain.PictrueLibrary;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface PictrueLibraryDao {
    List<PictrueLibrary> queryForList(Map<String, Object> params);
    int queryForCount(Map<String, Object> params);
    int insert(PictrueLibrary pictrueLibrary);
    int update(PictrueLibrary pictrueLibrary);
    int delete(int id);
    PictrueLibrary selectById(@Param("id")int id);
    int selectByName(@Param("id")int id, @Param("name")String name, @Param("category")int category);
    int updateStatus(@Param("id")int id ,@Param("status")int status);
    PictrueLibrary selectChart(int category);
    int updateStatus(@Param("id")int id ,@Param("status")short status);
    boolean updateSort(@Param("pictrueLibraries")List<PictrueLibrary> pictrueLibraries);
}
