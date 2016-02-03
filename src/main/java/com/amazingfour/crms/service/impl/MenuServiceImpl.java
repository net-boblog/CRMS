package com.amazingfour.crms.service.impl;


import com.amazingfour.crms.dao.MenuDao;
import com.amazingfour.crms.domain.Menu;
import com.amazingfour.crms.service.MenuService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Dicky on 2016/2/3.
 */
@Service("menuService")
public class MenuServiceImpl extends AbstractService<Menu,Long> implements MenuService {
    @Resource
    private MenuDao menuDao;

    @Resource
    public void setMenuDao(MenuDao menuDao) {
        this.menuDao = menuDao;
    }

    @Override
    public List<Menu> getMenuById(Long roleId) {
        return menuDao.getMenuById(roleId);
    }
}
