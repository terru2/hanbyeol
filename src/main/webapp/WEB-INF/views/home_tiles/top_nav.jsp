<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" style="margin-bottom: 0px; margin-top: 5px;"
				data-toggle="offcanvas">
				<span class="glyphicon glyphicon-list-alt"></span>
			</button>
			<button type="button" class="navbar-toggle" style="margin-bottom: 0px; margin-top: 5px;"
				data-toggle="collapse" data-target="#login_signup" >
				<span class="glyphicon glyphicon-user"></span>
			</button>
			<a class="navbar-brand" href="main.do">공용시설 안내 서비스</a>
		</div>
		
		<ul class="nav navbar-nav navbar-right collapse visible-sm">
			<li>
				<a data-toggle="offcanvas" style="cursor:pointer">
					<span class="glyphicon glyphicon-list-alt"></span> List
				</a>
			</li>
		</ul>
		<ul id="login_signup" class="nav navbar-nav navbar-right navbar-collapse collapse">
		<c:if test="${!empty log}">
			<li>
				<a data-toggle="modal" data-target="#member" style="cursor:pointer">
					<span class="glyphicon glyphicon-user"></span><strong> ${log.nickname } </strong>님<small> ( ${log.id } )</small>
				</a>	
			</li>
		</c:if>
		<c:if test="${empty log}">
			<li>
				<a data-toggle="modal" data-target="#login" style="cursor:pointer">
					<span class="glyphicon glyphicon-log-in"></span> Login
				</a>
			</li>
		</c:if>		
		</ul>
	</div>
</nav>