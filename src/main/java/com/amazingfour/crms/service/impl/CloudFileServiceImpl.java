package com.amazingfour.crms.service.impl;

import com.amazingfour.crms.dao.BaseDao;
import com.amazingfour.crms.dao.CloudFileDao;
import com.amazingfour.crms.domain.CloudFile;
import com.amazingfour.crms.service.CloudFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;

/**
 * Created by Huy on 2016-01-08.
 */
@Service("cloudFileService")
public class CloudFileServiceImpl extends AbstractService<CloudFile,Long> implements CloudFileService{
    @Resource
    private CloudFileDao cloudFileDao;
    @Resource
    public void setCloudFileDao(CloudFileDao cloudFileDao) {
        this.cloudFileDao = cloudFileDao;
        super.setBaseDao(this.cloudFileDao);
    }

    /*@Resource
    public void setBaseDao(){
        super.setBaseDao(cloudFileDao);
    }*/
}
