<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, com.hongik.project.vo.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
				<button type="button" onclick="javascript:rangesearch()">현재 위치 이동</button>
			</div>
			<div class="input-group">
				<c:if test="${address eq 'null'}">
					<input type="text" class="form-control"  placeholder="원하시는 지역명을 입력하세요(기준: 서울시청)" name="address">
				</c:if>
				<c:if test="${address ne 'null'}">
					<input type="text" class="form-control"  placeholder="원하시는 지역명을 입력하세요(기준: 서울시청)" name="address" value="${address}">
				</c:if>
				<div class="input-group-btn">
					<button class="btn btn-default" type="submit">
						<span class="glyphicon glyphicon-search"></span>
					</button>
				</div>
			</div>
		</form>
	</div>
</div>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
		<c:if test="${address eq 'null' || focusXYlist[0] == 1}">
		 	center: new daum.maps.LatLng(37.566696, 126.977942), //지도의 중심좌표.
		 	level: 7//지도의 레벨(확대, 축소 정도)
		</c:if>
		<c:if test="${address ne 'null' && focusXYlist[0] != 1}">
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
	map.addControl(mapTypeControl, daum.maps.ControlPosition.LEFT);

	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new daum.maps.ZoomControl();
	map.addControl(zoomControl, daum.maps.ControlPosition.BOTTOMRIGHT);

	var clusterer = new daum.maps.MarkerClusterer({
		map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
		averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
		minLevel : 3
	// 클러스터 할 최소 지도 레벨 
	});
	
	var marker = new daum.maps.Marker({}); 
	marker.setMap(map);
	
	daum.maps.event.addListener(map, 'click', function(mouseEvent){
		var latlng = mouseEvent.latLng;
		marker.setPosition(latlng);
	});  
	
</script>