<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, com.hongik.project.vo.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
$(document).ready(function(){
	getLatLng();
});
</script>
<!-- Map 부분  -->
<div class="col-sm-12 col-md-9 map" id="map" style="height: 100%;">
	<p class="pull-right visible-xs visible-sm" id="tog_btn">
		<button type="button" class="btn btn-default btn-sm"
			data-toggle="offcanvas">상세 분류</button>
	</p>
</div>
<!-- List 부분  -->
<div class="col-sm-6 col-md-3 sidebar-offcanvas sidebar"
	style="height: 100%;">
	<!-- 조건절들 보여주는 부분  -->
	<div
		style="padding-left: 0px; padding-right: 0px; padding-bottom: 15px; padding-top: 15px;">
		<form action="insertplace.do" name="form">
			<div>
				<label><h4>현재 위치로 이동</h4></label>
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-primary">
						<input type="radio" name="options" id="ON"> ON
					</label>
					<label class="btn btn-primary active">
						<input type="radio" name="options" id="OFF" checked > OFF
					</label>
				</div>
			</div>
			<div class="input-group">
				<c:if test="${focusAddress eq 'null'}">
					<input type="text" class="form-control"  placeholder="원하시는 지역명을 입력하세요(기준: 서울시청)" name="focusAddress">
				</c:if>
				<c:if test="${focusAddress ne 'null'}">
					<input type="text" class="form-control"  placeholder="원하시는 지역명을 입력하세요(기준: 서울시청)" name="focusAddress" value="${focusAddress}">
				</c:if>
				<div class="input-group-btn">
					<button class="btn btn-default"onclick="javascript:rangesearchswitch()">
						<span class="glyphicon glyphicon-search"></span>
					</button>
				</div>
			</div>
		</form>
	</div>
	<div id="list">
	</div>
	<nav align="center">
		<ul id="page" class="pagination" >
		</ul>
	</nav>
</div>
<div id="infoWindow" style="display: none">
	<h4 align="center"><strong>나만의 장소 추가하기</strong></h4>
	<div class="form-group" style="width: 300px;">
		<label>장소 이름</label>
		<input type="text" class="form-control" placeholder="추가 할 장소의 이름을 정해주세요" name="name">
	</div>
	<div class="form-group">
		<label>시설 선택</label>
		<select class="form-control" name="category1">
			<c:forEach items="${category1list}" var="list">
				<option>${list.category1}</option>
			</c:forEach>			
				<option>기타</option>	
		</select>
	</div>
	<div class="form-group">
		<label>이용 시간</label>
		<input type="text" class="form-control" placeholder="ex) 09:00 - 22:00" name="time">
	</div>
	<div class="form-group">
		<label for="exampleInputPassword1">휴무일</label>
		<input type="text" class="form-control" placeholder="ex) 매주금요일 or 법정공휴일" name="closeddays">
	</div>
	<div class="form-group">
		<label>기타 사항</label>
		<textarea class="form-control" rows="3" name="comments"></textarea>
	</div>
	<div class="form-group" style="padding-bottom: 15px">
		<button type="submit" class="btn btn-primary pull-right">장소 추가</button>
	</div>
</div>
<script>
var switch1 = document.getElementById("ON");
var switch2 = document.getElementById("OFF");
var map;
var id = "${sessionScope.log.id}";
/* geolocation 시작 */
function getLatLng() {
	if ("geolocation" in navigator) {
		navigator.geolocation.getCurrentPosition(function(position) {
			var lat = position.coords.latitude;
			var lng = position.coords.longitude;
			
			//좌표값을 통한 Map Set
			drawMap(lat, lng);
		});
	} else {
		alert("현재 웹에서는 geolocation을 사용 할 수 없습니다. <br> 관리자에게 문의 부탁드립니다.")
	}
}

