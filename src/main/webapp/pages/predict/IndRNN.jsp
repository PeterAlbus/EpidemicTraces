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
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#">疫情状况预测</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="page-banner">
    <h1 class="text-center text-white font-weight-bold" style="width: 100%;position: absolute;top:200px">疫情状况预测</h1>
</div>
<div class="d-flex container-fluid toggled" id="wrapper">
    <div id="page-content-wrapper">
    <section class="page-section" id="predict">
        <div class="container" style="text-align: center">
            <h2 class="text-center mt-0">IndRNN模型</h2>
            <hr class="divider my-4" />
            <div class="box" id="box_china"></div>
            <br><br><br>
            <div class="box" id="box_us"></div>
            <br><br><br>
            <div class="box" id="box_india"></div>
            <br><br><br>
            <div class="box" id="box_brazil"></div>
            <br><br><br>
            <div class="box" id="box_france"></div>
            <br><br><br>
            <div class="box" id="box_global"></div>
            <br><br><br>
            <div class="box" id="box_russia"></div>
        </div>
    </section>
    </div>
</div>
<script>
    var myChart_China=echarts.init(document.querySelector("#box_china"));
    var myChart_us=echarts.init(document.querySelector("#box_us"));
    var myChart_india=echarts.init(document.querySelector("#box_india"));
    var myChart_Brazil=echarts.init(document.querySelector("#box_brazil"));
    var myChart_france=echarts.init(document.querySelector("#box_france"));
    var myChart_global=echarts.init(document.querySelector("#box_global"));
    var myChart_russia=echarts.init(document.querySelector("#box_russia"));
    var option_brazil,option_china,option_france,option_global,option_india,option_russia,option_us;
    var date=[];
    var Brazil_origin=[],Brazil_predict=[],Brazil_death_origin=[],Brazil_death_predict=[];
    var China_origin=[],China_predict=[],China_death_origin=[],China_death_predict=[];
    var France_origin=[],France_predict=[],France_death_origin=[],France_death_predict=[];
    var Global_origin=[],Global_predict=[],Global_death_origin=[],Global_death_predict=[];
    var India_origin=[],India_predict=[],India_death_origin=[],India_death_predict=[];
    var Russia_origin=[],Russia_predict=[],Russia_death_origin=[],Russia_death_predict=[];
    var US_origin=[],US_predict=[],US_death_origin=[],US_death_predict=[];
    <c:forEach items="${predictList}" var="predict">
    /*date*/
        date.push('${predict.getDate()}');
    /*brazil*/
        <c:choose>
            <c:when test="${predict.getBrazil()==0}">
                Brazil_origin.push('');
                Brazil_death_origin.push('');
            </c:when>
            <c:when test="${predict.getBrazil()!=0}">
                Brazil_origin.push(${predict.getBrazil()});
                Brazil_death_origin.push(${predict.getBrazil_death()});
            </c:when>
        </c:choose>
        <c:choose>
            <c:when test="${predict.getBrazil_Predict()==0}">
                Brazil_predict.push('');
                Brazil_death_predict.push('');
            </c:when>
            <c:when test="${predict.getBrazil_Predict()!=0}">
                Brazil_predict.push(${predict.getBrazil_Predict()});
                Brazil_death_predict.push(${predict.getBrazil_death_predict()});
            </c:when>
        </c:choose>
    /*china*/
        <c:choose>
            <c:when test="${predict.getChina()==0}">
                China_origin.push('');
                China_death_origin.push('');
            </c:when>
            <c:when test="${predict.getChina()!=0}">
                China_origin.push(${predict.getChina()});
                China_death_origin.push(${predict.getChina_death()});
            </c:when>
        </c:choose>
        <c:choose>
            <c:when test="${predict.getChina_Predict()==0}">
                China_predict.push('');
                China_death_predict.push('');
            </c:when>
            <c:when test="${predict.getChina_Predict()!=0}">
                China_predict.push(${predict.getChina_Predict()});
                China_death_predict.push(${predict.getChina_death_predict()});
            </c:when>
        </c:choose>
    /*France*/
        <c:choose>
            <c:when test="${predict.getFrance()==0}">
                France_origin.push('');
                France_death_origin.push('');
            </c:when>
            <c:when test="${predict.getFrance()!=0}">
                France_origin.push(${predict.getFrance()});
                France_death_origin.push(${predict.getFrance_death()});
            </c:when>
        </c:choose>
        <c:choose>
            <c:when test="${predict.getFrance_Predict()==0}">
                France_predict.push('');
                France_death_predict.push('');
            </c:when>
            <c:when test="${predict.getFrance_Predict()!=0}">
                France_predict.push(${predict.getFrance_Predict()});
                France_death_predict.push(${predict.getFrance_death_predict()});
            </c:when>
        </c:choose>
    /*Global*/
        <c:choose>
            <c:when test="${predict.getGlobal()==0}">
                Global_origin.push('');
                Global_death_origin.push('');
            </c:when>
            <c:when test="${predict.getGlobal()!=0}">
                Global_origin.push(${predict.getGlobal()});
                Global_death_origin.push(${predict.getGlobal_death()});
            </c:when>
        </c:choose>
        <c:choose>
            <c:when test="${predict.getGlobal_Predict()==0}">
                Global_predict.push('');
                Global_death_predict.push('');
            </c:when>
            <c:when test="${predict.getGlobal_Predict()!=0}">
                Global_predict.push(${predict.getGlobal_Predict()});
                Global_death_predict.push(${predict.getGlobal_death_predict()});
            </c:when>
        </c:choose>
    /*India*/
        <c:choose>
            <c:when test="${predict.getIndia()==0}">
                India_origin.push('');
                India_death_origin.push('');
            </c:when>
            <c:when test="${predict.getIndia()!=0}">
                India_origin.push(${predict.getIndia()});
                India_death_origin.push(${predict.getIndia_death()});
            </c:when>
        </c:choose>
        <c:choose>
            <c:when test="${predict.getIndia_Predict()==0}">
                India_predict.push('');
                India_death_predict.push('');
            </c:when>
            <c:when test="${predict.getIndia_Predict()!=0}">
                India_predict.push(${predict.getIndia_Predict()});
                India_death_predict.push(${predict.getIndia_death_predict()});
            </c:when>
        </c:choose>
    /*Russia*/
        <c:choose>
            <c:when test="${predict.getRussia()==0}">
                Russia_origin.push('');
                Russia_death_origin.push('');
            </c:when>
            <c:when test="${predict.getRussia()!=0}">
                Russia_origin.push(${predict.getRussia()});
                Russia_death_origin.push(${predict.getRussia_death()});
            </c:when>
        </c:choose>
        <c:choose>
            <c:when test="${predict.getRussia_Predict()==0}">
                Russia_predict.push('');
                Russia_death_predict.push('');
            </c:when>
            <c:when test="${predict.getRussia_Predict()!=0}">
                Russia_predict.push(${predict.getRussia_Predict()});
                Russia_death_predict.push(${predict.getRussia_death_predict()});
            </c:when>
        </c:choose>
    /*US*/
        <c:choose>
            <c:when test="${predict.getUS()==0}">
                US_origin.push('');
                US_death_origin.push('');
            </c:when>
            <c:when test="${predict.getUS()!=0}">
                US_origin.push(${predict.getUS()});
                US_death_origin.push(${predict.getUS_death()});
            </c:when>
        </c:choose>
        <c:choose>
            <c:when test="${predict.getUS_Predict()==0}">
                US_predict.push('');
                US_death_predict.push('');
            </c:when>
            <c:when test="${predict.getUS_Predict()!=0}">
                US_predict.push(${predict.getUS_Predict()});
                US_death_predict.push(${predict.getUS_death_predict()});
            </c:when>
        </c:choose>
    </c:forEach>
    option_brazil = {
        title: {
            text: '巴西疫情状况'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['确诊人数', '预测确诊人数','死亡人数','预测死亡人数'],
            selected:{
                '死亡人数':false,
                '预测死亡人数':false,
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
                data: Brazil_origin
            },
            {
                name: '预测确诊人数',
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
                data: Brazil_predict
            },
            {
                name: '死亡人数',
                type: 'line',
                stack: '3',
                itemStyle: {
                    normal: {
                        color: "#db9158",//折线点的颜色
                        lineStyle: {
                            color: "#db9158"//折线的颜色
                        }
                    }
                },
                data: Brazil_death_origin
            },
            {
                name: '预测死亡人数',
                type: 'line',
                stack: '4',
                itemStyle: {
                    normal: {
                        color: "#2c9501",//折线点的颜色
                        lineStyle: {
                            color: "#2c9501"//折线的颜色
                        }
                    }
                },
                data: Brazil_death_predict
            }
        ]
    };
    myChart_Brazil.setOption(option_brazil);
    option_china = {
        title: {
            text: '中国疫情状况'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['确诊人数', '预测确诊人数','死亡人数','预测死亡人数'],
            selected:{
                '死亡人数':false,
                '预测死亡人数':false,
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
                data: China_origin
            },
            {
                name: '预测确诊人数',
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
                data: China_predict
            },
            {
                name: '死亡人数',
                type: 'line',
                stack: '3',
                itemStyle: {
                    normal: {
                        color: "#db9158",//折线点的颜色
                        lineStyle: {
                            color: "#db9158"//折线的颜色
                        }
                    }
                },
                data: China_death_origin
            },
            {
                name: '预测死亡人数',
                type: 'line',
                stack: '4',
                itemStyle: {
                    normal: {
                        color: "#2c9501",//折线点的颜色
                        lineStyle: {
                            color: "#2c9501"//折线的颜色
                        }
                    }
                },
                data: China_death_predict
            }
        ]
    };
    myChart_China.setOption(option_china);
    option_france = {
        title: {
            text: '法国疫情状况'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['确诊人数', '预测确诊人数','死亡人数','预测死亡人数'],
            selected:{
                '死亡人数':false,
                '预测死亡人数':false,
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
                data: France_origin
            },
            {
                name: '预测确诊人数',
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
                data: France_predict
            },
            {
                name: '死亡人数',
                type: 'line',
                stack: '3',
                itemStyle: {
                    normal: {
                        color: "#db9158",//折线点的颜色
                        lineStyle: {
                            color: "#db9158"//折线的颜色
                        }
                    }
                },
                data: France_death_origin
            },
            {
                name: '预测死亡人数',
                type: 'line',
                stack: '4',
                itemStyle: {
                    normal: {
                        color: "#2c9501",//折线点的颜色
                        lineStyle: {
                            color: "#2c9501"//折线的颜色
                        }
                    }
                },
                data: France_death_predict
            }
        ]
    };
    myChart_france.setOption(option_france);
    option_global = {
        title: {
            text: '世界疫情状况'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['确诊人数', '预测确诊人数','死亡人数','预测死亡人数'],
            selected:{
                '死亡人数':false,
                '预测死亡人数':false,
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
                data: Global_origin
            },
            {
                name: '预测确诊人数',
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
                data: Global_predict
            },
            {
                name: '死亡人数',
                type: 'line',
                stack: '3',
                itemStyle: {
                    normal: {
                        color: "#db9158",//折线点的颜色
                        lineStyle: {
                            color: "#db9158"//折线的颜色
                        }
                    }
                },
                data: Global_death_origin
            },
            {
                name: '预测死亡人数',
                type: 'line',
                stack: '4',
                itemStyle: {
                    normal: {
                        color: "#2c9501",//折线点的颜色
                        lineStyle: {
                            color: "#2c9501"//折线的颜色
                        }
                    }
                },
                data: Global_death_predict
            }
        ]
    };
    myChart_global.setOption(option_global);
    option_india = {
        title: {
            text: '印度疫情状况'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['确诊人数', '预测确诊人数','死亡人数','预测死亡人数'],
            selected:{
                '死亡人数':false,
                '预测死亡人数':false,
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
                data: India_origin
            },
            {
                name: '预测确诊人数',
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
                data: India_predict
            },
            {
                name: '死亡人数',
                type: 'line',
                stack: '3',
                itemStyle: {
                    normal: {
                        color: "#db9158",//折线点的颜色
                        lineStyle: {
                            color: "#db9158"//折线的颜色
                        }
                    }
                },
                data: India_death_origin
            },
            {
                name: '预测死亡人数',
                type: 'line',
                stack: '4',
                itemStyle: {
                    normal: {
                        color: "#2c9501",//折线点的颜色
                        lineStyle: {
                            color: "#2c9501"//折线的颜色
                        }
                    }
                },
                data: India_death_predict
            }
        ]
    };
    myChart_india.setOption(option_india);
    option_russia = {
        title: {
            text: '俄罗斯疫情状况'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['确诊人数', '预测确诊人数','死亡人数','预测死亡人数'],
            selected:{
                '死亡人数':false,
                '预测死亡人数':false,
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
                data: Russia_origin
            },
            {
                name: '预测确诊人数',
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
                data: Russia_predict
            },
            {
                name: '死亡人数',
                type: 'line',
                stack: '3',
                itemStyle: {
                    normal: {
                        color: "#db9158",//折线点的颜色
                        lineStyle: {
                            color: "#db9158"//折线的颜色
                        }
                    }
                },
                data: Russia_death_origin
            },
            {
                name: '预测死亡人数',
                type: 'line',
                stack: '4',
                itemStyle: {
                    normal: {
                        color: "#2c9501",//折线点的颜色
                        lineStyle: {
                            color: "#2c9501"//折线的颜色
                        }
                    }
                },
                data: Russia_death_predict
            }
        ]
    };
    myChart_russia.setOption(option_russia);
    option_us = {
        title: {
            text: '美国疫情状况'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['确诊人数', '预测确诊人数','死亡人数','预测死亡人数'],
            selected:{
                '死亡人数':false,
                '预测死亡人数':false,
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
                data: US_origin
            },
            {
                name: '预测确诊人数',
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
                data: US_predict
            },
            {
                name: '死亡人数',
                type: 'line',
                stack: '3',
                itemStyle: {
                    normal: {
                        color: "#db9158",//折线点的颜色
                        lineStyle: {
                            color: "#db9158"//折线的颜色
                        }
                    }
                },
                data: US_death_origin
            },
            {
                name: '预测死亡人数',
                type: 'line',
                stack: '4',
                itemStyle: {
                    normal: {
                        color: "#2c9501",//折线点的颜色
                        lineStyle: {
                            color: "#2c9501"//折线的颜色
                        }
                    }
                },
                data: US_death_predict
            }
        ]
    };
    myChart_us.setOption(option_us);
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