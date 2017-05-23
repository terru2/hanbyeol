<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal fade" id="login" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span>&times;</span></button>
				<h4 class="modal-title loginform">Log In</h4>
			</div>
			<form action="login" method="POST">
				<div class="modal-body">
					<div class="form-group">
						<label>ID</label>
						<input type="text" id="loginid" name="id" class="form-control" placeholder="input your ID" required>
					</div>
					<div class="form-group">
						<label>Password</label>
						<input type="password" id="loginpw" name="password" class="form-control" placeholder="input your PW" required>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary loginbtn" onclick="chkId()">Log in</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</form>
		</div>
	</div>
</div>
<div class="modal fade" id="signup" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span>&times;</span></button>
				<h4 class="modal-title">Sign Up</h4>
			</div>
			<form action="signin" method="POST" onsubmit="return checkSubmit()">
			<div class="modal-body">
				<div class="form-group idform" >
					<label>ID 입력 <small class="iderror"></small></label>
					<p class="help-block">영문, 또는 숫자를 포함한 영문 5자 이상, 16자 이하 (대소문자 구분)</p>
					<div class="input-group">
						<input type="text" id="signupid" name="id" class="form-control" placeholder="input new ID" onblur="idReset()" required >
						<div class="input-group-btn">
							<button class="btn btn-default idchkbtn" type="button" onclick="chkDupId()">
								ID 중복 확인 <span class="glyphicon glyphicon-edit"></span>
							</button>
						</div>
					</div>
				</div>
				<div class="form-group pw1form">
					<label>Password 입력</label>
					<p class="help-block">영문, 숫자를 모두 포함하여 6자 이상, 16자 이하 (대소문자 구분)</p>
					<input type="password" id="signuppw" name="password" class="form-control inputpw" placeholder="input new PW" oninput="chkPw()" required>
				</div>
				<div class="form-group pw2form">
					<label>Password 확인</label>
					<p class="help-block">비밀번호를 한번 더 입력해주세요.</p>
					<input type="password" id="signuppw2" class="form-control inputpw2" placeholder="check new PW" oninput="chkPw()" required>
				</div>
				<div class="form-group phoneform">
					<label>전화번호 입력</label>
					<p class="help-block">지역번호 또는 통신사(ex 010) 포함 '-' 없이 입력해주세요</p>
					<input type="text" id="signupphone" name="phonenumber" class="form-control inputphone" placeholder="input PhoneNumber" onblur="chkPhone()" onkeypress="chkPhone()" required>
				</div>
				<div class="form-group">
					<label>Email 입력</label>
					<input type="email" name="email" class="form-control" placeholder="input Email" required>
				</div>
				<div class="form-group nickform">
					<label>Nickname 입력 <small class="nickerror"></small></label>
					<p class="help-block">3자 이상, 7자 이하 </p>
					<div class="input-group">
						<input type="text" id="signupnick" name="nickname" class="form-control inputnick" placeholder="input new Nickname" onblur="nickReset()" required>
						<div class="input-group-btn">
							<button class="btn btn-default nickchkbtn" type="button" onclick="chkDupNick()">
									Nickname 중복 확인 <span class="glyphicon glyphicon-edit"></span>
								</button>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary" >Sign Up</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</form>
		</div>
	</div>
</div>
<div class="modal fade" id="member" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span>&times;</span></button>
				<h4 class="modal-title">My Info</h4>
			</div>
			<div class="modal-body">
				<div>
					<label>ID</label>
					${log.id }<br>
				<label>NickName</label>
				${log.nickname }<br>
				<label>PhoneNumber</label>
				${log.phonenumber }<br>
				<label>Email</label>
				${log.email }
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editinfo" data-dismiss="modal">Edit Info</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="editinfo" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span>&times;</span></button>
				<h4 class="modal-title">Edit Info</h4>
			</div>
			<form action="edit" method="POST" onsubmit="return checkSubmit()">
			<div class="modal-body">
				<div class="form-group idform" >
					<label>ID</label>
					<input type="text" name="id" class="form-control inputid" value="${log.id }" disabled>
				</div>
				<div class="form-group pw1form">
					<label>Password 입력</label>
					<p class="help-block">영문, 숫자를 모두 포함하여 6자 이상, 16자 이하 (대소문자 구분)</p>
					<input type="password" id="editinfopw" name="password" class="form-control inputpw" placeholder="input new PW" oninput="chkPw()" required>
				</div>
				<div class="form-group pw2form">
					<label>Password 확인</label>
					<p class="help-block">비밀번호를 한번 더 입력해주세요.</p>
					<input type="password" id="editinfopw2" class="form-control inputpw2" placeholder="check new PW" oninput="chkPw()" required>
				</div>
				<div class="form-group phoneform">
					<label>전화번호 입력</label>
					<p class="help-block">지역번호 또는 통신사(ex 010) 포함 '-' 없이 입력해주세요</p>
					<input type="text" id="editinfophone" name="phonenumber" class="form-control inputphone" value="${log.phonenumber }" onblur="chkPhone()" onkeypress="chkPhone()" required>
				</div>
				<div class="form-group">
					<label>Email 입력</label>
					<input type="email" name="email" class="form-control" value="${log.email }" required>
				</div>
				<div class="form-group nickform">
					<label>Nickname 입력 <small class="nickerror"></small></label>
					<p class="help-block">3자 이상, 7자 이하 </p>
					<div class="input-group">
						<input type="text" id="editinfonick" name="nickname" class="form-control inputnick" value="${log.nickname }" onblur="nickReset()" required>
						<div class="input-group-btn">
							<button class="btn btn-default nickchkbtn" type="button" onclick="chkDupNick()">
									Nickname 중복 확인 <span class="glyphicon glyphicon-edit"></span>
								</button>
							</div>
						</div>
					</div>					
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary" >Edit</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</form>
		</div>
	</div>
