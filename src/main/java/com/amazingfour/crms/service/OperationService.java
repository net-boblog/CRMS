package com.amazingfour.crms.service;


import com.amazingfour.crms.domain.Menu;
import com.amazingfour.crms.domain.Operation;
import com.amazingfour.crms.domain.RoleMenu;
import com.amazingfour.crms.domain.RoleOper;

import java.util.List;

/**
 * Created by Dicky on 2016/3/27.
 */
public interface OperationService  extends BaseService<Operation,Long>{

    public void insertOper(RoleOper domain);

    public void updateOper(RoleOper domain);

    public void deleteOper(RoleOper domain);

    public List<Operation> findParent() ;

    public List<Operation> findChild(Long id);

    public List<Object> listAllOperById(List<Operation> operations,List<Operation> operationList);

    public List<Operation> getOperbyId(Long id);


}
