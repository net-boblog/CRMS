<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">
    <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

    <title>CRMS主页</title>

    <!-- 引入全局css样式 -->
    <jsp:include page="/WEB-INF/reuse/css.jsp"/>


    <script type="text/javascript">
        function del(userId) {
            if (confirm("确定要删除这条记录吗?")) {
                $
                        .get(
                        "${pageContext.request.contextPath}/user/delete.htm",
                        {
                            userId : userId
                        },
                        function(data) {

                            var data = eval("(" + data + ")"); //将data 转换成JS对象，这样才可以使用data.msg这种形式

                            if ("success" == data.msg) {
                                alert("删除成功!");
                                window.location.href = "${pageContext.request.contextPath}/user/list.htm";
                            } else {
                                alert(data.error);
                            }
                        });
            }
        }
        function defriend(userId) {
            if (confirm("你确定拉黑用户吗?")) {
                $
                        .get(
                        "${pageContext.request.contextPath}/user/defriend.htm",
                        {
                            userId : userId
                        },
                        function(data) {

                            var data = eval("(" + data + ")"); //将data 转换成JS对象，这样才可以使用data.msg这种形式

                            if ("ok" == data.msg) {
                                alert("拉黑成功!");
                                window.location.href = "${pageContext.request.contextPath}/user/list.htm";
                            } else {
                                alert(data.error);
                            }
                        });
            }
        }
        function removeBlack(userId) {
            if (confirm("你要解除该用户黑名单?")) {
                $
                        .get(
                        "${pageContext.request.contextPath}/user/removeBlack.htm",
                        {
                            userId : userId
                        },
                        function(data) {

                            var data = eval("(" + data + ")"); //将data 转换成JS对象，这样才可以使用data.msg这种形式

                            if ("suc" == data.msg) {
                                alert("解除黑名单成功!");
                                window.location.href = "${pageContext.request.contextPath}/user/list.htm";
                            } else {
                                alert(data.error);
                            }
                        });
            }
        }
    </script>
</head>

<body>

<section id="container">
    <!-- **********************************************************************************************************************************************************
    TOP BAR CONTENT & NOTIFICATIONS
    *********************************************************************************************************************************************************** -->
    <!--header-->
    <jsp:include page="/WEB-INF/reuse/header.jsp"/>

    <!-- **********************************************************************************************************************************************************
    MAIN SIDEBAR MENU
    *********************************************************************************************************************************************************** -->
    <!--sidebar-->
    <jsp:include page="/WEB-INF/reuse/sidebar.jsp"/>

    <!-- **********************************************************************************************************************************************************
    MAIN CONTENT
    *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper site-min-height">
            <h3><i class="fa fa-angle-right"></i>角色管理</h3>

            <div class="row mt">
                <div class="col-lg-12">
                    <div class="col-lg-4">
                        <button type="button" class="btn btn-theme02" onclick="openAddRole()"><i class="glyphicon glyphicon-plus"></i>新增</button>
                    </div>
                    <div class="col-lg-8">
                        <div class="pull-right">
                            <form class="form-inline" role="form" action="/role/list.htm" method="post">

                                <div class="form-group">
                                    <label class="control-label" for="roleNameId">角色名：</label>
                                    <input type="text" name="roleName" class="form-control" id="roleNameId" placeholder="">
                                </div>
                                <button type="submit" class="btn btn-theme">搜索<i class="glyphicon glyphicon-search"></i></button>
                            </form>
                        </div>
                    </div><!-- /form-panel -->
                </div>
            </div>

            <div class="row mt">
                <div class="col-lg-12">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th><center>序号 </center></th>
                            <th><center>角色名 </center></th>
                            <th><center>说明 </center></th>
                            <th><center>权限 </center></th>
                            <th><center>操作</center></th>

                        </tr>
                        <c:forEach var="role" items="${roleList}" varStatus="status">
                            <tr>
                                <td width="50px"><center>${status.count } </center></td>
                                <td><center>${role.roleName } </center></td>
                                <td><center>${role.roleDescript} </center></td>
                                <td style="WORD-WRAP: break-word"  width="500px">
                                    <c:forEach var="menu" items="${role.menuList}" varStatus="status">
                                    ${menu.name},
                                    </c:forEach></td>

                                <td width="180px">
                                    <center>
                                        <div style="text-align:center">
                                            <table width="100%">
                                                <tr>
                                                    <td> <a href="javascript:openEditUser('${role.roleId.toString()}')"> 编辑及权限</a></td>
                                                    <td> <a href="javascript:del('${role.roleId}')">删除</a></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </center>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>

                    <div class="row centered">
                        <nav>
                            <ul class="pagination">${pageCode }
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </section>
        <! --/wrapper -->
    </section>
    <!-- /MAIN CONTENT -->

    <!--main content end-->

    <!--footer start-->
    <jsp:include page="/WEB-INF/reuse/footer.jsp"/>
    <!--footer end-->
</section>

<!-- js placed at the end of the document so the pages load faster -->
<jsp:include page="/WEB-INF/reuse/js.jsp"/>
<!-- 让侧边栏菜单高亮 -->
<script>$("#roleMainId").attr({"class" : "active"});</script>
<!--引入此页面的js-->
<script type="text/javascript" src="/res/js/role/roleMain.js"></script>
</body>
</html>

