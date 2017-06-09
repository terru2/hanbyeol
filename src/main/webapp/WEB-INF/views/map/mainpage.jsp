<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, com.hongik.project.vo.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
$(document).ready(function(){
	getMapdata();
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

<div class="col-sm-6 col-md-3 sidebar-offcanvas sidebar" style="height: 100%;">
	<!-- 조건절들 보여주는 부분  -->
	<div style="padding-left: 0px; padding-right: 0px; padding-bottom: 15px; padding-top: 15px;">
		<form action="townsearch.do" name="form">
			<div>
				<span>현재 위치 범위 검색</span>
				<select name="range">
					<option value="500">500m</option>
					<option value="1000">1km</option>
					<option value="2000">2km</option>
				</select>
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-primary">
						<input type="radio" name="options" id="ON"> ON
					</label>
					<label class="btn btn-primary active">
						<input type="radio" name="options" id="OFF" checked> OFF
					</label>
				</div>
			</div>
			<div class="input-group">
				<select name="city" id="city" onchange="javascirpt:getTownShip(this, 'township')" style="width: 80px; height: 30px;">
					<option value="default">=시/도=</option>
					<c:forEach items="${citylist}" var="list">
						<option>${list.city}</option>
					</c:forEach>
				</select>
				<select name="township" id="township" style="width: 80px; height: 30px;"> 
					<option value="default">=군/구=</option>
				</select>
				<select name="category1" style="width: 90px; height: 30px;">
					<option value="default">=시설물=</option>
					<c:forEach items="${categorylist}" var="list">
						<option>${list.category1}</option>
					</c:forEach>
				</select>
				<button class="btn btn-default" onclick="javascript:rangesearchswitch()">
					<span class="glyphicon glyphicon-search"></span>
				</button>
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
<script>
var switch1 = document.getElementById("ON");
var switch2 = document.getElementById("OFF");
var markers = [];

function rangesearchswitch() {
	if($(switch1).is(":checked")){
		var theForm = document.form;
		theForm.action = "rangesearch.do";
		theForm.submit();
	}
}

var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new daum.maps.LatLng('${focuslist[0]}', '${focuslist[1]}'), //지도의 중심좌표.
		level: 5//지도의 레벨(확대, 축소 정도)
	};
var map = new daum.maps.Map(container, options);
	map.setZoomable(false);
//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new daum.maps.MapTypeControl();

// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의합니다
map.addControl(mapTypeControl, daum.maps.ControlPosition.LEFT);

// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new daum.maps.ZoomControl();
map.addControl(zoomControl, daum.maps.ControlPosition.BOTTOMRIGHT);

var clusterer = new daum.maps.MarkerClusterer({
    map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
    averageCenter: false, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
    minLevel: 5  // 클러스터 할 최소 지도 레벨 
});

daum.maps.event.addListener(map, 'tilesloaded', function() {
    addMarkeroutMap(map.getBounds());
    makeList(map.getBounds());
});

// 다중 Select Box를 위한 Script
function getTownShip(srcE, targetId){
	var val = srcE.options[srcE.selectedIndex].value;
	var targetE = document.getElementById(targetId);
	removeAll(targetE);
	$.ajax({
		url : "getTownShiplist",
		data : {
				"city":val
				},
		dataType : "json",
		error : function(){alert("군/구 데이터 오류 ");},
		success : function(data){
 			for(var i=0; i<data.length; i++){
 				addOption(data[i].township, targetE);
 			}
		}
	});
}

function addOption(value, e){
	var o = new Option(value);
	e.add(o);
}

function removeAll(e){
    for(var i = 0, limit = e.options.length; i < limit - 1; ++i){
        e.remove(1);
    }
}

var getdata;
function getMapdata() {
	$.ajax({
		url : "allMapdata",
		data : {
				"city":'${city}',
				"township":'${township}',
				"category1":'${category1}'
				},
		dataType : "json",
		error : function(){alert("공공시설 정보 오류");},
		success : function(data){
			putMarkerinMap(data);
			getdata = data;
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
    }
 }

function panTo(x,y){
	 var moveLatLon = new daum.maps.LatLng(x, y);
	 map.setLevel(3);
	 map.panTo(moveLatLon);
}

function addMarkeroutMap(bound){
	var clusterermarkes=[];
    for(var i = 0; i < markers.length; i++){
       if(bound.contain(markers[i].getPosition()) == true){
//    	  clusterer.addMarker(markers[i]);
          clusterermarkes.push(markers[i]);
       }else{
//    	  clusterer.removeMarker(markers[i]);
       }
    }
    clusterer.addMarkers(clusterermarkes);
 }

function makeList(bound){
	$('#list').html('<span>총 '+getdata.length+'개의 데이터가 검색 되었습니다. </span>')
	$('#list div').remove();
	 for(var i = 0; i < markers.length; i++){
		 if(bound.contain(markers[i].getPosition()) == true){
			var listOrig = $('#list').html()
			var panelTop = '<div class="panel panel-default"><div class="panel-heading">'
			var	panelTitle ='<h3 class="panel-title" onclick="javascript:panTo('+getdata[i].wsg84x+','+getdata[i].wsg84y+')" style="cursor:pointer"><strong>'+markers[i].getTitle()+'</strong></h3></div>'
			var panleBot;
			<c:if test="${sessionScope.log.id  eq 'admin'}">
				panleBot = '<div class="panel-body"><strong>'+getdata[i].address+'</strong><br><a onclick="info(' + i + ')" style="cursor:pointer">상세정보 보기</a>'
				+'&nbsp&nbsp&nbsp <a href="DeleteMainMapData.do?name='+markers[i].getTitle()+'">X</a>'
				+'</div></div>'
	        </c:if>
			<c:if test="${sessionScope.log.id  ne 'admin'}">
				panleBot = '<div class="panel-body"><strong>'+getdata[i].address+'</strong><br><a onclick="info(' + i + ')" style="cursor:pointer">상세정보 보기</a></div></div>'
	        </c:if>
			$('#list').html(listOrig + panelTop + panelTitle + panleBot);
		}
	}
}
</script>