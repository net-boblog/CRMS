package com.amazingfour.crms.dao;

import com.amazingfour.crms.domain.CloudFile;
import org.springframework.stereotype.Repository;

/**
 * Created by Huy on 2016-01-08.
 */
@Repository("cloudFileDao")
public interface CloudFileDao extends BaseDao<CloudFile,Long>{

}
