<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<title>공용 시설 안내</title>
	<tiles:insertAttribute name="setting"/>
</head>
<body>
	<tiles:insertAttribute name="top_nav"/>
	<div class="container-fluid">
		<div class="row">
			<tiles:insertAttribute name="map"/>
			<tiles:insertAttribute name="side_bar"/>
		</div>
	</div>
</body>
</html>