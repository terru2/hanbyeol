<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, com.hongik.project.vo.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
$(document).ready(function(){
	getMapdata();
	$('.range').selectpicker('hide')
});
</script>
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
				<label class="btn btn-default btn-on-2 btn-sm" onclick="$('.range').selectpicker('show')">
					<input type="radio" name="switch" id="onoff">ON
				</label>			
				<label class="btn btn-default btn-off-2 btn-sm active" onclick="$('.range').selectpicker('hide')">
					<input type="radio" name="switch" id="onoff" checked>OFF
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
var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new daum.maps.LatLng('${focuslist[0]}', '${focuslist[1]}'), //지도의 중심좌표.
		level: 5//지도의 레벨(확대, 축소 정도)
	};
var map = new daum.maps.Map(container, options);
// 	map.setZoomable(false);
//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new daum.maps.MapTypeControl();

// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의합니다
map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new daum.maps.ZoomControl();
map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

var markers = [];

var clusterer = new daum.maps.MarkerClusterer({
    map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
    averageCenter: false, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
    minLevel: 5  // 클러스터 할 최소 지도 레벨 
});

var custominfowindow = new daum.maps.CustomOverlay();

daum.maps.event.addListener(map, 'tilesloaded', function() {
    addMarkeroutMap(map.getBounds());
    makeList(map.getBounds());
});

function rangesearchswitch() {
	if($('#onoff').is(":checked")){
		var theForm = document.form;
		theForm.action = "rangesearch.do";
		theForm.submit();
	}  
}

var getdata;
function getMapdata() {
	$.ajax({
		url : "allMapdata",
		data : {
				"category1":'${category1}'
				},
		dataType : "json",
		error : function(){alert("공공시설 정보 오류");},
		success : function(data){
			putMarkerinMap(data);
			getdata = data;
			addMarkeroutMap(map.getBounds());
		    makeList(map.getBounds());
		}
	})
}

function putMarkerinMap(data){
	for(var i = 0; i < data.length; i++){
		var title = data[i].name;
		var address = data[i].address;
		var latlng = new daum.maps.LatLng(data[i].wsg84x,data[i].wsg84y);
		var marker = new daum.maps.Marker({
			title : title,
			address : address,	
			position : latlng
			});
		
		markers.push(marker);		
		markerEvent(marker, i);
	}
}

function markerEvent(marker, i){
	daum.maps.event.addListener(marker, 'click', function() {
		panTo(i);
	});
}

function panTo(i){
	var moveLatLng = markers[i].getPosition();

	if($('.row-offcanvas').hasClass('active')){
		$('.row-offcanvas').toggleClass('active');
	}
	
	map.setLevel(3);	
	map.panTo(moveLatLng);
	sumUpInfowindow(i, moveLatLng);	
}

function sumUpInfowindow(i, LatLng){
	var content = '<div class="customInfo">' + 
				'    <div class="sumupinfo">' + 
				'        <div class="title">' + 
				'			<strong>' + markers[i].getTitle() + '</strong>' +
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


function addMarkeroutMap(bound){
	var clusterermarkes=[];
    for(var i = 0; i < markers.length; i++){
       if(bound.contain(markers[i].getPosition()) == true){
          clusterermarkes.push(markers[i]);
       }
    }
    clusterer.addMarkers(clusterermarkes);    
 }


function makeList(bound){
	$('#list').html('<span>총 '+markers.length+'개의 데이터가 검색 되었습니다. </span>')
	$('#list div').remove();
	 for(var i = 0; i < markers.length; i++){
		 if(bound.contain(markers[i].getPosition()) == true){
			var listOrig = $('#list').html()
			
			var deletebtn = '';
			
			<c:if test="${sessionScope.log.id  eq 'admin'}">
				deletebtn = '<a class="btn btn-xs btn-danger pull-right" href="DeleteMapData.do?name='+markers[i].getTitle()+'">장소 삭제</a>'
        	</c:if>
			
			var panel = '<div class="panel panel-default">' + 
						'	<div class="panel-heading">' + 
						'		<h3 class="panel-title" onclick="panTo('+i+')" style="cursor:pointer"><strong>'+markers[i].getTitle()+'</strong></h3>' + 
						'	</div>' + 
						'	<div class="panel-body"><strong>'+getdata[i].address+'</strong><br>' + 
						'		<a class="link" onclick="info(' + i + ')" style="cursor:pointer">상세정보 보기</a>' + deletebtn + 
						'	</div>' + 
						'</div>';
						
			$('#list').html(listOrig + panel);
		}
	}
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