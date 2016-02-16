package com.amazingfour.crms.service;

import com.amazingfour.crms.domain.Menu;
import com.amazingfour.crms.domain.Role;

import java.util.List;

/**
 * Created by kennyho on 2016/1/13.
 */
public interface RoleService extends BaseService<Role,Long> {
    //public List<Role> findByUserId(Long userId);
    public List<Object> listAllMenu();
    public List<Object> listAllMenuById(List<Menu> menu);
    public List<Menu> listSubMenu(String menuId);
    public boolean existRoleByName(String roleName);
}
