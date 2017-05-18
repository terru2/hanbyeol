<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>공용 시설 안내</title>
	<tiles:insertAttribute name="setting"/>
	<style>
	#tog_btn {
		position: relative;
		z-index: 1;
	}
	
	html, body {
		height: 100%;
	}
	
	input:-webkit-autofill, 
	input:-webkit-autofill:hover, 
	input:-webkit-autofill:focus,
	input:-webkit-autofill:active {
		-webkit-box-shadow: 0 0 0px 1000px white inset !important;
	}
	
	.custom_typecontrol {
		position: absolute;
		top: 5px;
		right: 100px;
		overflow: hidden;
		width: 85px;
		height: 30px;
		margin: 0;
		padding: 0;
		z-index: 1;
		font-size: 12px;
		font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
	}
	
	.radius_border {
		border:1px solid #919191;
		border-radius:5px;
	}
	
	</style>
</head>
<body>
	<tiles:insertAttribute name="login_signup"/>
	<tiles:insertAttribute name="top_nav"/>
	<div class="container-fluid" style="height: 100%">
		<div class="row row-offcanvas row-offcanvas-right" style="height: 100%;">
			<tiles:insertAttribute name="map"/>
		</div>
	</div>
</body>
</html>