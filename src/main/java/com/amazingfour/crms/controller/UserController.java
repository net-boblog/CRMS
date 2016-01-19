package com.amazingfour.crms.controller;

import com.alibaba.fastjson.JSONObject;
import com.amazingfour.common.utils.PageUtil;
import com.amazingfour.common.utils.ResponseUtil;
import com.amazingfour.crms.domain.Role;
import com.amazingfour.crms.domain.User;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by kennyho on 2016/1/11.
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService userService;
    @Resource
    private RoleService roleService;

    //管理员登录
    @RequestMapping("/login")
    public String login(User user,HttpServletRequest request){
        User resultUser = userService.login(user);
        if(resultUser!=null){
            byte userState=resultUser.getUserState();
            if(userState==1){
                request.setAttribute("user", user);
                request.setAttribute("blacklist","该用户已被拉黑，请联系管理员！");
                return "forward:/login.jsp";
            }else {
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", resultUser);
                return "/index";
            }
        }
        else {
            request.setAttribute("user", user);
            request.setAttribute("errorMsg", "用户名或密码错误");
            return "forward:/login.jsp";
        }
    }

    //从数据库中获取所有用户信息
    @RequestMapping("/list")
    public ModelAndView list(
            @RequestParam(value = "page", required = false) String page,
            User user, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        HttpSession session = request.getSession();

        int pageSize = 4; // 页容量

        if (page == null || page == "") {
            page = "1";
            session.setAttribute("user", user);
        } else {
            user = (User) session.getAttribute("user");
        }
        String userName=user.getUserName();
        Byte userState=user.getUserState();
        Map<String, Object> map = new HashMap<String, Object>(); // 使用Map传值到mapper处理
        map.put("start", (Integer.parseInt(page) - 1) * pageSize); // 起始记录
        map.put("size", pageSize);
        map.put("userName",userName);
        map.put("userState",userState);

        List<User> userList = userService.find(map); //查询

        int total = userService.count(user);

        Map<String,Object> params =new HashMap<String,Object>();
        params.put("userName",userName);//传入搜素字段
        params.put("userState",userState);


        String pageCode = PageUtil.getPagation("/user/list.htm",params, total, Integer.parseInt(page), pageSize);
        mav.addObject("pageCode", pageCode);
        mav.addObject("userList", userList);
        mav.setViewName("/index");
        return mav;
    }

    //删除用户
    @RequestMapping("/delete")
    public void delete(@RequestParam(value = "userId") String userId,
                       HttpServletResponse response) {
        JSONObject result = new JSONObject();

        if (userService.delete(Long.parseLong(userId))){  //删除管理员
            result.put("msg", "success");
        }
        try {
            ResponseUtil.write(result, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //用户添加前置
    @RequestMapping("/preinsert")
    public ModelAndView presave() {
        ModelAndView mav = new ModelAndView();
        Map<String, Object> map = new HashMap<String, Object>();
        List<Role> roleList = roleService.find(map); //查询出角色表的内容，方便页面取出角色名
        mav.addObject("roleList",roleList);
        mav.setViewName("user/addUser");//跳到指定页面
        return mav;
    }

    /**
     * 新增用户
     * @param
     * @return
     */
    @RequestMapping("/insert")
    public String insert(User user,HttpSession session) {

        if (userService.existUserByName(user.getUserName())==true){//用户名不能相同
            session.setAttribute("user",user);
            session.setAttribute("errorMsg2","保存失败，该用户已存在");
            return "redirect:/user/preinsert.htm";
        }

           userService.insert(user);
           return "redirect:/user/list.htm";
    }
    //用户更新前置
    @RequestMapping("/preUpdate")
    public ModelAndView preUpdate(@RequestParam(value = "userId") String userId) {
        ModelAndView mav = new ModelAndView();

        Map<String, Object> map = new HashMap<String, Object>();
        List<Role> roleList = roleService.find(map); //查询出角色表的内容，方便页面取出角色名
        mav.addObject("roleList",roleList);

        User user=new User();
        user = userService.findById(Long.parseLong(userId));//根据Id找出所选择用户的所有信息
        mav.addObject("user",user);
        mav.addObject("mainPage", "user/updateUser.jsp");
        mav.setViewName("user/updateUser");
        return mav;
    }

    //管理员更新
    @RequestMapping("/update")
    public String update(User user, HttpServletResponse response) {
        userService.update(user);
        return "redirect:/user/list.htm";
    }

    //拉黑用户，将状态属性设置为1
    @RequestMapping("/defriend")
    public void defriend(@RequestParam(value = "userId") String userId,
                       HttpServletResponse response) {
        JSONObject result = new JSONObject();

        if (userService.defriend(Long.parseLong(userId))) {  //根据id将状图字段改为1，即拉黑
            result.put("msg", "ok");
        }
        try {
            ResponseUtil.write(result, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }



}