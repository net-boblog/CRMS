package com.amazingfour.crms.service.impl;

import com.amazingfour.crms.dao.MenuDao;
import com.amazingfour.crms.dao.RoleDao;
import com.amazingfour.crms.domain.Menu;
import com.amazingfour.crms.domain.Role;
import com.amazingfour.crms.service.RoleService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by kennyho on 2016/1/13.
 */
@Service("roleService")
public class RoleServiceImpl extends AbstractService<Role,Long> implements RoleService {

    @Resource
    private RoleDao roleDao;
    @Resource
    private MenuDao menuDao;

    @Resource
    public void setMenuDao(MenuDao menuDao) {
        this.menuDao = menuDao;
    }

    @Resource
    public void setRoleDao(RoleDao roleDao) {
        this.roleDao = roleDao;
        super.setBaseDao(this.roleDao);
    }

    /*
     通过用户id找到用户角色
     */
    public List<Object> listAllMenu(){
        List<Object> listZTree = new ArrayList<Object>();
        List<Menu> listLibrary  = menuDao.listAllMenu();
        System.out.println("即将进入");
        String str = "";
        for (int i = 0; i < listLibrary.size(); i++) {
            Menu  library = listLibrary.get(i);//分类信息
            str = "{id:'" +library.getMenuId() + "', pId:'"+library.getPid()+"', name:\""+library.getName()+"\" }";//封装ztree需要格式的字符串
            listZTree.add(str);
            System.out.println(str+"正在进入");
        }
        System.out.println("完成进入");
        return listZTree;

    }

    public List<Menu> listSubMenu(String menuId){
        return menuDao.listSubMenu(menuId);
    }
}
