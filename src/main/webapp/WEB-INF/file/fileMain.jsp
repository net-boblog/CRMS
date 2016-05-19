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

  <title>资源管理页面</title>
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
      <h3><i class="fa fa-angle-right"></i> 资源管理</h3>
      <!--<img src="http://developer.qiniu.com/samples/黑名单-S01E12.flv?vframe/jpg/offset/10/w/328/h/220">-->

      <!-- DEL ADD SEARCH FORM -->
      <div class="row mt">
        <div class="col-lg-12">
          <div class="col-lg-4">
            <button type="button" class="btn btn-theme04" onclick="deleteMFiles()"><i class="glyphicon glyphicon-trash"></i>删除</button>
            <%--<button type="button" class="btn btn-theme02" onclick="openAddFile()"><i
                    class="glyphicon glyphicon-plus"></i>新增
            </button>--%>
          </div>
          <div class="col-lg-8">
            <div class="pull-right">
              <form id="actionId" class="form-inline" role="form" method="post" action="/filec/listFile.htm">
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
                    <option value="2">已过审</option>
                    <option value="3">未过审</option>
                  </select>
                </div>
                <button type="submit" class="btn btn-theme">搜索<i class="glyphicon glyphicon-search"></i></button>
              </form>
            </div>
          </div><!-- /form-panel -->
        </div><!-- /col-lg-12 -->
      </div><!-- /row -->

      <!-- 文件列表row -->
      <div class="row mt">
        <div class="col-lg-12">
          <form id="fileMainForm">
          <table class="table table-striped table-advance table-hover"> <%--table table-striped table-advance table-hover--%>
            <thead>
            <tr>
              <th width="30px"><input type="checkbox" onclick="selectFiles2()" title="全选/全不选"></th>
              <th><i class="fa fa-files-o"></i> 文件名称</th>
              <th class="hidden-phone"><i class="fa fa-question-circle"></i> 文件描述</th>
              <th><i class="fa fa-calendar"></i> 修改时间</th>
              <th><i class=" fa fa-edit"></i> 状态</th>
              <th><i class=" fa fa-cog"></i> 操作</th>
            </tr>
            </thead>
            <tbody>
<c:forEach var="cloudFile" items="${cloudFileList}" varStatus="status">
          <c:set var="cfurl" value="${cloudFile.fileUrl}" scope="request"/>
          <c:set var="vurl" value="${cloudFile.vframeUrl}" scope="request"/>
          <%
            String url = (String)request.getAttribute("cfurl");
            String fileType = url.substring(url.lastIndexOf('.')+1).toLowerCase();
            String furl = "/res/img/file-type/32/file.png";
            if(fileType.matches("(^(doc|docx)$)")){
              furl = "/res/img/file-type/32/word.png";
            }else if(fileType.matches("(^(xls|xlsx)$)")){
              furl = "/res/img/file-type/32/excel.png";
            }else if(fileType.matches("(^(ppt|pptx)$)")){
              furl = "/res/img/file-type/32/ppt.png";
            }else if(fileType.equals("pdf")){
              furl = "/res/img/file-type/32/pdf.png";
            }else if(fileType.equals("txt")){
              furl = "/res/img/file-type/32/txt.png";
            }else if(fileType.matches("^(flv|mp4|webm|ogg)$")){
              furl = "/res/img/file-type/32/movie.png";
            }else if(fileType.matches("^(gif|jpg|jpeg|png)$")){
              furl = "/res/img/file-type/32/image.png";
            }else if(fileType.matches("^(mp3|acc)$")){
              furl = "/res/img/file-type/32/music.png";
            }else if(fileType.matches("(^(zip|rar)$)")){
              furl = "/res/img/file-type/32/zip.png";
            }else{}
          %>
              <tr>
                <td>
                    <input class="cb" type="checkbox" name="fileUrl" value="${cloudFile.fileUrl}" title="选中进行删除">
                </td>
                <td>
                  <img src="<%=furl%>" width="24px">
                  <a href='javascript:viewFile("${cloudFile.fileUrl}","${cloudFile.fileName}");'>${cloudFile.fileName}</a>
                </td>
                <td class="hidden-phone">${cloudFile.fileDescript}</td>
                <td>${cloudFile.fileDate.toLocaleString()}</td>
                <td>
                  <c:choose>
                    <c:when test="${cloudFile.fileState==3}">
                      <span class="label label-danger label-mini">未过审</span>
                    </c:when>
                    <c:when test="${cloudFile.fileState==2}">
                      <span class="label label-success label-mini">已过审</span>
                    </c:when>
                    <c:when test="${cloudFile.fileState==1}">
                      <span class="label label-info label-mini">审核中</span>
                    </c:when>
                    <c:otherwise>
                      <span class="label label-warning label-mini">未审核</span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <%--<a class="btn btn-default btn-xs" href='javascript:void(0);' role="button" title="是否共享"><i class="fa fa-share-alt"></i></a>--%>
                  <a class="btn btn-default btn-xs" href='javascript:editFilePre("${cloudFile.fileId}");' role="button" title="编辑"><i class="fa fa-pencil"></i></a>
                  <a class="btn btn-default btn-xs" href='javascript:downloadFile("${cloudFile.fileUrl}","${cloudFile.fileName}");' role="button" title="下载"><i class="fa fa-download"></i></a>
                </td>
              </tr>
</c:forEach>
            </tbody>
          </table>
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


