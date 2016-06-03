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
    <title>我的资源页面</title>
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
            <h3><i class="fa fa-angle-right"></i> 我的资源</h3>
            <!--<img src="http://developer.qiniu.com/samples/黑名单-S01E12.flv?vframe/jpg/offset/10/w/328/h/220">-->

            <!-- DEL ADD SEARCH FORM -->
            <div class="row mt">
                <div class="col-lg-12">
                    <div class="col-lg-4">

                        <button type="button" class="btn btn-theme03" onclick="selectFiles2()">全选</button>
                        <button type="button" class="btn btn-theme04" onclick="deleteFiles()"><i class="glyphicon glyphicon-trash"></i>删除
                        </button>

                        <button type="button" class="btn btn-theme02" onclick="openAddFile()"><i
                                class="glyphicon glyphicon-plus"></i>新增
                        </button>

                        <%--<a id="iframe" class="btn btn-theme02" href="/filec/gotoUpload.htm" role="button"><i class="glyphicon glyphicon-plus"></i>新增</a>--%>

                    </div>

                    <div class="col-lg-8">
                        <div class="pull-right">
                            <form id="actionId" class="form-inline" role="form" method="post" action="/task/listMyFile.htm">
                                <div class="form-group">
                                    <label class="control-label" for="fileNameSearchId">文件名：</label>
                                    <input type="text" class="form-control" id="fileNameSearchId" name="fileName"
                                           placeholder="">
                                </div>
                                <div class="form-group">
                                    <label class="control-label" for="fileStateId">审核状态：</label>
                                    <select name="fileState" class="form-control" id="fileStateId">
                                        <option value="">请选择...</option>
                                        <option value="0">未审核</option>
                                        <option value="1">审核中</option>
                                        <option value="2">已过审</option>
                                        <option value="3">未过审</option>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-theme">搜索<i class="glyphicon glyphicon-search"></i>
                                </button>
                            </form>
                        </div>
                    </div>

                    <!-- /form-panel -->
                </div>
            </div>
            <!-- /col-lg-12 -->
            </div><!-- /row -->


            <!-- 任务列表row -->

            <div class="row mt">
                <div class="col-lg-12">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th width="30px">
                                <input style=" width:15px;height:15px;" type="checkbox" onclick="selectFiles2()" title="全选/全不选">
                            </th>
                            <th>
                                <center>序号</center>
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
                                    <td>
                                        <input class="cb" type="checkbox" name="fileUrl" value="${cloudFile.fileUrl}"/>
                                    </td>
                                    <td width="50px">
                                        <center>
                                                ${status.index+1 }
                                        </center>
                                    </td>
                                    <td width="150px">
                                        <center>
                                            <a href='javascript:viewFile("${cloudFile.fileUrl}","${cloudFile.fileName}");'>
                                                ${cloudFile.fileName}
                                            </a>
                                        </center>
                                    </td>
                                    <td width="100px">
                                        <center>${cloudFile.fileDate.toLocaleString()} </center>
                                    </td>
                                    <td width="400px">${cloudFile.fileDescript} </td>
                                    <td width="50px">
                                        <center>
                                            <c:choose>
                                                <c:when test="${cloudFile.fileState==3}">未过审</c:when>
                                                <c:when test="${cloudFile.fileState==2}">已过审</c:when>
                                                <c:when test="${cloudFile.fileState==1}">审核中</c:when>
                                                <c:otherwise>未审核</c:otherwise>
                                            </c:choose>
                                        </center>
                                    </td>
                                    <td width="200px">
                                        <center>
                                            <div style="text-align:center">
                                                <a id="${cloudFile.fileId}" class="Atag nowrap" href='javascript:shareFile("${cloudFile.fileId}","${cloudFile.shareState}");'>
                                                    <c:choose>
                                                        <c:when test="${cloudFile.shareState==0}">共享</c:when>
                                                        <c:otherwise>取消共享</c:otherwise>
                                                    </c:choose>
                                                </a>

                                                <a href='javascript:downloadFile("${cloudFile.fileUrl}","${cloudFile.fileName}");'>下载</a>  <%--<i class="glyphicon glyphicon-download-alt">下载</i>--%>
                                                <a class="Atag nowrap" href='javascript:viewFileMes("${cloudFile.fileId}","${cloudFile.fileUrl}","${cloudFile.fileName}");'>
                                                    详情
                                                </a>
                                                <c:if test="${cloudFile.fileState==2}">
                                                    <a href='javascript:editFilePre("${cloudFile.fileId}");'><i
                                                            class="glyphicon glyphicon-edit"></i>编辑</a>
                                                </c:if>
                                                <c:choose>
                                                    <c:when test="${cloudFile.fileState==1||cloudFile.fileState==3}">
                                                        <a href="/diagram-viewer/index.html?processDefinitionId=${proDefId}&processInstanceId=${cloudFile.instanceId}"
                                                           class="trace nowrap"
                                                           target="_BLANK"
                                                           id="${cloudFile.bussinessKey}">点击查看流程图
                                                    </a>
                                                    </c:when>
                                                </c:choose>
                                                <c:if test="${cloudFile.fileState==3}">
                                                    <a href="javascript:" id="lookReseaon${cloudFile.instanceId}"
                                                       onclick="lookReseaon(${cloudFile.instanceId})">查看拒绝理由
                                                    </a>
                                                    <a href="javascript:" id="receiveAdjust${cloudFile.instanceId}"
                                                       onclick="preAdjust(${cloudFile.fileId},${cloudFile.instanceId})">接受调整
                                                    </a>
                                                    <a href="javascript:" id="rejectAdjust${cloudFile.instanceId}"
                                                       onclick="rejectAdjust(${cloudFile.instanceId},${cloudFile.fileId})">拒绝调整
                                                    </a>
                                                </c:if>
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
<script>$("#myUpLoadId").attr({"class": "active"});</script>
<!--引入此页面的js-->
<script type="text/javascript" src="/res/js/file/fileMain.js"></script>
<script type="text/javascript" src="/res/js/task/taskMain.js"></script>
<script type="text/javascript" src="/res/js/task/adjustFile.js"></script>
</body>
</html>


