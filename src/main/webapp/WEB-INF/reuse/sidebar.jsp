<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!--sidebar start-->
<aside>
    <div id="sidebar" class="nav-collapse ">
        <!-- sidebar menu start-->
        <ul class="sidebar-menu" id="nav-accordion">

            <p class="centered"><a href="profile.html"><img src="/assets/img/ui-sam.jpg" class="img-circle"
                                                            width="60"></a></p>
            <h5 class="centered">${sessionScope.currentUser.userName}</h5>

            <li class="mt">
                <a id="userMainId" href="/user/list.htm">
                    <i class="fa fa-user"></i>
                    <span>用户管理</span>
                </a>
            </li>

            <li class="sub">
                <a id="roleMainId" href="/role/list.htm">
                    <i class="fa fa-dashboard"></i>
                    <span>角色管理</span>
                </a>
            </li>

            <%--<li class="sub">--%>
            <%--<a id="authorMainId" href="/operation/list.htm">--%>
            <%--<i class="fa fa-cogs"></i>--%>
            <%--<span>角色权限管理</span>--%>
            <%--</a>--%>
            <%--</li>--%>

            <li class="sub">
                <a id="fileMainId" href="/filec/listFile.htm">
                    <i class="fa fa-desktop"></i>
                    <span>资源管理</span>
                </a>
            </li>

            <li class="sub">
                <a id="myUpLoadId" href="/task/listMyFile.htm">
                    <i class="fa fa-desktop"></i>
                    <span>投稿管理</span>
                </a>
            </li>

            <li class="sub-menu">
                <a id="workMainId" href="javascript:;">
                    <i class="fa fa-book"></i>
                    <span>任务管理</span>
                </a>
                <ul class="sub">
                    <li><a href="/task/taskList.htm?taskState=0">待领任务</a></li>
                    <li><a href="/task/taskList.htm?taskState=1">待办任务</a></li>
                    <li><a href="/task/showHistroicTask.htm">已完成任务</a></li>
                    <li><a href="/task/showAllRunningTasks.htm">所有正在运行的任务</a></li>
                </ul>
            </li>
            <%--<li class="sub-menu">--%>
            <%--<a id="processMainId" href="javascript:;">--%>
            <%--<i class="fa fa-book"></i>--%>
            <%--<span>流程管理</span>--%>
            <%--</a>--%>
            <%--<ul class="sub">--%>
            <%--<li><a href="">所有运行中流程</a></li>--%>
            <%--<li><a href="">我参与的流程</a></li>--%>
            <%--</ul>--%>
            <%--</li>--%>
        </ul>
        <!-- sidebar menu end-->
    </div>
</aside>
<!--sidebar end-->
