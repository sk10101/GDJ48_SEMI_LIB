<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지 / 건의사항 / 상세보기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="icon" href="resources/img/favicon.png">
<style>
   
</style>
</head>
<body>
	<div id="header">
		<jsp:include page="../../commons/header.jsp"/>
	</div>
	<hr style="height: 1px !important; background:#333; display: block !important; width: 100% !important; margin:0;"/>
    <div id="myPage_menu">
        <h3>관리자 페이지</h3>
        <hr/>
        <a href="memberList.go">회원관리</a><br/>
        <br/>
        <a href="bookList.go">도서관리</a><br/>
        <br/>
        <a href="adminClaimList">건의사항</a><br/>
        <br/>
        <a href="blackList.go">블랙리스트</a><br/>
        <br/>
        <a href="penaltyList.go">이용정지내역</a>
    </div>
    <div id="main_content">
    	<form action="adminClaimUpdate.do" method="post" enctype="multipart/form-data">
        <table id="claim_detail">
            <tr>
                <th>제목</th>
                <td>
                	<input type="hidden" name="claim_id" value="${claim.claim_id}"/>
                	${claim.claim_title}
                </td>
            </tr>
            <tr>
                <th>작성일</th>
                <td>${claim.claim_date}</td>
            </tr>
            <tr>
                <th>처리상태</th>
                <td>
                	<select id="status" status="${claim.status}" name="status">
                		<option class="status" value="미처리">미처리</option>
			       		<option class="status" value="처리중">처리중</option>
			       		<option class="status" value="처리완료">처리완료</option>
                	</select>
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td>${claim.claim_content}</td>
            </tr>
            <c:if test="${claimList.size()>0}">
	            <tr>
	                <th>이미지</th>
	                <td>
		                <c:forEach items="${claimList}" var="path">
								<img src="/image/${path.newFileName}" width="640"/>
						</c:forEach>
					</td>
	            </tr>
            </c:if>
            <tr>
				<th colspan="2">
					<!-- onclick="location.href='adminClaimUpdate.do?claim_id=${claim.claim_id}'" -->
					<input type="submit" value="처리상태 수정"/>
					<input type="button" value="목록" onclick="location.href='/adminClaimList'"/>
				</th>
			</tr>
        </table>
        </form>
        <br/>
        <hr/>
        <br/>
		<form action="replyWrite.go" method="post" enctype="multipart/form-data">
	        <table id="claim_reply">
	            <tr>
	                <th>관리자</th>
	                <td>
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
	                <td>${reply.reply_content}</td>
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
	            <tr>
					<th colspan="2">
						<!-- onclick="location.href='adminClaimUpdate.do?claim_id=${claim.claim_id}'" -->
						<c:choose>
							<c:when test="${reply.reply_id eq null}">
								<input type="submit" value="답변하기"/>
							</c:when>
							<c:otherwise>
								<input type="button" value="수정" onclick="location.href='replyUpdate.go?reply_id=${reply.reply_id}&claim_id=${claim.claim_id}'"/>
							</c:otherwise>
						</c:choose>
					</th>
				</tr>
	        </table>
		</form>
    </div>
</body>
<script>
	var msg = "${msg}"
	if (msg != "") {
		alert(msg);
	}


	// 현재 건의사항 작성글의 처리상태를 옵션 목록에서 바로 보여주기
	$(document).ready(function(){
		var status = $("select").attr("status");
		console.log(status);
		$("option[value='"+status+"']").prop("selected",true);
	});
	
</script>
</html>