/* Map Set */
function drawMap(lat, lng) {
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center : new daum.maps.LatLng(lat, lng), //지도의 중심좌표.
		level : 4
	//지도의 레벨(확대, 축소 정도)
	}
	map = new daum.maps.Map(container, options);
	//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new daum.maps.MapTypeControl();
	// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
	// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의합니다
	map.addControl(mapTypeControl, daum.maps.ControlPosition.LEFT);
	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new daum.maps.ZoomControl();
	map.addControl(zoomControl, daum.maps.ControlPosition.BOTTOMRIGHT);
	
	var marker = new daum.maps.Marker(); 
	marker.setMap(map);
	
	var geocoder = new daum.maps.services.Geocoder();
	daum.maps.event.addListener(map, 'click', function(mouseEvent){
		var latlng = mouseEvent.latLng;
		marker.setPosition(latlng);
		searchDetailAddrFromCoords(mouseEvent.latLng, function(status, result) {
	        if (status === daum.maps.services.Status.OK) {
	        	console.log(result);
	        	var roadAddress = result[0].roadAddress.name;
	        	var jibunAddress = result[0].jibunAddress.name;
	        	if(id != ""){
	            	MakeInfoWindow(latlng, roadAddress, jibunAddress);
	        	}else{
	        		alert("Login이 정상적으로 수행되지 않았습니다.")
	        	}
	        }else{
	        	alert("주소를 정상적으로 Load 하지 못했습니다.");
	        	MakeInfoWindow(latlng);
	        }
		});    
	});
	
	function searchDetailAddrFromCoords(coords, callback) {
	    // 좌표로 법정동 상세 주소 정보를 요청합니다
	    geocoder.coord2detailaddr(coords, callback);
	}

	function MakeInfoWindow(latlng, roadAddress, jibunAddress){
		var jibunAddress = jibunAddress.replace(/(\s*)/g,"");
		var roadAddress = roadAddress.replace(/(\s*)/g,"");
		var lat = latlng.getLat();
		var lng = latlng.getLng();
		// 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		
		var infoWindow = $('#infoWindow').html();
		
		var iwContent = '<form action="insertplace.do" method="post" style="padding:20px;">'
		+ infoWindow
		+'<input type="hidden" name="id" value='+id+'>'
		+'<input type="hidden" name="lat" value='+lat+'>'
		+'<input type="hidden" name="lng" value='+lng+'>'
		+'<input type="hidden" name="address" value='+jibunAddress+'>'
		+'<input type="hidden" name="roadaddress" value='+roadAddress+'>'
		+'</form>';
		
		iwRemoveable = true;
		// 인포윈도우를 생성합니다
		infowindow = new daum.maps.InfoWindow({
		    position : new daum.maps.LatLng(latlng), 
		    content : iwContent,
		    removable : iwRemoveable
		});
		infowindow.open(map, marker);
	}
	
	focusMarker(lat, lng);
	getMapdata();
}

function focusMarker(lat, lng) {
	var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
	var imageSize = new daum.maps.Size(24, 35);
	var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize);
	var marker = new daum.maps.Marker({
		map : map, // 마커를 표시할 지도
		position : new daum.maps.LatLng(lat, lng), // 마커를 표시할 위치
			title : '현재위치', // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			image : markerImage
		// 마커 이미지 
	});
	marker.setMap(map);
}

var getdata;
function getMapdata() {
	if(id != ""){
		$.ajax({
			url : "idcheckMapdata",
			data: {"id":'${sessionScope.log.id}'},
			dataType : "json",
			error : function(){alert("공공시설 정보 오류");},
			success : function(data){
				makeMarker(data);
				getdata = data;
				page(1);
			}
		});
	}else{
		alert("Login인 정상적으로 진행되지 않았습니다.");	
	}
}

function rangesearchswitch() {
	if($(switch1).is(":checked")){
		var theForm = document.form;
		theForm.action = "focusinsertplace.do";
		theForm.submit();	
	}else{
		var theForm = document.form;
		theForm.action = "insertplace.do";
		theForm.submit();	
	}
}

function panTo(x, y) {
	var moveLatLon = new daum.maps.LatLng(x, y);
	map.setLevel(2);
	map.panTo(moveLatLon);
}

function makeMarker(data) {
	var keys = Object.keys(data);
	var vo = data[keys[0]];
		var makers = $(data).map(function(i, vo) {
		var maks = new daum.maps.Marker({
			map : map,
			title : vo.name,
			position : new daum.maps.LatLng(vo.wsg84x, vo.wsg84y)
		});
		return maks;
	});
}

function info(cnt) {
	$('.infoname').html(getdata[cnt].name 
		+ ' <span class="label label-warning">9.8</span> <small class="infocategory2"> ('
		+ getdata[cnt].category2
		+ ')</small>')
	$('.infoaddress').text(getdata[cnt].address)
	$('.infophonenumber').text(getdata[cnt].phonenumber)
	$('.infotime').text(getdata[cnt].time)
	$('.infocloseddays').text(getdata[cnt].closeddays)
	$('.infocomments').text(getdata[cnt].comments)
	$('#information').modal('show');
}

