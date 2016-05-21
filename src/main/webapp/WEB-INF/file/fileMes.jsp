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

  <title>文件详情页面</title>
  <jsp:include page="/WEB-INF/reuse/css.jsp"/>
</head>

<body>
<form id="fileForm" class="panel">
  <table class="table table-bordered">
    <tbody>
    <tr>
      <th scope="row" width="100px">文件名称：</th>
      <td>${cloudFile.fileName}</td>
    </tr>
    <tr>
      <th scope="row">审核状态：</th>
      <td>
          <c:choose>
            <c:when test="${cloudFile.fileState==3}">未过审</c:when>
            <c:when test="${cloudFile.fileState==2}">已过审</c:when>
            <c:when test="${cloudFile.fileState==1}">审核中</c:when>
            <c:otherwise>未审核</c:otherwise>
          </c:choose>
      </td>
    </tr>
    <tr>
      <th scope="row">修改时间：</th>
      <td>${cloudFile.fileDate.toLocaleString()}
    </tr>
    <tr>
      <th scope="row" height="100px">文件描述：</th>
      <td>
        ${cloudFile.fileDescript}
      </td>
    </tr>

    </tbody>
  </table>
</form>


<!-- js placed at the end of the document so the pages load faster -->
<jsp:include page="/WEB-INF/reuse/layerJs.jsp"/>

</body>
</html>

