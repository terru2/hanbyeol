<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="map" style="width:100%; min-height:700px;"></div>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=6hl4w71wQyasH_xd4et9"></script>
<script type="text/javascript">
var mapOptions = {
	    center: new naver.maps.LatLng(${lat}, ${lng}),
	    zoom: 11
	};

	var map = new naver.maps.Map('map', mapOptions);
</script>
</body>
</html>