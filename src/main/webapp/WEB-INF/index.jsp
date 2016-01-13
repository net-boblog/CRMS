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

    <title>DASHGUM - Bootstrap Admin Template</title>

    <!-- Bootstrap core CSS -->
    <link href="/assets/css/bootstrap.css" rel="stylesheet">
    <!--external css-->
    <link href="/assets/font-awesome/css/font-awesome.css" rel="stylesheet"/>

    <!-- Custom styles for this template -->
    <link href="/assets/css/style.css" rel="stylesheet">
    <link href="/assets/css/style-responsive.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->


    <script type="text/javascript">
        function del(userId) {
            if (confirm("确定要删除这条记录吗?")) {
                $
                        .get(
                        "/user/delete.htm",
                        {
                            userId : userId
                        },
                        function(data) {

                            var data = eval("(" + data + ")"); //将data 转换成JS对象，这样才可以使用data.msg这种形式

                            if ("success" == data.msg) {
                                alert("删除成功!");
                                window.location.href = "/user/list.htm";
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
    <jsp:include page="reuse/header.jsp"/>

    <!-- **********************************************************************************************************************************************************
    MAIN SIDEBAR MENU
    *********************************************************************************************************************************************************** -->
    <!--sidebar-->
    <jsp:include page="reuse/sidebar.jsp"/>

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
                        <button type="button" class="btn btn-theme02"><i class="glyphicon glyphicon-plus"></i>新增</button>
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

            <div>
                <table class="">
                    <tr>
                        <th>序号</th>
                        <th>编号</th>
                        <th>用户名</th>
                        <th>角色</th>
                        <th>是否黑名单</th>
                        <th>操作</th>

                    </tr>
                    <c:forEach var="b" items="${userList}" varStatus="status">
                        <tr>
                            <td>${status.index+1 }</td>
                            <td>${b.userId }</td>
                            <td>${b.userName }</td>
                            <td>${b.role.roleName }</td>
                            <td>
                                <c:choose>
                                  <c:when test="${b.userState==1}">是</c:when>
                                  <c:otherwise>否</c:otherwise>
                                </c:choose>
                            </td>
                            <td><a href="${pageContext.request.contextPath}/admin/preUpdate.do?userId=${user.userId}">编辑</a>
                                <a href="javascript:del('${user.userId}')">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>

                <nav>
                    <ul class="pagination">${pageCode }
                    </ul>
                </nav>
            </div>
        </section>
        <! --/wrapper -->
    </section>
    <!-- /MAIN CONTENT -->

    <!--main content end-->

    <!--footer start-->
   <jsp:include page="reuse/footer.jsp"/>
    <!--footer end-->
</section>

<!-- js placed at the end of the document so the pages load faster -->
<jsp:include page="reuse/js.jsp"/>

</body>
</html>

