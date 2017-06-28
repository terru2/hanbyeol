<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, com.hongik.project.vo.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Map 부분  -->
<div class="col-sm-12 col-md-9 map" id="map">
</div>
<!-- List 부분  -->
<div class="col-sm-6 col-md-3 sidebar-offcanvas sidebar">
	<!-- 조건절들 보여주는 부분  -->
	<form action="search.do" name="form">
		<div id="gps" style="padding-top: 10px; padding-bottom: 10px;">
			<span>현재 위치로 범위 검색 </span>
			<div class="btn-group" data-toggle="buttons">			
				<label class="btn btn-default btn-on-2 btn-sm active" onclick="$('.range').selectpicker('show')">
					<input type="radio" name="switch" id="onoff" checked>ON
				</label>			
				<label class="btn btn-default btn-off-2 btn-sm" onclick="$('.range').selectpicker('hide')">
					<input type="radio" name="switch" id="onoff">OFF
				</label>
			</div>
		</div>
		<div>
			<select class="selectpicker range" data-width="45%" name="range" >
				<option value="500">반경 500m</option>
				<option value="1000">반경 1km</option>
				<option value="2000">반경 2km</option>
			</select>
			<select class="selectpicker" data-width="50%" name="category1">
				<c:forEach items="${categorylist}" var="list">
					<option <c:if test="${list.category1 eq category1}">selected</c:if> >${list.category1}</option>
				</c:forEach>	
			</select>
		</div>
		<div class="input-group" style="padding-top: 10px;">
			<input type="text" class="form-control" placeholder="원하시는 지역명을 입력하세요(기준: 서울시청)" name="focusAddress" value="${focusAddress}"> 
			<div class="input-group-btn">
				<button class="btn btn-default" onclick="rangesearchswitch()">
					<span class="glyphicon glyphicon-search"></span>
				</button>
			</div>
		</div>
	</form>
	<div id="list" style="padding-top: 10px;">
	</div>
	<div id="toTop" class="btn btn-info"><span class="glyphicon glyphicon-chevron-up"></span></div>
</div>
<script>
$(function(){
	var map;
	getLatLng();
})

function rangesearchswitch() {
	if($('#onoff').is(":checked")){
		var theForm = document.form;
		theForm.action = "rangesearch.do";
		theForm.submit();
	}  
}

function getLatLng() {
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {
			var lat = position.coords.latitude;
			var lng = position.coords.longitude;
			
			drawMap(lat, lng)
		});
	} else {
		alert("현재 웹에서는 geolocation을 사용 할 수 없습니다. <br> 관리자에게 문의 부탁드립니다.")
	}
}

function drawMap(lat, lng) {
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center : new daum.maps.LatLng(lat, lng), //지도의 중심좌표.
		level : 4//지도의 레벨(확대, 축소 정도)
	}
	map = new daum.maps.Map(container, options);
	
	//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new daum.maps.MapTypeControl();
	
	// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
	// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의합니다
	map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);
	
	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new daum.maps.ZoomControl();
	map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
	
	drawCircle(lat, lng)
	focusMarker(lat, lng);
	getMapdata(lat, lng);
}

function drawCircle(lat, lng) {
	var circle = new daum.maps.Circle({
		center : new daum.maps.LatLng(lat, lng), // 원의 중심좌표 입니다 
		radius : ${range}, // 미터 단위의 원의 반지름입니다 
		strokeWeight : 3, // 선의 두께입니다 
		strokeColor : '#75B8FA', // 선의 색깔입니다
		strokeOpacity : 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
		strokeStyle : 'solid', // 선의 스타일 입니다
		fillColor : '#CFE7FF', // 채우기 색깔입니다
		fillOpacity : 0.5// 채우기 불투명도 입니다   
	});
	circle.setMap(map);
}

function focusMarker(lat, lng) {
	var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
	var imageSize = new daum.maps.Size(24, 35);
	var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize);
	var marker = new daum.maps.Marker({
		map : map, // 마커를 표시할 지도
		position : new daum.maps.LatLng(lat, lng), // 마커를 표시할 위치
			title : '현재위치', // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			image : markerImage// 마커 이미지 
	});
	marker.setMap(map);
}

var getdata;
function getMapdata(lat, lng) {
	$.ajax({
		url : "rangelimitMapdata",
		data : {
			"category1" : '${category1}',
			"lat" : lat,
			"lng" : lng,
			"range" : '${range}'
		},
		dataType : "json",
		error : function() {
			alert("공공시설 정보 오류");
		},
		success : function(data) {
			/* 데이터 거리순 정렬 */
			data.sort(function (a, b) { 
				return a.distance < b.distance ? -1 : a.distance > b.distance ? 1 : 0;  
			});
			
			getdata = data;
			makeMarker(data);
			makeList(data);
		}
	})
}

