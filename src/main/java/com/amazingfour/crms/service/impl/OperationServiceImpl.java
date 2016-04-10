package com.amazingfour.crms.service.impl;


import com.amazingfour.crms.dao.OperationDao;
import com.amazingfour.crms.domain.Menu;
import com.amazingfour.crms.domain.Operation;
import com.amazingfour.crms.domain.RoleOper;
import com.amazingfour.crms.service.OperationService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Dicky on 2016/3/27.
 */
@Service("operationService")
public class OperationServiceImpl extends AbstractService<Operation,Long> implements OperationService{

    @Resource
    private OperationDao operationDao;

    @Resource
    public void setOperationDao(OperationDao operationDao) {
        this.operationDao = operationDao;
    }


    @Override
    public void insertOper(RoleOper domain) {
        operationDao.insertOper(domain);
    }

    @Override
    public void updateOper(RoleOper domain) {

    }

    @Override
    public void deleteOper(RoleOper domain) {
        operationDao.deleteOper(domain);
    }


    public List<Operation> findParent() {
        return operationDao.findParent();
    }

    @Override
    public List<Operation> findChild(Long id) {
        return operationDao.findChild(id);
    }

    public List<Object> listAllOperById(List<Operation> operations,List<Operation> operationList){
        List<Object> listZTree = new ArrayList<Object>();
        String str = "";
        for (int i = 0; i < operations.size(); i++) {
            Operation  library = operations.get(i);//分类信息
            str = "{id:'" +library.getOperationId() + "', pId:'"+library.getPid()+"', " +
                    "name:'"+library.getFunName()+"',open:true}";//封装ztree需要格式的字符串

            for(int j = 0; j < operationList.size(); j++) {
                if (library.getOperationId().equals(operationList.get(j).getOperationId())) {
                    str = "{id:'" +library.getOperationId() + "', pId:'"+library.getPid()+"', " +
                            "name:'"+library.getFunName()+"',open:true,checked:true}";//
                }
            }
            listZTree.add(str);
        }
        return listZTree;
    }

    @Override
    public List<Operation> getOperbyId(Long id) {
        return operationDao.getOperbyId(id);
    }


}
