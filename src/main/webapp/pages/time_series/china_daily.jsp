<%--
  Created by IntelliJ IDEA.
  User: wuhon
  Date: 2021/2/9
  Time: 13:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>信息展示</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/echart.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
    <link href="${pageContext.request.contextPath}/css/page-banner.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/simple-sidebar.css" rel="stylesheet">
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
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#">图表展示</a></li>
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/chinamap">地图展示</a></li>
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/GlobalDeathPredict">疫情状况预测</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="page-banner">
    <h1 class="text-center text-white font-weight-bold" style="width: 100%;position: absolute;top:200px">时间序列数据</h1>
</div>
<div class="d-flex container-fluid toggled" id="wrapper">
    <div class="bg-light border-right" id="sidebar-wrapper">
        <div class="sidebar-heading">切换数据</div>
        <div class="list-group list-group-flush">
            <a href="#daily" class="list-group-item list-group-item-action bg-light">中国-时间序列图</a>
            <a href="${pageContext.request.contextPath}/ChinaProvince" class="list-group-item list-group-item-action bg-light">中国-饼图</a>
            <a href="${pageContext.request.contextPath}/ChinaNew" class="list-group-item list-group-item-action bg-light">中国今日新增</a>
            <a href="${pageContext.request.contextPath}/WorldTime" class="list-group-item list-group-item-action bg-light">世界疫情变化图</a>
        </div>
    </div>
    <div id="page-content-wrapper">
        <div class="hide-button">
            <button class="btn btn-light" id="menu-toggle">查看其他数据</button>
        </div>
        <section class="page-section" id="daily">
            <div class="container" style="text-align: center">
                <h2 class="text-center mt-0">中国疫情信息展示</h2>
                <hr class="divider my-4" />
                <div class="box"></div>
                <div class="box2"></div>
            </div>
        </section>
    </div>
</div>
<script>
    var date=[];
    var newCase=[];
    var comulative=[];
    var death=[];
    <c:forEach items="${chinalist}" var="chinadaily">
        date.push("${chinadaily.date}");
        newCase.push(${chinadaily.newCase});
        comulative.push(${chinadaily.comulative});
        death.push(${chinadaily.death});
    </c:forEach>
    var myChart=echarts.init(document.querySelector(".box"));
    var myChart2=echarts.init(document.querySelector(".box2"));
    var option;
    option = {
        title: {
            text: '疫情数据'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['当前确诊', '累计确诊', '死亡']
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        toolbox: {
            feature: {
                saveAsImage: {}
            }
        },
        xAxis: {
            type: 'category',
            boundaryGap: false,
            data: date
        },
        yAxis: {
            type: 'value'
        },
        series: [
            {
                name: '当前确诊',
                type: 'line',
                stack: '总量',
                data: newCase
            },
            {
                name: '累计确诊',
                type: 'line',
                stack: '总量',
                data: comulative
            },
            {
                name: '死亡',
                type: 'line',
                stack: '2',
                data: death
            },
        ]
    };
    myChart.setOption(option);
    var option2 = {
        title: {
            text: '疫情数据区域图'
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'cross',
                label: {
                    backgroundColor: '#6a7985'
                }
            }
        },
        legend: {
            data: ['当前确诊', '累计确诊']
        },
        toolbox: {
            feature: {
                saveAsImage: {}
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis: [
            {
                type: 'category',
                boundaryGap: false,
                data: date
            }
        ],
        yAxis: [
            {
                type: 'value'
            }
        ],
        series: [
            {
                name: '累计确诊',
                type: 'line',
                stack: '总量',
                areaStyle: {},
                emphasis: {
                    focus: 'series'
                },
                data: comulative
            },
            {
                name: '当前确诊',
                type: 'line',
                stack: '总量',
                areaStyle: {},
                emphasis: {
                    focus: 'series'
                },
                data: newCase
            },
        ]
    };
    myChart2.setOption(option2);
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
