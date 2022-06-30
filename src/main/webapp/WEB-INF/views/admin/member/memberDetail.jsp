<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>회원상세보기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resources/css/frame.css">
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
	        <h3>관리자 페이지</h3>
	        <hr style="height: 1px !important; background:#333; display: block !important; width: 140px !important; margin:10px 5px 20px 5px;"/>
	        <a class="tabSelect" href="memberList.go">회원관리</a><br/>
	        <br/>
	        <a href="bookList.go">도서관리</a><br/>
	        <br/>
	        <a href="adminClaimList">건의사항</a><br/>
	        <br/>
	        <a href="blackList.go">블랙리스트</a><br/>
	        <br/>
	        <a href="penaltyList.go">이용정지내역</a>
	    </div>
		<h3>회원상세보기</h3>
		<form action="update.do" method="post">
		    <table class="bbs">
		        <tr>
		            <th>회원ID</th><!-- hidden으로 해결,, 올바른 방법인지는 모르겠음 ㅎㅎ -->
		            <td><input type="hidden" name="mb_id"  id="mb_id" value="${dto.mb_id}">${dto.mb_id}</td>
		        </tr>
		        <tr>
		            <th>회원등급</th>
		            <td>
		                <select name="mb_class">
		                    <option value="일반회원" ${dto.mb_class == '일반회원' ? 'selected="selected" ' : '' }>일반회원</option>
		                    <option value="관리자" ${dto.mb_class == '관리자' ? 'selected="selected" ' : '' } >관리자</option>
		                </select>
		            </td>
		        </tr>
		        <tr>
		            <th>이름</th>
		            <td>${dto.name }</td>
		        </tr>
		        <tr>
		            <th>이메일</th>
		            <td>${dto.email }</td>
		        </tr>
		        <tr>
		            <th>전화번호</th>
		            <td>${dto.phone }</td>
		        </tr>
		        <tr>
		            <th>가입일</th>
		            <td>${dto.reg_date }</td>
		        </tr>
		        <tr>
		            <th>회원상태</th>
		            <td>${dto.mb_status }</td>
		        </tr>
		        <tr>
		            <th>탈퇴신청일</th>
		            <td>${dto.leave_date }</td>
		        </tr>
		        <tr>
		            <th colspan="2">
		                <input type="button" value="대출내역" onclick="brwList()"/>
		                <input type="button" value="예약내역" onclick="reserveList()"/>
		                <input type="submit" value="수정" onclick="update()"/>
		                <input type="button" value="목록보기" onclick="location.href='/memberList.go'"/>
		        </tr>
		    </table>
	    </form>
	</div>
</body>
<script>


	var msg = "${msg}";
	if(msg != ""){
	   alert(msg);
	}

	function update(){
		alert("수정되었습니다.");
	}

	function brwList() {
		var mb_id = $('#mb_id').val();
		console.log(mb_id);
		location.href = 'memberBrw.go?mb_id='+mb_id;
	}
	
	function reserveList() {
		var mb_id = $('#mb_id').val();
		console.log(mb_id);
		location.href = 'memberReserve.go?mb_id='+mb_id;
	}


</script>
</html>