$(function(){
    //设置复选框鼠标事件隐藏和显示
    $(".videoDiv").mouseover(function(){
        $(this).find(".checkDiv").show();
    });
    $(".videoDiv").mouseout(function(){
        $(".cb:checked").parent().show();
        $(".cb:not(:checked)").parent().hide();
    });

});


//观看视频
function viewFile(fileUrl,fileName){
    $.get("/filec/getDownloadUrl.htm",{key:fileUrl},
        function(data){
            //弹出iframe层-多媒体
            layer.open({
                type: 2,
                title: false,
                area: ['800px', '450px'],
                shade: 0.8,
                //maxmin: true,
                //closeBtn: 0,
                //shadeClose: true,
                content: data.downloadUrl
            });
            layer.msg(fileName+'正在播放',{time:2000});
        });
}

//下载视频
function downloadFile(fileUrl,fileName){
    $.get("/filec/getDownloadUrl.htm",{key:fileUrl},
        function(data){

            var ext = fileUrl.substring(fileUrl.lastIndexOf("."));
            var fName = fileName + ext;
            var url = data.downloadUrl;//+"&attname=";
            //window.location=url;

            //document.getElementById('downloadFrame').src=url;

            //alert("success");
           /* $.get(data.downloadUrl,
                function(rep,status,xhr){
                    alert(status);
                },"application/x-please-download-me");*/

            /*var xhr = new XMLHttpRequest();
            if( xhr.overrideMimeType ){
                //overrideMimeType() 必须在 send() 之前设置
                xhr.overrideMimeType("application/octet-stream");
            }
            xhr.open('GET',data.downloadUrl,true);
            xhr.send(null);*/

            var link = document.createElement("a");
            link.download = fName;
            link.href = url;
            link.click();
        });
}

//弹出新增视频的iframe层窗口
function openAddFile(){
    layer.open({
        type: 2,
        title: ['新增视频','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
        shade: 0.5,
        area: ['600px', '305px'],
        content: ['/filec/gotoUpload.htm','no'],
        btn:['提交','取消'],
        yes:function(index, layero){
            /*var body = layer.getChildFrame('body',index);
             var iframeWin = window[layero.find('iframe')[0]['name']];
             body.find("#start_upload").click();*/
        },
        move:false
    });
}

//点击全选按钮可以全选和反选
var isChecked = true;
function selectFiles(){
    if(isChecked){
        $(".cb").prop('checked', isChecked).parent().show();
        isChecked = false;
        //return;
    }else{
        $(".cb").prop('checked', isChecked).parent().hide();
        isChecked = true;
        //return;
    }
    /*$(".cb").prop('checked', isChecked);
    $(".cb:checked").parent().show();*/
}

//点击删除按钮删除选中的文件
function deleteFiles(){
    /*if(!confirm("删除后无法恢复,确定要删除吗？")){
        return;
    }*/
    layer.confirm('删除后无法恢复,确定要删除吗？', {icon: 0, title:'警告',offset:30}, function(index){
        if($(".cb:checked").length<=0){
            layer.alert("请至少选择一项!",{icon:3,title:'提醒',offset:30,shift:6});
            return;
        }
        var formdata = $("#fileMainForm").serializeArray();
        $.ajax({
            type:'POST',
            url:'/filec/delFiles.htm',
            data:formdata,
            cache:false,
            success:function(data,status){
                layer.msg(data.mes, {icon: 1,time:1000,offset:100},function(){
                    window.location.href = "/filec/listFile.htm";
                });
            },
            error:function(xhr,status,ex){
                layer.msg(status+":请求失败!",{icon:5,offset:100,shift:6});
            }
        });
    });
}

//编辑视频前置，查询并弹出编辑iframe页面
function editFilePre(fileId){
    var contentUrl = 'filec/preUpdate.htm?fileId='+fileId;
    layer.open({
        type: 2,
        title: ['编辑视频','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
        shade: 0.5,
        area: ['600px', '407px'],
        content: [contentUrl,'no'],
        btn:['提交','取消'],
        yes:function(index, layero){},
        move:false
    });
}

