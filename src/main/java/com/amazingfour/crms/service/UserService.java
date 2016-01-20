package com.amazingfour.crms.service;


import com.amazingfour.crms.domain.User;

/**
 * Created by kennyho on 2016/1/11.
 */
public interface UserService extends BaseService<User,Long> {
    public User login(User user);
    public boolean existUserByName(String userName);
    public boolean defriend(Long id);
    public boolean updatePassword(User user);
    public boolean removeBlack(Long id);
}
