package com.amazingfour.crms.service.impl;

import com.amazingfour.crms.dao.BaseDao;
import com.amazingfour.crms.dao.CloudFileDao;
import com.amazingfour.crms.domain.CloudFile;
import com.amazingfour.crms.service.CloudFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

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

    //批量删除文件
    public int deleteBatch(List<String> fileUrls){
        return cloudFileDao.deleteBatch(fileUrls);
        /*if(rows==fileUrls.size()){
            return true;
        }else{
            return false;
        }*/
    }
}
