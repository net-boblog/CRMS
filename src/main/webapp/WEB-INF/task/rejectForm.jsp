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
  <title>拒绝理由填写页面</title>
  <jsp:include page="/WEB-INF/reuse/css.jsp"/>
</head>
<body>
  <table class="table table-bordered">
    <tbody>
    <tr>
      <th scope="row">拒绝理由：</th>
      <td><textarea id="rejectTextarea" class="form-control " name="rejectReseaon" rows="3" placeholder="请输入拒绝理由" required></textarea></td>
    </tr>
    </tbody>
  </table>
<!-- js placed at the end of the document so the pages load faster -->
<jsp:include page="/WEB-INF/reuse/layerJs.jsp"/>
<!--used for this page -->
</body>
</html>

