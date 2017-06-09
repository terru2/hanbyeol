<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.hongik.project.vo.BoardVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
#writer1{/* 비회원 */
	display : none;
}
#writer2{/* 닉네임 */
	display : none;
}
#temp1{/* 로그인확인여부 */
	display : none;
}
.previous{/* 이전버튼 */
	display : none;
}
.next{/* 다음버튼 */
	display : none;
}
#commentLength{
	display : none;
}
#sisulName{	
    color : white;
    text-shadow: 1px 1px 2px black, 1px 1px 6px #555555;
}
#reload{		
	 transition: background 2s, width 2s, height 2s;
}
#reload:hover {
	background: green;
	width: 120px;
    height: 40px; 
} 

</style>

<div class="modal fade" id="information" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span>&times;</span></button>					
				<h4 class="modal-title">상세 정보</h4>				
			</div>
			<div class="modal-body">
				<div class="container-fluid">
            		<div class="row">
            			<div class="col-sm-4">
							<img class="img-rounded" src="resources/images/library.jpg" width="180" height="180">							
            			</div>
            			<div class="col-sm-8">
							<dl>
								<dt>주소</dt>
								<dd class="text-right infoaddress"></dd>
								<dt>전화번호</dt>
								<dd class="text-right infophonenumber"></dd>
								<dt>이용시간</dt>
								<dd class="text-right infotime"></dd>
								<dt>휴무일</dt>
								<dd class="text-right infocloseddays"></dd>
								<dt>기타사항</dt>
								<dd class="text-right infocomments">1. 관람료 있음<br>2. 동계 이용시간은 1시간 가량 짧음<br>2. 동계 이용시간은 1시간 가량 짧음<br>2. 동계 이용시간은 1시간 가량 짧음<br>2. 동계 이용시간은 1시간 가량 짧음</dd>
							</dl>
						</div>
						<div class="col-sm-12">
							<h2 id="infoname" class="infoname"></h2> 
							<h4>시설 평가 </h4>
							<hr>
							
							<span id="createtable">							
							</span>
							
							<ul class="pager">
								<li class="previous"><a href="#" onClick="backBoard();">&larr;	이전</a></li>
								
								<li class="next"><a href="#" onClick="nextBoard();">다음 &rarr;</a></li>								
							</ul>
							<span id="Newcreate">
								<FONT id="writer" SIZE="4"><strong id="writer1" style="color:gray">비회원 </strong><strong id="writer2" style="color:green">${log.nickname}</strong>님</FONT>
								<span id="comment_password"></span>						
								 <body><span>&nbsp별★점&nbsp<a id="a1" onclick="aTag(2)">★</a><a id="a2" onclick="aTag(4)">★</a><a id="a3" onclick="aTag(6)">★</a><a id="a4" onclick="aTag(8)">★</a><a id="a5" onclick="aTag(10)">★</a></span><span onclick="aTag(0)"><FONT SIZE="2">&nbsp※ 모두☆로 채우기</FONT></span></body>								 
								<!-- <FONT SIZE="3">&nbsp별★점&nbsp<select id = "rate2" name= "rate2"><option value="10">★★★★★</option><option value="8">★★★★☆</option><option value="6">★★★☆☆</option ><option value="4">★★☆☆☆</option><option value="2">★☆☆☆☆</option><option value="0">☆☆☆☆☆</option></select></div> -->						
								<textarea id="comment" name="comment" rows="2" cols="70">한줄평을 입력해주세요. 한줄평은 100글자까지만 입력가능합니다.</textarea>																
							</span>
						</div>
            		</div>
					<span id="temp1" name="temp1">${log.nickname}</span>
					
				</div>
			</div>
			<div class="modal-footer">
				<span id="commentLength"><Font size="3" style="color:red">더 이상 입력 불가능 합니다. </Font></span>
							
				<button id="reload" type="button" class="btn btn-primary" onclick="saveatDB()" >평가하기</button>				
				<button id="close" type="button" class="btn btn-default" data-dismiss="modal" >Close</button>								
			</div>
		</div>
	</div>
