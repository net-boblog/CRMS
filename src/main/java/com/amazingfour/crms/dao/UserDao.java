package com.amazingfour.crms.dao;

import com.amazingfour.crms.domain.User;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by kennyho on 2016/1/11.
 */
@Repository("userDao")
public interface UserDao extends BaseDao<User,Long>{
    public User login(User user);
    public int existUserByName(String userName);
    public int defriend(Long id);
}
