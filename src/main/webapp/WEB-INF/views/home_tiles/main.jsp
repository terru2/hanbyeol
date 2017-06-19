<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>공용 시설 안내</title>
	<tiles:insertAttribute name="setting"/>
	<style>
	input:-webkit-autofill,
 	input:-webkit-autofill:hover,
 	input:-webkit-autofill:focus,
 	input:-webkit-autofill:active {
 		-webkit-box-shadow: 0 0 0px 1000px white inset !important;
	}
	
	.btn-default.btn-on-2.active{
		background-color: #5BB75B;color: white;
	}
	.btn-default.btn-off-2.active{
		background-color: #A7A7A7;color: white;
	}
	
	#toTop{
		position: fixed;
		bottom: 10px;
		right: 10px;
		cursor: pointer;
 		display: none;
	}
	
	.link {
    	color: #5085BB;
    }
	
	.insertInfo {
		position: absolute; 
		bottom: 40px; 
		width: 300px;
		height: 483px;
		margin-left: -149px;
		overflow: hidden;
	}
	.customInfo {
		position: absolute; 
		bottom: 40px; 
		width: 250px;
		height: 105px;
		margin-left: -124px;
		overflow: hidden;
	}
    .sumupinfo {
    	border-radius: 5px;
    	border-bottom: 2px solid #ccc;
    	border-right: 1px solid #ccc;
    	overflow: hidden;
    	background: #fff;
    }
    .sumupinfo:nth-child(1) {
    	border: 0;
    	box-shadow: 0px 1px 2px #888;
    }
    .sumupinfo .title {
    	padding: 3%;
    	height: 38px;
    	background: #eee;
    	border-bottom: 1px solid #ddd;
    	font-size: large;
    }
    .sumupinfo .close {
    	position: absolute;
    	right: 3%;
    }
    .sumupinfo .body {
    	position: relative;
    	overflow: hidden;
    }
    .sumupinfo .desc {
    	position: relative;
    	padding: 3%;
    }
    .desc .address {
    	overflow: hidden;
    	text-overflow: ellipsis;
    }
    .sumupinfo:after {
    	content: '';
    	position: absolute;
    	margin-left: -12px;
    	left: 50%;
    	bottom: 0;
    	width: 22px;
    	height: 12px;
    	background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
    }
	
	</style>
</head>
<body>
	<tiles:insertAttribute name="login_signup"/>
	<tiles:insertAttribute name="information"/>
	<tiles:insertAttribute name="shareinfo"/>
	<tiles:insertAttribute name="top_nav"/>
	<div class="container-fluid" style="height: 100%">
		<div class="row row-offcanvas row-offcanvas-right" style="height: 100%;">
			<tiles:insertAttribute name="map"/>
		</div>
	</div>
</body>
</html>