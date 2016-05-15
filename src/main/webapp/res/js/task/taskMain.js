/**
 * Created by hmaccelerate on 2016/5/2.
 */

/**
 * 领取任务
 * @param Id
 */
function taskClaim(Id,cloudFileId) {
    $.get("/task/taskClaim.htm", {taskId: Id,fileId:cloudFileId}, function (data, status) {
            if (status == "success") {
                var taskCliam="#taskCliam"+Id;
                $(taskCliam).text("已领取");
                $(taskCliam).removeAttr("href");
            }
        }
    );
}


/**
 * 审核通过
 * @param Id
 */
function taskFinish(Id,cloudFileId) {
    $.get("/task/taskFinish.htm", {taskId: Id,fileId:cloudFileId}, function (data, status) {
        if (status == "success") {
            var taskFinish="#taskFinish"+Id;
            var taskReject="#taskReject"+Id;
            var taskUp="#taskUp"+Id;
            $(taskFinish).removeAttr("href");
            $(taskReject).removeAttr("href");
            $(taskUp).removeAttr("href");
            $(taskFinish).text("已通过");

        }
    });
}


/**
 * 审核拒绝,弹出拒绝理由的iframe层窗口
 * @param Id
 * @param cloudFileId
 */
function openTaskReject(Id,cloudFileId){
   layer.open({
        type: 2,
        title: ['审核拒绝','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
        shade: 0.5,
        area: ['600px', '185px'],
        content: ['/task/gotoRejectForm.htm','no'],
        btn:['提交','取消'],
        yes:function(index, layero){
            //父页面通过iframe的id获取页面数据，找到输入框，获取值
            var reseaon=  $("#layui-layer-iframe1").contents().find("#rejectTextarea").val();
            if(reseaon==""){
                layer.tips("请输入理由",$("#layui-layer-iframe1").contents().find("#rejectTextarea"),{tips: 4})
            }else{
                $.post("/task/taskReject.htm", {taskId: Id,fileId:cloudFileId,rejectReseaon:reseaon}, function (data, status) {
                    if (status == "success") {
                        var taskFinish="#taskFinish"+Id;
                        var taskReject="#taskReject"+Id;
                        var taskUp="#taskUp"+Id;
                        $(taskFinish).removeAttr("href");
                        $(taskReject).removeAttr("href");
                        $(taskUp).removeAttr("href");
                        $(taskReject).text("已拒绝");
                        layer.close(index);
                    }
                });
            }


        },
        move:false
    });
}



/**
 * 申请二级审核
 * @param Id
 */
function taskUp(Id) {
    $.get("/task/taskUp.htm", {taskId: Id}, function (data, status) {
        if (status == "success") {
            var taskFinish="#taskFinish"+Id;
            var taskReject="#taskReject"+Id;
            var taskUp="#taskUp"+Id;
            $(taskFinish).removeAttr("href");
            $(taskReject).removeAttr("href");
            $(taskUp).removeAttr("href");
            $(taskUp).text("已申请");
        }
    });
}
/**
 * 查看理由
 * @param Id
 */
function lookReseaon(Id) {
    var  res="";
    $.get("/task/lookReseaon.htm", {instanceId: Id}, function (data, status) {
        if (status == "success") {
           res=data.reseaon;
            layer.alert(res, {icon: 6});
        }
    });

}


function rejectAdjust(Id,fId) {
    $.get("/task/rejectAdjust.htm", {instanceId: Id,fileId:fId}, function (data, status) {
        if (status == "success") {
            var lookReseaon="#lookReseaon"+Id;
            var receiveAdjust="#receiveAdjust"+Id;
            var rejectAdjust="#rejectAdjust"+Id;
            $(lookReseaon).removeAttr("href");
            $(receiveAdjust).removeAttr("href");
            $(rejectAdjust).removeAttr("href");
            $(rejectAdjust).text("已拒绝");
            layer.alert("你的文件已删除，请刷新", {icon: 6});
        }
    });
}

function preAdjust(fileId) {
    var contentUrl = '/task/preAdjust.htm?fileId='+fileId;
    layer.open({
        type: 2,
        title: ['编辑视频','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
        shade: 0.5,
        area: ['600px', '307px'],
        content: [contentUrl,'no'],
        btn:['提交','取消'],
        yes:function(index, layero){},
        move:false
    });
}