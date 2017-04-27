<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">

<title>Off Canvas Test</title>

<!-- Bootstrap core CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />

<!-- Custom styles for this template -->
<link type="text/css" rel="stylesheet" href="resources/css/offcanvas.css">

</head>

<body>
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="glyphicon glyphicon-user"></span>
				</button>
				<a class="navbar-brand" href="#">공용시설 안내 서비스</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<form class="navbar-form navbar-left">
					<div class="input-group">
						<input type="text" class="form-control"
							placeholder="원하시는 지역명, 시설명을 입력하세요">
						<div class="input-group-btn">
							<button class="btn btn-default" type="submit">
								<span class="glyphicon glyphicon-search"></span>
							</button>
						</div>
					</div>
				</form>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#"><span class="glyphicon glyphicon-log-in"></span>
							Login</a></li>
					<li><a href="#"><span class="glyphicon glyphicon-user"></span>Sign
							Up</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container-fluid">

		<div class="row row-offcanvas row-offcanvas-right">

			<div class="col-sm-12 col-md-9 map">
				<p class="pull-right visible-xs visible-sm">
					<button type="button" class="btn btn-default btn-sm"
						data-toggle="offcanvas">상세검색</button>
				</p>
				<div id="map" style="width: 100%; min-height: 700px;">
				</div>
			</div>

			<div class="col-sm-6 col-md-3 sidebar-offcanvas" id="sidebar">
				<div
					style="padding-left: 0px; padding-right: 0px; padding-bottom: 15px;">
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle"
							data-toggle="dropdown" aria-expanded="false">
							대분류 <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li><a>복지시설</a></li>
							<li><a>체육시설</a></li>
							<li><a>문화시설</a></li>
							<li><a>의료시설</a></li>
							<li><a>기타시설</a></li>
						</ul>
					</div>
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle"
							data-toggle="dropdown" aria-expanded="false">
							소분류 <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<c:forEach items="${category }" var="category">
								<li><a>${category.category2}</a></li>
							</c:forEach>
						</ul>
					</div>
					<form style="padding-top: 10px;">
						<div class="input-group input-group-sm">
							<input type="text" class="form-control">
							<div class="input-group-btn ">
								<button class="btn btn-default" type="submit">
									<span class="glyphicon glyphicon-search"></span>
								</button>
							</div>
						</div>
					</form>
				</div>
				<h3>검색결과</h3>
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">시설이름</h3>
					</div>
					<div class="panel-body">시설에 대한 상세 설명들을 여기에 담는다</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">시설이름</h3>
					</div>
					<div class="panel-body">시설에 대한 상세 설명들을 여기에 담는다</div>
				</div>

			</div>
		</div>
		<!--/row-->

		<hr>

	</div>
	<!--/.container-->


	<!--// jQuery Load -->
	<script type="text/javascript"
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!--// Bootstrap Libaray Load -->
	<script type="text/javascript"
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<script type="text/javascript" src="resources/offcanvas.js"></script>
	
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=6hl4w71wQyasH_xd4et9"></script>
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
