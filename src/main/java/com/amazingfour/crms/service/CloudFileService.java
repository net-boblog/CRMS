package com.amazingfour.crms.service;

import com.amazingfour.crms.domain.CloudFile;

import java.util.List;

/**
 * Created by Huy on 2016-01-08.
 */
public interface CloudFileService extends BaseService<CloudFile,Long>{
    //批量删除文件
    public int deleteBatch(List<String> fileUrls);
}
