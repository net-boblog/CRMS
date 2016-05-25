<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--sidebar start-->

<aside>
    <div id="sidebar" class="nav-collapse ">
        <!-- sidebar menu start-->
        <ul class="sidebar-menu" id="nav-accordion">

            <p class="centered"><a href="javascript:openEditUserInfo()">

                <c:if test="${sessionScope.currentUser.imgUrl==null}">
                <img src="/assets/img/ui-sam.jpg" class="img-circle" width="60" ></a></p>
                    </c:if>
            <c:if test="${sessionScope.currentUser.imgUrl!=null}">
                <img src="${sessionScope.currentUser.imgUrl}" class="img-circle" width="60"></a></p>
            </c:if>
            <h5 class="centered">${sessionScope.currentUser.userName}</h5>
            <c:forEach items="${sessionScope.menuList}" var="menu">
                <c:if test="${menu.name == '用户管理'}">
                    <li class="mt">
                        <a id="userMainId" href="${menu.url}">
                            <i class="fa fa-user"></i>
                            <span>${menu.name}</span>
                        </a>
                    </li>
                </c:if>
                <c:if test="${menu.name == '角色管理'}">
                    <li class="sub">
                        <a id="roleMainId" href="${menu.url}">
                            <i class="fa fa-dashboard"></i>
                            <span>${menu.name}</span>
                        </a>
                    </li>
                </c:if>
                <c:if test="${menu.name == '资源管理'}">
                    <li class="sub">
                        <a id="fileMainId" href="${menu.url}">
                            <i class="fa fa-desktop"></i>
                            <span>${menu.name}</span>
                        </a>
                    </li>
                </c:if>
            <c:if test="${menu.name == '资源共享库'}">
                <li class="sub">
                    <a id="fileLibId" href="${menu.url}">
                        <i class="fa fa-cloud"></i>
                        <span>${menu.name}</span>
                    </a>
                </li>
            </c:if>
                <c:if test="${menu.name == '我的资源'}">
                    <li class="sub">
                        <a id="myUpLoadId" href="${menu.url}">
                            <i class="fa fa-tasks"></i>
                            <span>${menu.name}</span>
                        </a>
                    </li>
                </c:if>
            <c:choose>
                    <c:when test="${menu.name=='任务管理'}">
                        <li class="sub-menu">
                        <a id="workMainId" href="javascript:;">
                            <i class="fa fa-book"></i>
                            <span>${menu.name}</span>
                        </a>
                        <ul class="sub">
                    </c:when>
                <c:when test="${menu.name == '待领任务'}">
                        <li><a href="${menu.url}">${menu.name}</a></li>
                        </li>
                </c:when>
                    <c:when test="${menu.name == '待办任务'}">
                        <li><a href="${menu.url}">${menu.name}</a></li>
                        </li>
                    </c:when>
                    <c:when test="${menu.name == '历史任务'}">
                        <li><a href="${menu.url}">${menu.name}</a></li>
                        </li>
                    </c:when>
                     <c:when test="${menu.name == '所有正在运行的任务'}">
                            <li><a href="${menu.url}">${menu.name}</a></li>
                            </li>
                  </c:when>
                    <c:when test ="1==1">
                    </ul>
                    </li>
                    </c:when>
                    </c:choose>
                </c:forEach>
            <%--<li class="mt">--%>
                <%--<a id="userMainId" href="/user/list.htm">--%>
                    <%--<i class="fa fa-user"></i>--%>
                    <%--<span>用户管理</span>--%>
                <%--</a>--%>
            <%--</li>--%>

            <%--<li class="sub">--%>
                <%--<a id="roleMainId" href="/role/list.htm">--%>
                    <%--<i class="fa fa-dashboard"></i>--%>
                    <%--<span>角色管理</span>--%>
                <%--</a>--%>
            <%--</li>--%>

            <%--&lt;%&ndash;<li class="sub">&ndash;%&gt;--%>
            <%--&lt;%&ndash;<a id="authorMainId" href="/operation/list.htm">&ndash;%&gt;--%>
            <%--&lt;%&ndash;<i class="fa fa-cogs"></i>&ndash;%&gt;--%>
            <%--&lt;%&ndash;<span>角色权限管理</span>&ndash;%&gt;--%>
            <%--&lt;%&ndash;</a>&ndash;%&gt;--%>
            <%--&lt;%&ndash;</li>&ndash;%&gt;--%>

            <%--<li class="sub">--%>
                <%--<a id="fileMainId" href="/filec/listFile.htm">--%>
                    <%--<i class="fa fa-desktop"></i>--%>
                    <%--<span>资源管理</span>--%>
                <%--</a>--%>
            <%--</li>--%>

            <%--<li class="sub">--%>
                <%--<a id="myUpLoadId" href="/task/listMyFile.htm">--%>
                    <%--<i class="fa fa-desktop"></i>--%>
                    <%--<span>我的资源</span>--%>
                <%--</a>--%>
            <%--</li>--%>

            <%--<li class="sub-menu">--%>
                <%--<a id="workMainId" href="javascript:;">--%>
                    <%--<i class="fa fa-book"></i>--%>
                    <%--<span>任务管理</span>--%>
                <%--</a>--%>
                <%--<ul class="sub">--%>
                    <%--<li><a href="/task/taskList.htm?taskState=0">待领任务</a></li>--%>
                    <%--<li><a href="/task/taskList.htm?taskState=1">待办任务</a></li>--%>
                    <%--<li><a href="/task/showHistroicTask.htm">历史任务</a></li>--%>
                    <%--<li><a href="/task/showAllRunningTasks.htm">所有正在运行的任务</a></li>--%>
                <%--</ul>--%>
            <%--</li>--%>
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
<script src="/assets/js/jquery.js"></script>
<script>
    $(function(){
        checkUserInfo();
    })
    //编辑用户基本信息
    function openEditUserInfo(){
        var userUrl = "/user/preUserInfo.htm?userId="+${sessionScope.currentUser.userId};
        layer.open({
            type: 2,
            title: ['编辑用户信息','font-family: Helvetica, arial, sans-serif;font-size: 14px;font-weight: bold;'],
            shade: 0.5,
            area: ['600px', '355px'],
            content: [userUrl,'no'],
            move:false
        });
    }

    function checkUserInfo(){
        if(${requestScope.userMsg=='1'}){
            openEditUserInfo();
            layer.msg("小提示：请完善您的基本信息！",{icon:5,offset:100,shift:6});
        }else if(${userMsg=='2'}){
            openEditUserInfo();
            layer.msg("小提示：绑定邮箱能绑住您找回密码哦！",{icon:5,offset:100,shift:6});
        }
    }
</script>
