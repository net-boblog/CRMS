package com.amazingfour.crms.dao;

import com.amazingfour.crms.domain.Menu;
import com.amazingfour.crms.domain.Role;
import com.amazingfour.crms.domain.RoleMenu;
import org.springframework.stereotype.Repository;


import java.util.List;

/**
 * Created by Dicky on 2016/1/21.
 */
@Repository("menuDao")
public interface MenuDao  extends BaseDao<Menu,Long> {
    List<Menu> listAllMenu();
    List<Menu> listSubMenuByParentId(Integer parentId);
    List<Menu> getMenuById(Long roleId);
    void insertMenu(Menu menu);
    void updateMenu(RoleMenu roleMenu);
    void deleteMenu(RoleMenu roleMenu);
    List<Menu> listSubMenu(String menuId);
    public void insertMenu(RoleMenu domain);
}
