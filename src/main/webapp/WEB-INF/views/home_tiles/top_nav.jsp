<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
				<span class="glyphicon glyphicon-user"></span>
			</button>
			<a class="navbar-brand" href="main.do">공용시설 안내 서비스</a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-right">
				<li>
					<a data-toggle="modal" data-target="#login">
						<span class="glyphicon glyphicon-log-in"></span> Log in
					</a>	
				</li>
				<li>
					<a data-toggle="modal" data-target="#SignUp">
						<span class="glyphicon glyphicon-user"></span> Sign Up
					</a>	
				</li>
			</ul>
		</div>
	</div>
</nav>
