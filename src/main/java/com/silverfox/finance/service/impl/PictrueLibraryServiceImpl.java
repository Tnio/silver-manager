package com.silverfox.finance.service.impl;

import com.silverfox.finance.domain.PictrueLibrary;
import com.silverfox.finance.orm.PictrueLibraryDao;
import com.silverfox.finance.service.PictrueLibraryService;
import com.silverfox.finance.util.LogRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PictrueLibraryServiceImpl implements PictrueLibraryService {

    @Autowired
    private PictrueLibraryDao pictrueLibraryDao;

    @Override
    @LogRecord(module=LogRecord.Module.IMAGE, operation=LogRecord.Operation.IMAGEOPERATION, id="${pictrueLibrary.id}", name="${pictrueLibrary.name}")
    public boolean save(PictrueLibrary pictrueLibrary) {
        if(pictrueLibrary != null) {
            if(pictrueLibrary.getId() > 0){
                return pictrueLibraryDao.update(pictrueLibrary) > 0 ? true : false;
            } else {
                return pictrueLibraryDao.insert(pictrueLibrary) > 0 ? true : false;
            }
        }
        return false;
    }
    @Override
    @LogRecord(module=LogRecord.Module.WEB_IMAGE, operation=LogRecord.Operation.EDIT, id="${pictrueLibrary.id}", name="")
    public boolean savePhotoGallery(PictrueLibrary pictrueLibrary) {
        if(pictrueLibrary != null) {
            if(pictrueLibrary.getId() > 0){
                return pictrueLibraryDao.update(pictrueLibrary) > 0 ? true : false;
            } else {
                return pictrueLibraryDao.insert(pictrueLibrary) > 0 ? true : false;
            }
        }
        return false;
    }
    @Override
    @LogRecord(module=LogRecord.Module.IMAGE, operation=LogRecord.Operation.REMOVE, id="${id}", name="")
    public boolean remove(int id) {
        return pictrueLibraryDao.delete(id) > 0 ? true : false;
    }

    @Override
    @LogRecord(module=LogRecord.Module.IMAGE, operation=LogRecord.Operation.IMAGEENABLE, id="${id}", remark="${status}")
    public boolean enable(int id, int status) {
        return pictrueLibraryDao.updateStatus(id, status) > 0 ? true : false;
    }

    @Override
    public boolean duplicate(int id, String name, int category) {
        return pictrueLibraryDao.selectByName(id, name, category) > 0 ? false : true;
    }

    @Override
    public int count(int category, int displayPlatform, int status) {
        Map<String,Object> params =new HashMap<String,Object>();
        params.put("category", category);
        params.put("displayPlatform", displayPlatform);
        params.put("status", status);
        return pictrueLibraryDao.queryForCount(params);
    }

    @Override
    public List<PictrueLibrary> list(int category, int displayPlatform,
                                     int status, int offset, int size) {
        Map<String,Object> params =new HashMap<String,Object>();
        params.put("category", category);
        params.put("displayPlatform", displayPlatform);
        params.put("status", status);
        params.put("offset", offset);
        params.put("size", size);
        return pictrueLibraryDao.queryForList(params);
    }

    @Override
    public PictrueLibrary get(int id) {
        return pictrueLibraryDao.selectById(id);
    }

    @Override
    public PictrueLibrary getChart(int category) {
        return pictrueLibraryDao.selectChart(category);
    }

    @Override
    public boolean changeSort(List<PictrueLibrary> pictrueLibraries) {
        return pictrueLibraryDao.updateSort(pictrueLibraries);
    }
    @Override
    @LogRecord(module=LogRecord.Module.WEB_IMAGE, operation=LogRecord.Operation.IMAGEENABLE, id="${id}", name="")
    public boolean enables(int id, int status) {
        return pictrueLibraryDao.updateStatus(id, status) > 0 ? true : false;
    }
    @Override
    @LogRecord(module=LogRecord.Module.PRODUCT_AD, operation=LogRecord.Operation.EDIT, id="${startChart.id}", name="")
    public void savePictrueLibrary(PictrueLibrary startChart) {
        if(startChart != null) {
            if(startChart.getId() > 0){
                pictrueLibraryDao.update(startChart);
            } else {
                pictrueLibraryDao.insert(startChart);
            }
        }
    }
    @Override
    @LogRecord(module=LogRecord.Module.PRODUCT_AD, operation=LogRecord.Operation.IMAGEENABLE, id="${id}", name="")
    public boolean enableChart(int id, short status) {

        return pictrueLibraryDao.updateStatus(id, status) > 0 ? true : false;
    }
}
