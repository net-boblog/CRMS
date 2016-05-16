<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2016-01-10
  Time: 22:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>任务管理页面</title>
    <!-- 引入全局css样式 -->
    <jsp:include page="/WEB-INF/reuse/css.jsp"/>
    <style>
        .checkDiv {
            padding: 0;
            margin: 0;
            /*margin-top:0;*/
            top: 0;
            left: 0;
            position: absolute;
            display: none;
        }

        .cb {
            width: 15px;
            height: 15px;
            /*padding: 0 5px 0 0;
            clear: left;
            float: left;*/
        }

        .Atag a:link, .Atag a:visited, .Atag a:hover, .Atag a:active {
            color: #000000;
            text-decoration: none;
        }

        .black_overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: black;
            z-index: 1100;
            -moz-opacity: 0.8;
            opacity: .85;
            filter: alpha(opacity=88);
        }

        .white_content {
            display: none;
            position: fixed;
            top: 18%;
            left: 20%;
            width: 800px;
            height: 450px;
            /*padding: 20px;
            border: 2px solid black;*/
            background-color: black;
            z-index: 1101;
            overflow: hidden;
        }

        .nowrap {
            white-space: nowrap;
            padding-top: 5px;
            padding-bottom: 5px;
            margin-left: 5px;
        }
    </style>
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
            <h3><i class="fa fa-angle-right"></i> 任务管理</h3>
            <!--<img src="http://developer.qiniu.com/samples/黑名单-S01E12.flv?vframe/jpg/offset/10/w/328/h/220">-->

            <!-- 任务列表row -->

            <div class="row mt">
                <div class="col-lg-12">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th>
                                <center>序号</center>
                            </th>
                            <th>
                                <center>任务ID</center>
                            </th>
                            <th>
                                <center>流程实例ID</center>
                            </th>
                            <th>
                                <center>任务名称</center>
                            </th>
                            <th>
                                <center>开始时间</center>
                            </th>
                            <th>
                                <center>签收时间</center>
                            </th>
                            <th>
                                <center>结束时间</center>
                            </th>

                        </tr>
                        <form id="fileMainForm">
                            <c:forEach var="historicTaskInstanceEntity" items="${historicTaskInstanceList}"
                                       varStatus="status">
                                <tr>
                                    <td width="50px">
                                        <center>
                                                ${status.index+1 }
                                        </center>
                                    </td>
                                    <td width="50px">
                                        <center>
                                                ${historicTaskInstanceEntity.id}
                                        </center>
                                    </td>
                                    <td width="50px">
                                        <center>
                                                ${historicTaskInstanceEntity.executionId}
                                        </center>
                                    </td>
                                    <td width="50px">
                                        <center>
                                                ${historicTaskInstanceEntity.name}
                                        </center>
                                    </td>
                                    <td width="50px">
                                        <center>
                                            <fmt:formatDate value="${historicTaskInstanceEntity.startTime}"
                                                            type="both"/>
                                        </center>
                                    </td>
                                    <td width="50px">
                                        <center>
                                            <fmt:formatDate value="${historicTaskInstanceEntity.claimTime}"
                                                            type="both"/>
                                        </center>
                                    </td>
                                    <td width="150px">
                                        <center><fmt:formatDate value="${historicTaskInstanceEntity.endTime}"
                                                                type="both"/></center>
                                    </td>
                                </tr>
                            </c:forEach>
                        </form>
                    </table>
                </div>
            </div>

            <!--分页栏row-->
            <div class="row centered">
                <nav>
                    <ul class="pagination">${pageCode}</ul>
                </nav>
            </div>
            <!-- /row -->

        </section>
        <! --/wrapper -->
    </section>
    <!-- /MAIN CONTENT -->

    <!--弹出层-->
    <div id="light" class="white_content" onmouseover="$(this).find('div').show();"
         onmouseout="$(this).find('div').hide();">
        <div id="lightDiv" style="position:absolute;z-index:1102;display:none;color: white"><h4>&nbsp;</h4></div>
    </div>
    <div id="fade" class="black_overlay"></div>
    <!--/弹出层结束-->

    <!--main content end-->

    <!--footer start-->
    <jsp:include page="/WEB-INF/reuse/footer.jsp"/>
    <!--footer end-->
</section>

<!-- js placed at the end of the document so the pages load faster -->
<jsp:include page="/WEB-INF/reuse/js.jsp"/>
<!-- 让侧边栏菜单高亮 -->
<script>$("#workMainId").attr({"class": "active"});</script>
<!--引入此页面的js-->
</body>
</html>


