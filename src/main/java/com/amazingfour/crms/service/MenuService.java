package com.amazingfour.crms.service;

import com.amazingfour.crms.domain.Menu;

import java.util.List;


/**
 * Created by Dicky on 2016/2/3.
 */
public interface MenuService extends BaseService<Menu,Long> {
    List<Menu> getMenuById(Long roleId);
}
