<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="col-md-3 col-md-offset-9 sidebar">
	<div style="padding-left: 0px; padding-right: 0px; padding-bottom: 15px;">
		<div class="btn-group">
			<button type="submit" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false" id="b_category">${b_category}<span class="caret"></span>
			</button>
			<ul class="dropdown-menu b_category" role="menu">
				<li><a>복지시설</a></li>
				<li><a>체육시설</a></li>
				<li><a>문화시설</a></li>
				<li><a>의료시설</a></li>
				<li><a>기타시설</a></li>		
			</ul>
		</div>
		<div class="btn-group">
			<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
				중분류 <span class="caret"></span>
			</button>
			<ul class="dropdown-menu m_category" role="menu">
				<c:forEach items="${m_category }" var="m_category">
					<li><a>${m_category}</a></li>
				</c:forEach>
			</ul>
		</div>
		<div class="btn-group">
			<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
				소분류 <span class="caret"></span>
			</button>
			<ul class="dropdown-menu" role="menu">
				<c:forEach items="${s_category }" var="s_category">
					<li><a>${s_category}</a></li>
				</c:forEach>
			</ul>
		</div>
		<button class="btn btn-default" type="submit">
			<span class="glyphicon glyphicon-search"></span>
		</button>
	</div>
	<h3>검색결과</h3>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">시설이름</h3>
		</div>
		<div class="panel-body">
			시설에 대한 상세 설명들을 여기에 담는다
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">시설이름</h3>
		</div>
		<div class="panel-body">
			시설에 대한 상세 설명들을 여기에 담는다
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">시설이름</h3>
		</div>
		<div class="panel-body">
			시설에 대한 상세 설명들을 여기에 담는다
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">시설이름</h3>
		</div>
		<div class="panel-body">
			시설에 대한 상세 설명들을 여기에 담는다
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">시설이름</h3>
		</div>
		<div class="panel-body">
			시설에 대한 상세 설명들을 여기에 담는다
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">시설이름</h3>
		</div>
		<div class="panel-body">
			시설에 대한 상세 설명들을 여기에 담는다
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">시설이름</h3>
		</div>
		<div class="panel-body">
			시설에 대한 상세 설명들을 여기에 담는다
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">시설이름</h3>
		</div>
		<div class="panel-body">
			시설에 대한 상세 설명들을 여기에 담는다
		</div>
	</div>
</div>

<script>
	$(".b_category li").click(function(){
			
		location.href = "home.hongik?b_category=" + $(this).text();
		
	})
	
	$(".m_category li").click(function(){
		var a = $("#b_category").text();
		var arr = a.split("\n");
		location.href = "home.hongik?b_category=" + arr[0] + "&m_category=" + $(this).text();
	})
</script>