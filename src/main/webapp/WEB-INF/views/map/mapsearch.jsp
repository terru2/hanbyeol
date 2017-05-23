<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, com.hongik.project.vo.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- <c:forEach>
	<input type="hidden">
</c:forEach> --%>
<script>
$(document).ready(function(){
	getMapdata();
});
</script>
<div class="col-sm-12 col-md-9 map" id="map" style="height: 100%;">
	<p class="pull-right visible-xs visible-sm" id="tog_btn">
		<button type="button" class="btn btn-default btn-sm"
			data-toggle="offcanvas">상세 분류</button>
	</p>
</div>
<div class="col-sm-6 col-md-3 sidebar-offcanvas sidebar" style="height: 100%;">
	<div style="padding-left: 0px; padding-right: 0px; padding-bottom: 15px; padding-top: 15px;">
		<form action="mapsearch.do">
			<select class="form-control" name=category1>
				<c:forEach items="${category1list}" var="list">
					<option hidden selected>시설 선택</option>
					<option>${list.category1}</option>
				</c:forEach>
			</select>
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
	<div>
		<span>총 ${pageVO.totalCount}개의 데이터가 검색 되었습니다. </span>
	</div>	
	<c:forEach items="${searchlist}" var="searchlist">
	<c:if test="${searchlist.distance < 1000}">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title" onclick="javascript:panTo(${searchlist.wsg84x},${searchlist.wsg84y})" style="cursor:pointer">
					<strong>${searchlist.name}</strong>
				</h3>
			</div>
			<div class="panel-body">
				<strong>${searchlist.address}</strong><br><a>상세정보 보기</a><br>
				 <%-- <span class="glyphicon glyphicon-phone-alt"></span> ${searchlist.phonenumber} --%>
			</div>
		</div>
	</c:if>	
	</c:forEach>
		<div id="page" align="center">
    <c:if test="${pageVO.pageNo != 0}">
        <c:if test="${pageVO.pageNo > pageVO.pageBlock}">
            <a href="mapsearch.do?page=${pageVO.firsthtmlPageNo}&address=${address}&category1=${category1}" style="text-decoration: none;">[처음]</a>
       </c:if>
       <c:if test="${pageVO.pageNo != 1}">
           <a href="mapsearch.do?page=${pageVO.prevhtmlhtmlPageNo}&address=${address}&category1=${category1}" style="text-decoration: none;">[이전]</a>
        </c:if>
        <span>
            <c:forEach var="i" begin="${pageVO.startPageNo}" end="${pageVO.endPageNo}" step="1">
                <c:choose>
                    <c:when test="${i eq pageVO.pageNo}">
                        <a href="mapsearch.do?page=${i}&address=${address}&category1=${category1}" style="text-decoration: none;">
                            <font style="font-weight: bold;">${i}</font>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="mapsearch.do?page=${i}&address=${address}&category1=${category1}" style="text-decoration: none;">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </span>
        <c:if test="${pageVO.pageNo != pageVO.finalPageNo }">
            <a href="mapsearch.do?page=${pageVO.lasthtmlhtmlhtmlPageNo}&address=${address}&category1=${category1}" style="text-decoration: none;">[다음]</a>
        </c:if>
        <c:if test="${pageVO.endPageNo < pageVO.finalPageNo }">
            <a href="mapsearch.do?page=${pageVO.finalPageNo}&address=${address}&category1=${category1}" style="text-decoration: none;">[끝]</a>
        </c:if>
    </c:if>
    </div>
</div>
<script type="text/javascript">
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
	    map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
	    averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
	    minLevel: 3  // 클러스터 할 최소 지도 레벨 
	});

function getMapdata() {
		$.ajax({
			url : "searchMapdata",
			data: {"category1":'${category1}'},
			dataType : "json",
			error : function(){alert("공공시설 정보 오류");},
			success : function(data){
				makeMarker(data);				
			}
		})
	}

	function makeMarker(data){
		var keys = Object.keys(data);
		var vo = data[keys[0]];
		
		var makers = $(data.positions).map(function(i, vo){
			var maks = new daum.maps.Marker({
				map : map,
				title : vo.name,
				position : new daum.maps.LatLng(vo.wsg84x, vo.wsg84y)
			});
			return maks;
			});
			clusterer.addMarkers(makers);
	}

function panTo(x,y){
	 var moveLatLon = new daum.maps.LatLng(x, y);
	 map.setLevel(1);
	 map.panTo(moveLatLon);
}
</script>
