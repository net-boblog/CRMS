//新增用户弹窗
function openAddUser(){
    layer.open({
        type: 2,
        title: ['新增用户','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
        shade: 0.5,
        area: ['600px', '305px'],
        content: ['/user/preinsert.htm','no'],
        move:false
    });
}

//编辑用户弹窗
function openEditUser(userId){
    var userUrl = "/user/preUpdate.htm?userId="+userId;
    layer.open({
        type: 2,
        title: ['编辑用户','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
        shade: 0.5,
        area: ['600px', '305px'],
        content: [userUrl,'no'],
        move:false
    });
}