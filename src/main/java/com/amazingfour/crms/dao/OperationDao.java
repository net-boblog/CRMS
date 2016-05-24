package com.amazingfour.crms.dao;

import com.amazingfour.crms.domain.Operation;
import com.amazingfour.crms.domain.RoleOper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Dicky on 2016/3/27.
 */
@Repository("operationDao")
public interface OperationDao extends BaseDao<Operation,Long> {
    //查询所有
    public List<Operation> findParent();

    public List<Operation> findChild(Long id);

    public List<Operation> getOperbyId(Long id);

    public List<Operation> getOperbySubId(Long id);

    public void insertOper(RoleOper domain);

    public void deleteOper(RoleOper domain);


}
