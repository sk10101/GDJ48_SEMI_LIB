<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>이용정지내역상세보기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resources/css/frame.css">
<link rel="stylesheet" href="resources/css/penaltyMember.css">
<link rel="icon" href="resources/img/favicon.png">
<style>
  
</style>
</head>
<body>
	<div id="header">
		<jsp:include page="../commons/header.jsp"/>
	</div>
	<hr style="height: 1px !important; background:#333; display: block !important; width: 100% !important; margin:0;"/>
	<div class="body">
		<div class="myPageTab" id="myPage_menu">
	        <h3>관리자 페이지</h3>
	        <hr style="height: 1px !important; background:#333; display: block !important; width: 140px !important; margin:10px 5px 20px 5px;"/>
	        <a href="memberList.go">회원관리</a><br/>
	        <br/>
	        <a href="bookList.go">도서관리</a><br/>
	        <br/>
	        <a href="adminClaimList">건의사항</a><br/>
	        <br/>
	        <a href="blackList.go">블랙리스트</a><br/>
	        <br/>
	        <a class="tabSelect" href="penaltyList.go">이용정지내역</a>
	    </div>
	    <div class="section">
	    	<div class="title-area">
	    		<h3>이용정지내역상세보기</h3>
			</div>
			<div class="info-area">
		<form action="penaltyUpdate.do" method="get">
		<input type ="hidden" id ="penalty_id" name = "penalty_id" value = "${param.penalty_id}"/>
		    <table class="bbs">
		        <tr>
		            <th class="penaltyDetailTh">회원ID</th>
		            <td>${dto.mb_id }</td>
		        </tr>
		        <tr>
		            <th>이름</th>
		            <td>${dto.name}</td>
		        </tr>
		        <tr>
		            <th>제한내역</th>
		            <c:choose>
		       			<c:when test="${dto.category_id eq '5'}">
		                     <td>대출연체</td>
		         		</c:when>
		                <c:otherwise>
		                     <td>예약만료</td>
		                </c:otherwise>
		   			</c:choose>
		        </tr>
		        <tr>
		            <th>이용정지날짜</th>
		            <td>${dto.penalty_start }</td>
		        </tr>
		        <tr>
		            <th>이용정지종료날짜</th>
		            <td>${dto.penalty_end }</td>
		        </tr>
		        <tr>
		            <th>취소한 관리자ID</th>
		            <td>${dto.admin_cancel }</td>
		        </tr>
		        <tr>
		            <th>취소</th>
		            <td> <input type="checkbox" id='cancel' name="cancel"<c:if test = "${dto.cancel}"> checked </c:if> value="true"/>
		</td> 
					
			        </tr>
			        </table>
			          <div class="penaltyDetailBtn-area">
		                <input type="button" value="돌아가기" onclick="location.href='penaltyList.go'"/>
		                <input type="submit" value="수정"/>
		     		   </div>	
	    			</form>
		      
    		</div>
    	</div>
    </div>
</body>
<script>

</script>
</html>