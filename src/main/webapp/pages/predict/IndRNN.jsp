<%--
  Created by IntelliJ IDEA.
  User: PeterAlbus
  Date: 2021/6/5
  Time: 22:58
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>IndRNN模型</title>
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
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/china_daily">图表展示</a></li>
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/chinamap">地图展示</a></li>
                <li class="nav-item"><a class   ="nav-link js-scroll-trigger" href="#">疫情状况预测</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="page-banner">
    <h1 class="text-center text-white font-weight-bold" style="width: 100%;position: absolute;top:200px">疫情状况预测</h1>
</div>
<div class="d-flex container-fluid toggled" id="wrapper">
    <section class="page-section" id="predict">
        <div class="container" style="text-align: center">
            <h2 class="text-center mt-0">IndRNN模型-世界确诊人数</h2>
            <hr class="divider my-4" />
            <div class="box"></div>
        </div>
    </section>
</div>
<script>
    var myChart=echarts.init(document.querySelector(".box"));
    var option;
    var date=[];
    var a=[];
    var predict=[];
    <c:forEach items="${predictList}" var="predict">
        <c:choose>
            <c:when test="${predict.getSh_confirm()==0&&predict.getSh_confirm_predict()==0}">
            </c:when>
            <c:otherwise>
                date.push('${predict.getDate()}');
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${predict.getBrazil()==0&&predict.getBrazil_Predict()!=0}">
                a.push('');
            </c:when>
            <c:when test="${predict.getBrazil()!=0}">
                a.push(${predict.getBrazil()});
            </c:when>
        </c:choose>
        <c:choose>
            <c:when test="${predict.getBrazil_Predict()==0&&predict.getBrazil()!=0}">
                predict.push('');
            </c:when>
            <c:when test="${predict.getBrazil_Predict()!=0}">
                predict.push(${predict.getBrazil_Predict()});
            </c:when>
        </c:choose>
    </c:forEach>
    option = {
        title: {
            text: '确诊人数'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['确诊人数', '预测人数'],
            selected:{
                '3*LSTM':false,
                'Bi-LSTM':false,
            }
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
                name: '确诊人数',
                type: 'line',
                stack: '1',
                data: a
            },
            {
                name: '预测人数',
                type: 'line',
                stack: '2',
                itemStyle: {
                    normal: {
                        color: "#DB5860",//折线点的颜色
                        lineStyle: {
                            color: "#DB5860"//折线的颜色
                        }
                    }
                },
                data: predict
            }
        ]
    };
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