function makeMarker(data) {
	
	for(var i = 0; i < data.length; i++){
		var title = data[i].name;
		var latlng = new daum.maps.LatLng(data[i].wsg84x,data[i].wsg84y);
		
		var marker = new daum.maps.Marker({
			title : title,
			position : latlng
			});
		console.log(data[i].name)
		
		marker.setMap(map)	
		markerEvent(marker, i);
	}
}

function markerEvent(marker, i){
	daum.maps.event.addListener(marker, 'click', function() {
		panTo(i);
	});
}

function panTo(i){
	var moveLatLng = new daum.maps.LatLng(getdata[i].wsg84x, getdata[i].wsg84y);

	if($('.row-offcanvas').hasClass('active')){
		$('.row-offcanvas').toggleClass('active');
	}
	
	map.setLevel(3);
	map.panTo(moveLatLng);
	sumUpInfowindow(i, moveLatLng);	
}

var custominfowindow = new daum.maps.CustomOverlay({
	clickable : true
});
function sumUpInfowindow(i, LatLng){
	var content = '<div class="customInfo">' + 
				'    <div class="sumupinfo">' + 
				'        <div class="title">' + 
				'			<strong>' + getdata[i].name + '</strong>' +
				'			<button type="button" class="close" onclick="custominfowindow.setMap(null)">' + 
				'				<span>&times;</span>' + 
				'			</button>' + 
				'        </div>' + 
				'        <div class="body">' + 
				'            <div class="desc">' + 
				'                <div class="address">'+getdata[i].address+'</div>' + 
				'                <div><a class="link" onclick="info(' + i + ')" style="cursor:pointer">상세정보 보기</a></div>' + 
				'            </div>' + 
				'        </div>' + 
				'    </div>' +    
				'</div>';
	
	custominfowindow.setMap(null);
	custominfowindow.setPosition(LatLng);
	custominfowindow.setContent(content);
	custominfowindow.setMap(map);
}

function info(cnt) {	
	
	 $.ajax({//상세정보 불러오는...
		type : "POST",
		url : "OneCulum",		
		async : false,
		data : "name="+getdata[cnt].name+"&address="+getdata[cnt].address,
		dataType : "json",
		error : function(){
		alert("컬럼 정보요청 오류");			
		},
		success : function(data){
		
			$('.infoname').html('<strong id="sisulName">' + data.name + '</strong> ' + 
								'<span id="rate" class="label label-warning" style="padding: 0.5% 2% 0.3% 2%;"></span>' + 
								' <small id="category" class="infocategory2"> (' + String(data.category2).replace(null , '회원추가') + ')</small>')			
			$('.infoaddress').text(data.address)
			$('.infophonenumber').text(String(data.phonenumber).replace(null , '정보없음'))
			$('.infotime').text(String(data.time).replace(null , '정보없음'))
			$('.infocloseddays').text(String(data.closeddays).replace(null , '정보없음'))
			$('.infocomments').text(String(data.comments).replace(null , '정보없음'))
			
			switch(data.category1){
				case "도서관"  : $('.img-rounded').attr('src', "resources/images/도서관.jpg"); break;
				case "도시공원" : $('.img-rounded').attr('src', "resources/images/공원.png"); break;
				case "주차장"  : $('.img-rounded').attr('src', "resources/images/주차장.jpg"); break;
				case "어린이집" : $('.img-rounded').attr('src', "resources/images/어린이집.png"); break;
				case "화장실" : $('.img-rounded').attr('src', "resources/images/화장실.jpg"); break;
				case "병원" : $('.img-rounded').attr('src', "resources/images/병원.png"); break;
				case "약국" : $('.img-rounded').attr('src', "resources/images/약국.jpg"); break;
				case "박물관" : $('.img-rounded').attr('src', "resources/images/박물관.png"); break;
				case "기타" : $('.img-rounded').attr('src', "resources/images/기타.png"); break;
			}
			
			rate(data.name)
			getBoard(data.name)
			
			$('#information').modal('show');
			
			$('#information').on('hidden.bs.modal', function(){
				$('#reviewPwInput').val("");
				$('#gpa').selectpicker('val', '★★★★★');
				$('#gpa').selectpicker('refresh');
				$('#comment').val("");
				$('#comment').attr('placeholder','${log.nickname} 회원님의 평가를 입력해주세요.')
			});
		
		}
	});
}

function rate(name){
	$.ajax({
		type : "GET",
		url : "return2",
		data : "name="+name,
		dataType : "json",
		error : function(){
			alert("평점 정보요청 오류");			
			},
		success : function(data){		
			$('#rate').text(data);
		}
	});
}

