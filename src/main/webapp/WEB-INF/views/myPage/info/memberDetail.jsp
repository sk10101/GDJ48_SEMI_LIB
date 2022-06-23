<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	  		h3 {text-align: left; font-weight: bold; font-size: 40px;}
            table {width: 40%}
            table, th, td {border: 1px solid black; border-collapse: collapse;}
            th, td{padding: 5px 10px; text-align: center;}
            textarea {width: 50%; height : 30px; resize: none; float:left;}
</style>
</head>
<body>
	  <h3>${sessionScope.mb_id }님의 상세 정보</h3>
	  <from action="memberUpdateDetail.do" method="post">
	 <table>
	 		<c:forEach items="${memberUpdateList}" var="memberUpdateDetail">
            <tr>
                <th>ID</th>
                <td>${memberUpdateDetail.mb_id}</td>
            </tr>
            <tr>
                <th>PW</th>
                <td>
                    <textarea name="">${memberUpdateDetail.mb_pw}</textarea>
                      ※ 4자리 이상,비밀번호 수정시에만 작성
                </td>
            </tr>
            <tr>
                <th>이름</th>
                <td><textarea name="">${memberUpdateDetail.name}</textarea></td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td>
                    <textarea name="">${memberUpdateDetail.phone}</textarea>
                    ※ ‘-’ 를 제외하고 입력
                </td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>${memberUpdateDetail.email }</td>
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
         </from>
            <tr>
                <th>PW 확인</th>
                <td><textarea name="notice_content"></textarea></td>
            </tr>
        </table>

        <br/>
        <input type="button" value="수정" onclick="location.href='memberDetailUpdate.do'">
</body>
<script></script>
</html>