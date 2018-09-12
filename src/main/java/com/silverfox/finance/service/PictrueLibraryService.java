package com.silverfox.finance.service;

import com.silverfox.finance.domain.PictrueLibrary;

import java.util.List;

public interface PictrueLibraryService {
    boolean save(PictrueLibrary pictrueLibrary);
    boolean remove(int id);
    boolean enable(int id, int status);
    boolean duplicate(int id, String name, int category);
    int count(int category, int displayPlatform, int status);
    List<PictrueLibrary> list(int category, int displayPlatform, int status, int offset, int size);
    PictrueLibrary get(int id);
    PictrueLibrary getChart(int category);
    boolean changeSort(List<PictrueLibrary> pictrueLibraries);
    boolean savePhotoGallery(PictrueLibrary photoGallery);
    boolean enables(int id, int status);
    void savePictrueLibrary(PictrueLibrary startChart);
    boolean enableChart(int id, short status);
}
