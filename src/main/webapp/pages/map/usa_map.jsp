<%--
  Created by IntelliJ IDEA.
  User: wuhon
  Date: 2021/3/13
  Time: 17:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>美国疫情数据</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
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
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#usa_map">地图展示</a></li>
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
            <a href="${pageContext.request.contextPath}/chinamap#china_map" class="list-group-item list-group-item-action bg-light">中国</a>
            <a href="#usa_map" class="list-group-item list-group-item-action bg-light">美国</a>
            <a href="#" class="list-group-item list-group-item-action bg-light">敬请期待</a>
            <a href="#" class="list-group-item list-group-item-action bg-light">敬请期待</a>
            <a href="#" class="list-group-item list-group-item-action bg-light">敬请期待</a>
            <a href="#" class="list-group-item list-group-item-action bg-light">敬请期待</a>
        </div>
    </div>
    <div id="page-content-wrapper">
        <div class="hide-button">
            <button class="btn btn-light" id="menu-toggle">更改显示国家</button>
            <button class="btn btn-light" onclick="location.href='/UpdateUSA'">更新数据</button>
        </div>
        <section class="page-section" id="usa_map">
            <div class="container" style="text-align: center">
                <h2 class="text-center mt-0">美国疫情信息展示</h2>
                <hr class="divider my-4" />
                <div class="box_map"></div>
            </div>
        </section>
    </div>
</div>
<script>
    var myChart = echarts.init(document.querySelector(".box_map"));
    var Data=[];
    <c:forEach items="${USAmaplist}" var="USAmap">
    Data.push({name: '${USAmap.city}',value: ${USAmap.count}});
    </c:forEach>
    var ROOT_PATH = 'https://cdn.jsdelivr.net/gh/apache/echarts-website@asf-site/examples';
    myChart.showLoading();

    $.getJSON ("/js/USA.json", function (usaJson){
/*    $.get(ROOT_PATH + '/data/asset/geo/USA.json', function (usaJson) {*/
        myChart.hideLoading();
        echarts.registerMap
        (
            'USA', usaJson,
            {
            Alaska: {              // 把阿拉斯加移到美国主大陆左下方
                left: -131,
                top: 25,
                width: 15
            },
            Hawaii: {
                left: -110,        // 夏威夷
                top: 28,
                width: 5
            },
            'Puerto Rico': {       // 波多黎各
                left: -76,
                top: 26,
                width: 2
            }
        });
        var optionMap = {
            title: {
                text: 'USA',
                left: 'right'
            },
            tooltip: {
                trigger: 'item',
                showDelay: 0,
                transitionDuration: 0.2,
                formatter: function (params) {
                    var value = (params.value + '').split('.');
                    value = value[0].replace(/(\d{1,3})(?=(?:\d{3})+(?!\d))/g, '$1,');
                    return params.seriesName + '<br/>' + params.name + ': ' + value;
                }
            },
            visualMap: {
                left: 'right',
                min: 2000,
                max: 2500000,
                inRange: {
                    color: ['#313695', '#4575b4', '#74add1', '#abd9e9', '#e0f3f8', '#ffffbf', '#fee090', '#fdae61', '#f46d43', '#d73027', '#a50026']
                },
                text: ['High', 'Low'],
                calculable: true
            },
            toolbox: {
                show: true,
                //orient: 'vertical',
                left: 'left',
                top: 'top',
                feature: {
                    dataView: {readOnly: false},
                    restore: {},
                    saveAsImage: {}
                }
            },
            series: [
                {
                    name: 'USA',
                    type: 'map',
                    roam: true,
                    map: 'USA',
                    emphasis: {
                        label: {
                            show: true
                        }
                    },
                    textFixed: {
                        Alaska: [20, -20]
                    },
                    data:Data
                }
            ]
        };
        myChart.setOption(optionMap);
    });
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
