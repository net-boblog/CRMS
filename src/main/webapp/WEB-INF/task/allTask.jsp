<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2016-01-10
  Time: 22:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<body style="overflow: hidden;">

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
            <h3><i class="fa fa-angle-right"></i> 正在运行的任务</h3>
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
                                <center>任务所属人</center>
                            </th>
                            <th>
                                <center>任务当前节点</center>
                            </th>
                            <th>
                                <center>文件名</center>
                            </th>
                            <th>
                                <center>递交时间</center>
                            </th>
                            <th>
                                <center>上传理由及文件描述</center>
                            </th>
                            <th>
                                <center>状态</center>
                            </th>
                            <th>
                                <center>操作</center>
                            </th>

                        </tr>
                        <form id="fileMainForm">
                            <c:forEach var="cloudFile" items="${cloudFileList}" varStatus="status">
                                <tr>
                                    <td width="50px">
                                        <center>
                                                ${status.index+1 }
                                        </center>
                                    </td>
                                    <td width="50px">
                                        <center>
                                                ${cloudFile.task.id}
                                        </center>
                                    </td>
                                    <td width="50px">
                                        <center>
                                                ${cloudFile.task.executionId}
                                        </center>
                                    </td>
                                    <td width="50px">
                                        <center>
                                                ${cloudFile.user.userName}
                                        </center>
                                    </td>
                                    <td width="50px">
                                        <center>
                                                ${cloudFile.task.name}
                                        </center>
                                    </td>
                                    <td width="150px">
                                        <center>${cloudFile.fileName} </center>
                                    </td>
                                    <td width="100px">
                                        <center>${cloudFile.fileDate.toLocaleString()} </center>
                                    </td>
                                    <td width="400px">${cloudFile.fileDescript} </td>
                                    <td width="50px">
                                        <center>
                                            <c:choose>
                                                <c:when test="${cloudFile.fileState==3}">审核未通过</c:when>
                                                <c:when test="${cloudFile.fileState==2}">审核通过</c:when>
                                                <c:when test="${cloudFile.fileState==1}">审核中</c:when>
                                                <c:otherwise>未审核</c:otherwise>
                                            </c:choose>
                                        </center>
                                    </td>
                                    <td width="200px">
                                        <center>
                                            <div style="text-align:center">
                                                <a href='javascript:downloadFile("${cloudFile.fileUrl}","${cloudFile.fileName}");'
                                                   class=""><i
                                                        class="glyphicon glyphicon-download-alt">下载</i></a>
                                                <a class="Atag nowrap"
                                                   href='javascript:viewFile("${cloudFile.fileUrl}","${cloudFile.fileName}");'>查看</a>
                                                <c:choose>
                                                    <c:when test="${cloudFile.fileState==1||cloudFile.fileState==3}">
                                                        <a href="/diagram-viewer/index.html?processDefinitionId=${cloudFile.task.processDefinitionId}&processInstanceId=${cloudFile.instanceId}"
                                                           class="trace nowrap"
                                                           target="_BLANK"
                                                           id="${cloudFile.bussinessKey}">查看流程图
                                                        </a>
                                                    </c:when>
                                                </c:choose>

                                            </div>
                                        </center>
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
<script type="text/javascript" src="/res/js/file/fileMain.js"></script>
<script type="text/javascript" src="/res/js/task/taskMain.js"></script>
<script type="text/javascript" src="/res/js/task/adjustFile.js"></script>
</body>
</html>


