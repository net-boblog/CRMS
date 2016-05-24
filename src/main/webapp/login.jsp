<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">
    <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

    <title>登录页面</title>
    <!-- 引入全局css样式 -->
    <jsp:include page="/WEB-INF/reuse/css.jsp"/>

	  <script type="text/javascript">


		  function changeImg() {
			  var imgSrc = $("#imgObj");
			  var src = imgSrc.attr("src");
			  imgSrc.attr("src", chgUrl(src));
		  }
		  //时间戳
		  //为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳
		  function chgUrl(url) {
			  var timestamp = (new Date()).valueOf();
			  url = url.substring(0, 17);
			  if ((url.indexOf("&") >= 0)) {
				  url = url + "×tamp=" + timestamp;
			  } else {
				  url = url + "?timestamp=" + timestamp;
			  }
			  return url;
		  }

	  </script>

  </head>

  <body>

      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->

	  <div id="login-page">
	  	<div class="container">
	  	
		      <form class="form-login" action="/user/login.htm" method="post">
		        <h2 class="form-login-heading">用户登录</h2>
		        <div class="login-wrap">

					<div>
						<span  id="login_err" class="sty_txt2" style="color: red"><font color="red">${errorMsg}${errorMsg1 }${blacklist}</font> </span>
					</div>

		            <input type="text" class="form-control" id="userName" name="userName" value="${user.userName }" placeholder="请输入用户名" autofocus>
		            <br>
		            <input type="password" class="form-control" id="password"  name="password" placeholder="请输入密码">
                    <br>
					<div>
						<span  id="code_err" class="sty_txt2" style="color: red"><font color="red">${msg}</font> </span>
					</div>
           <table cellpadding="2">
                     <tr>
					 <td>
						 <input class="form-control" id="verifyCode" name="verifyCode" type="text" style="width:180px;" placeholder="请输入验证码" /></td>
	                 <td style="padding-left: 15px;">
						 <a href="javascript:;" onclick="changeImg()">
							 <img id="imgObj" alt="点击刷新验证码" title="点击刷新验证码" src="code.htm" />
						 </a>
					 </td>
					 </tr>
           </table>
		            <label class="checkbox">
		                <span class="pull-right">
		                    <a data-toggle="modal" href="login.jsp#myModal"> 忘记密码?</a>
		
		                </span>
		            </label>
		            <button class="btn btn-theme btn-block login-submit-btn" type="submit"><i class="fa fa-lock"></i> 登录</button>
		            <hr>

		            <div class="registration">
		                云平台资源管理系统<br/>
		                <!--<a class="" href="#">
							云平台资源管理系统
		                </a>-->
		            </div>
		
		        </div>
			  </form>
		          <!-- Modal -->
		          <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
		              <div class="modal-dialog">
		                  <div class="modal-content">
		                      <div class="modal-header">
		                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                          <h4 class="modal-title">找回密码</h4>
		                      </div>
							  <div class="modal-body">
								  <form id="passForm">
									  <p>您的用户名：</p>
									  <input type="text" name="userName" placeholder="Username" autocomplete="off" class="form-control placeholder-no-fix" required>
									  <br>
									  <p>您的激活邮箱：</p>
									  <input type="text" name="userEmail" placeholder="Email" autocomplete="off" class="form-control placeholder-no-fix" required>
									  <br>
									  <p id="pmes" class="text-center" style="color: red"></p>
								  </form>
		                      </div>
		                      <div class="modal-footer">
		                          <button data-dismiss="modal" class="btn btn-default" type="button">取消</button>
		                          <button class="btn btn-theme" type="button" onclick="findPassByEmail()">提交</button>
		                      </div>
		                  </div>
		              </div>
		          </div>
		          <!-- modal -->
		

	  	
	  	</div>
	  </div>

    <!-- js placed at the end of the document so the pages load faster -->
    <script src="assets/js/jquery.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>

    <!--BACKSTRETCH-->
    <!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->
    <script type="text/javascript" src="assets/js/jquery.backstretch.min.js"></script>
    <script>
        $.backstretch("assets/img/login-bg.jpg", {speed: 500});
    </script>
	  <%
		  session.removeAttribute("errorMsg1");
	  %>

	  <script type="text/javascript">
	  $('.login-submit-btn').click(function checkForm(e){
		  var form = $('form.form-login');
		  var userName=document.getElementById("userName").value;
		  var password=document.getElementById("password").value;
		  var verifyCode=document.getElementById("verifyCode").value;
		  if(userName==null || userName==""){
			  document.getElementById("login_err").innerHTML="用户名不能为空";
			  return false;
		  }
		  if(password==null || password==""){
			  document.getElementById("login_err").innerHTML="密码不能为空";
			  return false;
		  }
		  if(verifyCode==null || verifyCode==""){
			  document.getElementById("code_err").innerHTML="验证码不能为空";
			  return false;
		  }
		  form.onsubmit();
		  return true;
	  })

		  //找回密码
		  function findPassByEmail(){
			  var passForm = $("#passForm");
			  var userInput = passForm.children("input[name='userName']");
			  var emailInput = passForm.children("input[name='userEmail']");
			  var pmes = $("#pmes");
			  var userVal = userInput.val();
			  var emailVal = emailInput.val();

			  if(userVal==""){
				  pmes.text("用户名不能为空");
			  }else if(emailVal==""){
				  pmes.text("邮箱不能为空");
			  }else{
				  $.ajax({
					  type:"POST",
					  url:"/user/findPassByEmail.htm",
					  data:passForm.serializeArray(),
					  cache:false,
					  success:function(data,status){
						  $("#pmes").text(data);
					  },
					  error:function(xhr,status,ex){
						  $("#pmes").text(status+":提交失败!");
					  }
				  });
			  }
		  }
	  </script>

  </body>
</html>
