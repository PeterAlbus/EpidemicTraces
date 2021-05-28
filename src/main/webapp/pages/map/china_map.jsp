<%--
  Created by IntelliJ IDEA.
  User: PeterAlbus
  Date: 2021/3/6
  Time: 16:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>中国疫情数据展示</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/china.js"></script>
    <link href="${pageContext.request.contextPath}/css/echart.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/simple-sidebar.css" rel="stylesheet">
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
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/InfoCollection">打卡</a></li>
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/china_daily">图表展示</a></li>
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#china_map">地图展示</a></li>
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/GlobalDeathPredict">疫情状况预测</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="page-banner">
    <h1 class="text-center text-white font-weight-bold" style="width: 100%;position: absolute;top:200px">地图展示</h1>
</div>
<div class="d-flex container-fluid toggled" id="wrapper">
    <div class="bg-light border-right" id="sidebar-wrapper">
        <div class="sidebar-heading">选择地区</div>
        <div class="list-group list-group-flush">
            <a href="#china_map" class="list-group-item list-group-item-action bg-light">中国</a>
            <a href="${pageContext.request.contextPath}/USAMap#usa_map" class="list-group-item list-group-item-action bg-light">美国</a>
            <a href="#" class="list-group-item list-group-item-action bg-light">敬请期待</a>
            <a href="#" class="list-group-item list-group-item-action bg-light">敬请期待</a>
            <a href="#" class="list-group-item list-group-item-action bg-light">敬请期待</a>
            <a href="#" class="list-group-item list-group-item-action bg-light">敬请期待</a>
        </div>
    </div>
    <div id="page-content-wrapper">
        <div class="hide-button">
            <button class="btn btn-light" id="menu-toggle">更改显示国家</button>
            <button class="btn btn-light" onclick="location.href='/UpdateChina'">更新数据</button>
        </div>
        <section class="page-section" id="china_map">
            <div class="container" style="text-align: center!important;">
                <h2 class="text-center mt-0">中国疫情信息展示（以国家标准地图为准）</h2>
                <hr class="divider my-4" />
                <div class="box_map"></div>
            </div>
        </section>
    </div>
</div>
<script>
    var Data=[];
    <c:forEach items="${chinamaplist}" var="chinamap">
        Data.push({name: '${chinamap.city}',value: ${chinamap.count}});
    </c:forEach>
    var optionMap = {
        backgroundColor: '#FFFFFF',
        title: {
            text: '全国地图大数据',
            subtext: '',
            x:'center'
        },
        tooltip : {
            trigger: 'item'
        },
        visualMap: {
            show : true,
            x: 'left',
            y: 'center',
            splitList: [
                {start: 4000, end:100000},{start: 1000, end: 4000},
                {start: 700, end: 1000},{start: 500, end: 700},
                {start: 100, end: 600},{start: 0, end: 100},
            ],
            color: ['#DB5860', '#ffa115', '#ffe44b','#0600ff', '#00FFF3', '#65f64b']
        },
        series: [{
            name: '确诊人数',
            type: 'map',
            mapType: 'china',
            roam: true,
            label: {
                normal: {
                    show: true
                },
                emphasis: {
                    show: false
                }
            },
            data:Data
        }]
    };
    var myChart = echarts.init(document.querySelector(".box_map"));
    myChart.setOption(optionMap);
</script>
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
