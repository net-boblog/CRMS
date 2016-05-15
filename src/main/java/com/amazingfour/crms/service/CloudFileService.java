package com.amazingfour.crms.service;

import com.amazingfour.crms.domain.CloudFile;
import com.amazingfour.crms.domain.UserFile;

import java.util.List;
import java.util.Map;

/**
 * Created by Huy on 2016-01-08.
 */
public interface CloudFileService extends BaseService<CloudFile, Long> {
    //批量删除文件
    public int deleteBatch(List<String> fileUrls);

    //根据bussinessKey查找一个文件
    public CloudFile findByBussinessKey(String bussinessKey);

    //    添加user/file的联系
    public void insertUF(UserFile userFile);

    //根据id查找所有人文件
    public List<CloudFile> findByUserId(Map<String, Object> map);

    public int countById(Map<String, Object> map);
}
