<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal fade" id="shareinfo" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span><b data-toggle="tooltip" title="창을 닫으시겠습니까?">&times;</b></span></button>					
				<h4 class="modal-title">상세 정보</h4>							
			</div>
			<div class="modal-body">
				<div class="container-fluid">
            		<div class="row">
            			<div class="col-sm-4">
							<img class="img-rounded" src="resources/images/Loading.gif" width="100%" height="100%">							
            			</div>
            			<div class="col-sm-8">
							<dl>
								<dt>등록자</dt>
								<dd class="text-right infoid"></dd>
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
							<h2 id="infoname" class="infoname"></h2> 
						</div>
            		</div>
				</div>
			</div>
			<div class="modal-footer infobtn">										
			</div>
		</div>
	</div>
</div>