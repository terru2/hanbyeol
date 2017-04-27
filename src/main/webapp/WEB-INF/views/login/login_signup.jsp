<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal fade" id="login" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span>&times;</span></button>
				<h4 class="modal-title">Log In</h4>
			</div>
			<div class="modal-body">
				<form action="test2.hongik" method="GET">
					<div class="form-group">
						<label>ID</label>
						<input type="text" name="id" class="form-control" placeholder="input your ID" required>
					</div>
					<div class="form-group">
						<label>Password</label>
						<input type="password" name="pw" class="form-control" placeholder="input your PW" required>
					</div>
					<input type="submit" class="btn btn-primary" value="Log In">
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="SignUp" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span>&times;</span></button>
				<h4 class="modal-title">Sign Up</h4>
			</div>
			<form>
				<div class="modal-body">
					<div class="form-group">
						<label>ID 입력</label>
						<div class="input-group">
							<input type="text" class="form-control" placeholder="input new ID" required>
							<div class="input-group-btn">
								<button class="btn btn-default" type="submit">
									ID 중복 확인 <span class="glyphicon glyphicon-edit"></span>
								</button>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label>Password 입력</label>
						<p class="help-block">숫자, 특수문자 포함 8자 이상</p>
						<input type="password" class="form-control" placeholder="input new PW" required>
					</div>
					<div class="form-group">
						<label>Password 확인</label>
						<p class="help-block">비밀번호를 한번 더 입력해주세요.</p>
						<input type="password" class="form-control" placeholder="check new PW" required>
					</div>
					<div class="form-group">
						<label>전화번호 입력</label>
						<input type="number" class="form-control" placeholder="input PhoneNumber (- 없이 입력해 주세요)" required>
					</div>
					<div class="form-group">
						<label>Email 입력</label>
						<input type="email" class="form-control" placeholder="input Email" required>
					</div>
					<div class="form-group">
						<label>닉네임</label>
						<div class="input-group">
							<input type="text" class="form-control" placeholder="input new Nickname" required>
							<div class="input-group-btn">
								<button class="btn btn-default" type="submit">
									닉네임 중복 확인 <span class="glyphicon glyphicon-edit"></span>
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