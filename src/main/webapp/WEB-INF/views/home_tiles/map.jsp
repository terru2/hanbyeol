<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- <c:forEach>
	<input type="hidden">
</c:forEach> --%>

<div class="col-md-9 map">
	<div id="map" style="width:100%; min-height:580px;">
	</div>
</div>
<div class="col-md-3 col-md-offset-9 sidebar">
	<div style="padding-left: 0px; padding-right: 0px; padding-bottom: 15px;">
		<div class="input-group">	
			<form class="navbar-form navbar-left" action="mapsearch.do">
			<input type="text" class="form-control" placeholder="원하시는 지역명을 입력하세요(기준: 서울시청)" name="address">
				<select class="form-control" name="table"  >
					<option value="cf_table">문화시설</option>
					<option value="gf_table">체육시설</option>
					<option value="ef_table">응급시설</option>
					<option value="of_table">기타시설</option>
				</select>
				<div class="input-group-btn">
					<button class="btn btn-default" type="submit">
						<span class="glyphicon glyphicon-search"></span>
					</button>
				</div>
			</form>	
		</div>
	</div>	
	<c:forEach items="${datalist}" var="datalist">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><strong>${datalist.name}</strong></h3>
			</div>
			<div class="panel-body">
				<strong>${datalist.address}</strong><br>
				 <span class="glyphicon glyphicon-phone-alt"></span> ${datalist.phonenumber}
			</div>
		</div>
	</c:forEach>
</div>
<script>
/* select 했을시 그 값을 유지 하게끔 하는 javascript  */
$("select[name = table] option[value = '${table}']").prop('selected', true);
var namelist = new Array();
	<% ArrayList<String> list1 = (ArrayList)request.getAttribute("namelist");
	for(int i=0; i<list1.size(); i++){%>
		namelist[<%=i%>] = '<%=list1.get(i).trim()%>';
	<%}%>
var postionXlist = new Array();	
	<% ArrayList<Double> list2 = (ArrayList)request.getAttribute("PositionXlist");
	for(int i=0; i<list2.size(); i++){%>
	postionXlist[<%=i%>] = '<%=list2.get(i)%>';
	<%}%>
var postionYlist = new Array();
	<% ArrayList<Double> list3 = (ArrayList)request.getAttribute("PositionYlist");
	for(int i=0; i<list3.size(); i++){%>
	postionYlist[<%=i%>] = '<%=list3.get(i)%>';
	<%}%>

var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
	center: new daum.maps.LatLng(37.566696, 126.977942), //지도의 중심좌표.
		level: 7//지도의 레벨(확대, 축소 정도)
};

var map = new daum.maps.Map(container, options);

for(var i =0; i<namelist.length; i++){
	var marker = new daum.maps.Marker({
		position : new daum.maps.LatLng(postionXlist[i], postionYlist[i]),
	    title : namelist[i],
	    map: map
	});
}
</script>