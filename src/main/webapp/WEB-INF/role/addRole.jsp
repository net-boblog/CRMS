<%--
  Created by IntelliJ IDEA.
  User: Huy
  Date: 2016-01-06
  Time: 16:02
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

  <title>添加用户页面</title>

  <jsp:include page="/WEB-INF/reuse/css.jsp"/>

    <!-- js placed at the end of the document so the pages load faster -->
    <jsp:include page="/WEB-INF/reuse/layerJs.jsp"/>
    <link href="/assets/ztree/css/demo.css" rel="stylesheet" />
    <link href="/assets/ztree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <script src="/assets/ztree/js/jquery-1.4.4.min.js"></script>
    <script src="/assets/ztree/js/jquery.ztree.core-3.5.js"></script>
    <script src="/assets/ztree/js/jquery.ztree.excheck-3.5.js"></script>
    <script src="/assets/ztree/js/jquery.ztree.exedit-3.5.js"></script>


</head>

<body>
<form id="auserForm"> <%--action="/user/insert.htm" method="post" onsubmit="return checkForm()">--%>
  <table class="table table-bordered table-striped table-condensed">
    <tbody>
    <tr>
      <th scope="row">角色名：</th>
      <td><input id="roleName" class="form-control" type="text" name="roleName" value="" placeholder="请输入角色名" required>
        <div>
          <span id="userError"></span>
          <%--<span font color="red">${errorMsg2}</span>--%>
        </div>
      </td>

    </tr>
    <tr>
      <th scope="row">说明：</th>
      <td><input id="roleDes" class="form-control" type="text" name="roleDes" value="" placeholder="请输入角色说明" required>
        <div>
          <span id="userError"></span>
          <%--<span font color="red">${errorMsg2}</span>--%>
        </div>
      </td>

    </tr>
    <tr>
      <th scope="row">权限：</th>
      <td>
          <!-- 树加载后存放的容器 -->
         <ul id="treeDemo" class="ztree"></ul>
      </td>
    <tr>
      <td><input type="hidden" name="roledto.permissionIds" /></td>
      <td><input type="hidden" name="roledto.roleId" value="${roleId}"/></td>
      <td><input type="hidden" name="orgid" value="${orgId}"/></td>
    </tr>
    </tr>

    <tr>
      <th scope="row"></th>
      <td class="text-right">
        <button id="auserBtn" type="button" class="btn btn-primary">提交</button>&nbsp;
        <button id="fileCance2" type="reset" class="btn btn-default">重置</button>&nbsp;
        <%--<button id="fileCance3" type="button" class="btn btn-default" onclick="window.location='/user/list.htm'">返回</button>--%>
      </td>
    </tr>
    </tbody>
  </table>
</form>


<script type="text/javascript">
  $(function() {
      $("#auserBtn").click(function () {
          if ($("#roleName").val() == "") {
              layer.tips('角色名不能为空!', '#roleName', {tips: 4, tipsMore: true});
          }
          if ($("#roleDes").val() == "") {
              layer.tips('角色说明不能为空!', '#roleDes', {tips: 4, tipsMore: true});
          }
          if ($("#roleSel").val() == "") {
              layer.tips('请选择角色!', '#roleSel', {tips: 4, tipsMore: true});
          } else {
              var userdata = $("#auserForm").serializeArray();
              $.ajax({
                  type: "POST",
                  url: "/role/insert.htm",
                  data: userdata,
                  cache: false,
                  success: function (data, status) {
                      var utip = data.usertip;
                      if (utip == 0) {
                          //$("#userError").text(reData.mes);
                          layer.tips(data.mes, '#userName', {tips: [3, 'red'], tipsMore: true});
                      } else if (utip == 1) {
                          parent.layer.msg(status + data.mes, {shade: 0.1, time: 2000}, function () {
                              parent.window.location = "/user/list.htm";
                          });
                      } else {
                          //do nothing
                          alert("do nothing");
                      }
                  },
                  error: function (xhr, status, ex) {
                      alert(status + ":保存失败!");
                  }
              });
          }
      });
  });
      /**ztree的参数配置，setting主要是设置一些tree的属性，是本地数据源，还是远程，动画效果，是否含有复选框等等**/
      var setting = {
          check: {
              enable: true,
              chkStyle: "checkbox",
              chkboxType: {"Y": "p", "N": "s"}
          },
          view: {
              //dblClickExpand: false,
              expandSpeed: 300 //设置树展开的动画速度，IE6下面没效果，
          },
          async: {
              enable: true,
              type: 'post',
              url: "/role/addRole.htm"
              ///dataFilter: filter
          },
          data: {
              simpleData: {   //简单的数据源，一般开发中都是从数据库里读取，API有介绍，这里只是本地的
                  enable: true,
                  idKey: "id",  //id和pid，这里不用多说了吧，树的目录级别
                  pIdKey: "pId",
                  rootPId: 0   //根节点
              }
          },
          callback: {
              /**回调函数的设置，随便写了两个**/

          }
      };

      $(document).ready(function () {//初始化ztree对象
          var zTreeDemo = $.fn.zTree.init($("#treeDemo"), setting);
      });


/*    function checkForm() {
 var userName = $("#userName").val();
 if (userName == null || userName == "") {
 $("#userError").text("用户名不能为空！");
 return false;
 }

 if (confirm("确认保存?")) {
 return true;
 } else {
 return false;
 }
 }*/
</script>

</body>
</html>
