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

    //查询所有
    public List<Role> find(Map<String, Object> map);   //map可以存放一些其它数据，如用于分页查询的start(起始页)和size(每页数量)
    //根据id查一个
    public Role findById(Long id);
    //查询数量
    public int getCountByName(Role domain);
    //增
    public void insertRole(Role domain);
    //删
    public int deleteRoleById(Long id);
    //改基本信息
    public void updateRoleBaseInfo(Role domain);
    //修改权限信息
    void updateRoleRights(Role role);

}
