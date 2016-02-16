package com.amazingfour.crms.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.amazingfour.common.utils.PageUtil;

import com.amazingfour.common.utils.ResponseUtil;

import com.amazingfour.crms.domain.Menu;
import com.amazingfour.crms.domain.Role;


import com.amazingfour.crms.domain.RoleMenu;
import com.amazingfour.crms.domain.User;
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
        mav.setViewName("role/addRole");//跳到指定页面
        return mav;
    }
    //删除角色
    @RequestMapping("/delete")
    public void delete(@RequestParam(value = "roleId") String roleId,
                       HttpServletResponse response) {
        JSONObject result = new JSONObject();
        //查出roleId对应的菜单
        List<Menu> listMenu = menuService.getMenuById(Long.valueOf(roleId));//查询到List<Menu>集合
        RoleMenu roleMenu = new RoleMenu();
        roleMenu.setRoleId(Long.valueOf(roleId));
        for(Menu menu:listMenu){
            roleMenu.setMenuId(menu.getMenuId());
            menuService.deleteMenu(roleMenu);
        }
        roleService.delete(Long.valueOf(roleId));

            result.put("msg", "success");

        try {
            ResponseUtil.write(result, response);
        } catch (Exception e) {
            result.put("error","删除失败！");
            e.printStackTrace();
        }
    }

    //显示权限栏目树
    @RequestMapping("/addRole")
    public void showMenu( HttpServletResponse response) {
       List<Object> list =  roleService.listAllMenu();
        ResponseUtil.renderJson(response, list.toString());
    }

    //添加角色
    @RequestMapping("/insert")
    public void insertRole(Role role,HttpServletResponse response,HttpServletRequest request) {
        JSONObject obj = new JSONObject();
        String ids = request.getParameter("ids");
        String[] str = ids.split(",");

        if (roleService.existRoleByName(role.getRoleName())){//角色名不能相同
            obj.put("roletip",0);
            obj.put("mes","保存失败，该角色已存在!");
            //return "redirect:/user/preinsert.htm";
        }else {
            roleService.insert(role);   //插入角色
//            RoleMenu roleMenu = new RoleMenu();
            Long roleId = role.getRoleId(); //获取自增的roleId
//            roleMenu.setRoleId(roleId);
            for (int i = 0; i < str.length; i++) {
                //在menuService中新建一个新的插入方法
                Long menuId = Long.valueOf(str[i]);
                RoleMenu rm = new RoleMenu();
                rm.setMenuId(menuId);
                rm.setRoleId(roleId);
                menuService.insertMenu(rm);
            }
            obj.put("roletip", 1);
            obj.put("mes", "保存成功!");
        }

        ResponseUtil.renderJson(response, obj.toString());

    }

    //角色更新前置
    @RequestMapping("/preUpdate")
    public ModelAndView preUpdate(@RequestParam(value = "roleId") String roleId,HttpServletRequest request) {

        ModelAndView mav = new ModelAndView();
        Role role = roleService.findById(Long.valueOf(roleId));
        request.setAttribute("role",role);
        mav.addObject("roleId",roleId);
        mav.setViewName("role/updateRole");
        return mav;
    }

    //显示权限栏目树
    @RequestMapping("/updateRole")
    public void showUpdateMenu(@RequestParam(value = "roleId") String roleId, HttpServletResponse response) {
        //查出roleId对应的菜单
        List<Menu> menu = menuService.getMenuById(Long.valueOf(roleId));//查询到List<Menu>集合
        //查询所有菜单
        List<Object> list =  roleService.listAllMenuById(menu);
        ResponseUtil.renderJson(response, list.toString());
    }


    //更新角色
    @RequestMapping("/updateMenu")
    public void updateMenu(@RequestParam(value = "roleId") String roleId,Role role,HttpServletRequest request,HttpServletResponse response) {
        String rname = request.getParameter("rname");
        String rdesc = request.getParameter("rdesc");
        JSONObject obj = new JSONObject();
        if(!rname.equals(role.getRoleName())){  //角色名修改了
            if (roleService.existRoleByName(role.getRoleName())){   //修改后的名字已处在
                obj.put("roletip",0);
                obj.put("mes","保存失败，该角色已存在!");
                ResponseUtil.renderJson(response, obj.toString());
                return;
                //return "redirect:/user/preinsert.htm";
            }
            role.setRoleId(Long.valueOf(roleId));
            roleService.update(role);
            }

            //查出roleId对应的菜单
            List<Menu> rmList = menuService.getMenuById(Long.valueOf(roleId));//查询到List<Menu>集合

            String ids = request.getParameter("ids");
            //页面勾选权限id
            String[] mids = ids.split(",");

            //页面存在数据库不存在就添加
            if(mids.length>0){

                for (String menuid : mids) {
                    if(this.isContain(rmList,menuid)){
                        RoleMenu rolemenu = new RoleMenu();
                        rolemenu.setMenuId(Long.valueOf(menuid));
                        rolemenu.setRoleId(Long.valueOf(roleId));
                        //添加页面有数据库没有的菜单
                        menuService.insertMenu(rolemenu);

                    }
                }
            }
            //数据库存在而页面不存在就删除
            for (Menu menu : rmList) {
                String menuid = menu.getMenuId().toString();
                if(this.isContain(mids,menuid)){
                    RoleMenu rolemenu = new RoleMenu();
                    rolemenu.setRoleId(Long.valueOf(roleId));
                    rolemenu.setMenuId(Long.valueOf(menuid));
                    //删除对应的菜单
                    menuService.deleteMenu(rolemenu);

                }
            }
            obj.put("roletip", 1);
            obj.put("mes", "保存成功!");



        ResponseUtil.renderJson(response, obj.toString());
    }

    private boolean isContain(String [] mids,String menuid){
        for (String mid : mids) {
            if(menuid.equals(mid))
                return false;
        }
        return true;
    }

    private boolean isContain(List<Menu> menuList,String menuid){
        for (Menu menu : menuList) {
            if(menuid.equals(menu.getMenuId().toString()))
                return false;
        }
        return true;
    }

}