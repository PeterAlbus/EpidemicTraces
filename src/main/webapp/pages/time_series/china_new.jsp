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
            <a href="${pageContext.request.contextPath}/china_daily" class="list-group-item list-group-item-action bg-light">中国-时间序列图</a>
            <a href="${pageContext.request.contextPath}/ChinaProvince" class="list-group-item list-group-item-action bg-light">中国-饼图</a>
            <a href="#daily" class="list-group-item list-group-item-action bg-light">中国今日新增</a>
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
                <div class="box_large"></div>
            </div>
        </section>
    </div>
</div>
<script>
    var dataAxis = [];
    var data = [];
    <c:forEach items="${chinaProvinceList}" var="chinaProvince">
    dataAxis.push('${chinaProvince.name}');
    data.push(${chinaProvince.value});
    </c:forEach>
    var myChart=echarts.init(document.querySelector(".box_large"));
    var option;
    var yMax = 500;
    var dataShadow = [];
    for (var i = 0; i < data.length; i++) {
        dataShadow.push(yMax);
    }
    option = {
        title: {
            text: '中国今日各省份新增',
            subtext: '点击即可进行放大，滑动滚轮缩小/放大'
        },
        xAxis: {
            data: dataAxis,
            axisLabel: {
                inside: true,
                textStyle: {
                    color: '#000000'
                }
            },
            axisTick: {
                show: false
            },
            axisLine: {
                show: false
            },
            z: 10
        },
        yAxis: {
            axisLine: {
                show: false
            },
            axisTick: {
                show: false
            },
            axisLabel: {
                textStyle: {
                    color: '#000000'
                }
            }
        },
        dataZoom: [
            {
                type: 'inside'
            }
        ],
        series: [
            {
                type: 'bar',
                showBackground: true,
                itemStyle: {
                    color: new echarts.graphic.LinearGradient(
                        0, 0, 0, 1,
                        [
                            {offset: 0, color: '#83bff6'},
                            {offset: 0.5, color: '#188df0'},
                            {offset: 1, color: '#188df0'}
                        ]
                    )
                },
                emphasis: {
                    itemStyle: {
                        color: new echarts.graphic.LinearGradient(
                            0, 0, 0, 1,
                            [
                                {offset: 0, color: '#2378f7'},
                                {offset: 0.7, color: '#2378f7'},
                                {offset: 1, color: '#83bff6'}
                            ]
                        )
                    }
                },
                data: data
            }
        ]
    };

    // Enable data zoom when user click bar.
    var zoomSize = 6;
    myChart.on('click', function (params) {
        console.log(dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)]);
        myChart.dispatchAction({
            type: 'dataZoom',
            startValue: dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)],
            endValue: dataAxis[Math.min(params.dataIndex + zoomSize / 2, data.length - 1)]
        });
    });
    myChart.setOption(option);
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
