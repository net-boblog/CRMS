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
            <h3><i class="fa fa-angle-right"></i>用户管理</h3>

            <div class="row mt">
                <div class="col-lg-12">
                    <div class="col-lg-4">
                        <button type="button" class="btn btn-theme02" onclick="openAddUser()"><i class="glyphicon glyphicon-plus"></i>新增</button>
                    </div>
                    <div class="col-lg-8">
                        <div class="pull-right">
                            <form class="form-inline" role="form" action="/user/list.htm" method="post">
                                <div class="form-group">
                                    <label class="control-label" for="userNameSearchId">用户名：</label>
                                    <input type="text" name="userName" class="form-control" id="userNameSearchId" placeholder="">
                                </div>
                                <div class="form-group">
                                    <label class="control-label" for="userStateId">是否黑名单：</label>
                                    <select name="userState" class="form-control" id="userStateId">
                                        <option></option>
                                        <option value="0">否</option>
                                        <option value="1">是</option>
                                    </select>
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
                        <th><center>用户名 </center></th>
                        <th><center>角色 </center></th>
                        <th><center>用户描述 </center></th>
                        <th><center>是否黑名单 </center></th>
                        <th><center>操作</center></th>

                    </tr>
                    <c:forEach var="b" items="${userList}" varStatus="status">
                        <tr>
                            <td width="50px"><center>${status.index+1 } </center></td>
                            <td><center>${b.userName } </center></td>
                            <td><center>${b.role.roleName } </center></td>
                            <td width="500px">${b.userDescript } </td>
                            <td width="100px"><center>
                                <c:choose>
                                  <c:when test="${b.userState==1}">是</c:when>
                                  <c:otherwise>否</c:otherwise>
                                </c:choose>
                            </center> </td>
                            <td width="180px">
                                 <center>
                                     <div style="text-align:center">
                                      <table width="100%">
                                         <tr>
                                             <td> <a href="javascript:openEditUser('${b.userId.toString()}')">编辑</a></td>
                                             <td> <a href="javascript:del('${b.userId}')">删除</a></td>
                                             <td> <a href="javascript:defriend('${b.userId}')">拉黑</a></td>
                                             <td><a href="javascript:removeBlack('${b.userId}')">解除</a></td>
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
<script>$("#userMainId").attr({"class" : "active"});</script>
<!--引入此页面的js-->
<script type="text/javascript" src="/res/js/user/index.js"></script>
</body>
</html>

