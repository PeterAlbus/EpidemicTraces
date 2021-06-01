<%--
  Created by IntelliJ IDEA.
  User: wuhon
  Date: 2021/3/13
  Time: 18:09
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
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/pages/predict/global_death.jsp">疫情状况预测</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="page-banner">
    <h1 class="text-center text-white font-weight-bold" style="width: 100%;position: absolute;top:200px">学生打卡</h1>
</div>
<section class="page-section" id="daily">
    <div class="container" style="text-align: center">
        <h2 class="text-center mt-0">学生打卡系统</h2>
        <hr class="divider my-4" />
        <div class="container">
            <form role="form" action="${pageContext.request.contextPath}/clock_in" method="post">
                <div class="row">
                    <div class="form-group text-left col-sm-12 col-md-12">
                        <label for="stu_school">学校</label>
                        <input type="text" class="form-control" id="stu_school" name="stu_school" placeholder="请输入所在学校">
                    </div>
                    <div class="form-group text-left col-sm-12 col-md-4">
                        <label for="stu_id">学号</label>
                        <input type="text" class="form-control" id="stu_id" name="stu_id" placeholder="请输入学号">
                    </div>
                    <div class="form-group text-left col-sm-12 col-md-4">
                        <label for="stu_name">姓名</label>
                        <input type="text" class="form-control" id="stu_name" name="stu_name" placeholder="请输入姓名">
                    </div>
                    <div class="form-group text-left col-sm-12 col-md-4">
                        <label for="stu_class">班级</label>
                        <select class="form-control" id="spec_num1" name="spec_num1"
                                onchange="document.getElementById('stu_class').value=$('#spec_num1 option:selected').text()">
                            <option>可从本下拉菜单选择</option>
                            <option>19计科1</option>
                            <option>19计科2</option>
                            <option>19计科3</option>
                            <option>18计科1</option>
                            <option>18计科2</option>
                            <option>18计科3</option>
                        </select>
                        <input type="text" class="form-control selectInput" id="stu_class" name="stu_class" placeholder="请选择"/>
                    </div>
                </div>
                <div class="form-group text-left selectInput">
                    <label for="stu_address">今晚居住地址</label>
                    <select class="form-control" id="spec_num0" name="spec_num"
                            onchange="document.getElementById('stu_address').value=$('#spec_num0 option:selected').text()">
                        <option>可从本下拉菜单选择</option>
                        <option>学校</option>
                    </select>
                    <input type="text" class="form-control selectInput" id="stu_address" name="stu_address" placeholder="请选择"/>
                </div>
                <div class="row">
                    <div class="form-group text-left col-md-6 col-sm-12">
                        <label for="stu_tmp">今日体温(摄氏度)</label>
                        <input type="text" class="form-control" id="stu_tmp" name="stu_tmp" placeholder="请输入体温">
                    </div>
                    <div class="form-group text-left col-md-6 col-sm-12">
                        <label>今日是否有出行:</label><br>
                        <label><input type="radio" name="is_out" value="true">是</label>
                        &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                        <label><input type="radio" name="is_out" value="false">否</label>
                    </div>
                </div>
                <div class="form-group text-left">
                    <label for="stu_des">出行目的地</label>
                    <input type="text" class="form-control" id="stu_des" name="stu_des" placeholder="请输入地址">
                </div>
                <div class="form-group text-left">
                    <label for="stu_time_out">出发时间</label>
                    <input type="datetime-local" class="form-control" name="stu_time_out" id="stu_time_out">
                </div>
                <div class="form-group text-left">
                    <label for="stu_time_back">返回时间</label>
                    <input type="datetime-local" class="form-control" name="stu_time_back" id="stu_time_back">
                </div>
                <button type="submit" class="btn btn-primary">提交</button>
                <button type="reset" class="btn btn-primary">重置</button>
            </form>
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

