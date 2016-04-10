package com.amazingfour.crms.controller;

import com.alibaba.fastjson.JSONObject;
import com.amazingfour.common.utils.Encrypt;
import com.amazingfour.common.utils.PageUtil;
import com.amazingfour.common.utils.ResponseUtil;
import com.amazingfour.crms.domain.Menu;
import com.amazingfour.crms.domain.Role;
import com.amazingfour.crms.domain.User;
import com.amazingfour.crms.service.MenuService;
import com.amazingfour.crms.service.RoleService;
import com.amazingfour.crms.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;
import java.util.Enumeration;
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
    @Resource
    private MenuService menuService;

    //管理员登录
    @RequestMapping("/login")
    public String login(User user,HttpServletRequest request){

        String username=user.getUserName();//获取页面填入的用户名
        String password=user.getPassword();//获取页面填入的密码
        String s= Encrypt.Encrypt_md5(password);//将页面密码转化为密文
        user.setPassword(s);
        User resultUser = userService.login(user);
        if(resultUser!=null){//判断是否从数据库里查出了数据
            byte userState=resultUser.getUserState();
            if(userState==1){
                request.setAttribute("user", user);
                request.setAttribute("blacklist","该用户已被拉黑，请联系管理员！");
                return "forward:/login.jsp";
            }else {
                HttpSession session = request.getSession();
                /*
                    1.将用户存入session
                 */
                session.setAttribute("currentUser", resultUser);
                User u  =userService.findById(resultUser.getUserId());
                Role role = u.getRole();
                /*
                    2.将角色存入session
                 */
                session.setAttribute("role",role);
                List<Menu> menuList = menuService.getMenuById(Long.valueOf(role.getRoleId()));//查询到List<Menu>集合
//                for(Menu m : menu){
//                    System.out.println(m.getName());
//                }
                /*
                    3.将菜单存入session
                 */
                session.setAttribute("menuList",menuList);


                return "redirect:/user/list.htm";
                /*if(resultUser.getUserName().equals(username)&&resultUser.getPassword().equals(s)){//判断数据库获得的数据与页面输入的数据是否相等
                    HttpSession session = request.getSession();
                    session.setAttribute("currentUser", resultUser);
                    return "redirect:/user/list.htm";
                }
                else{
                    return null;
                }*/
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
    public void insert(User user,HttpSession session,HttpServletResponse response) {
        JSONObject obj = new JSONObject();
        if (userService.existUserByName(user.getUserName())){//用户名不能相同
            session.setAttribute("user",user);
            //session.setAttribute("errorMsg2","保存失败，该用户已存在");
            obj.put("usertip",0);
            obj.put("mes","保存失败，该用户已存在!");
            //return "redirect:/user/preinsert.htm";
        }else {

            user.setPassword(Encrypt.Encrypt_md5(user.getPassword()));
            userService.insert(user);
            obj.put("usertip", 1);
            obj.put("mes", "保存成功!");
            //return "redirect:/user/list.htm";
        }
        ResponseUtil.renderJson(response, obj.toString());
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

    //用户更新
    @RequestMapping("/update")
    public void update(User user, HttpServletResponse response) {
        JSONObject obj = new JSONObject();
        user.setPassword(Encrypt.Encrypt_md5(user.getPassword()));
        userService.update(user);
        //return "redirect:/user/list.htm";
        obj.put("mes","更新成功!");
        ResponseUtil.renderJson(response,obj.toString());
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
    //解除用户黑名单，将状态属性设置为0
    @RequestMapping("/removeBlack")
    public void removeBlack(@RequestParam(value = "userId") String userId,
                         HttpServletResponse response) {
        JSONObject result = new JSONObject();

        if (userService.removeBlack(Long.parseLong(userId))) {  //根据id将状图字段改为1，即拉黑
            result.put("msg", "suc");
        }
        try {
            ResponseUtil.write(result, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    //注销用户
    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/login.jsp";
    }

    //修改密码前置
    @RequestMapping("/passPre")
    public String passPre(){
        return "user/updatePassword";
    }

    //修改密码
    @RequestMapping("/updatepassword")
    public void updatePassword(User user, HttpServletResponse response,HttpServletRequest request,String password1,String password2) {
        JSONObject obj = new JSONObject();
        HttpSession session= request.getSession();//获取session实例
        User currentUser =  (User)session.getAttribute("currentUser");
        String userName=currentUser.getUserName();
        String oldPassword=currentUser.getPassword();//获取登录时的密码
        String inputPassword=Encrypt.Encrypt_md5(user.getPassword());//获取原密码并转化为加密形式
       if(oldPassword.equals(inputPassword)){//原密码与输入密码的比较
           if (password1.equals(password2)){//密码与确认密码的比较
               currentUser.setPassword(Encrypt.Encrypt_md5(password1));
               userService.updatePassword(currentUser);
               obj.put("mes","修改密码成功,请重新登录!");

           }else {
               obj.put("errorMsg", "输入密码不一致！请重新输入...");
           }
       } else {
           obj.put("error", "原密码输入错误！请重新输入...");
       }
        ResponseUtil.renderJson(response,obj.toString());
    }




}
