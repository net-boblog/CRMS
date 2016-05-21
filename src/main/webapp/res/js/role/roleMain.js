/**
 * Created by Dicky on 2016/1/27.
 */
//新增角色弹窗
function openAddRole(url){
    layer.open({
        type: 2,
        title: ['新增角色','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
        shade: 0.5,
        area: ['600px', '450px'],
        content: [url],
        move:false
    });

}

//编辑角色菜单弹窗
function openEditRole(roleId,url){
    var roleUrl = ""+url+"?roleId="+roleId;
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
function openEditOper(roleId,url){
    var roleUrl = ""+url+"?roleId="+roleId;
    layer.open({
        type: 2,
        title: ['编辑角色及权限','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
        shade: 0.5,
        area: ['600px', '450px'],
        content: [roleUrl],
        move:false
    });
}