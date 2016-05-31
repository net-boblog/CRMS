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

    <title>添加用户页面</title>

        <jsp:include page="/WEB-INF/reuse/css.jsp"/>
</head>

<body>
<form id="auserForm"> <%--action="/user/insert.htm" method="post" onsubmit="return checkForm()">--%>
    <table class="table table-bordered table-striped table-condensed">
        <tbody>
        <tr>
            <th scope="row">用户名：</th>
            <td><input id="userName" class="form-control" type="text" name="userName" value="" placeholder="请输入用户名" required>
                <div>
                    <span id="userError"></span>
                    <%--<span font color="red">${errorMsg2}</span>--%>
                </div>
            </td>

        </tr>
        <tr>
            <th scope="row">角色：</th>
            <td>
                <div id="container">
                    <select id="roleSel" name="role.roleId" class="form-control" style="width:152px">
                        <option value="">------</option>
                        <c:forEach var="b" items="${roleList}" varStatus="status">
                        <option value="${b.roleId}">${b.roleName}</option>
                    </c:forEach>
                    </select>
                </div>
            </td>
        </tr>
        <tr>
            <th scope="row">密码：</th>
            <td><input id="passwordId" class="form-control" type="password" name="password" value="" placeholder="请输入密码" required></td>
        </tr>
        <tr>
            <th scope="row">描述：</th>
            <td><textarea id="fileIntroId" class="form-control" name="userDescript" rows="3" placeholder="请输入用户描述"></textarea></td>
        </tr>
        <tr>
            <th scope="row"></th>
            <td class="text-right">
                <button id="auserBtn" type="button" class="btn btn-primary">提交</button>&nbsp;
                <button id="fileCance2" type="reset" class="btn btn-default">重置</button>&nbsp;
                <%--<button id="fileCance3" type="button" class="btn btn-default" onclick="window.location='/user/list.htm'">返回</button>--%>
            </td>
        </tr>
        </tbody>
    </table>
</form>

<!-- js placed at the end of the document so the pages load faster -->
<jsp:include page="/WEB-INF/reuse/layerJs.jsp"/>

<script type="text/javascript">
$(function(){
    $("#auserBtn").click(function(){
        if($("#userName").val()==""){
            layer.tips('用户名不能为空!', '#userName',{tips: 4});
            return;
        }
        if($("#roleSel").val()==""){
            layer.tips('请选择角色!', '#roleSel',{tips: 4,tipsMore:true});
            return;
        }
        if($("#passwordId").val()==""){
            layer.tips('密码不能为空!', '#passwordId',{tips: 4,tipsMore:true});
        }else {
            var userdata = $("#auserForm").serializeArray();
            $.ajax({
                type: "POST",
                url: "/user/insert.htm",
                data: userdata,
                cache: false,
                success: function (data, status) {
                    var utip = data.usertip;
                    if (utip == 0) {
                        //$("#userError").text(reData.mes);
                        layer.tips(data.mes, '#userName', {tips: [3, 'red'], tipsMore: true});
                    } else if (utip == 1) {
                        parent.layer.msg(status + data.mes, {shade: 0.1, time: 2000}, function () {
                            parent.window.location = "/user/list.htm";
                        });
                    } else {
                        //do nothing
                        alert("do nothing");
                    }
                },
                error: function (xhr, status, ex) {
                    alert(status + ":保存失败!");
                }
            });
        }
    });
});



/*    function checkForm() {
        var userName = $("#userName").val();
        if (userName == null || userName == "") {
            $("#userError").text("用户名不能为空！");
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
