package com.amazingfour.crms.domain;

import java.util.Date;

/**
 * Created by kennyho on 2016/1/11.
 */
public class User {
    private Long userId;
    private  Role role;
    private String userName;
    private String password;
    private String userDescript;
    private Byte userState;

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserDescript() {
        return userDescript;
    }

    public void setUserDescript(String userDescript) {
        this.userDescript = userDescript;
    }

    public Byte getUserState() {
        return userState;
    }

    public void setUserState(Byte userState) {
        this.userState = userState;
    }

}