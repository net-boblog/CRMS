package com.amazingfour.crms.service;

import com.amazingfour.crms.domain.Menu;
import com.amazingfour.crms.domain.RoleMenu;

import java.util.List;


/**
 * Created by Dicky on 2016/2/3.
 */
public interface MenuService extends BaseService<Menu,Long> {
    List<Menu> getMenuById(Long roleId);

    public void insertMenu(RoleMenu domain);

    public void updateMenu(RoleMenu domain);

    public void deleteMenu(RoleMenu domain);
}