</div>
<script>
var nickname = "" + $('#temp1').text();//로그인 여부 확인과 닉네임 저장
var nowDate = new Date(); //날짜관련
var nowYear = nowDate.getYear()+1900;//날짜관련
var lowDate = nowYear+"-"+(nowDate.getMonth()+1)+"-"+nowDate.getDate()+" "+nowDate.getHours()+":"+nowDate.getMinutes()//현재 날짜와 시간을 저장하는 변수
var name; //걍 db 불러오기 위한...
var bData;
var currentNum = 0;//게시판의 처음시작 번호, DB의 첫 시작 부분을 의미
var starScore = 10;//별점 초기값을 10으로...

$('#information').on('shown.bs.modal', function(){//모달이 실행될때 실행되는 문장
	name = sessionStorage.getItem("name");//시설 이름을 불러오는문장	
	getDB();
	cl();
});

function getDB(){
	 $.ajax({//게시판의 이름에 관한 전체를 불러오는 문장
		type : "POST",
		url : "Boardinfo",		
		async : false,
		data : "name="+name,
		dataType : "json",
		error : function(){
		alert("게시판 정보요청 오류("+name+")");			
	},
	success : function(data){				
		bData=data;		
		if(data.length == 0){			
			$('#rate').text("0");
			$('#createtable').append('<span id="tb"><hr style="border: solid 1px black;"><FONT id="b" SIZE="3" style="word-break:break-all"> 아직 댓글이 없습니다. </FONT><hr style="border: solid 1px black;"></span>');		
		}
		else{	
				rate();
				showBoard();
			}
		}	
	});
}

