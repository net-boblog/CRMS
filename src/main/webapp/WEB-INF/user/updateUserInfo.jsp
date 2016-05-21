<%--
  Created by IntelliJ IDEA.
  User: Huy
  Date: 2016-01-06
  Time: 16:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="keyword" content="">

    <title>更新用户基本信息页面</title>
    <style>
        #preview {
            width: 100px;
            height: 100px;
            overflow: hidden;
        }
        #preview img {
            width: 100%;
            height: 100%;
        }
    </style>

    <jsp:include page="/WEB-INF/reuse/css.jsp"/>

</head>

<body>
<form id="euserForm" encType="multipart/form-data" method="post"><%-- action="/user/update.htm" method="post" onsubmit="return checkForm()">--%>
    <table class="table table-bordered table-striped table-condensed">
        <tbody>
        <tr>
            <th scope="row">上传头像：</th>
            <td> <input type="file" name="file" id="file"/>
                <div id="preview" style="width: 100px;height:100px;border:1px solid gray;"></div>
            </td>

        </tr>

        <tr>
            <th scope="row">邮箱：</th>
            <td><c:set var="acti" scope="page" value="${user.activated}"/>
                <span class="col-xs-7" style="padding: 0px;">
                    <input id="userEmail" class="form-control" type="text" name="userEmail" value="${user.userEmail}" placeholder="email@example.com"
                           <c:if test="${acti == 1}">disabled</c:if>>
                </span>
                <span id="emailSpan" <c:if test="${acti==1}">style="display: none"</c:if> class="col-xs-2"><button id="emailBtn" type="button" class="btn btn-success">绑定</button></span>
                <span id="eSpan" <c:if test="${acti==1}">style="display: none"</c:if>>绑定邮箱<br>可以找回密码!</span>
                <span id="rEmailSpan" <c:if test="${acti==0||acti==null}">style="display: none"</c:if> class="col-xs-2"><button id="rEmailBtn" type="button" class="btn btn-default">重新绑定</button></span>
                <span id="cEmailSpan" style="display: none"><button id="cEmailBtn" type="button" class="btn btn-default">取消</button></span>
            </td>
        </tr>
        <tr>
            <th scope="row">手机号码：</th>
            <td><input id="telPhone" class="form-control" name="telPhone" rows="3"></td>
        </tr>
        <tr>
            <th scope="row"></th>
            <td class="text-right">
                <%--<a class="btn btn-primary" href="javascript:$('#euserForm').submit();" role="button" target="_parent">修改2</a>--%>
                <button id="euserBtn" type="button" class="btn btn-primary">保存</button>&nbsp;
                <button id="fileCance2" type="reset" class="btn btn-default">重置</button>&nbsp;
                <%--<button id="fileCance3" type="button" class="btn btn-default" onclick="window.location='/user/list.htm'">返回</button>--%>
            </td>
        </tr>
        </tbody>
    </table>
</form>

<%--<div id="container">
  <a class="btn btn-default btn-lg " id="pickfiles" href="#" >
    <i class="glyphicon glyphicon-plus"></i>
    <span>选择文件</span>
  </a>
</div>--%>

<!-- js placed at the end of the document so the pages load faster -->
<jsp:include page="/WEB-INF/reuse/layerJs.jsp"/>
<script type="text/javascript" src="/assets/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="/assets/js/plupload/plupload.full.min.js"></script>

<script type="text/javascript">
$(function(){
    //更新用户信息，不包括邮箱
    $("#euserBtn").click(function(){
        if($("#userName").val()==""){
            //$("#userError").text("用户名不x能为空！");
            layer.tips('用户名不能为空!', '#userName',{tips: 4});
            return;
        }

        $.ajaxFileUpload({
            type:"POST",
            url:"/user/upload.htm",
            secureuri :false,
            fileElementId :'file',//file控件id
            dataType : 'json',
            data:{"userEmail":$("#userEmail").val(),"telPhone":$("#telPhone").val(),"userId":${sessionScope.currentUser.userId}},
            cache:false,
            success:function(data,status){
                alert("");
                parent.layer.msg(status+data.mes,{shade:0.5,time:2000},function(){
                    parent.window.location="/user/list.htm";
                });
            },
            error:function(xhr,status,ex){
                alert(status+":更新失败!");
            }
        });
    });

    //绑定邮箱
    $("#emailBtn").click(function(){
        if($("#userEmail").val()==""){
            layer.tips('邮箱不能为空!', '#userEmail',{tips: 1});
            return;
        }
        var userid = $("input[name='userId']").val();
        var useremail = $("input[name='userEmail']").val();
        var emaildata = {userId:userid,userEmail:useremail};
        $.ajax({
            type:"POST",
            url:"/user/bindEmail.htm",
            data:emaildata,
            cache:false,
            success:function(data,status){
                parent.layer.alert(status+data.mes, {icon: 6,title:'激活邮箱',btn:'已激活'},function(index){
                    window.location="/user/preUpdate.htm?userId="+userid;
                    parent.layer.close(index);
                });
            },
            error:function(xhr,status,ex){
                alert(status+":绑定邮箱失败，请重新绑定!");
            }
        });
    });

    //重新绑定邮箱
    $("#rEmailBtn").click(function(){
        $("#userEmail").attr("disabled",false)
        $("#rEmailSpan").hide();
        $("#emailSpan").show();
        $("#cEmailSpan").show();
    });
    //取消按钮
    $("#cEmailBtn").click(function(){
        $("#userEmail").attr("disabled",true);
        $("#emailSpan").hide();
        $("#cEmailSpan").hide();
        $("#rEmailSpan").show();
    });
});

function preview1(file) {
    var img = new Image(), url = img.src = URL.createObjectURL(file)
    var $img = $(img)
    img.onload = function() {
        URL.revokeObjectURL(url)
        $('#preview').empty().append($img)
    }
}
function preview2(file) {
    var reader = new FileReader()
    reader.onload = function(e) {
        var $img = $('<img>').attr("src", e.target.result)
        $('#preview').empty().append($img)
    }
    reader.readAsDataURL(file)
}

/*
 * 判断图片类型
 *
 * @param ths
 *          type="file"的javascript对象
 * @return true-符合要求,false-不符合
 */


$(function() {
    $('[type=file]').change(function(e) {
            if (!/\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/.test(this.value)) {
                alert("图片类型必须是.gif,jpeg,jpg,png中的一种");
                ths.value = "";
                return ;
            }
        var file = e.target.files[0]
        preview1(file)
    })
})

</script>

</body>
</html>
