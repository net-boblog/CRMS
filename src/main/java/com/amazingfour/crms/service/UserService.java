package com.amazingfour.crms.service;


import com.amazingfour.crms.domain.User;

import java.util.List;

/**
 * Created by kennyho on 2016/1/11.
 */
public interface UserService extends BaseService<User,Long> {
    public User login(User user);
    public boolean existUserByName(String userName);
    public boolean defriend(Long id);
    public boolean updatePassword(User user);
    public boolean removeBlack(Long id);
    public User findOneById(User user);
    public boolean existEmail(User user);
    public boolean bindEmail(User user);
    public boolean activated(User user);
    public int existUserEmail(User user);
    public boolean saveEmailMes(User user);
    public List<Integer> findByRoleName(String roleName);
}
