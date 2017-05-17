<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="org.json.simple.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">

<!--// Bootstrap Style Load -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<!-- Custom styles for this template -->
<link type="text/css" rel="stylesheet" href="resources/css/dashboard.css">

<!--// jQuery Load -->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<!--// Bootstrap Libaray Load -->
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- 다음 지도 -->
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=2280fd7a86793fef854e4c2d014f194f&libraries=services,clusterer,drawing"></script>
<!-- Jquery  -->
<script src="resources/jquery-3.1.1.min.js"></script>
<style>
.radius_border{border:1px solid #919191;border-radius:5px;}     
.custom_typecontrol {position:absolute;top:10px;right:100px;overflow:hidden;width:100px;height:30px;margin:0;padding:0;z-index:1;font-size:12px;font-family:'Malgun Gothic', '맑은 고딕', sans-serif;}  
</style>