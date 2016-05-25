package com.amazingfour.crms.controller;

import com.alibaba.fastjson.JSONObject;
import com.amazingfour.common.utils.PageUtil;

import com.amazingfour.common.utils.ResponseUtil;

import com.amazingfour.crms.domain.*;


import com.amazingfour.crms.service.MenuService;
import com.amazingfour.crms.service.OperationService;
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

import java.io.UnsupportedEncodingException;
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
    @Resource
    private OperationService operationService;

    //从数据库中获取所有角色信息
    @RequestMapping("/list")
    public ModelAndView list(
            @RequestParam(value = "page", required = false) String page,
            Role role, HttpServletRequest request) throws UnsupportedEncodingException {
        ModelAndView mav = new ModelAndView();
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();

        int pageSize = 5; // 页容量

        if (page == null || page == "") {

            page = "1";
            session.setAttribute("role", role);
        } else {

            role = (Role) session.getAttribute("role");

        }
        String roleName=role.getRoleName();

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
        if(userService.findUserRole(Long.valueOf(roleId))){
            result.put("msg", "error");
        }else{
        //查出roleId对应的菜单
        List<Menu> listMenu = menuService.getMenuById(Long.valueOf(roleId));//查询到List<Menu>集合
        List<Operation> listOperation = operationService.getOperbyId(Long.valueOf(roleId));
        RoleMenu roleMenu = new RoleMenu();
        roleMenu.setRoleId(Long.valueOf(roleId));
        for(Menu menu:listMenu){
            roleMenu.setMenuId(menu.getMenuId());
            menuService.deleteMenu(roleMenu);
        }
        RoleOper roleOper = new RoleOper();
        roleOper.setRoleId(Long.valueOf(roleId));
        for(Operation operation:listOperation){
            roleOper.setOperationId(operation.getOperationId());
            operationService.deleteOper(roleOper);
        }
        roleService.delete(Long.valueOf(roleId));
            result.put("msg", "success");

        }
        try {
            ResponseUtil.write(result, response);
        } catch (Exception e) {
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

    //角色菜单更新前置
    @RequestMapping("/preUpdate")
    public ModelAndView preUpdate(@RequestParam(value = "roleId") String roleId,HttpServletRequest request) {

        ModelAndView mav = new ModelAndView();
        Role role = roleService.findById(Long.valueOf(roleId));
        request.setAttribute("role",role);
        mav.addObject("roleId",roleId);
        mav.setViewName("role/updateRole");
        return mav;
    }

    //角色功能更新前置
    @RequestMapping("/preUpdateOper")
    public ModelAndView preUpdateOper(@RequestParam(value = "roleId") String roleId,HttpServletRequest request) {

        ModelAndView mav = new ModelAndView();
        mav.addObject("roleId",roleId);
        mav.setViewName("role/updateOper");
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

    //显示功能栏目树
    @RequestMapping("/updateOper")
    public void showUpdateOper(@RequestParam(value = "roleId") String roleId, HttpServletResponse response) {
        //查出roleId对应的菜单
        List<Menu> rmList = menuService.getMenuById(Long.valueOf(roleId));//查询到List<Menu>集合
        List<Operation> operList = operationService.findParent();   //查询pid为0的功能节点
        List list = new ArrayList();
        for (Menu m : rmList) {
            String mn = m.getName();
            for (Operation oper : operList) {
                String op = oper.getFunName();
                if (mn.equals(op)) {              //如果菜单名相同
                    list.add(Long.valueOf(oper.getOperationId()));    //则获取功能对应的id
                }
            }
        }

        String str = "";
        List<Operation> operChecked = operationService.getOperbyId(Long.valueOf(roleId));
        List<Object> liste  = new ArrayList<Object>();
        List<Object> listztree = null;
        for (int i = 0; i < list.size(); i++) {
            Long id = (Long) list.get(i);
            List<Operation> operSub = operationService.findChild(id);   //寻找父ID下的子节点及父节点
            listztree= operationService.listAllOperById(operSub,operChecked);
          for(int j=0;j<listztree.size();j++){
              str = (String) listztree.get(j);
              liste.add(str);               //将所有json数据添加到liste集合中
          }
        }

        ResponseUtil.renderJson(response, liste.toString());
    }


    //更新角色菜单
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
        }
        role.setRoleId(Long.valueOf(roleId));
        roleService.update(role);
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
            /*
                1.这里要同时删除对应菜单下的所有功能
             */
            for (Menu menu : rmList) {
                String menuid = menu.getMenuId().toString();

                if(this.isContain(mids,menuid)){
                    List<Operation> delist = operationService.findChild(Long.valueOf(menuid));
                    RoleOper roleOper = new RoleOper();
                    for(int i=0;i<delist.size();i++){
                        roleOper.setOperationId(delist.get(i).getOperationId());
                        roleOper.setRoleId(Long.valueOf(roleId));
                        //删除对应的权限
                        operationService.deleteOper(roleOper);
                    }
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

    //更新角色功能
    @RequestMapping("/updateOperByMenu")
    public void updateOperByMenu(@RequestParam(value = "roleId") String roleId,Role role,HttpServletRequest request,HttpServletResponse response) {

        JSONObject obj = new JSONObject();

        //查出roleId对应的功能
        List<Operation> opList = operationService.getOperbyId(Long.valueOf(roleId));
        String ids = request.getParameter("ids");
        //页面勾选权限id
        String[] mids = ids.split(",");

        //页面存在数据库不存在就添加
        if(mids.length>0){

            for (String operationId : mids) {
                if(this.isContainOper(opList, operationId)){
                    RoleOper roleOper = new RoleOper();
                    roleOper.setOperationId(Long.valueOf(operationId));
                    roleOper.setRoleId(Long.valueOf(roleId));
                    //添加页面有数据库没有的菜单
                    operationService.insertOper(roleOper);

                }
            }
        }
        //数据库存在而页面不存在就删除
        for (Operation oper : opList) {
            String operationId = oper.getOperationId().toString();
            if(this.isContain(mids,operationId)){
                RoleOper roleOper = new RoleOper();
                roleOper.setOperationId(Long.valueOf(operationId));
                roleOper.setRoleId(Long.valueOf(roleId));
                //删除对应的菜单
                operationService.deleteOper(roleOper);

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
    private boolean isContainOper(String [] mids,String operationId){
        for (String mid : mids) {
            if(operationId.equals(mid))
                return false;
        }
        return true;
    }
    private boolean isContainOper(List<Operation> opList,String operationId){
        for (Operation oper : opList) {
            if(operationId.equals(oper.getOperationId().toString()))
                return false;
        }
        return true;
    }

}