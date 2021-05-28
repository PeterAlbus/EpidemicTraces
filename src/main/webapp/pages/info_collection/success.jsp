<%--
  Created by IntelliJ IDEA.
  User: wuhon
  Date: 2021/3/14
  Time: 20:02
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
        <a class="navbar-brand js-scroll-trigger" href="${pageContext.request.contextPath}/index">疫迹</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto my-2 my-lg-0">
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/index#news">要闻</a></li>
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#">打卡</a></li>
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/china_daily">图表展示</a></li>
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/chinamap">地图展示</a></li>
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/GlobalDeathPredict">疫情状况预测</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="page-banner">
    <h1 class="text-center text-white font-weight-bold" style="width: 100%;position: absolute;top:200px">学生打卡</h1>
</div>
<section class="page-section" id="daily">
    <div class="container" style="text-align: center">
        <h2 class="text-center mt-0">打卡成功!</h2>
        <hr class="divider my-4" />
        <div class="container" style="margin: 0 auto">
            <h3>提交的打卡信息:</h3>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>key</th>
                    <th>value</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>学号</td>
                    <td>${clock_in.getStu_id()}</td>
                </tr>
                <tr>
                    <td>姓名</td>
                    <td>${clock_in.getStu_name()}</td>
                </tr>
                <tr>
                    <td>班级</td>
                    <td>${clock_in.getStu_class()}</td>
                </tr>
                <tr>
                    <td>今晚居住地址</td>
                    <td>${clock_in.getStu_address()}</td>
                </tr>
                <tr>
                    <td>今日体温</td>
                    <td>${clock_in.getStu_tmp()}</td>
                </tr>
                <tr>
                    <td>是否出行</td>
                    <td>${clock_in.isIs_out()}</td>
                </tr>
                <tr>
                    <td>出行目的地</td>
                    <td>${clock_in.getStu_des()}</td>
                </tr>
                <tr>
                    <td>出发时间</td>
                    <td>${clock_in.getStu_out()}</td>
                </tr>
                <tr>
                    <td>返回时间</td>
                    <td>${clock_in.getStu_back()}</td>
                </tr>
                <tr>
                    <td>打卡时间</td>
                    <td>${clock_in.getClock_date()}</td>
                </tr>
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
