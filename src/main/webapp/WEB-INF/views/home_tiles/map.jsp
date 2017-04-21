<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="col-sm-9 col-md-10">
	<div id="map" style="width:100%;height:400px;"></div>
</div>
<script>
var mapOptions = {
    center: new naver.maps.LatLng(37.5666805, 126.9784147),
    zoom: 10
};

var map = new naver.maps.Map('map', mapOptions);

var cityhall = new naver.maps.LatLng(37.5666805, 126.9784147);

var contentString = [
    '<div class="iw_inner">',
    '   <h3>서울특별시청</h3>',
    '   <p>서울특별시 중구 태평로1가 31 | 서울특별시 중구 세종대로 110 서울특별시청<br>',
    '       <img src="./img/hi-seoul.jpg" width="55" height="55" alt="서울시청" class="thumb" /><br>',
    '       02-120 | 공공,사회기관 > 특별,광역시청<br>',
    '       <a href="http://www.seoul.go.kr" target="_blank">www.seoul.go.kr/</a>',
    '   </p>',
    '</div>'
].join('');

var marker = new naver.maps.Marker({
    map: map,
    position: cityhall
});

var infowindow = new naver.maps.InfoWindow({
    content: contentString
});

naver.maps.Event.addListener(marker, "click", function(e) {
    if (infowindow.getMap()) {
        infowindow.close();
    } else {
        infowindow.open(map, marker);
    }
});
</script>