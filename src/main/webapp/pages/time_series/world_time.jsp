<%--
  Created by IntelliJ IDEA.
  User: PeterAlbus
  Date: 2021/3/19
  Time: 21:13
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
            <a href="${pageContext.request.contextPath}/ChinaNew" class="list-group-item list-group-item-action bg-light">中国今日新增</a>
            <a href="#daily" class="list-group-item list-group-item-action bg-light">世界疫情变化图</a>
        </div>
    </div>
    <div id="page-content-wrapper">
        <div class="hide-button">
            <button class="btn btn-light" id="menu-toggle">查看其他数据</button>
        </div>
        <section class="page-section" id="daily">
            <div class="container" style="text-align: center">
                <h2 class="text-center mt-0">世界疫情信息变化趋势展示</h2>
                <hr class="divider my-4" />
            </div>
            <div class="box_huge"></div>
        </section>
    </div>
</div>
<script>
    var myChart=echarts.init(document.querySelector(".box_huge"));
    var dateList=[];
    var source=[];
    source.push(['date','USA','China','Japan','Germany','UK','France','India']);
    <c:forEach items="${worldTimeList}" var="worldTime">
        dateList.push('${worldTime.getDate()}');
        source.push(['${worldTime.getDate()}',${worldTime.getUSA()},${worldTime.getChina()},${worldTime.getJapan()},${worldTime.getGermany()},${worldTime.getUK()},${worldTime.getFrance()},${worldTime.getIndia()}])
    </c:forEach>
    var countryList=['USA','China','Japan','Germany','UK','France','India'];
    var option = {
        timeline:{
            axisType: 'category',
            autoPlay: true,
            playInterval: 1500,
            data: dateList,
            label:{
                fontSize: 18
            }
        },
        baseOption:{
            dataset:{
                source:source
            },

            title: {
                text: '2020.6月各国确诊人数',
                left: 'center',
                textStyle:{
                    fontSize:24
                }
            },
            tooltip: {
                trigger: 'axis'
            },
            toolbox: {
                feature: {
                    saveAsImage: {}
                }
            },
            legend: {
            },
            grid: {
                left: '10%',
                bottom: '15%',
                containLabel: true
            },
            xAxis: [
                {
                    type:'category',
                    data: countryList,
                    axisPointer: {
                        type: 'shadow'
                    },

                    axisLabel: {
                        formatter: function (value) {
                            return '{' + value + '| }\n{value|' + value + '}';
                        },
                        margin: 0,
                        rich: {
                            value: {
                                lineHeight: 10,
                                fontSize: 15,
                                align: 'center'
                            },
                            USA: {
                                height: 20,
                                align: 'center',
                            },
                            China: {
                                height: 20,
                                align: 'center',
                            },
                            Germany: {
                                height: 20,
                                align: 'center',
                            },
                            UK: {
                                height: 20,
                                align: 'center',
                            },
                            France: {
                                height: 20,
                                align: 'center',
                            },
                            Japan: {
                                height: 20,
                                align: 'center',
                            },
                            India: {
                                height: 20,
                                align: 'center',
                            },
                        }
                    }

                },
            ],
            yAxis:[
                {
                    name:'确诊人数',
                    type:'value',
                    nameTextStyle:{
                        fontSize:18
                    },
                    axisLabel:{
                        fontSize:18
                    }
                },
            ],
            series: [
                {
                    type: 'bar',
                    seriesLayoutBy: 'row',
                    encode:{
                        x:'year',
                        y:'1998'
                    }
                },
            ]
        },
        options:[]
    };
    for (var n = 0; n<dateList.length; n++){
        option.options.push({
            title:{
                show:true,
                text:dateList[n]+'月各国确诊人数',
                left: 'center',
                textStyle:{
                    fontSize:24
                }
            },
            series:[
                {
                    type: 'bar',
                    seriesLayoutBy: 'row',
                    encode:{
                        x:'year',
                        y:dateList[n]
                    }
                },
            ]
        });
    }
    myChart.setOption(option);
</script>
<script src="../../js/http_code.jquery.com_jquery-3.5.1.slim.js"></script>
<script src="../../js/http_cdn.jsdelivr.net_npm_bootstrap@4.5.3_dist_js_bootstrap.bundle.js"></script>
<script src="../../js/http_cdnjs.cloudflare.com_ajax_libs_jquery-easing_1.4.1_jquery.easing.js"></script>
<script src="../../js/http_cdnjs.cloudflare.com_ajax_libs_magnific-popup.js_1.1.0_jquery.magnific-popup.js"></script>
<script src="../../js/scripts.js"></script>
<footer class="bg-light py-5">
    <div class="container"><div class="small text-center text-muted">Copyright © 2021 - PeterAlbus&Jay</div></div>
</footer>
</body>
</html>
