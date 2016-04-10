package com.amazingfour.crms.service.impl;

import com.amazingfour.crms.dao.UserDao;
import com.amazingfour.crms.domain.User;
import com.amazingfour.crms.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by kennyho on 2016/1/11.
 */
@Service("userService")
public class UserServiceImpl extends AbstractService<User,Long> implements UserService{
    @Resource
    private UserDao userDao;

    @Resource
    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
        super.setBaseDao(this.userDao);
    }

    //用户登录
    public User login(User user) {

        return userDao.login(user);
    }
    //验证用户是否存在
    public boolean existUserByName(String userName) {
        int i = userDao.existUserByName(userName);
        if (i > 0) {
            return true;
        } else {
            return false;
        }
    }
    //拉黑用户
    public boolean defriend(Long id){
        if(userDao.defriend(id)>0){
             return true;
        }
        else{
            return false;
        }
    }
    //确认密码是否存在
    public boolean updatePassword(User user){
        if(userDao.update(user)>0){
            return true;
        }else{
            return false;
        }
    }
    //解除用户黑名单
    public boolean removeBlack(Long id){
        if(userDao.removeBlack(id)>0){
            return true;
        }
        else{
            return false;
        }
    }



}
