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
   <div id="list">
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
    center: new daum.maps.LatLng(37.566696, 126.977942), //지도의 중심좌표.
    level: 7//지도의 레벨(확대, 축소 정도)
};
var map = new daum.maps.Map(mapContainer, mapOption); 
//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new daum.maps.MapTypeControl();
//지도에 컨트롤을 추가해야 지도위에 표시됩니다
//daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의합니다
map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

//지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new daum.maps.ZoomControl();
map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

var id = "${sessionScope.log.id}";
   
var getdata;
function getMapdata() {
   if(id != ""){
      $.ajax({
         url : "getShareData",
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
      location.href="main.do"
   }
}

var clusterer = new daum.maps.MarkerClusterer({
	map : map,
	averageCenter : true,
	minLevel : 3
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
				'			<strong>' + getdata[i].name + '</strong>' + '<small> (' + getdata[i].id + ')</small>' + 
				'			<button type="button" class="close" onclick="custominfowindow.setMap(null)">' + 
				'				<span>&times;</span>' + 
				'			</button>' + 
				'        </div>' + 
				'        <div class="body">' + 
				'            <div class="desc">' + 
				'                <div class="address">'+ getdata[i].address +'</div>' + 
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


function info(i) {
	var basic = $('#information').html();
	var shareinfobtn = '<a class="btn btn-success " href="sharingdata.do?name='+getdata[i].name+'&id='+getdata[i].id+'">등록</a>' + 
						'<button class="btn btn-warning" onclick="shareControl('+i+', 1)" data-dismiss="modal">취소</button>' + 
						'<button class="btn btn-danger" onclick="shareControl('+i+', 2)" data-dismiss="modal">장소 삭제</button>';
	
	$('hr').remove()
	$('#boardinput').remove()
	$('#createtable').remove()
	$('#pageMove').remove()
						
	$('.infoname').html('<strong>' + getdata[i].name + '</strong>' +  
						' <small id="category" class="infocategory2"> (' + getdata[i].category1 + ')</small>')
	$('.infoaddress').text(getdata[i].address)
	$('.infophonenumber').text(String(getdata[i].phonenumber).replace(null , '정보없음'))
	$('.infotime').text(String(getdata[i].time).replace(null , '정보없음'))
	$('.infocloseddays').text(String(getdata[i].closeddays).replace(null , '정보없음'))
	$('.infocomments').text(String(getdata[i].comments).replace(null , '정보없음'))
	$('#infodata').append('<dt>등록자</dt>' + 
						'	<dd class="text-right infoid">' + getdata[i].id + '</dd>')
	$('.infobtn').html(shareinfobtn)
	
	switch(getdata[i].category1){
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
	
		
	$('#information').modal('show');
	
	$('#information').on('hidden.bs.modal', function(){
		$('#information').html(basic)
	});	
}

function makeList(page){
	var totalcount = getdata.length;
	var pageSize = 10;
	var finalPage = parseInt((totalcount + (pageSize-1)) / pageSize);
	
	$('#list').empty()
	$('#list').html('<h3>공유 요청 자료</h3><span> 현재 공유대기중인 데이터는 '+getdata.length+'개 입니다. </span>')
	
	for(var i = pageSize*(page-1); i < pageSize*page; i++){
		if(i < totalcount){
			var listOrig = $('#list').html()
			
			var panel = '<div class="panel panel-default" id="'+i+'">' + 
						'	<div class="panel-heading">' + 
						'		<h3 class="panel-title" onclick="panTo('+i+')" style="cursor:pointer">' + 
						'			<strong>'+getdata[i].name+'</strong>' + ' (' + getdata[i].id + ')' + 
						'		</h3>' + 
						'	</div>' + 
						'	<div class="panel-body"><strong>'+getdata[i].address+'</strong><br>' + 
						'		<a class="link" onclick="info(' + i + ')" style="cursor:pointer">상세정보 보기</a>' +
						'		<button class="btn btn-xs btn-danger pull-right" onclick="shareControl('+i+', 2)">장소 삭제</button>' + 
						'		<button class="btn btn-xs btn-warning pull-right" onclick="shareControl('+i+', 1)" style="margin-right: 10px;">취소</button>' + 
						'	</div>' + 
						'</div>';
			$('#list').append(panel);
		}
	}
}

function shareControl(i, type){
	var url;
	
	if(type == 1){
		url = 'ShareCancle.do';
	}else if(type == 2){
		url = 'DeleteMapData.do';
	}
	
	$.ajax({
		type : 'POST',  
		url : url,
		data:{ "name" :  getdata[i].name,
				"id" : getdata[i].id
			},
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