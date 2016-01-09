package com.amazingfour.crms.service.impl;

import com.amazingfour.crms.dao.BaseDao;
import com.amazingfour.crms.service.BaseService;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * Created by Huy on 2016-01-08.
 */
public abstract class AbstractService<T, ID extends Serializable> implements BaseService<T, ID> {
    private BaseDao<T,ID> baseDao;
    public void setBaseDao(BaseDao<T, ID> baseDao) {
        this.baseDao = baseDao;
    }

    //查询所有
    @Override
    public List<T> find(Map<String, Object> map){
        return baseDao.find(map);
    }
    //根据id查一个
    @Override
    public T findById(ID id){
        return baseDao.findById(id);
    }
    //查询数量
    @Override
    public int count(T domain){
        return baseDao.count(domain);
    }
    //增
    @Override
    public void insert(T domain){
        baseDao.insert(domain);
    }
    //删
    @Override
    public boolean delete(ID id){
        if(baseDao.delete(id)>0){
            return true;
        }else{
            return false;
        }
    }
    //改
    @Override
    public boolean update(T domain){
        if(baseDao.update(domain)>0){
            return true;
        }else{
            return false;
        }
    }
}
