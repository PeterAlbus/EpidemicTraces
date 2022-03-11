<%--
  Created by IntelliJ IDEA.
  User: wuhon
  Date: 2021/3/9
  Time: 13:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>死亡数据预测</title>
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
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#">疫情状况预测</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="page-banner">
    <h1 class="text-center text-white font-weight-bold" style="width: 100%;position: absolute;top:200px">疫情状况预测</h1>
</div>
<div class="d-flex container-fluid toggled" id="wrapper">
    <div class="bg-light border-right" id="sidebar-wrapper">
        <div class="sidebar-heading">切换数据</div>
        <div class="list-group list-group-flush">
            <a href="#predict" class="list-group-item list-group-item-action bg-light">全球死亡人数预测</a>
            <a href="${pageContext.request.contextPath}/GlobalConfirmPredict" class="list-group-item list-group-item-action bg-light">全球确诊人数预测</a>
            <a href="${pageContext.request.contextPath}/ChinaConfirmPredict" class="list-group-item list-group-item-action bg-light">中国确诊人数预测</a>
            <a href="${pageContext.request.contextPath}/USAConfirmPredict" class="list-group-item list-group-item-action bg-light">美国确诊人数预测</a>
            <a href="${pageContext.request.contextPath}/IndRNNPredict" class="list-group-item list-group-item-action bg-light">IndRNN模型展示</a>
        </div>
    </div>
    <div id="page-content-wrapper">
        <div class="hide-button">
            <button class="btn btn-light" id="menu-toggle">查看其他数据</button>
        </div>
        <section class="page-section" id="predict">
            <div class="container" style="text-align: center">
                <h2 class="text-center mt-0">全球死亡人数预测</h2>
                <hr class="divider my-4" />
                <div class="box"></div>
            </div>
        </section>
    </div>
</div>
<script>
    var myChart=echarts.init(document.querySelector(".box"));
    var date=[];
    var a=[];
    var predict=[];
    var adjust=[];
    <c:forEach items="${predictList}" var="predict">
        date.push('${predict.getDate()}');
        <c:choose>
        <c:when test="${predict.getGlobal_death()==0}">
            a.push('');
        </c:when>
        <c:otherwise>
            a.push(${predict.getGlobal_death()});
        </c:otherwise>
        </c:choose>
        <c:choose>
        <c:when test="${predict.getGlobal_death_predict()==0}">
            predict.push('');
        </c:when>
        <c:otherwise>
            predict.push(${predict.getGlobal_death_predict()});
        </c:otherwise>
        </c:choose>
        <c:choose>
        <c:when test="${predict.getGlobal_death_adjust()==0}">
            adjust.push('');
        </c:when>
        <c:otherwise>
            adjust.push(${predict.getGlobal_death_adjust()});
        </c:otherwise>
        </c:choose>
    </c:forEach>
    var option;
    option = {
        title: {
            text: '死亡数据'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['死亡人数', '3*LSTM','Bi-LSTM'],
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
                name: '死亡人数',
                type: 'line',
                stack: '1',
                data: a
            },
            {
                name: '3*LSTM',
                type: 'line',
                stack: '2',
                data: predict,
                itemStyle: {
                    normal: {
                        color: "#DB5860",//折线点的颜色
                        lineStyle: {
                            color: "#DB5860"//折线的颜色
                        }
                    }
                },
            },
            {
                name: 'Bi-LSTM',
                type: 'line',
                stack: '3',
                itemStyle: {
                    normal: {
                        color: "#fadb14",//折线点的颜色
                        lineStyle: {
                            color: "#fadb14"//折线的颜色
                        }
                    }
                },
                data: adjust
            },
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
</html>
