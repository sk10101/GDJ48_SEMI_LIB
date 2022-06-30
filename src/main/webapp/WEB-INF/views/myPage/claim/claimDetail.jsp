<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지 / 건의사항 / 상세보기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resources/css/claim.css">
<link rel="icon" href="resources/img/favicon.png">
<style>
</style>
</head>
<body>
    <div id="header">
		<jsp:include page="../../commons/header.jsp"/>
	</div>
	<hr style="height: 1px !important; background:#333; display: block !important; width: 100% !important; margin:0;"/>
	<div class="body">
	    <div class="myPageTab" id="myPage_menu">
	        <h3>마이페이지</h3>
	        <hr/>
	        <a href="/brwHistory">도서내역</a><br/>
	        <br/>
	        <a class="tabSelect" href="claimList">건의사항</a><br/>
	        <br/>
	        <a href="myUpdateDetail.go">회원정보</a>
	    </div>
	    <div class="section" id="main_content">
		    <div class="claimTable-area">
		        <table class="claim_table" id="claim_detail">
		            <tr>
		                <th class="claimTableTh">제목</th>
		                <td>${claim.claim_title}</td>
		            </tr>
		            <tr>
		                <th>작성일</th>
		                <td>${claim.claim_date}</td>
		            </tr>
		            <tr>
		                <th>처리상태</th>
		                <td>${claim.status}</td>
		            </tr>
		            <tr>
		                <th>내용</th>
		                <td class="tableTextLeft">${claim.claim_content}</td>
		            </tr>
		            <c:if test="${claimList.size()>0}">
		            <tr>
		                <th>이미지</th>
		                <td>
			                <c:forEach items="${claimList}" var="path">
									<img src="/image/${path.newFileName}" width="90%"/>
							</c:forEach>
						</td>
		            </tr>
	            	</c:if>
		        </table>
		        <br/>
		        <hr style="height: 1px !important; background:#333; width: 90% !important; margin:0 5% 0 5%;"/>
		        <br/>
				<table class="claim_table" id="claim_reply">
				    <tr>
				        <th class="claimTableTh">관리자</th>
				        <td class="tableTextLeft">
				        	<input type="hidden" name="claim_id" value="${claim.claim_id}"/>
				        	<input type="hidden" name="reply_id" value="${reply.reply_id}"/>
				        	${reply.mb_id}
				        </td>
				    </tr>
				    <tr>
				        <th>작성일</th>
				        <td>${reply.reply_date}</td>
				    </tr>
				    <tr>
				        <th>답변 내용</th>
				        <td class="tableTextLeft">${reply.reply_content}</td>
				    </tr>
				    <c:if test="${replyList.size()>0}">
				     <tr>
				         <th>이미지</th>
				         <td>
				          	<c:forEach items="${replyList}" var="pathR">
								<img src="/image/${pathR.newFileName}" width="640"/>
							</c:forEach>
						</td>
			        </tr>
			       </c:if>
				</table>
				<div class="claimBtnSection">
					<c:choose>
						<c:when test="${claim.status eq '미처리'}">
							<input class="claimBtn" type="button" value="수정" onclick="location.href='claimUpdate.go?claim_id=${claim.claim_id}'"/>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
					<input class="claimBtn" type="button" value="목록" onclick="location.href='/claimList'"/>
				</div>
		    </div>
	    </div>
    </div>
</body>
<script></script>
</html>