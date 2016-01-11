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

      <!-- INLINE FORM ELELEMNTS -->
      <div class="row mt">
        <div class="col-lg-12">
          <div class="col-lg-4">
            <button type="button" class="btn btn-theme04"><i class="glyphicon glyphicon-trash"></i>删除</button>
            <button type="button" class="btn btn-theme02"><i class="glyphicon glyphicon-plus"></i>新增</button>
          </div>
          <div class="col-lg-8">
            <div class="pull-right">
              <form class="form-inline" role="form">
                <div class="form-group">
                  <label class="control-label" for="fileNameSearchId">文件名：</label>
                  <input type="text" class="form-control" id="fileNameSearchId" placeholder="">
                </div>
                <div class="form-group">
                  <label class="control-label" for="fileStateId">审核状态：</label>
                  <select class="form-control" id="fileStateId">
                    <option></option>
                    <option>未审核</option>
                    <option>审核中</option>
                    <option>已审核</option>
                  </select>
                </div>
                <button type="submit" class="btn btn-theme">搜索<i class="glyphicon glyphicon-search"></i></button>
              </form>
            </div>
          </div><!-- /form-panel -->
        </div>
      </div><!-- /col-lg-12 -->
      </div><!-- /row -->

      <div class="row mt">
        <div class="col-lg-12">


          <! -- 1RD ROW OF PANELS -->
          <! -- Spotify Panel -->
          <div class="col-lg-3 col-md-3 col-sm-3 mb">
            <div class="content-panel pn">
              <div id="spotify"> <!--style="background:url(http://developer.qiniu.com/samples/黑名单-S01E12.flv?vframe/jpg/offset/10/w/328/h/220) no-repeat center top;background-position-x:50%;background-position-y:50%;background-size:cover;">-->
                <div class="col-xs-4 col-xs-offset-8">
                  <!--<button class="btn btn-sm btn-clear-g">FOLLOW</button>-->
                  <!--<span class="label label-danger pull-right">未审核</span>-->
                  <!--<span class="label label-warning pull-right">审核中</span>		 label-success -->
                  <span class="label btn btn-sm btn-clear-g">已审核</span>
                </div>
                <div class="sp-title" style="width:220px">
                  <h4>广东海洋大学宣传片之你好啊广东海洋大学好</h4>
                </div>
                <div class="play">
                  <i class="fa fa-play-circle"></i>
                </div>
              </div>
              <p class="followers text-right">
                <!--<i class="fa fa-user"></i> 576,000 FOLLOWERS-->
                <span class="pull-left"><i class="glyphicon glyphicon-time"></i> 2016-01-08 16:40:30</span>
                <a href="#"><i class="glyphicon glyphicon-edit"></i>编辑</a>&nbsp;
                <a href="#"><i class="glyphicon glyphicon-download-alt">下载</i></a>&nbsp;
              </p>
            </div>
          </div><! --/col-md-4-->

          <! -- Spotify Panel -->
          <div class="col-lg-3 col-md-3 col-sm-3 mb">
            <div class="content-panel pn">
              <div id="spotify">
                <div class="col-xs-4 col-xs-offset-8">
                  <button class="btn btn-sm btn-clear-g">FOLLOW</button>
                </div>
                <div class="sp-title">
                  <h4>LORDE</h4>
                </div>
                <div class="play">
                  <i class="fa fa-play-circle"></i>
                </div>
              </div>
              <p class="followers"><i class="fa fa-user"></i> 576,000 FOLLOWERS</p>
            </div>
          </div><! --/col-md-4-->

          <! -- Spotify Panel -->
          <div class="col-lg-3 col-md-3 col-sm-3 mb">
            <div class="content-panel pn">
              <div id="spotify">
                <div class="col-xs-4 col-xs-offset-8">
                  <button class="btn btn-sm btn-clear-g">FOLLOW</button>
                </div>
                <div class="sp-title">
                  <h3>LORDE</h3>
                </div>
                <div class="play">
                  <i class="fa fa-play-circle"></i>
                </div>
              </div>
              <p class="followers"><i class="fa fa-user"></i> 576,000 FOLLOWERS</p>
            </div>
          </div><! --/col-md-4-->

          <! -- Spotify Panel -->
          <div class="col-lg-3 col-md-3 col-sm-3 mb">
            <div class="content-panel pn">
              <div id="spotify">
                <div class="col-xs-4 col-xs-offset-8">
                  <button class="btn btn-sm btn-clear-g">FOLLOW</button>
                </div>
                <div class="sp-title">
                  <h3>LORDE</h3>
                </div>
                <div class="play">
                  <i class="fa fa-play-circle"></i>
                </div>
              </div>
              <p class="followers"><i class="fa fa-user"></i> 576,000 FOLLOWERS</p>
            </div>
          </div><! --/col-md-4-->

          <! -- Spotify Panel -->
          <div class="col-lg-3 col-md-3 col-sm-3 mb">
            <div class="content-panel pn">
              <div id="spotify">
                <div class="col-xs-4 col-xs-offset-8">
                  <button class="btn btn-sm btn-clear-g">FOLLOW</button>
                </div>
                <div class="sp-title">
                  <h3>LORDE</h3>
                </div>
                <div class="play">
                  <i class="fa fa-play-circle"></i>
                </div>
              </div>
              <p class="followers"><i class="fa fa-user"></i> 576,000 FOLLOWERS</p>
            </div>
          </div><! --/col-md-4-->


        </div>
      </div>
    </section><! --/wrapper -->
  </section><!-- /MAIN CONTENT -->

  <!--main content end-->

  <!--footer start-->
  <jsp:include page="/WEB-INF/reuse/footer.jsp"/>
  <!--footer end-->
</section>

<!-- js placed at the end of the document so the pages load faster -->
<jsp:include page="/WEB-INF/reuse/js.jsp"/>
<!-- 让侧边栏菜单高亮 -->
<script>$("#fileMainId").attr({"class" : "active"});</script>

</body>
</html>


