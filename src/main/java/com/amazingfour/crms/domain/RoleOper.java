package com.amazingfour.crms.domain;

/**
 * Created by Dicky on 2016/3/27.
 */
public class RoleOper {
    private Long operationId;  //角色id
    private Long roleId;  //菜单id
    private Operation menu;
    private Role role;

    public Long getOperationId() {
        return operationId;
    }

    public void setOperationId(Long operationId) {
        this.operationId = operationId;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Operation getMenu() {
        return menu;
    }

    public void setMenu(Operation menu) {
        this.menu = menu;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
}
