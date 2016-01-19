package com.amazingfour.crms.dao;

import com.amazingfour.crms.domain.CloudFile;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Huy on 2016-01-08.
 */
@Repository("cloudFileDao")
public interface CloudFileDao extends BaseDao<CloudFile,Long>{
    //批量删除文件
    public int deleteBatch(List<String> fileUrls);
}
