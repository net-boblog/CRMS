package com.amazingfour.crms.dao;

import com.amazingfour.crms.domain.Role;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by kennyho on 2016/1/13.
 */
@Repository("roleDao")
public interface RoleDao extends BaseDao<Role,Long> {

   // public List<Role> findByUserId(Long userId);

}