function rate(){	
	$.ajax({//평점 불러오는...
		type : "GET",
		url : "return2",		
		async : false,
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

if(nickname != ""){//로그인을 했는지 확인하는 문장 
	$('#writer1').hide();	
	$('#abc').remove();
	$('#writer2').show();	
}
else{
nickname="비회원";
$('#writer1').show();
$('#comment_password').append('<FONT id="abc">&nbsp&nbsp&nbsp* 비밀번호 : <abbr title="여기는 글 비밀번호를 입력하는곳 입니다."><input id="comment_pass" type="text" value="**********" size="12"/></abbr>&nbsp</FONT>');
}

function backBoard(){	//이전버튼		
		currentNum = currentNum-4;			
		showBoard();	
}

function nextBoard(){	//다음 버튼		
		currentNum += 4;			
		showBoard();	
}

function cl(){// 글 비번과 한줄평 비우는  함수
$("#comment_pass").click(function(){
	$("#comment_pass").val("");		
});
$("#comment").one("click",function(){//처음에 댓글창 클릭시 비우는 문장
	$("#comment").val("");	
});
}

$('#comment').on('keyup',function(){
	var commLength = $('#comment').val().length;
	if(commLength > 100) $('#commentLength').show();
	else $('#commentLength').hide();
});

function saveatDB(){//평가하기(저장) 버튼 클릭시 호출되는 메소드(함수)		
	var name = sessionStorage.getItem("name");//시설 이름
	var comments = $('#comment').val();
	var password2 = $('#comment_pass').val();
	var gpa = starScore;/* $('#rate2').val(); */
	
	if(comments == "한줄평을 입력해주세요. 한줄평은 100글자까지만 입력가능합니다." || comments == ""){
		comments="한줄평을 작성하지 않으셨습니다;";
	}
	
	//이 아래의 if문과 else if문이 db 저장을 막는 문장이다.
	if(comments.length > 100){//댓글이 100글자를 넘을때 db연결하지않도록...
		alert("댓글창에는 100글자만 입력가능합니다.(현재 "+comments.length+"글자)\n*글 비밀번호 잊지 말아주세요");
	}
	else if(password2 == "" || password2 == "*"){//비밀번호가 널값이나 초기값일때 db연결하지않도록
		alert("비밀번호를 작성해주세요.");
	}	
	else{
		if(bData.length == 0){$('#tb').remove();}	//아직 댓글이 없다는 문장 지우기
		 $.ajax({
			type : 'POST',	
			async : false,
			data : "writer=" + nickname + "&comment=" + comments +"&password2="+ password2 +"&gpa=" + gpa +"&name2=" + name+"&time="+lowDate,
			dataType : 'text',
			url : 'informat',
			error : function(fail){
				alert("게시판 저장요청 오류("+fail+")");
			},
			success : function(success){
				if(success > 0){
					getDB();		
				}
			}
		});		 	 
	}
}

function showBoard(){// 페이징 및 댓글 생성, 삭제버튼, 이전버튼 다음버튼 show,hide
	var k = currentNum;
	var j = k+4;	
	$('.previous').show();
	$('.next').show();
	
	$('#allRow').remove();	
	$('#createtable').append('<div id="allRow"></div>');	
	for(var i=k;i<j;i++){
		if(i < bData.length){
			$('#allRow').append('<span>작성자 : '+bData[i].writer+'님   '+"\t"+' | 별★점 : '+changeGPA(bData[i].gpa)+'점 | '+bData[i].time+'</span>');
			if(nickname == "관리자"){//관리자일때..
				$('#allRow').append('&nbsp&nbsp<a onClick="deleteComment('+i+')"><FONT SIZE="3" style="color: red;">삭 제</FONT></a>');
			}
			else if(nickname != "비회원" && nickname == bData[i].writer){//회원일때..
				$('#allRow').append('&nbsp&nbsp<a onClick="deleteComment('+i+')"><FONT SIZE="3" style="color: red;">삭 제</FONT></a>');				
			}
			else if(nickname == "비회원" && bData[i].writer == "비회원"){
				$('#allRow').append('&nbsp&nbsp<a onClick="deleteMycomment('+i+')"><FONT SIZE="3" style="color: red;">삭 제</FONT></a>');
				$('#allRow').append('<abbr title="자신이 이전에 썼던 글 비밀번호를 입력해주세요."><input id="passwordHwak'+i+'" type="text" size="6"/></abbr>');
			}
			$('#allRow').append('<br><br><FONT SIZE="3" style="word-break:break-all">'+bData[i].comments+'<hr style="border: solid 1px black;"></FONT>');			
		}
		else break;
	}
	if(currentNum <4){
		$('.previous').hide();
	}
	if(currentNum > bData.length-5){//
		$('.next').hide();
	}
}

function deleteMycomment(nnum){//비회원님의 댓글 삭제기능
	console.log(nnum);
	console.log(bData[nnum].seq);
	console.log(bData[nnum].password);	
	var loadHwak = $('#passwordHwak'+nnum).val();
	console.log(loadHwak);
	if(bData[nnum].password == loadHwak){
		$.ajax({
			type : 'POST',	
			async : false,
			data : "&seq="+bData[nnum].seq,
			dataType : 'text',
			url : 'deleteInfo', 
			error : function(fail){
				alert("게시판 삭제요청 오류("+fail+")");
			},
			success : function(success){			
				if(success != tmp || success != ""){
					getDB();		
				}
				var tmp = success;
			}
		});
	}
	else{
		alert("글 비밀번호가 틀렸습니다.");
	}
}
function deleteComment(nnum){//관리자와 회원의 댓글 삭제기능		
	$.ajax({
		type : 'POST',	
		async : false,
		data : "&seq="+bData[nnum].seq,
		dataType : 'text',
		url : 'deleteInfo', 
		error : function(fail){
			alert("게시판 삭제요청 오류("+fail+")");
		},
		success : function(success){			
			if(success != tmp || success != ""){
				getDB();		
			}
			var tmp = success;
		}
	});	
}

function changeGPA(gpa){//별점을 치환하는거!
	switch(gpa){	
	  case 0  : return "☆☆☆☆☆"; 
	  case 2  : return "★☆☆☆☆"; 
	  case 4  : return "★★☆☆☆"; 
	  case 6  : return "★★★☆☆"; 
	  case 8  : return "★★★★☆"; 
	  case 10 : return "★★★★★";	 	               
	}
}

 
function aTag(aScore){//별점 화면에 보여주고 한줄평 변환하는거..	
	 var IdNum = aScore/2;	 
	 if(aScore > starScore){
			for(var j=1;j<=IdNum;j++){				
				$("#a"+j).text("★"); 
			}
		} 		
 	for(var i=5;i>IdNum;i--){
 		$("#a"+i).text("☆"); 						
 	}
 	starScore = aScore;
 	switch(aScore){	
	  case 0: $('#comment').val("최악이예요");break; 
	  case 2: $('#comment').val("별로예요");break; 
	  case 4: $('#comment').val("그저그래요");break; 
	  case 6: $('#comment').val("나쁘지않았어요");break; 
	  case 8: $('#comment').val("만족해요");break; 
	  case 10: $('#comment').val("매우 좋아요");break;	 	               
	}
 }
</script>
