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
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <meta name="keyword" content="">

  <title>视频管理页面</title>
  <!-- 引入全局css样式 -->
  <jsp:include page="/WEB-INF/reuse/css.jsp"/>

  <style>
    .checkDiv{
      padding:0;
      margin:0;
      /*margin-top:0;*/
      top:0;
      left:0;
      position: absolute;
      display:none;
    }

    .cb {
      width: 15px;
      height: 15px;
      /*padding: 0 5px 0 0;
      clear: left;
      float: left;*/
    }

    .Atag a:link,.Atag a:visited,.Atag a:hover,.Atag a:active{
      color:#000000;
      text-decoration:none;
    }

    .black_overlay{
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height:100%;
      background-color: black;
      z-index:1100;
      -moz-opacity: 0.8;
      opacity:.85;
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
      z-index:1101;
      overflow: hidden;
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
      <h3><i class="fa fa-angle-right"></i> 视频管理</h3>
      <!--<img src="http://developer.qiniu.com/samples/黑名单-S01E12.flv?vframe/jpg/offset/10/w/328/h/220">-->

      <!-- DEL ADD SEARCH FORM -->
      <div class="row mt">
        <div class="col-lg-12">
          <div class="col-lg-4">
            <button type="button" class="btn btn-theme03" onclick="selectFiles()">全选</button>
            <button type="button" class="btn btn-theme04" onclick="deleteFiles()"><i class="glyphicon glyphicon-trash"></i>删除</button>
            <button type="button" class="btn btn-theme02" onclick="openAddFile()"><i class="glyphicon glyphicon-plus"></i>新增</button>
            <%--<a id="iframe" class="btn btn-theme02" href="/filec/gotoUpload.htm" role="button"><i class="glyphicon glyphicon-plus"></i>新增</a>--%>
          </div>
          <div class="col-lg-8">
            <div class="pull-right">
              <form class="form-inline" role="form" method="post" action="/filec/listFile.htm">
                <div class="form-group">
                  <label class="control-label" for="fileNameSearchId">文件名：</label>
                  <input type="text" class="form-control" id="fileNameSearchId" name="fileName" placeholder="">
                </div>
                <div class="form-group">
                  <label class="control-label" for="fileStateId">审核状态：</label>
                  <select name="fileState" class="form-control" id="fileStateId">
                    <option value="">请选择...</option>
                    <option value="0">未审核</option>
                    <option value="1">审核中</option>
                    <option value="2">已审核</option>
                  </select>
                </div>
                <button type="submit" class="btn btn-theme">搜索<i class="glyphicon glyphicon-search"></i></button>
              </form>
            </div>
          </div><!-- /form-panel -->
        </div>
      </div><!-- /col-lg-12 -->
      </div><!-- /row -->

      <!-- 视频列表row -->
      <div class="row mt">
        <div class="col-lg-12">
<form id="fileMainForm">
          <!-- PANELS -->
<c:forEach var="cloudFile" items="${cloudFileList}" varStatus="status">
          <!-- Spotify Panel -->
          <div class="col-lg-3 col-md-3 col-sm-3 mb videoDiv">
            <!--复选框div-->
            <div class="checkDiv" title="选中进行删除">
              <input class="cb" type="checkbox" name="fileUrl" value="${cloudFile.fileUrl}">
              <%--<input type="hidden" name="fileId" value="${cloudFile.fileId}">--%>
            </div><!-- /复选框div -->
            <div class="content-panel pn">
            <a class="Atag" href='javascript:viewFile("${cloudFile.fileUrl}","${cloudFile.fileName}");'>
              <div id="spotify" style="background:url(${cloudFile.vframeUrl}) no-repeat center top;background-position-x:50%;background-position-y:50%;background-size:cover;">
                <div class="col-xs-4 col-xs-offset-8">
                  <span class="label btn btn-clear-g">
                    <c:choose>
                      <c:when test="${cloudFile.fileState==2}">已审核</c:when>
                      <c:when test="${cloudFile.fileState==1}">审核中</c:when>
                      <c:otherwise>未审核</c:otherwise>
                    </c:choose>
                  </span>
                </div>
                <div class="sp-title" style="width:220px">
                  <h4>${cloudFile.fileName}</h4>
                </div>
                <div class="play">
                  <i class="fa fa-play-circle"></i>
                </div>
              </div>
            </a>
              <p class="followers text-right">
                <span class="pull-left"><i class="glyphicon glyphicon-time"></i> ${cloudFile.fileDate.toLocaleString()}</span>
                <a href='javascript:editFilePre("${cloudFile.fileId}");'><i class="glyphicon glyphicon-edit"></i>编辑</a>
                <a href='javascript:downloadFile("${cloudFile.fileUrl}","${cloudFile.fileName}");'><i class="glyphicon glyphicon-download-alt">下载</i></a>&nbsp;
              </p>
            </div>
          </div>
</c:forEach>
</form>
        </div>
      </div><!-- /row -->

      <!--分页栏row-->
      <div class="row centered">
        <nav>
          <ul class="pagination">${pageCode}</ul>
        </nav>
      </div><!-- /row -->

    </section><! --/wrapper -->
  </section><!-- /MAIN CONTENT -->

  <!--弹出层-->
  <div id="light" class="white_content" onmouseover="$(this).find('div').show();" onmouseout="$(this).find('div').hide();">
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
<script>$("#fileMainId").attr({"class" : "active"});</script>
<!--引入此页面的js-->
<script type="text/javascript" src="/res/js/file/fileMain.js"></script>

</body>
</html>


