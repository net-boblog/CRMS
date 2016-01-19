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

    <title>更新用户页面</title>
    <jsp:include page="/WEB-INF/reuse/css.jsp"/>

</head>

<body>
<form id="euserForm"><%-- action="/user/update.htm" method="post" onsubmit="return checkForm()">--%>
    <table class="table table-bordered table-striped table-condensed">
        <tbody>
        <tr>
            <th scope="row">用户名：</th>
            <td><input id="userName" class="form-control" type="text" name="userName" value="${user.userName}">
                <div>
                    <font color="red" id="error"></font>
                </div>
            </td>

        </tr>
        <tr>
            <th scope="row">角色：</th>
            <td>
                <div id="container">
                    <select name="role.roleId" class="form-control" style="width:152px">
                        <option value="${user.role.roleId}" selected="selected">${user.role.roleName}</option>
                        <c:forEach var="b" items="${roleList}" varStatus="status">
                            <option value="${b.roleId}">${b.roleName}</option>
                        </c:forEach>
                    </select>
                </div>
            </td>
        </tr>
        <tr>
            <input type="hidden" name="userId" value="${user.userId}"/>
            <th scope="row">密码：</th>
            <td><input id="password" class="form-control" type="text" name="password" value="${user.password}"  required></td>
        </tr>
        <tr>
            <th scope="row">描述：</th>
            <td><textarea id="" class="form-control" name="userDescript" rows="3">${user.userDescript}</textarea></td>
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
        if($("#userName").val()==""){
            //$("#userError").text("用户名不能为空！");
            layer.tips('用户名不能为空!', '#userName',{tips: 4});
            return;
        }
        var userdata = $("#euserForm").serializeArray();
        $.ajax({
            type:"POST",
            url:"/user/update.htm",
            data:userdata,
            cache:false,
            success:function(data,status){
                parent.layer.msg(status+data.mes,{shade:0.5,time:2000},function(){
                    parent.window.location="/user/list.htm";
                });
            },
            error:function(xhr,status,ex){
                alert(status+":更新失败!");
            }
        });
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
