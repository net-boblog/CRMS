package com.amazingfour.crms.dao;

import com.amazingfour.crms.domain.Menu;
import com.amazingfour.crms.domain.Role;
import org.springframework.stereotype.Repository;


import java.util.List;

/**
 * Created by Dicky on 2016/1/21.
 */
@Repository("menuDao")
public interface MenuDao  extends BaseDao<Menu,Long> {
    List<Menu> listAllMenu();
    List<Menu> listSubMenuByParentId(Integer parentId);
    Menu getMenuById(Integer menuId);
    void insertMenu(Menu menu);
    void updateMenu(Menu menu);
    void deleteMenuById(Integer menuId);
    List<Menu> listSubMenu(String menuId);
}
