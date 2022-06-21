<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/5415520417.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/style.css">
<style></style>
</head>
<body>
	<a href="ki_main.go">
        <i class="fa-solid fa-angles-left back"></i>
    </a>
    <a href="ki_logout.do">
        <i class="fa-solid fa-arrow-right-from-bracket logout"></i>
    </a>
    <div class="table">
        <table>
            <thead>
                <tr>
                    <th id="chk">체크</th>
                    <th id="hiddenId">책 번호</th>
                    <th>제목</th>
                </tr>
            </thead>
            <tbody>
            	<c:forEach items="${list}" var="dto">
				<c:set var="i" value="${i+1 }"></c:set>
					<tr>
						<td><input type="checkbox" class="chkbox" id="chkbox${i }">
						<label for="chkbox${i }"></label></td>
						<td id="hiddenId">${dto.b_id}</td>
						<td id="brwList">${dto.b_title}</td>
					</tr>			
				</c:forEach>
            </tbody>
        </table>
        <button class="btn-book" onclick="borrow()">대출하기</button>
    </div>
</body>
<script>
	
	function borrow(){
		
	}
	
</script>
</html>