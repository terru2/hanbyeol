<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.hongik.project.vo.BoardVO"%>
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
							<img class="img-rounded" src="resources/images/이미지없음.png" width="100%" height="100%">							
            			</div>
            			<div class="col-sm-8">
							<dl id="infodata">
								<dt>주소</dt>
									<dd class="text-right infoaddress"></dd>
								<dt>전화번호</dt>
									<dd class="text-right infophonenumber"></dd>
								<dt>이용시간</dt>
									<dd class="text-right infotime"></dd>
								<dt>휴무일</dt>
									<dd class="text-right infocloseddays"></dd>
								<dt>기타사항</dt>
									<dd class="text-right infocomments"></dd>
							</dl>
						</div>
						<div class="col-sm-12">
							<h2 class="infoname" style="margin-bottom: 20px;"></h2>
							<hr style="border: solid 1px #e5e5e5;">
						</div>
						<div id="boardinput">
							<div class="col-sm-12">
								<h4 class="col-sm-3" style="padding: 0px; display: inline-flex">
									<strong>평가하기</strong>
								</h4>
								<div class="col-sm-9" style="padding: 0px; display: inline">
									<select class="selectpicker" data-width="fit" id="gpa">
										<option value="10">★★★★★</option>
										<option value="8">★★★★☆</option>
										<option value="6">★★★☆☆</option>
										<option value="4">★★☆☆☆</option>
										<option value="2">★☆☆☆☆</option>
										<option value="0">☆☆☆☆☆</option>
									</select>
									<label id="reviewStarLabel" class="control-label input-sm" style="float: right">별점</label>
									<input id="reviewPwInput" type="password" class="form-control input-sm" style="margin-bottom: 5px; float: right;" placeholder="Password">
									<label id="reviewPwLabel" class="control-label input-sm" style="float: right;">비밀번호</label>
								</div>
							</div>
							<div class="col-sm-12" style="display: inline-block;">
								<div class="input-group">
									<textarea id="comment" class="form-control" style="resize: none;" maxlength="60" placeholder="${log.nickname} 회원님의 평가를 입력해주세요."></textarea>
									<span class="input-group-addon btn btn-default" onclick="saveatDB()">등록</span>
								</div>
							</div>
						</div>
						<div class="col-sm-12" id="createtable">
						</div>
						<div class="col-sm-12" id="pageMove">
						</div>
            		</div>						
				</div>
			</div>
			<div class="modal-footer infobtn">
				<button id="close" type="button" class="btn btn-default" data-dismiss="modal" >Close</button>								
			</div>
		</div>
	</div>
</div>
<script>
$('.selectpicker').selectpicker('setStyle', 'btn-sm', 'add');
$('.bootstrap-select').addClass('pull-right');

function saveatDB(){
	var sisulName = $('#sisulName').text();
	var comments = $('#comment').val();
	var password = $('#reviewPwInput').val();
	var gpa = $('#gpa').val();
	var nowDate = new Date();
	var nowYear = nowDate.getYear()+1900;
	var date = nowYear+"-"+(nowDate.getMonth()+1)+"-"+nowDate.getDate()
	
	if(comments == "" || password == "" || gpa == null){
		$('#comment').val("");
		$('#comment').attr('placeholder','빈칸 또는 작성 내용을 확인하세요')
		return;
		}
	$.ajax({
		type : 'POST',	
		data : "writer=${log.nickname }" + "&comment=" + comments +"&password2="+ password +"&gpa=" + gpa +"&name2=" + sisulName + "&time="+date,
		dataType : 'text',
		url : 'informat',
		error : function(fail){
			alert("게시판 저장요청 오류("+fail+")");
		},
		success : function(success){
			if(success > 0){
				getBoard(sisulName);
				$('#reviewPwInput').val("");
				$('#gpa').selectpicker('val', '★★★★★');
				$('#gpa').selectpicker('refresh');
				$('#comment').val("");
				$('#comment').attr('placeholder','${log.nickname} 회원님의 평가를 입력해주세요.')
			}
		}
	});		 	 
	
}


function deleteSetting(i){
	createtable(boardData,page)
	var deleteSetting ='<button type="button" class="btn btn-danger btn-sm" onclick="deleteComment(' + i + ')" style="float: right;">삭제</button>' + 
						'<input type="password" id="deletePw" class="form-control input-sm" style="width: 30%; float: right;" placeholder="Password">' +
						'<label id="reviewPwLabel" class="control-label input-sm" style="float: right;">비밀번호</label>';
						
	$('#boardComment'+i+'').html(deleteSetting)
}

function deleteComment(i){
	var deletePw = $('#deletePw').val();
	var sisulName = $('#sisulName').text();
	
	if(deletePw == boardData[i].password || '${sessionScope.log.id}' == 'admin'){
	 	$.ajax({
		type : 'POST',
		data : "&seq="+boardData[i].seq,
		dataType : 'text',
		url : 'deleteInfo', 
		error : function(fail){
				alert("게시판 삭제요청 오류("+fail+")");
			},
		success : function(success){				
				if(success > 0){
					getBoard(sisulName);	
				}								
			}
		});
	}else{
		$('#deletePw').val("");
		$('#boardComment'+i+'').attr('class', 'col-sm-8 has-error')
		return;
	}
	
}



$('#gpa').change(function(){
	var selected = $(this).val();
	var comment = $('#comment').val()
	if(comment == "" || comment == "최악이에요" || comment == "별로에요" || comment == "그저 그래요" || comment == "나쁘지 않았어요" || comment == "만족해요" || comment == "매우 좋아요"){		
		switch(selected){	
			case '0' : $('#comment').val("최악이에요");break; 
			case '2' : $('#comment').val("별로에요");break; 
			case '4' : $('#comment').val("그저 그래요");break; 
			case '6' : $('#comment').val("나쁘지 않았어요");break; 
			case '8' : $('#comment').val("만족해요");break; 
			case '10': $('#comment').val("매우 좋아요");break;	 	               
		} 
	}
});




</script>