<%--
  Created by IntelliJ IDEA.
  User: PeterAlbus
  Date: 2021/5/10
  Time: 19:17
--%>
<%--
  Created by IntelliJ IDEA.
  User: wuhon
  Date: 2021/3/13
  Time: 18:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>打卡系统</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/page-banner.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3 navbar-scrolled" id="mainNav">
    <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="${pageContext.request.contextPath}/index">疫迹-打卡信息查看</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto my-2 my-lg-0">
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/index#news">要闻</a></li>
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#">打卡</a></li>
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/china_daily">图表展示</a></li>
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/chinamap">地图展示</a></li>
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/pages/predict/global_death.jsp">疫情状况预测</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="page-banner">
    <h1 class="text-center text-white font-weight-bold" style="width: 100%;position: absolute;top:200px">学生打卡信息查看</h1>
</div>
<section class="page-section" id="daily">
    <div class="container" style="text-align: center">
        <div class="col-md-12 column text-center">
            <table class="table table-hover table-striped table-bordered">
                <thead>
                <tr>
                    <th>学号</th>
                    <th>姓名</th>
                    <th>班级</th>
                    <th>体温</th>
                    <th>今晚住址</th>
                    <th>是否出行</th>
                    <th>目的地</th>
                    <th>出行时间</th>
                    <th>返回时间</th>
                    <th>打卡时间</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${clockInInfoList}" var="clockInfo">
                    <tr>
                        <td>${clockInfo.getStu_id()}</td>
                        <td>${clockInfo.getStu_name()}</td>
                        <td>${clockInfo.getStu_class()}</td>
                        <td>${clockInfo.getStu_tmp()}</td>
                        <td>${clockInfo.getStu_address()}</td>
                        <td>${clockInfo.isIs_out()}</td>
                        <td>${clockInfo.getStu_des()}</td>
                        <td>${clockInfo.getStu_out()}</td>
                        <td>${clockInfo.getStu_back()}</td>
                        <td>${clockInfo.getClock_date()}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</section>
<script src="../../js/http_code.jquery.com_jquery-3.5.1.slim.js"></script>
<script src="../../js/http_cdn.jsdelivr.net_npm_bootstrap@4.5.3_dist_js_bootstrap.bundle.js"></script>
<script src="../../js/http_cdnjs.cloudflare.com_ajax_libs_jquery-easing_1.4.1_jquery.easing.js"></script>
<script src="../../js/http_cdnjs.cloudflare.com_ajax_libs_magnific-popup.js_1.1.0_jquery.magnific-popup.js"></script>
<script src="../../js/scripts.js"></script>
<footer class="bg-light py-5">
    <div class="container"><div class="small text-center text-muted">Copyright © 2021 - PeterAlbus&LJH</div></div>
</footer>
</body>
</html>

