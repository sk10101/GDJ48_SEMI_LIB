<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    .detail {
        right: 0;
    }
    table.bbs {
		width: 50%;
	}
	table, th, td {
		border: 1px solid black;
		border-collapse: collapse;
	}
	th, td {
		padding: 10px 10px;
	}
	input[type='text'] {
		width: 100%;
	}
	textarea {
		width: 100%;
		height: 150px;
		resize: none;
	}
	button {
		margin-bottom: 5px;
	}
    a:link {
        text-decoration: none;
    }
</style>
</head>
<body>
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
	                <input type="submit" value="수정"/>
	                <input type="button" value="목록보기" onclick="location.href='/memberList.do'"/>
	        </tr>
	    </table>
    </form>
</body>
<script>
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