</div>

	<script>
	
 	$('.modal').on('shown.bs.modal', function () {
		$(this).find('input:firsthtml').focus()
		});
 	

 	var signupOrig = $('#signup').html();
 	var editinfoOrig = $('#editinfo').html();
 	var loginOrig = $('#login').html();
 	$('.modal').on('hidden.bs.modal', function () {
        $(this).find('input').val('')
       	$('#signup').html(signupOrig)
       	$('#editinfo').html(editinfoOrig)
       	$('#login').html(loginOrig)
    });
 	
 	
	function chkId(){
		var loginid = $('#loginid').val()
		var loginpw = $('#loginpw').val()
		
		$.ajax({
			type : 'POST',  
			data:"id=" + loginid + "&pw=" + loginpw,
			dataType : 'text',
			url : 'login',  
			success : function(rData) {
				var chklog = rData;

				if(chklog == "logfail"){
					$('.loginform').html('Log In <small class="text-danger logerror"><strong>ID 또는 PassWord 를 확인해주세요</strong></small>')
					$('#login').find('input').val('')
				}else{
					location.reload()
				}
			}
		});
	}
 	
 	
	var dupIdChkBtn = 1;
	function chkDupId(){
 		var prmId = $('#signupid').val();
		if(!prmId.match(/^(?=.*[a-zA-Z])(?=.*[0-9]).{5,16}$|^(?=.*[a-zA-Z]).{5,16}$/)){
			$('.iderror').attr('class','text-danger iderror')
			$('.iderror').text('ID 양식을 확인하세요')
			return;
			}
		$.ajax({
			type : 'POST',  
			data:"prmId="+ prmId,
			dataType : 'text',
			url : 'chkDupId',  
			success : function(rData) {
				var chkRst = rData;
				$('.iderror').hide()
				if(chkRst == 0){	
					dupIdChkBtn = 1;
					$('.idform').attr('class', 'form-group has-success has-feedback idform')
					$('.idchkbtn').attr("class", "btn btn-success idchkbtn")
					$('.idchkbtn').html('<span class="glyphicon glyphicon-ok"></span> ID 사용 가능')
					$('#signupid').removeAttr('onblur')
					$('#signupid').attr('onchange', 'idReset()')
				}else{
					dupIdChkBtn = 0;
					$('.idform').attr('class', 'form-group has-error has-feedback idform')
					$('.idchkbtn').attr("class", "btn btn-danger idchkbtn")
					$('.idchkbtn').html('<span class="glyphicon glyphicon-remove"></span> 새로운 ID를 입력하세요')
				}
			}
		});
	}
	
	function idReset(){
		dupIdChkBtn = 0;
		$('.iderror').show()
		$('.iderror').attr('class','text-danger iderror')
		$('.iderror').text('ID 중복을 확인하세요')
		$('.idform').attr('class', 'form-group idform')
		$('.idchkbtn').attr("class", "btn btn-default idchkbtn")
		$('.idchkbtn').html('ID 중복 확인 <span class="glyphicon glyphicon-edit"></span>')
	}
	
	
	var dupNickChkBtn = 1;
	function chkDupNick(){
		var signupnick = $('#signupnick').val(); 
		var editinfo = $('#editinfonick').val();
		
		if(signupnick != ""){
			chkDupNick2(signupnick)
		}else{
			chkDupNick2(editinfo)
		}
	}
	
	function chkDupNick2(prmNick){
		if(!prmNick.match(/^.{3,7}$/)){
			$('.nickerror').attr('class','text-danger nickerror')
			$('.nickerror').text('Nickname 양식을 확인하세요')
			return;
			}
		$.ajax({
			type : 'POST',  
			data:"prmNick="+ prmNick,
			dataType : 'text',
			url : 'chkDupNick',  
			success : function(rData) {
				var chkRst = rData;
				$('.nickerror').hide()
				if(chkRst == 0){
					dupNickChkBtn = 1;
					$('.nickform').attr('class', 'form-group has-success has-feedback nickform')
					$('.nickchkbtn').attr("class", "btn btn-success nickchkbtn")
					$('.nickchkbtn').html('<span class="glyphicon glyphicon-ok"></span> Nickname 사용 가능')
					$('.inputnick').removeAttr('onblur')
					$('.inputnick').attr('onchange', 'nickReset()')
				}else{
					dupNickChkBtn = 0;
					$('.nickform').attr('class', 'form-group has-error has-feedback nickform')
					$('.nickchkbtn').attr("class", "btn btn-danger nickchkbtn")
					$('.nickchkbtn').html('<span class="glyphicon glyphicon-remove"></span> 새로운 Nickname을 입력하세요')
				}
			}
		});
	}
	function nickReset(){
		dupNickChkBtn = 0;
		$('.nickerror').show()
		$('.nickerror').attr('class','text-danger nickerror')
		$('.nickerror').text('Nickname 중복을 확인하세요')
		$('.nickform').attr('class', 'form-group nickform')
		$('.nickchkbtn').html('Nickname 중복 확인 <span class="glyphicon glyphicon-edit"></span>')
		$('.nickchkbtn').attr("class", "btn btn-default nickchkbtn")
	}
	
	
	var pwChkBtn = 0;
	function chkPw() {
		var signuppw = $('#signuppw').val();
		var editinfopw = $('#editinfopw').val();
		
		if(signuppw != ""){
			var signuppw2 = $('#signuppw2').val();
			chkPw2(signuppw, signuppw2)
		}else{
			var editinfopw2 = $('#editinfopw2').val();
			chkPw2(editinfopw, editinfopw2)
		}	
		
	}
		
	function chkPw2(pw, pw2) {
		
		if(!pw.match(/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,16}$/)){
			$('.pw1form').attr('class', 'form-group has-error has-feedback pw1form')
			$('.pw1form').find('span').remove()
			$('.pw1form').append('<span class="glyphicon glyphicon-remove form-control-feedback"></span>')
		}
		
		if(pw.match(/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,16}$/)){
			$('.pw1form').attr('class', 'form-group has-success has-feedback pw1form')
			$('.pw1form').find('span').remove()
			$('.pw1form').append('<span class="glyphicon glyphicon-ok form-control-feedback"></span>')
			$('.inputpw').attr('onchange', 'chkPw()')
			
			if(pw2 != ''){	
				
				if(pw == pw2){
					pwChkBtn = 1;
					$('.pw2form').attr('class', 'form-group has-success has-feedback pw2form')
					$('.pw2form').find('span').remove()
					$('.pw2form').append('<span class="glyphicon glyphicon-ok form-control-feedback"></span>')
				}
				
				if(pw != pw2){
					pwChkBtn = 0;
					$('.pw2form').attr('class', 'form-group has-error has-feedback pw2form')
					$('.pw2form').find('span').remove()
					$('.pw2form').append('<span class="glyphicon glyphicon-remove form-control-feedback"></span>')
				}
				
			}
		}	
	}
	
	var phoneChkBtn = 1;
	function chkPhone(){
		var signupphone = $('#signupphone').val();
		var editinfophone = $('#editinfophone').val();
		
		if(signupphone != ""){
			chkPhone2(signupphone)
		}else{
			chkPhone2(editinfophone)
		}
	}
	
	function chkPhone2(phone){
	
		if((event.keyCode<48)||(event.keyCode>57)){
			event.returnValue=false;
		}
		if( 9 < phone.length < 12){
			phoneChkBtn = 1;
			$('.phoneform').attr('class', 'form-group has-success has-feedback phoneform')
			$('.phoneform').find('span').remove()
			$('.phoneform').append('<span class="glyphicon glyphicon-ok form-control-feedback"></span>')
			$('.inputphone').removeAttr('onblur')
			$('.inputphone').attr('oninput', 'chkPhone()')
		}
		
		if(phone.length > 11 || phone.length < 10){
			phoneChkBtn = 0;
			$('.phoneform').attr('class', 'form-group has-error has-feedback phoneform')
			$('.phoneform').find('span').remove()
			$('.phoneform').append('<span class="glyphicon glyphicon-remove form-control-feedback"></span>')
			$('.inputphone').removeAttr('onblur')
			$('.inputphone').attr('oninput', 'chkPhone()')
		}
		
	}
	
	function checkSubmit(){
		try{
		
		if(dupIdChkBtn != 1 || dupNickChkBtn != 1){
			alert(dupIdChkBtn+":"+dupNickChkBtn+":"+pwChkBtn+":"+phoneChkBtn)
			return false;	
		}
		if(pwChkBtn != 1){
			alert(dupIdChkBtn+":"+dupNickChkBtn+":"+pwChkBtn+":"+phoneChkBtn)
			return false;
		}
		
		if(phoneChkBtn != 1){
			alert(dupIdChkBtn+":"+dupNickChkBtn+":"+pwChkBtn+":"+phoneChkBtn)
			return false;
		}
		
		alert(dupIdChkBtn+":"+dupNickChkBtn+":"+pwChkBtn+":"+phoneChkBtn)
		$('.inputid').removeAttr('disabled')
		return true;
		
		}catch(e){
			alert(e)
			return false;
		}
	}
	</script>