package com.amazingfour.crms.controller;

import com.alibaba.fastjson.JSONArray;
import com.amazingfour.common.utils.PageUtil;

import com.amazingfour.common.utils.ResponseUtil;

import com.amazingfour.crms.domain.Role;

import com.amazingfour.crms.service.RoleService;
import com.amazingfour.crms.service.UserService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

        int total = roleService.count(role); //符合条件的总记录数

        Map<String, Object> params = new HashMap<String, Object>();

        params.put("roleName", roleName);

        String pageCode = PageUtil.getPagation("/role/list.htm", params, total, Integer.parseInt(page), pageSize);
        mav.addObject("pageCode", pageCode);
        mav.addObject("roleList", roleList);
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
    public void showMenu(HttpServletRequest request, HttpServletResponse response) {
//        System.out.println(request.getParameter("id") + " " + request.getParameter("name") + " " + request.getParameter("otherParam"));
//        response.setCharacterEncoding("UTF-8");
//        List<Object> listZTree = new ArrayList<Object>();
//        List<Menu> listLibrary = roleService.listAllMenu();
//        String str = "";
//        for (int i = 0; i < listLibrary.size(); i++) {
//            Menu library = listLibrary.get(i);//分类信息
//            str = "{id:'" + library.getMenuId() + "', pId:'" + library.getPid() + "', name:\"" + library.getName() + "\" }";//封装ztree需要格式的字符串
//            listZTree.add(str);
//        }

        //根据角色找到对应的操作权限id
//        String operationids = roleService.listAllParentMenu();
//        String menuId = request.getParameter("menuId");
//        System.out.println(menuId);
//        //查询所有的权限分类，如系统管理、订单管理、采购管理等等，作为树的一级节点
//        List<Menu> list =roleService.listAllParentMenu();
//        System.out.println("执行成功");
//        //存放树节点信息
//        List<Map<String,Object>> items = new ArrayList<Map<String,Object>>();
//        //当前角色对应的操作
////        List<RoleOperation> rolist = this.roleServiceImpl.getRoleOperationByRoleId(roleId);
//
//        for(Menu node: list){   //第一级遍历，遍历所有的权限分类
//
//            Map<String,Object> item = new HashMap<String,Object>();   //最外层，父节点
//            item.put("id", node.getMenuId());//id属性  ，数据传递
//            item.put("name", node.getName()); //name属性，显示节点名称
//            item.put("isParent", true);//设置为父节点，这样所有最外层节点都是统一的图标，看起来会舒服些
//            //item.put("iconSkin", "diy02");//设置节点的图标皮肤， diy02在zTreeStyle.css中进行设置
//
//            /**
//             * 如果当前节点（权限分类）有对应的操作（权限），添加操作权限作为该节点的子节点
//             */
//            if (node.getPid()!=null){
//                List<Menu> list1 = roleService.listSubMenu(menuId);
//                node.setChildren(list1);
//                Iterator<Menu> it = node.getChildren().iterator();
//                //存放第一层子节点信息
//                List<Map<String,Object>> subitems = new ArrayList<Map<String,Object>>();
//
//                while(it.hasNext()){//对操作进行遍历
//
//                    Map<String,Object> subitem = new HashMap<String,Object>();//第二层
//                    Menu oper = (Menu) it.next();
//                    subitem.put("id", oper.getMenuId()+":oper");//id属性  ，数据传递
//                    subitem.put("name", oper.getName()); //name属性，显示节点名称
//
//                    subitem.put("checked", true);//将此操作选中
//                    subitems.add(subitem);//添加到树的第二层
//                }
//                item.put("children", subitems);//添加第一层子节点
//
//            }
//            items.add(item); //添加到树的第一层
//
//        }
//        JSONArray json = JSONArray.fromObject(items);//转成json格式
//        try {
//            response.getWriter().write(json.toString());
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
       List<Object> list =  roleService.listAllMenu();
        System.out.println(list.toString());
        ResponseUtil.renderJson(response, list.toString());

    }


}