<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>회원리스트(회원)</title>
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
	        <h3>마이페이지</h3>
	        <hr style="border:1px solid #333; display: block !important; width: 140px !important; margin:10px 5px 20px 5px;"/>
	        <a href="/brwHistory">도서내역</a><br/>
	        <br/>
	        <a href="claimList">건의사항</a><br/>
	        <br/>
	        <a class="tabSelect" href="myUpdateDetail.go">회원정보</a>
	    </div>
	  <h3>${sessionScope.loginId }님의 상세 정보</h3>
	  <h3>리스트 보기</h3>
	 <table>
	 		<c:forEach items="${myUpdateList}" var="myUpdateDetail">
            <tr>
                <th>ID</th>
                <td><a href="myUpdateDetail?mb_id=${myUpdateDetail.mb_id}">${myUpdateDetail.mb_id}</a></td>
            </tr>
            <tr>
                <th>PW</th>
                <td>
                    <textarea name="">${myUpdateDetail.mb_pw}</textarea>
                      ※ 4자리 이상,비밀번호 수정시에만 작성
                </td>
            </tr>
            <tr>
                <th>이름</th>
                <td><textarea name="">${myUpdateDetail.name}</textarea></td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td>
                    <textarea name="">${myUpdateDetail.phone}</textarea>
                    ※ ‘-’ 를 제외하고 입력
                </td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>${myUpdateDetail.email }</td>
            </tr>
            <tr>
                <th>회원탈퇴신청</th>
                <td><input type="checkbox" name="chk"  onclick="" />
                    ※ 체크하신 후 수정버튼을 누르시면 탈퇴신청이 접수됩니다.<br/>
                    (신청일 포함 7일 동안 체크해제를 하지 않으셨다면 탈퇴처리가 완료됩니다.)                    
                </td>
            </tr>
            </c:forEach>
        </table>

        <br/>

        <table>
            <tr>
                <th>PW 확인</th>
                <td><textarea name="notice_content"></textarea></td>
            </tr>
        </table>

        <br/>
        <input type="button" value="수정" onclick="location.href='memberDetailUpdate.do'">
        </div>
</body>
<script></script>
</html>