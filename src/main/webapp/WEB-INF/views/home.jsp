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

<!-- 네이버 지도 -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=6hl4w71wQyasH_xd4et9"></script>

	<style>
	
	.wrap {position:static;}
	.navigation { position:fixed; width:100%; border-bottom:1px solid #ededed;}
	.contents { padding-top:51px; }
	
	</style>

</head>
<body>
<div class="wrap">
	<div class="navigation">
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-2">
					<a class="navbar-brand" style="width: 100%; text-align:center;" href="#">공용시설 안내 서비스</a>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-8">
					<form style="padding:10px; width: 100%;">
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
				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-2" style="text-align:center;">
				<ul class="nav navbar-nav navbar-right">
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
	
		
	<div class="contents">	
		<div class="col-md-10" style="padding:0px" >
			<div class="map">
				<div id="map" style="width:100%; height:500px;"></div>
			</div>
		</div>		
		<div class="col-md-2" style="background: #E0E0E0;">
			<div class="side">
				<div class="btn-group" style="padding-top: 15px;">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
						대분류 <span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#">시설1</a></li>
						<li><a href="#">시설2</a></li>
						<li><a href="#">시설3</a></li>
						<li><a href="#">시설4</a></li>
						<li><a href="#">시설5</a></li>
					</ul>
				</div>
				<div class="btn-group" style="padding-top: 15px;">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
						소분류 <span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#">시설1</a></li>
						<li><a href="#">시설2</a></li>
					</ul>
				</div>
				
				<form style="padding-left: 0px; padding-right: 0px; padding-top: 15px; padding-bottom: 15px">
					<div class="input-group input-group-sm">
						<input type="text" class="form-control">
						<div class="input-group-btn">
							<button class="btn btn-default" type="submit">
								<i class="glyphicon glyphicon-search"></i>
							</button>
						</div>
					</div>
				</form>
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
			</div>
		</div>
	</div>
</div>


<script>
var mapOptions = {
    center: new naver.maps.LatLng(37.5666805, 126.9784147),
    zoom: 10
};

var map = new naver.maps.Map('map', mapOptions);

var cityhall = new naver.maps.LatLng(37.5666805, 126.9784147);

var contentString = [
    '<div class="iw_inner">',
    '   <h3>서울특별시청</h3>',
    '   <p>서울특별시 중구 태평로1가 31 | 서울특별시 중구 세종대로 110 서울특별시청<br>',
    '       <img src="./img/hi-seoul.jpg" width="55" height="55" alt="서울시청" class="thumb" /><br>',
    '       02-120 | 공공,사회기관 > 특별,광역시청<br>',
    '       <a href="http://www.seoul.go.kr" target="_blank">www.seoul.go.kr/</a>',
    '   </p>',
    '</div>'
].join('');

var marker = new naver.maps.Marker({
    map: map,
    position: cityhall
});

var infowindow = new naver.maps.InfoWindow({
    content: contentString
});

naver.maps.Event.addListener(marker, "click", function(e) {
    if (infowindow.getMap()) {
        infowindow.close();
    } else {
        infowindow.open(map, marker);
    }
});
</script>
</body>
</html>