<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, com.hongik.project.vo.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no">
    
    <!--// Bootstrap Style Load -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
	<!--// Bootstrap-select Style Load -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/css/bootstrap-select.min.css"/>
    <!--// jQuery Load -->
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!--// Bootstrap Libaray Load -->
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<!--// Bootstrap-select Libaray Load -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/js/bootstrap-select.min.js"></script>
    
    <title>공영시설 안내 서비스</title>
	
	<style>
		html,
		body {
			overflow: hidden;
			height:100%;
		}
		
		@media(max-width: 425px){
			.carousel-inner{
				width: 100%;
				text-align: center;
			}
			.item{
				margin-top: 0%;
				height: 100%;
			}
			.form-group{
				text-align: center;
			}
			.form-control{
				display: inline;
				width: 50%;
			}
			#mainWebTitle{
				display: none;
			}
			#mainStartTitle{
				display: none;
			}
			#mainEx{
				padding: 4%;
			}
			#mainExStrong{
				display: none;
			}
			#mainCnt{
				display: none;
			}
		}
		
		@media (min-width: 426px) and (max-width: 1024px){
			.carousel-inner{
				width: 100%;
				text-align: center;
			}
			.item{
				margin-top: 0%;
				height: 100%;
			}
			#mainWebTitle{
				display: none;
			}
			#mainEx{
				padding: 4%;
			}
			#mainCnt{
				text-align: center;
			}
		}
		
		@media (min-width: 1025px){
			.carousel-inner{
				width: 60%;
			}
			.item{
				margin-top: 15%;
			}
			#mainEx{
				border: 6px solid white; 
				padding: 2%;
			}
		}
		
	</style>
