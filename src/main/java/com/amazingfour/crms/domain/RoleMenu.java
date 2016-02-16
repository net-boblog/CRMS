package com.amazingfour.crms.domain;

/**
 * Created by Dicky on 2016/1/21.
 */
/**
 * 角色与菜单的中间表
 *
 * 这里精确到菜单下面的url链接，也就是同一个链接，不一样的角色，
 * 可以访问到该菜单的不一样url链接
 * @author luohong
 * @date 2014-12-25
 * @email 846705189@qq.com
 * */
public class RoleMenu {

    private Long roleId;  //角色id
    private Long menuId;  //菜单id
    private Menu menu;
    private Role role;

    public Menu getMenu() {
        return menu;
    }

    public void setMenu(Menu menu) {
        this.menu = menu;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }


    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Long getMenuId() {
        return menuId;
    }

    public void setMenuId(Long menuId) {
        this.menuId = menuId;
    }

    @Override
    public String toString() {
        return "RoleMenu{" +
                "roleId='" + roleId + '\'' +
                ", menuId='" + menuId + '\'' +
                ", menu=" + menu +
                ", role=" + role +
                '}';
    }
}
