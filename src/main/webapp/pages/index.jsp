<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>疫迹</title>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet" />
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav">
    <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="#">疫迹</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto my-2 my-lg-0">
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#news">要闻</a></li>
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/InfoCollection">打卡</a></li>
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/china_daily">图表展示</a></li>
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/chinamap">地图展示</a></li>
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/GlobalDeathPredict">疫情状况预测</a></li>
            </ul>
        </div>
    </div>
</nav>
<header class="masthead">
    <div class="container h-100">
        <div class="row h-100 align-items-center justify-content-center text-center">
            <div class="col-lg-10 align-self-end">
                <h1 class="text-uppercase text-white font-weight-bold">疫迹-高校疫情评估管理系统</h1>
                <hr class="divider my-4" />
            </div>
            <div class="col-lg-8 align-self-baseline">
                <p class="text-white-75 font-weight-light mb-5">您可以在这里查看疫情要闻及预测，下滑查看</p>
                <a class="btn btn-primary btn-xl js-scroll-trigger" href="#news">查看最新消息</a>
            </div>
        </div>
    </div>
</header>
<section class="page-section" id="news">
    <div class="container">
        <h2 class="text-center mt-0">新闻速递</h2>
        <hr class="divider my-4" />
        <div>
            <h3 class="text-center">
                当前疫情信息<br>累计确诊:<code>${today.getComulative()}</code>,当前确诊:<code>${today.getNewCase()}</code>,死亡:<code>${today.getDeath()}</code>
            </h3>
            <c:forEach items="${newslist}" var="news">
                <h2>${news.title}</h2>
                <p>${news.summary}......<a href="${news.sourceUrl}" target="_blank">查看详情</a></p>
            </c:forEach>
        </div>
    </div>
</section>
<footer class="bg-light py-5">
    <div class="container"><div class="small text-center text-muted">Copyright © 2021 - PeterAlbus&LJH</div></div>
</footer>
<script src="../js/http_code.jquery.com_jquery-3.5.1.slim.js"></script>
<script src="../js/http_cdn.jsdelivr.net_npm_bootstrap@4.5.3_dist_js_bootstrap.bundle.js"></script>
<script src="../js/http_cdnjs.cloudflare.com_ajax_libs_jquery-easing_1.4.1_jquery.easing.js"></script>
<script src="../js/http_cdnjs.cloudflare.com_ajax_libs_magnific-popup.js_1.1.0_jquery.magnific-popup.js"></script>
<script src="../js/scripts.js"></script>
</body>
</html>
