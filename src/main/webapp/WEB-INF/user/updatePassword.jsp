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

    <title>更新密码页面</title>
    <jsp:include page="/WEB-INF/reuse/css.jsp"/>

</head>

<body>
<form id="passForm"><%-- action="/user/update.htm" method="post" onsubmit="return checkForm()">--%>
    <table class="table table-bordered table-striped table-condensed">
        <tbody>
        <tr>
            <th scope="row">原密码：</th>
            <td><input id="pass" class="form-control" type="password" name="password" placeholder="请输入原密码">
                <div>
                    <font color="red" id="error"></font>
                </div>
            </td>

        </tr>

            <th scope="row">新密码：</th>
            <td><input id="pass1" class="form-control" type="password" name="password1" placeholder="请输入新密码" required></td>
        </tr>
        <tr>
            <th scope="row">确认密码：</th>
            <td><input id="pass2" class="form-control" type="password" name="password2" placeholder="两次密码须一致"　required></td>
            <div>
                <font color="red" id="errorMsg"></font>
            </div>
        </tr>
        <tr>
            <th scope="row"></th>
            <td class="text-right">
                <%--<a class="btn btn-primary" href="javascript:$('#euserForm').submit();" role="button" target="_parent">修改2</a>--%>
                <button id="euserBtn" type="button" class="btn btn-primary">修改</button>&nbsp;
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
<script type="text/javascript" src="/assets/js/plupload/plupload.full.min.js"></script>

<script type="text/javascript">
    $(function(){
        $("#euserBtn").click(function(){
            if($("#pass").val()==""){
                layer.tips('原密码不能为空!', '#pass',{tips: 4});
            }
            if($("#pass1").val()==""){
                layer.tips('新密码不能为空!', '#pass1',{tips: 4,tipsMore:true});
            }
            if($("#pass2").val()=="") {
                layer.tips('密码不能为空!', '#pass2', {tips: 4, tipsMore: true});
            }else{
                var userdata = $("#passForm").serializeArray();
                $.ajax({
                    type:"POST",
                    url:"/user/updatepassword.htm",
                    data:userdata,
                    cache:false,
                    success:function(data,status){
                        if(data.error!=undefined){
                            layer.tips(data.error, '#pass', {tips: [3, 'red'], tipsMore: true});
                        }
                        if(data.errorMsg!=undefined){
                            layer.tips(data.errorMsg, '#pass1', {tips: [3, 'red'], tipsMore: true});
                        }
                        if(data.mes!=undefined){
                            parent.layer.alert(data.mes,{icon:1},function(){
                                parent.window.location="/user/logout.htm";
                            });
                        }
                    },
                    error:function(xhr,status,ex){
                        alert(status+":更新失败!");
                    }
                });
            }
        });
    });


    /*    function checkForm() {
     var userName = $("#userName").val();
     if (userName == null || userName == "") {
     $("#error").html("用户名不能为空！");
     return false;
     }

     if (confirm("确认保存?")) {
     return true;
     } else {
     return false;
     }
     }*/
</script>

</body>
</html>
