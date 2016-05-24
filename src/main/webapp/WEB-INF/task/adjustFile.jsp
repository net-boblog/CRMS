<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2016-01-17
  Time: 15:12
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

  <title>修改视频页面</title>
  <jsp:include page="/WEB-INF/reuse/css.jsp"/>
</head>

<body>
<form id="fileForm" class="panel">
  <input type="hidden" name="fileId" value="${cloudFile.fileId}">
  <input id="fileUrlId" type="hidden" name="fileUrl" value="${cloudFile.fileUrl}">
  <input  type="hidden" name="instanceId" value="${cloudFile.instanceId}">
  <input  type="hidden" name="fileState" value="${cloudFile.fileState}">
  <table class="table table-bordered">
    <tbody>
    <tr>
      <th scope="row">文件名称：</th>
      <td><input id="fileNameId" class="form-control" type="text" name="fileName" value="${cloudFile.fileName}" placeholder="请输入文件名称" required></td>
    </tr>
    <tr>
      <th scope="row">上传文件：</th>
      <td width="435px">
        <!--plupload文件上传组件-->
        <div id="container">
          <a class="btn btn-default btn-lg " id="pickfiles" href="#" >
            <i class="glyphicon glyphicon-plus"></i>
            <span>重新选择上传文件</span>
          </a>
        </div><!-- /上传组件end -->

        <!--上传进度div，默认隐藏-->
        <div id="upproId" style="display:none">
          <div class="task-info">
            <div id="descId" class="desc">正在上传</div>
          </div>
          <div class="progress progress-striped" style="margin-bottom:0;margin-top:5px;height:10px;">
            <div id="barDivId" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0"
                 aria-valuemin="0" aria-valuemax="100" style="width: 0%">
              <span class="sr-only">0% Complete (success)</span>
            </div>
          </div>
          <div class="percent">
            <span><small id="persId">......</small></span>
          </div>
        </div><!-- /上传进度end -->
      </td>
    </tr>
    <tr>
      <th scope="row">文件属性：</th>
      <td>文件类型：
        <input style="border:0" id="fileTypeId" type="text" name="fileType" value="${cloudFile.fileType}" size="10" readonly required>
        &nbsp;文件大小：
        <input style="border:0" id="fileSizeId" type="text" name="fileSize" value="${cloudFile.fileSize}" size="10" readonly required>
      </td>
    </tr>
    <tr>
      <th scope="row">文件描述：</th>
      <td>
        <textarea id="fileIntroId" class="form-control" name="fileDescript" rows="3" placeholder="请输入文件描述">${cloudFile.fileDescript}</textarea>
      </td>
    </tr>
    <tr>
      <th scope="row">上次更新时间：</th>
      <td><input id="fileDateId" class="form-control" type="text" name="fileDate" value="${cloudFile.fileDate.toLocaleString()}" placeholder="请输入文件名称" disabled></td>
    </tr>
    </tbody>
  </table>
</form>


<!-- js placed at the end of the document so the pages load faster -->
<jsp:include page="/WEB-INF/reuse/layerJs.jsp"/>
<!--used for this page -->
<script type="text/javascript" src="/assets/js/plupload/plupload.full.min.js"></script>
<script type="text/javascript" src="/assets/js/qiniu.js"></script>
<script type="text/javascript" src="/res/js/task/adjustFile.js"></script>

</body>
</html>