</head>
<body style="background-color: gray;">
	<div class="container-fluid" style="height:100%; padding: 0;">
		<div id="myCarousel" class="carousel slide" data-ride="carousel" style="height:100%;">
			<!-- Indicators -->
			<ol class="carousel-indicators" style="margin-bottom: 0px;">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
				<li data-target="#myCarousel" data-slide-to="3"></li>
			</ol>
			
			<!-- Wrapper for slides -->
			<div class="carousel-inner" style="height:100%; margin:auto;">
				<div class="item active">
					<div id="mainWebTitle" style="text-align: right;">
						<h1 style="color: white; margin-top: 0;"><strong>공용시설 안내 서비스</strong></h1>
					</div>
					<div id="mainEx">
						<h1 id="mainTitle" style="color: white;"><strong><span class="glyphicon glyphicon-cog"></span> 우리 서비스는 ?</strong></h1>
						<p class="lead" style="color: white; margin-top: 30px;"><strong>여러분 누구나 경험 했을 것이라고 생각했습니다.</strong></p>
						<p style="color: white;">
							새로운 장소나 특정 장소에 갔을 때 <br><br>
							화장실을 못 찾거나 찾아도 이용을 못해서 곤란했던 경험,<br><br>
							오랜만에 도서관을 찾아갔는데 그날 따라 문이 닫힌 휴무일,<br><br>
							차를 가지고 나왔는데 도대체 차를 어디에 세울 수 있는지 알 수 없는 이 거리..<br><br><br><br>
							<strong id="mainExStrong">저희는 이러한 경험들로부터 다양한 공용시설과 그 정보들을 한번에 알 수 있는 서비스 입니다.</strong>
						</p>
						<p id="mainCnt" class="text-right" style="color: white;">
							1/4
						</p>
					</div>
				</div>
				<div class="item">
					<div id="mainWebTitle" style="text-align: right;">
						<h1 style="color: white; margin-top: 0;"><strong>공용시설 안내 서비스</strong></h1>
					</div>
					<div id="mainEx">
						<h1 id="mainTitle" style="color: white;"><strong><span class="glyphicon glyphicon-search"></span> 시설 위치 검색 ?</strong></h1>
						<p class="lead" style="color: white; margin-top: 30px;"><strong>여러분 누구나 경험 했을 것이라고 생각했습니다.</strong></p>
						<p style="color: white;">
							원하는 위치를 검색창에 입력하고 시설을 선택하세요<br><br>
							검색된 위치의 시설들이 한눈에 보여집니다<br><br>
							현재 위치기능을 'on' 하고 범위를 지정하세요<br><br>
							본인의 현재 위치 반경에 시설들을 한눈에 확인하고 볼 수 있습니다<br><br><br><br>
							<strong id="mainExStrong">시설들의 위치를 지도를 통해 한눈에 볼 수 있으며 리스트로 확인 가능합니다.</strong>
						</p>
						<p id="mainCnt" class="text-right" style="color: white;">
							2/4
						</p>
					</div>
				</div>
				<div class="item">
					<div id="mainWebTitle" style="text-align: right;">
						<h1 style="color: white; margin-top: 0;"><strong>공용시설 안내 서비스</strong></h1>
					</div>
					<div id="mainEx">
						<h1 id="mainTitle" style="color: white;"><strong><span class="glyphicon glyphicon-list-alt"></span> 상세 정보 확인 ?</strong></h1>
						<p class="lead" style="color: white; margin-top: 30px;"><strong>여러분 누구나 경험 했을 것이라고 생각했습니다.</strong></p>
						<p style="color: white;">
							리스트 또는 마커를 선택해 위치와 정보창을 확인합니다<br><br>
							상세보기를 선택하세요<br><br>
							시설에 대한 자세한 정보들을 개별적으로 확인 할 수 있습니다<br><br>
							평가하기를 통해 각 시설을 평가하고 댓글을 남길 수 있습니다<br><br><br><br>
							<strong id="mainExStrong">각 시설들의 상세 정보들은 물론 평점 및 댓글을 통해 보다 나은 정보를 제공합니다.</strong>
						</p>
						<p id="mainCnt" class="text-right" style="color: white;">
							3/4
						</p>
					</div>
				</div>
				<div class="item">
					<div id="mainWebTitle" style="text-align: right;">
						<h1 style="color: white; margin-top: 0;"><strong>공용시설 안내 서비스</strong></h1>
					</div>
					<div id="mainEx">
						<h1 id="mainTitle" style="color: white;"><strong><span class="glyphicon glyphicon-map-marker"></span> 나만의 위치 추가 ?</strong></h1>
						<p class="lead" style="color: white; margin-top: 30px;"><strong>여러분 누구나 경험 했을 것이라고 생각했습니다.</strong></p>
						<p style="color: white;">
							회원이 되어 나만의 위치 추가 기능을 활용하세요<br><br>
							위치를 선택해 정보를 입력하면 회원만의 위치를 추가 할 수 있습니다<br><br>
							공유 요청 기능을 통해 나만이 아는 장소를 사용자들과 공유 할 수 있습니다<br><br><br><br>
							<strong id="mainExStrong">회원만의 장소를 추가하고 공유 요청 시 전체 시설 데이터에 저장되어 확인 할 수 있습니다.</strong>
						</p>
						<p id="mainCnt" class="text-right" style="color: white;">
							4/4
						</p>
					</div>
				</div>
			</div>
		</div>
			
		<!-- Left and right controls -->
		<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
			<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			<span class="sr-only">Previous</span>
		</a>
		<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
			<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>
		
		<div style="position: absolute; bottom: 10%; left: 50%; margin-left: -174px">
			<p id="mainStartTitle" class="text-center" style="color: white;">서비스를 시작하세요</p>
			<form class="form-inline" action="search.do">
				<div class="form-group">
					<input type="text" class="form-control" name="focusAddress" placeholder="지역명을 입력하세요">
					<select class="selectpicker" data-width="auto" name="category1">
						<c:forEach items="${categorylist}" var="vo">
							<option>${vo.category1}</option>
						</c:forEach>
					</select>
					<button type="submit" class="btn btn-default">검색</button>
				</div>
			</form>
		</div>
</body>
</html>