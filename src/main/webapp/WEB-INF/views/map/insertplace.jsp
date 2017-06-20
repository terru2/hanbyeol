<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, com.hongik.project.vo.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
$(document).ready(function(){
	getMapdata();
});
</script>
<!-- Map 부분  -->
<div class="col-sm-12 col-md-9 map" id="map">
</div>
<!-- List 부분  -->
<div class="col-sm-6 col-md-3 sidebar-offcanvas sidebar">
	<!-- 조건절들 보여주는 부분  -->
	<form action="insertplace.do" name="form">
		<div id="gps" style="padding-top: 10px; padding-bottom: 10px;">
			<span>현재 위치로 범위 검색 </span>
			<div class="btn-group" data-toggle="buttons">			
				<label class="btn btn-default btn-on-2 btn-sm">
					<input type="radio" name="switch" id="onoff">ON
				</label>			
				<label class="btn btn-default btn-off-2 btn-sm active">
					<input type="radio" name="switch" id="onoff" checked>OFF
				</label>
			</div>
		</div>
		<div class="input-group" style="padding-top: 10px;">
			<c:if test="${focusAddress eq 'null'}">
				<input type="text" class="form-control"  placeholder="원하시는 지역명을 입력하세요(기준: 서울시청)" name="focusAddress">
			</c:if>
			<c:if test="${focusAddress ne 'null'}">
				<input type="text" class="form-control"  placeholder="원하시는 지역명을 입력하세요(기준: 서울시청)" name="focusAddress" value="${focusAddress}">
			</c:if>
			<div class="input-group-btn">
				<button class="btn btn-default" onclick="rangesearchswitch()">
					<span class="glyphicon glyphicon-search"></span>
				</button>
			</div>
		</div>
	</form>
	<div id="list" style="padding-top: 10px;">
	</div>
	<nav align="center">
		<ul id="page" class="pagination" >
		</ul>
	</nav>
	<div id="toTop" class="btn btn-info"><span class="glyphicon glyphicon-chevron-up"></span></div>
</div>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
	<c:if test="${focusAddress eq 'null' || focusXYlist[0] == 1}">
	 	center: new daum.maps.LatLng(37.566696, 126.977942), //지도의 중심좌표.
	 	level: 7//지도의 레벨(확대, 축소 정도)
	</c:if>
	<c:if test="${focusAddress ne 'null' && focusXYlist[0] != 1}">
	 	center: new daum.maps.LatLng('${focusXYlist[0]}', '${focusXYlist[1]}'), //지도의 중심좌표.
	 	level: 5//지도의 레벨(확대, 축소 정도)
	</c:if>
};
//지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new daum.maps.Map(mapContainer, mapOption); 
//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new daum.maps.MapTypeControl();
// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의합니다
map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new daum.maps.ZoomControl();
map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

function rangesearchswitch() {
	if($('#onoff').is(":checked")){
		var theForm = document.form;
		theForm.action = "focusinsertplace.do";
		theForm.submit();
	}else{
		var theForm = document.form;
		theForm.action = "insertplace.do";
		theForm.submit();	
	}  
}

var getdata;
var id = "${sessionScope.log.id}";
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


var clusterer = new daum.maps.MarkerClusterer({
	map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
	averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
	minLevel : 3
// 클러스터 할 최소 지도 레벨 
});

function makeMarker(data) {
	clusterer.clear();
	
	var markers = []; 
	
	for(var i = 0; i < data.length; i++){
		var title = data[i].name;
		var latlng = new daum.maps.LatLng(data[i].wsg84x,data[i].wsg84y);
		
		var marker = new daum.maps.Marker({
			title : title,
			position : latlng
			});
		
		markers.push(marker);		
		markerEvent(marker, i);
	}
	clusterer.addMarkers(markers);
}

function markerEvent(marker, i){
	daum.maps.event.addListener(marker, 'click', function() {
		markerInfo.setMap(null)
		panTo(i);
	});
}


