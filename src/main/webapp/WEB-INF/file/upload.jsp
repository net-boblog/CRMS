<%--
  Created by IntelliJ IDEA.
  User: Huy
  Date: 2016-01-06
  Time: 16:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>上传视频页面</title>
</head>
<body>
<form id="fileForm">
  <table class="table table-bordered table-striped table-condensed">
    <tbody>
    <tr>
      <th scope="row">文件名称：</th>
      <td><input id="fileNameId" type="text" name="fileName" value="" placeholder="请输入文件名称" required></td>
    </tr>
    <tr>
      <th scope="row">上传文件：</th>
      <td>
        <div id="container">
          <a class="btn btn-default btn-lg " id="pickfiles" href="#" >
            <i class="glyphicon glyphicon-plus"></i>
            <span>选择文件进行上传</span>
          </a>
        </div>
      </td>
    </tr>
    <tr>
      <th scope="row">文件描述：</th>
      <td><textarea id="fileIntroId" class="form-control" name="fileDescript" rows="3" placeholder="请输入文件描述"></textarea></td>
    </tr>
    <tr>
      <th scope="row"></th>
      <td>
        <button id="start_upload" type="button" class="btn btn-primary">提交</button>
        <button id="fileCancel" type="button" class="btn btn-default">取消</button>
      </td>
    </tr>
    </tbody>
  </table>
</form>

<%--<div id="container">
  <a class="btn btn-default btn-lg " id="pickfiles" href="#" >
    <i class="glyphicon glyphicon-plus"></i>
    <span>选择文件</span>
  </a>
</div>--%>

<!-- js placed at the end of the document so the pages load faster -->
<jsp:include page="/WEB-INF/reuse/js.jsp"/>
<script type="text/javascript" src="/assets/js/plupload/plupload.full.min.js"></script>
<script type="text/javascript" src="/assets/js/qiniu.js"></script>
<script type="text/javascript" src="/res/js/file/initUpload.js"></script>
</body>
</html>
