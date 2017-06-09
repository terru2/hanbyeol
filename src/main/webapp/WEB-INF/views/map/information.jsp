<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
								<dd class="text-right infoaddress" id="address"></dd>
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
							<h2 class="infoname">시설 이름이 길다면 어떻게 되나 <span class="label label-warning">9.8</span> <small class="infocategory2"></small></h2>
							<h4>시설 평가 </h4>
							<table class="table table-bordered">
								<thead>
									<tr>
										<th>Nickname</th>
										<th>평가</th>
										<th>평점</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>John</td>
										<td>ㄴㅇㅁㅇㄴㅇㄴㅁㅇㄴㅇㄴㅁㅇㄴㅁㅇㄴㅁㄴㅇㄴㅇㄴㅁㅇㄴ</td>
										<td>***</td>
									</tr>
									<tr>
										<td>John</td>
										<td>ㄴㅇㅁㅇㄴㅇㄴㅁㅇㄴㅇㄴㅁㅇㄴㅁㅇㄴㅁㄴㅇㄴㅇㄴㅁㅇㄴ</td>
										<td>***</td>
									</tr>
									<tr>
										<td>John</td>
										<td>ㄴㅇㅁㅇㄴㅇㄴㅁㅇㄴㅇㄴㅁㅇㄴㅁㅇㄴㅁㄴㅇㄴㅇㄴㅁㅇㄴ</td>
										<td>***</td>
									</tr>
									<tr>
										<td>John</td>
										<td>ㄴㅇㅁㅇㄴㅇㄴㅁㅇㄴㅇㄴㅁㅇㄴㅁㅇㄴㅁㄴㅇㄴㅇㄴㅁㅇㄴ</td>
										<td>***</td>
									</tr>
								</tbody>
							</table>
							<ul class="pager">
								<li class="prevhtmlhtmlious"><a href="#">&larr;	이전</a></li>
								<li class="lasthtmlhtmlhtml"><a href="#">다음 &rarr;</a></li>
							</ul>
						</div>
            		</div>
					
				</div>
			</div>
			<div class="modal-footer">
			<c:if test="${sessionScope.log.id  eq 'admin'}">
				<button type="button" class="btn btn-primary" id="update">수정</button>
			</c:if>
				<button type="button" class="btn btn-primary">평가</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
