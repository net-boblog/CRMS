/**
 * Created by Dicky on 2016/1/27.
 */
//新增角色弹窗
function openAddRole(){
    layer.open({
        type: 2,
        title: ['新增角色','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
        shade: 0.5,
        area: ['600px', '450px'],
        content: ['/role/preinsert.htm'],
        move:false
    });

}

//编辑角色菜单弹窗
function openEditRole(roleId){
    var roleUrl = "/role/preUpdate.htm?roleId="+roleId;
    layer.open({
        type: 2,
        title: ['编辑角色及权限','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
        shade: 0.5,
        area: ['600px', '450px'],
        content: [roleUrl],
        move:false
    });
}

//编辑角色功能弹窗
function openEditOper(roleId){
    var roleUrl = "/role/preUpdateOper.htm?roleId="+roleId;
    layer.open({
        type: 2,
        title: ['编辑角色及权限','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
        shade: 0.5,
        area: ['600px', '450px'],
        content: [roleUrl],
        move:false
    });
}