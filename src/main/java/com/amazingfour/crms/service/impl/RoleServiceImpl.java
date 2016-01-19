package com.amazingfour.crms.service.impl;

import com.amazingfour.crms.dao.RoleDao;
import com.amazingfour.crms.domain.Role;
import com.amazingfour.crms.service.RoleService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by kennyho on 2016/1/13.
 */
@Service("roleService")
public class RoleServiceImpl extends AbstractService<Role,Long> implements RoleService {

    @Resource
   private RoleDao roleDao;

    @Resource
    public void setRoleDao(RoleDao roleDao) {
        this.roleDao = roleDao;
        super.setBaseDao(this.roleDao);
    }

    /*
     通过用户id找到用户角色
     *
    public List<Role> findByUserId(Long userId){
        return roleDao.findByUserId(userId);
    }*/

}
