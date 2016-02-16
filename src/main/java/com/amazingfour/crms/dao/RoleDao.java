package com.amazingfour.crms.dao;

import com.amazingfour.crms.domain.Role;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by kennyho on 2016/1/13.
 */
@Repository("roleDao")
public interface RoleDao extends BaseDao<Role,Long> {


    //查询数量
    public int getCountByName(Role domain);
    //增
    public void insert(Role domain);
    //删
    public int deleteRoleById(Long id);
    //改基本信息
    public void updateRoleBaseInfo(Role domain);
    //修改权限信息
    void updateRoleRights(Role role);
    //查询是否存在相同名字的角色
    public int existRoleByName(String roleName);

}
