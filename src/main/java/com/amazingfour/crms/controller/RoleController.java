package com.amazingfour.crms.controller;

import com.alibaba.fastjson.JSONArray;
import com.amazingfour.common.utils.PageUtil;

import com.amazingfour.common.utils.ResponseUtil;

import com.amazingfour.crms.domain.Menu;
import com.amazingfour.crms.domain.Role;


import com.amazingfour.crms.service.MenuService;
import com.amazingfour.crms.service.RoleService;
import com.amazingfour.crms.service.UserService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.*;

/**
 * Created by Dicky on 2016/1/21.
 */
@Controller
@RequestMapping("/role")
public class RoleController {

    @Resource
    private UserService userService;
    @Resource
    private RoleService roleService;
    @Resource
    private MenuService menuService;

    //从数据库中获取所有角色信息
    @RequestMapping("/list")
    public ModelAndView list(
            @RequestParam(value = "page", required = false, defaultValue = "1") String page,
            Role role, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        int pageSize = 4; // 页容量

        String roleName = role.getRoleName();

        Map<String, Object> map = new HashMap<String, Object>(); // 使用Map传值到mapper处理
        map.put("start", (Integer.parseInt(page) - 1) * pageSize); // 起始记录
        map.put("size", pageSize);

        map.put("roleName", roleName);

        List<Role> roleList = roleService.find(map); //查询符合条件的所有Role角色
        List<Role> list = new ArrayList<Role>();
        for(Role role1:roleList){
            Long roleId = role1.getRoleId();
            //根据roleId查询对应的menu，并填充到MenuList
            List<Menu> menu = menuService.getMenuById(roleId);//查询到List<Menu>集合
            role1.setMenuList(menu);
            list.add(role1);
        }
        int total = roleService.count(role); //符合条件的总记录数

        Map<String, Object> params = new HashMap<String, Object>();

        params.put("roleName", roleName);

        String pageCode = PageUtil.getPagation("/role/list.htm", params, total, Integer.parseInt(page), pageSize);
        mav.addObject("pageCode", pageCode);
        mav.addObject("roleList", list);
        mav.setViewName("role/roleMain");
        return mav;
    }

    //角色添加前置
    @RequestMapping("/preinsert")
    public ModelAndView presave() {
        ModelAndView mav = new ModelAndView();
        Map<String, Object> map = new HashMap<String, Object>();
        List<Role> roleList = roleService.find(map); //查询出权限菜单的内容
        mav.addObject("roleList", roleList);
        mav.setViewName("role/addRole");//跳到指定页面
        return mav;
    }

    //显示权限栏目树
    @RequestMapping("/addRole")
    public void showMenu( HttpServletResponse response) {
       List<Object> list =  roleService.listAllMenu();
        ResponseUtil.renderJson(response, list.toString());

    }

    //显示权限栏目树
    @RequestMapping("/insert")
    public void insert(Role role,HttpSession session,HttpServletResponse response,HttpServletRequest request) {
        String ids = request.getParameter("ids");
        System.out.println(role.getRoleName());
        System.out.println(role.getRoleDescript());
        System.out.println(ids);

    }

}