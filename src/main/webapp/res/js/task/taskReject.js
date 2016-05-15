/**
 * Created by hmaccelerate on 2016/5/3.
 */
$(function() {

    parent.$(".layui-layer-btn0").click(function(){
        if($("#rejectTextarea").val()==""){
            layer.tips('理由不能为空!', '#rejectTextarea',{tips: 4});
        } else{
            $.get("/task/oneLevelTaskReject.htm", {taskId: Id,fileId:cloudFileId}, function (data, status) {
                if (status == "success") {
                    var taskFinish="#taskFinish"+Id;
                    var taskReject="#taskReject"+Id;
                    var taskUp="#taskUp"+Id;
                    var value=$("#rejectForm").val();
                    console.log(value);
                    $(taskFinish).removeAttr("href");
                    $(taskReject).removeAttr("href");
                    $(taskUp).removeAttr("href");
                    $(taskReject).text("已拒绝");
                    layer.close(index);
                }
            });
        }

    });


});