<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" style="margin-bottom: 0px; margin-top: 5px;"
				data-toggle="collapse" data-target="#login_signup" aria-expanded="false"
				aria-controls="navbar">
				<span class="glyphicon glyphicon-user"></span>
			</button>
			<!-- <button type="button" class="navbar-toggle" style="margin-bottom: 0px; margin-top: 5px;"
				data-toggle="collapse" data-target="#search_form" aria-expanded="false"
				aria-controls="navbar">
				<span class="glyphicon glyphicon-search"></span>
			</button> -->
			<a class="navbar-brand" href="main.do">공용시설 안내 서비스</a>
		</div>
		
		<ul id="login_signup" class="nav navbar-nav navbar-right navbar-collapse collapse" style="padding-left: 15px;">
		<%
		if(session.getAttribute("log") != null){
		%>
			<li>
				<a href="insertplace.do">
					<span class="glyphicon glyphicon-map-marker"></span> 장소 추가
				</a>
			</li>
			<li>
				<a data-toggle="modal" data-target="#member" style="cursor:pointer">
					<span class="glyphicon glyphicon-user"></span><strong> ${log.nickname } </strong>님<small> ( ${log.id } )</small>
				</a>	
			</li>
			<li>
				<a href="logout">
					<span class="glyphicon glyphicon-log-out"></span> Logout
				</a>
			</li>
		<%
		}else{
		%>
			<li>
				<a data-toggle="modal" data-target="#login" style="cursor:pointer">
					<span class="glyphicon glyphicon-log-in"></span> Login
				</a>
			</li>
			<li>
				<a data-toggle="modal" data-target="#signup" style="cursor:pointer">
					<span class="glyphicon glyphicon-user"></span> SignUp
				</a>
			</li>
		<%
		}
		%>
		</ul>
		<!-- <form id="search_form" class="navbar-collapse collapse navbar-form" style="margin-bottom: 0px;">
			<div class="input-group" style="display:table;">
				<input type="text" class="form-control" placeholder="원하시는 지역명, 시설명을 입력하세요">
				<div class="input-group-btn" style="width:1%;">
					<button class="btn btn-default" type="submit"><span class="glyphicon glyphicon-search"></span></button>
				</div>
			</div>
		</form> -->
	</div>
</nav>
