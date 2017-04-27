<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="col-md-9 map">
	<div id="map" style="width:100%; min-height:580px;">
	</div>
</div>
<script>
var mapOptions = {
    center: new naver.maps.LatLng(37.5666805, 126.9784147),
    zoom: 8
};

var map = new naver.maps.Map('map', mapOptions);
</script>