var boardData;
function getBoard(name){

	$.ajax({
		type : "POST",
		url : "Boardinfo",
		data : "name="+name,
		dataType : "json",
		error : function(){
			alert("게시판 정보요청 오류("+name+")");			
		},
		success : function(data){
			boardData = data;
			var pageMove = '<hr style="border: solid 1px #e5e5e5;">' + 
							'<button type="button" id="previous" class="btn btn-default btn-sm" style="float: left;">' + 
							'	<span class="glyphicon glyphicon-chevron-left"></span>' + 
							'</button>' + 
							'<button type="button" id="next" class="btn btn-default btn-sm" style="float: right;">' + 
							'	<span class="glyphicon glyphicon-chevron-right"></span>' + 
							'</button>';
			$('#pageMove').html(pageMove)
			createtable(data,0);
		}	
	});
}

var page = 0;
function preBoard(){		
	page = page - 4;
	createtable(boardData,page);
}

function nextBoard(){	
	page = page + 4;
	createtable(boardData,page);
}

function createtable(data,page){
	$('#createtable').empty()
	
	$('#previous').removeClass('disabled');
	$('#previous').attr('onClick','preBoard()');
	$('#next').removeClass('disabled');
	$('#next').attr('onClick','nextBoard()');
	
	if(data.length == 0){
		
		$('#previous').addClass('disabled');
		$('#previous').removeAttr('onClick');
		$('#next').addClass('disabled');
		$('#next').removeAttr('onClick');
		
		var noreview = '<hr style="border: solid 1px #e5e5e5;">' + 
						'<p class="text-center">아직 평가글이 없습니다</p>';
		
		$('#createtable').html(noreview)
		
	}else{
		
		if(page < 4){
			$('#previous').addClass('disabled');
			$('#previous').removeAttr('onClick');
		}
		
		if(page > data.length-5){
			$('#next').addClass('disabled');
			$('#next').removeAttr('onClick');
		}
		
		for(var i = page; i < page+4; i++){
			
			if(i == data.length){
				break;
			}
			
			var deleteSetting = '<button type="button" class="btn btn-danger btn-sm" onclick="deleteSetting(' + i + ')" style="float: right;">삭제</button>';
			
			if('${sessionScope.log.id}' == 'admin'){
				deleteSetting = '<button type="button" class="btn btn-danger btn-sm" onclick="deleteComment(' + i + ')" style="float: right;">삭제</button>';
			}
			
			var review ='<div class="col-sm-12" style="padding: 0;">' + 
						'	<hr style="border: solid 1px #e5e5e5;">' + 
						'</div>' +
						'<h5 class="col-sm-4" style="padding: 0; display:inline-flex;">' + 
						'	<strong>' + data[i].writer + '</strong><span class="label label-warning">' + data[i].gpa + '</span>' + 
						'</h5>' + 
						'<div class="col-sm-8" id="boardComment'+i+'" style="padding: 0; display: inline">' + 
						deleteSetting + 
						'</div>' + 
						'<div class="col-sm-12" style="padding: 0;">' + 
						'	<p>' + data[i].comments + '</p>' +  
						'</div>';
			
			$('#createtable').append(review)
			
		}
	}
}

function makeList(data){
	$('#list').html('<span>총 '+getdata.length+'개의 데이터가 검색 되었습니다. </span>')
	$('#list div').remove()
	
	 for(var i = 0; i < data.length; i++){
		var listOrig = $('#list').html()
		
		var deletebtn = '';
		
		<c:if test="${sessionScope.log.id  eq 'admin'}">
			deletebtn = '<a class="btn btn-xs btn-danger pull-right" href="DeleteMapData.do?name='+getdata[i].name+'">장소 삭제</a>'
       	</c:if>
		
		var panel = '<div class="panel panel-default">' + 
					'	<div class="panel-heading">' + 
					'		<h3 class="panel-title" onclick="panTo('+i+')" style="cursor:pointer"><strong>'+data[i].name+'</strong></h3>' + 
					'	</div>' + 
					'	<div class="panel-body"><strong>현 위치와의 거리 = '+data[i].distance+'m</strong><br>' + 
					'		<a class="link" onclick="info(' + i + ')" style="cursor:pointer">상세정보 보기</a>' + deletebtn + 
					'	</div>' + 
					'</div>';
					
		$('#list').html(listOrig + panel);
	}
}

$('.sidebar').scroll(function () {
	if ($(this).scrollTop() != 0) {
		$('#toTop').fadeIn();
	} else {
		$('#toTop').fadeOut();
	}
}); 
$('#toTop').click(function(){
	$('.sidebar').animate({ scrollTop: 0 }, 600);
});
</script>