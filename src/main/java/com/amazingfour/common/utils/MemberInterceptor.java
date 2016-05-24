package com.amazingfour.common.utils;

import java.net.URLEncoder;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.amazingfour.crms.domain.Menu;
import com.amazingfour.crms.domain.Operation;
import com.amazingfour.crms.domain.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
/**
 * Created by Dicky on 2016/5/23.
 */
/**
 *
 */

public class MemberInterceptor implements HandlerInterceptor {

    public final static String SEESION_USER = "currentUser";
    public final static String SEESION_MENU = "menuList";
    public final static String SEESION_OPER = "operList";
    private List<String> excludedUrls;

    public List<String> getExcludedUrls() {
        return excludedUrls;
    }

    public void setExcludedUrls(List<String> excludedUrls) {
        this.excludedUrls = excludedUrls;
    }

    /*
         * (non-Javadoc)
         *
         * @see org.springframework.web.servlet.HandlerInterceptor#afterCompletion(javax.servlet.http.HttpServletRequest,
         * javax.servlet.http.HttpServletResponse, java.lang.Object, java.lang.Exception)
         */
    public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2,
                                Exception arg3) throws Exception {
        // TODO Auto-generated method stub

    }

    /*
     * (non-Javadoc)
     *
     * @see org.springframework.web.servlet.HandlerInterceptor#postHandle(javax.servlet.http.HttpServletRequest,
     * javax.servlet.http.HttpServletResponse, java.lang.Object, org.springframework.web.servlet.ModelAndView)
     */
    public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2,
                           ModelAndView arg3) throws Exception {
        // TODO Auto-generated method stub

    }

    /*
     * (non-Javadoc)
     * 拦截mvc.xml配置的/member/**路径的请求
     * @see org.springframework.web.servlet.HandlerInterceptor#preHandle(javax.servlet.http.HttpServletRequest,
     * javax.servlet.http.HttpServletResponse, java.lang.Object)
     */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) throws Exception {
        //这里配置放行的路径
        excludedUrls.add("/user/preUserInfo.htm");
        excludedUrls.add("/user/login.htm");
        excludedUrls.add("/user/logout.htm");
        excludedUrls.add("/code.htm");
        excludedUrls.add("/role/updateRole.htm");
        excludedUrls.add("/role/updateOper.htm");
        excludedUrls.add("/role/updateOperByMenu.htm");
        excludedUrls.add("/role/updateMenu.htm");

        String requestUri = request.getRequestURI();
        for (String url : excludedUrls) {
            if (requestUri.endsWith(url)) {
                return true;
            }
        }
        //请求的路径
        String contextPath=request.getContextPath();
        String  url=request.getServletPath().toString();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(SEESION_USER);
        List<Menu> menuList = (List<Menu>) session.getAttribute(SEESION_MENU);
        List<Operation> operList = (List<Operation>) session.getAttribute(SEESION_OPER);
        //这里可以根据session的用户来判断角色的权限，根据权限来重定向不同的页面，简单起见，这里只是做了一个重定向
        if (user==null||user.equals("")) {
            //被拦截，重定向到login界面
            response.sendRedirect(contextPath+"/user/relogin.htm");
            return false;
        }
        for(Menu menu : menuList){
            if(requestUri.endsWith(menu.getUrl())){
                return true;
            }
        }
        if(operList!=null) {
            for (Operation oper : operList) {
                if (requestUri.endsWith(oper.getAction())) {
                    return true;
                }
            }
        }
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write("您没有访问该地址的权限！");
            return false;
    }

}