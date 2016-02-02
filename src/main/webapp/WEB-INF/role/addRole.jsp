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
<form id="aroleForm"> <%--action="/user/insert.htm" method="post" onsubmit="return checkForm()">--%>
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
      <td><input id="roleDes" class="form-control" type="text" name="roleDescript" value="" placeholder="请输入角色说明" required>
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

    </tr>
    <tr>
        <input type="hidden" id="ids" name="ids" value="hei">
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
          if ($("#roleDescript").val() == "") {
              layer.tips('角色说明不能为空!', '#roleDes', {tips: 4, tipsMore: true});
          } else {
              var ids = fun();
              $("#ids").val(ids);
              var roledata = $("#aroleForm").serializeArray();

              $.each(roledata, function(i, field){
                  alert(field.name + ":" + field.value + " ");
              });
              $.ajax({
                  type: "POST",
                  url: "/role/insert.htm",
                  data: roledata,ids:ids,
                  cache: false,
                  success: function (data, status) {
                      alert(status + ":成功！!");
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
          edit: {
              enable: true
          },
          async: {
              enable: true,
              type: 'post',
              url: "/role/addRole.htm",
              dataFilter: filter
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

  function filter(treeId, parentNode, childNodes) {
      if (!childNodes) return null;
      for (var i = 0, l = childNodes.length; i < l; i++) {
          childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
      }
      return childNodes;
  }
  function fun() {
      var zTree = $.fn.zTree.getZTreeObj("treeDemo");
      var checkedNodes = zTree.getCheckedNodes(true);
      var count=checkedNodes.length;
      var ids=new Array();
      for(var i=0;i<count;i=i+1){
          ids.push(checkedNodes[i].id);
      }
      ids=ids.join(",");
      return ids;
  }

  function beforeRename(treeId, treeNode, newName) {
      if (newName.length == 0) {
          alert("节点名称不能为空.");
          return false;
      }
      return true;
  }
      $(document).ready(function () {//初始化ztree对象
          var zTreeDemo = $.fn.zTree.init($("#treeDemo"), setting);
          zTreeDemo.expandAll(true);//全部展开
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