function panTo(i){
	var moveLatLng = new daum.maps.LatLng(getdata[i].wsg84x,getdata[i].wsg84y);

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


function MakeInfoWindow(latlng, roadAddress, jibunAddress){
	var jibunAddress = jibunAddress.replace(/(\s*)/g,"");
	var roadAddress = roadAddress.replace(/(\s*)/g,"");
	var lat = latlng.getLat();
	var lng = latlng.getLng();
	
	var content ='<form action="insertplace.do" method="post">' +  
				'<div class="insertInfo">' + 
				'    <div class="sumupinfo">' + 
				'        <div class="title">' + 
				'			<strong>나만의 장소 추가하기</strong>' +
				'			<button type="button" class="close" onclick="custominfowindow.setMap(null),markerInfo.setMap(null)">' + 
				'				<span>&times;</span>' + 
				'			</button>' + 
				'        </div>' + 
				'        <div class="body">' + 
				'			<div class="desc">' + 
				'				<div class="form-group">' + 
				'			 		<strong>장소 이름</strong>' + 
				'			 		<input type="text" class="form-control" placeholder="추가 할 장소의 이름을 정해주세요" name="name">' + 
				'				</div>' + 
				'				<div class="form-group">' +
				'					<strong>시설 선택</strong>' + 
				'					<select class="selectpicker" name="category1">' + 
				'						<c:forEach items="${category1list}" var="list">' + 
				'							<option>${list.category1}</option>' + 
				'						</c:forEach>' + 
				'							<option>기타</option>' + 
				'					</select>' + 
				'				</div>' + 
				'				<div class="form-group">' +
				'					<strong>이용 시간</strong>' + 
				'					<input type="text" class="form-control" placeholder="ex) 09:00 - 22:00" name="time">' + 
				'				</div>' + 
				'				<div class="form-group">' +
				'					<strong>휴무일</strong>' + 
				'					<input type="text" class="form-control" placeholder="ex) 매주금요일 or 법정공휴일" name="closeddays">' +
				'				</div>' + 
				'				<div class="form-group">' +
				'					<strong>기타 사항</strong>' + 
				'					<textarea class="form-control" rows="3" name="comments"></textarea>' + 
				'				</div>' + 
				'				<div style="text-align:right;">' +
				'					<button type="submit" class="btn btn-sm btn-primary">장소 추가</button>' + 
				'					<button type="button" class="btn btn-sm btn-default" onclick="custominfowindow.setMap(null),markerInfo.setMap(null)">Close</button>' + 
				'				</div>' +
				'				<input type="hidden" name="id" value='+id+'>' + 
				'				<input type="hidden" name="lat" value='+lat+'>' + 
				'				<input type="hidden" name="lng" value='+lng+'>' + 
				'				<input type="hidden" name="address" value='+jibunAddress+'>' + 
				'				<input type="hidden" name="roadaddress" value='+roadAddress+'>' + 
				'            </div>' + 
				'        </div>' + 
				'    </div>' +    
				'</div>' + 
				'</form>';
	
	custominfowindow.setMap(null);
	custominfowindow.setPosition(latlng);
	custominfowindow.setContent(content);
	custominfowindow.setMap(map);
	
}

var geocoder = new daum.maps.services.Geocoder();
function searchDetailAddrFromCoords(coords, callback) {
    // 좌표로 법정동 상세 주소 정보를 요청합니다
    geocoder.coord2detailaddr(coords, callback);
}

var markerInfo = new daum.maps.Marker();
daum.maps.event.addListener(map, 'click', function(mouseEvent){
	
	var latlng = mouseEvent.latLng;
	
	markerInfo.setMap(null);
	markerInfo.setPosition(latlng);
	markerInfo.setMap(map);
	
	searchDetailAddrFromCoords(latlng, function(status, result) {
        
		if (status === daum.maps.services.Status.OK) {
        	console.log(result);
        	var roadAddress = result[0].roadAddress.name;
        	var jibunAddress = result[0].jibunAddress.name;
        	
        	if(id != ""){
            	MakeInfoWindow(latlng, roadAddress, jibunAddress);
            	$('.selectpicker').selectpicker('refresh');
        	}else{
        		alert("Login이 정상적으로 수행되지 않았습니다.")
        	}
        	
        }else{
        	alert("주소를 정상적으로 Load 하지 못했습니다.");
        }
	});
	MakeInfopanTo(latlng)
});

function MakeInfopanTo(latlng){
	
	if($('.row-offcanvas').hasClass('active')){
		$('.row-offcanvas').toggleClass('active');
	}
	
	var mapProjection = map.getProjection();

	var point = mapProjection.pointFromCoords(latlng);

	point.y = point.y-260
	
	var pointTolatlng = mapProjection.coordsFromPoint(point);
	
	map.panTo(pointTolatlng);
}
	
function info(i) {
	var basic = $('#shareinfo').html();
	
	var shareinfobtn = '<button class="btn btn-danger" onclick="shareControl('+i+', 3)" data-dismiss="modal">장소 삭제</button>';
	
	if(getdata[i].shareox == 'X'){
		shareinfobtn = '<button class="btn btn-success" onclick="shareControl('+i+', 1)" data-dismiss="modal">공유 요청</button>' + shareinfobtn;
	}else{
		shareinfobtn = '<button class="btn btn-warning" onclick="shareControl('+i+', 2)" data-dismiss="modal">공유 취소</button>' + shareinfobtn;
	}
	
	$('.infoname').html(getdata[i].name + '<small id="category" class="infocategory"> (' + getdata[i].category1 + ')</small>')
	$('.infoid').text(getdata[i].id)
	$('.infoaddress').text(getdata[i].address)
	$('.infophonenumber').text(getdata[i].phonenumber)
	$('.infotime').text(getdata[i].time)
	$('.infocloseddays').text(getdata[i].closeddays)
	$('.infocomments').text(getdata[i].comments)
	$('.infobtn').html(shareinfobtn)
	
	$('#shareinfo').modal('show');
	
	$('#shareinfo').on('hidden.bs.modal', function(){
		$('#shareinfo').html(basic)
	});	
}

function makeList(page){
	var totalcount = getdata.length;
	var pageSize = 10;
	var finalPage = parseInt((totalcount + (pageSize-1)) / pageSize);
	
	$('#list').empty()
	$('#list').html('<h3>공유 요청 자료</h3><span> 현재 공유대기중인 데이터는 '+getdata.length+'개 입니다. </span>')
	
	/* 거리나 가까운순으로 정렬 */
	getdata.sort(function (a, b) { 
		return a.distance < b.distance ? -1 : a.distance > b.distance ? 1 : 0;  
	});
	
	for(var i = pageSize*(page-1); i < pageSize*page; i++){
		if(i < totalcount){
			var listOrig = $('#list').html()
			var sharstauts;
			var sharebtn;
			
			if(getdata[i].shareox == '1'){
				sharstauts = "";
				sharebtn = '<button class="btn btn-xs btn-success pull-right" onclick="shareControl('+i+', 1)" style="margin-right: 10px;">공유 요청</button>'
			}else if(getdata[i].shareox == '2'){
				sharstauts = "/ 공유 대기중";
				sharebtn = '<button class="btn btn-xs btn-warning pull-right" onclick="shareControl('+i+', 2)" style="margin-right: 10px;">공유 취소</button>'
			}else if(getdata[i].shareox == '3'){
				sharstauts = "/ 공유중";
				sharebtn = '<button class="btn btn-xs btn-warning pull-right" onclick="shareControl('+i+', 2)" style="margin-right: 10px;">공유 취소</button>'
			}
			
			var panel = '<div class="panel panel-default">' + 
						'	<div class="panel-heading">' + 
						'		<h3 class="panel-title" onclick="panTo('+i+')" style="cursor:pointer"><strong>'+getdata[i].name+sharstauts+'</strong></h3>' + 
						'	</div>' + 
						'	<div class="panel-body"><strong>'+getdata[i].address+'</strong><br>' + 
						'		<a class="link" onclick="info(' + i + ')" style="cursor:pointer">상세정보 보기</a>' +
						'		<button class="btn btn-xs btn-danger pull-right" onclick="shareControl('+i+', 3)">장소 삭제</button>' + sharebtn
						'	</div>' + 
						'</div>';
			$('#list').append(panel);
		}
	}
}	

function shareControl(i, type){
	var url;
	
	if(type == 1){
		url = 'ShareMapData.do';
	}else if(type == 2){
		url = 'ShareCancle.do';
	}else if(type == 3){
		url = 'DeleteMapData.do';
	}
	
	$.ajax({
		type : 'POST',  
		url : url,
		data:{ "name" :  getdata[i].name,
				"id" : getdata[i].id},
		success : function(){
				if($('.row-offcanvas').hasClass('active')){
					$('.row-offcanvas').toggleClass('active');
				}
				$('.sidebar').animate({ scrollTop: 0 }, 600);
				custominfowindow.setMap(null);
				getMapdata()
			}
	});
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