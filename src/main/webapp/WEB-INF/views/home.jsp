<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<!-- 부트스트랩 -->
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

	<style>
	
	.wrap {position:static;}
	.navigation { position:fixed; width:100%; z-index:3; }
	.side_navigation {position:fixed; width:100%; height:100%;  }
	
	</style>

</head>
<body>
<div class="wrap">
	<div class="navigation">
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-12 col-md-2">
					<a class="navbar-brand" style="width: 100%; text-align:center;" href="#">공용시설 안내 서비스</a>
				</div>
				<div class="col-sm-12 col-md-6">
					<form class="navbar-form" style="width: 100%;">
						 <div class="input-group input-group-sm" style="width: 100%">
							<input type="text" class="form-control" placeholder="원하시는 지역명, 시설명을 입력하세요">
							<div class="input-group-btn" style="width: 34px">
								<button class="btn btn-default" type="submit">
									<i class="glyphicon glyphicon-search"></i>
								</button>
							</div>
						</div>
					</form>
				</div>
				<div class="col-sm-12 col-md-2" style="text-align:center;">
				<ul class="nav navbar-nav">
					<li>
						<a href="#">
							<span class="glyphicon glyphicon-log-in"></span> 
							Login
						</a>
					</li>
					<li>
						<a href="#">
							<span class="glyphicon glyphicon-user"></span>
							Sign Up
						</a>
					</li>
				</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="side_navigation">
		<div class="col-md-2 col-md-offset-10" style="background: #E0E0E0;">
			<div class="col-md-6">
				<div class="dropdown">
					<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
						대분류 <span class="caret"></span>
					</button>
					<ul class="dropdown-menu">
						<li><a href="#">문화시설</a></li>
						<li><a href="#">체육시설</a></li>
						<li><a href="#">복지시설</a></li>
					</ul>
				</div>
			</div>
	
			<div class="col-md-6">
				<div class="dropdown" style="padding-left: 0px;">
					<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
						소분류 <span class="caret"></span>
					</button>
					<ul class="dropdown-menu">
						<li><a href="#">문화시설</a></li>
						<li><a href="#">체육시설</a></li>
						<li><a href="#">복지시설</a></li>
					</ul>
				</div>
			</div>
	
			<form class="navbar-form navbar-left"
				style="padding-left: 0px; padding-right: 0px;">
				<div class="input-group input-group-sm">
					<input type="text" class="form-control">
					<div class="input-group-btn">
						<button class="btn btn-default" type="submit">
							<i class="glyphicon glyphicon-search"></i>
						</button>
					</div>
				</div>
			</form>
		</div>
	</div>
			
</div>
</body>
</html>