function makeList(page){
	var totalcount = getdata.length;
	var pageSize = 10;
	var finalPage = parseInt((totalcount + (pageSize-1)) / pageSize);
	$('#list').html('<span>'+id+'님이 등록한 장소는  '+getdata.length+'개 입니다. </span>')
	$('#list div').remove()
	
	/* 거리나 가까운순으로 정렬 */
	getdata.sort(function (a, b) { 
		return a.distance < b.distance ? -1 : a.distance > b.distance ? 1 : 0;  
	});
	
	for(var i = pageSize*(page-1); i < pageSize*page; i++){
		if(i < totalcount){
			var listOrig = $('#list').html()
			var panelTop = '<div class="panel panel-default"><div class="panel-heading">'
			var	panelTitle ='<h3 class="panel-title" onclick="javascript:panTo('+getdata[i].wsg84x+','+getdata[i].wsg84y+')" style="cursor:pointer"><strong>'+getdata[i].name+'</strong></h3></div>'
			var panleBot = '<div class="panel-body"><strong>'+getdata[i].address+'</strong><br><a onclick="info(' + i + ')" style="cursor:pointer">상세정보 보기</a>'
			+'&nbsp&nbsp&nbsp <a href="DeleteMapData.do?name='+getdata[i].name+'">X</a>'
			+'</div></div>'
			$('#list').html(listOrig + panelTop + panelTitle + panleBot);
		}
	}
}	

function pageBlcokCount(pageNo, pageBlockNo, pageBlock, totalpageBlock){
	var pageBlockNo = pageBlockNo;
	var pageBlock = pageBlock;
	var totalpageBlock = totalpageBlock;
	for(i=1; i<=totalpageBlock; i++){
        if(pageNo > pageBlock*i){pageBlockNo = pageBlockNo+1;}
     }	
	return pageBlockNo;
} 

function page(pageNo){
	$('#page li').remove()
	var totalcount = getdata.length;
	var pageBlockNo = 1;
	var pageBlock = 5;
	var pageSize = 10;
	var count = 5;
	
	//마지막 페이지
	var finalPage = parseInt((totalcount + (pageSize-1)) / pageSize);
	var fisrtPageNo = 1;
	var isNowFirst;
	if(pageNo == 1){isNowFirst = true;}else{isNowFirst = false;}
	var isNowFinal;
	if(pageNo == finalPage){isNowFinal = true;}else{isNowFinal = false;}
	var prevPageNo
	if(isNowFirst){prevPageNo = 1;}else{
		if((pageNo -1)<1){
			prevPageNo = 1
		}else{
			prevPageNo = pageNo-1;
		}
	}
	var nextPageNo
	if(isNowFinal){nextPageNo = finalPage;}else{
		if((pageNo+1)>finalPage){
			nextPageNo = finalPage;
		}else{
			nextPageNo = pageNo+1;
		}
	}
	var totalpageBlock;
	if(finalPage%pageBlock != 0){
		totalpageBlock =  parseInt(finalPage/pageBlock)+1;
	}else{
		totalpageBlock =  parseInt(finalPage/pageBlock);
	}
	pageBlockNo = pageBlcokCount(pageNo, pageBlockNo, pageBlock, totalpageBlock);
	var startblock = parseInt((pageBlockNo -1 / pageBlock))*pageBlock+1;
	var endblock = startblock + pageBlock-1;
	if(endblock>finalPage){
		endblock = finalPage;
	}
	
	/*console.log("현재 페이지 ="+pageNo);
	console.log("finalPage = "+finalPage);
	console.log("prevPageNo = "+prevPageNo);
	console.log("nextPageNo = "+nextPageNo);
	console.log("startblock = "+startblock);
	console.log("endblock = "+endblock); */
		
	if(finalPage > 5){
		for(var i = startblock; i<=endblock; i++){
			var pageOrig = $('#page').html()
			var page = '<li><a onclick="page('+ i +')" style="cursor:pointer">'+i+'</a></li>'
			$('#page').html(pageOrig + page);
		}
	var pageAfter = $('#page').html()
	var first = '<li><a onclick="page('+fisrtPageNo+')" style="cursor:pointer"><span aria-hidden="true">&laquo;</span></a></li>'
	var prev = '<li><a onclick="page('+ prevPageNo +')" style="cursor:pointer"><span aria-hidden="true">&lt;</span></a></li>'
	var next = '<li><a onclick="page('+ nextPageNo +')" style="cursor:pointer"><span aria-hidden="true">&gt;</span></a></li>'
	var last = '<li><a onclick="page('+ finalPage +')" style="cursor:pointer"><span aria-hidden="true">&raquo;</span></a></li>'
	if(pageNo == 1){
		$('#page').html(pageAfter + next + last)
	}else if(pageNo == finalPage){
		$('#page').html(first + prev + pageAfter)
	}else{
		$('#page').html(first + prev + pageAfter + next + last)
	}
}else{	
	for(var i = 1; i<=finalPage; i++){
		var pageOrig = $('#page').html()
		var page = '<li><a onclick="page('+ i +')" style="cursor:pointer">'+i+'</a></li>'
		$('#page').html(pageOrig + page);
	}
}
makeList(pageNo);	
} 
</script>