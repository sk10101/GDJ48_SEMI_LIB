<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>도서상세보기(관리자)</title>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resources/css/frame.css">
<link rel="stylesheet" href="resources/css/adminBook.css"/>
<link rel="icon" href="resources/img/favicon.png">
<style></style>
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
	        <a href="memberList.go">회원관리</a><br/>
	        <br/>
	        <a class="tabSelect" href="bookList.go">도서관리</a><br/>
	        <br/>
	        <a href="adminClaimList">건의사항</a><br/>
	        <br/>
	        <a href="blackList.go">블랙리스트</a><br/>
	        <br/>
	        <a href="penaltyList.go">이용정지내역</a>
	    </div>
    	<div class="section">
    		<div class="bookDetail-area">
	            <form action="bookUpdate.do" method="post" enctype="multipart/form-data">
	                <table class="book">
	                    <tr>
	                        <th>책 ID</th>
	                        <td><input type="hidden" name="b_id" value="${book.b_id}">${book.b_id}</td>
	                    </tr>
	                    <tr>
	                        <th>책 표지</th>
	                        <td><input type="file" name="b_img"/>
	                        	<c:forEach items="${list}" var="path">
									<p><img src="/image/${path.newFileName}" height="200"/>
								</c:forEach>
								<button id="b_id" value="${book.b_id}" onclick="deleteBtn(this)">삭제</button>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>책 제목</th>
	                        <td><input type="text" name="b_title" value="${book.b_title}"></td>
	                    </tr>
	                    <tr>
	                        <th>저자</th>
	                        <td><input type="text" name="writer" value="${book.writer}"></td>
	                    </tr>
	                    <tr>
	                        <th>출판사</th>
	                        <td><input type="text" name="publisher" value="${book.publisher}"></td>
	                    </tr>
	                    <tr>
	                        <th>발행년도</th>
	                        <td><input type="text" name="issue" value="${book.issue}"></td>
	                    </tr>
	                    <tr>
	                        <th>등록일자</th>
	                        <td><input type="text" name="b_date" value="${book.b_date}"></td>
	                    </tr>
	                    <tr>
	                        <th>도서예약상태</th>
	                        <td>
	                        	<c:choose>
	                        		<c:when test="${book.reserve_able eq true}"><p>예약자없음</p></c:when>
	                        		<c:otherwise><p>예약중도서</p></c:otherwise>
	                        	</c:choose>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>도서상태</th>
	                        <td class="bookStatus">
		                        <select class="bookStatusSelect" name="b_status" id="selectBox">
		                            <option value="대출가능" ${book.b_status == '대출가능' ? 'selected="selected" ' : '' } >대출가능</option>
		                            <option value="대출중" ${book.b_status == '대출중' ? 'selected="selected" ' : '' } >대출중</option>
		                            <option value="도서준비중" ${book.b_status == '도서준비중' ? 'selected="selected" ' : '' } >도서준비중</option>
		                            <option value="대출불가" ${book.b_status == '대출불가' ? 'selected="selected" ' : '' } >대출불가</option>
		                        </select>
	                        </td>
	                    </tr>
	                </table>
	                <div class="downBtn-area">
		       			<input type="submit" value="수정하기"/>
		         		<input type="button" value="리스트" onclick="location.href='bookList.go' "/>
	         		</div>
	            </form>
	    	</div>
        </div>
    </div>
</body>
<script>
var msg = "${msg}"
if (msg != "") {
	alert(msg);
}	

function deleteBtn(btn) {
	var b_id = $("#b_id").val();
	console.log(b_id);
	
	$.ajax({
		type:'get',
		url:'delPhoto.ajax',
		data: {
			b_id : b_id
		},
		dataType:'json',
		success:function(data){
			
		},
		error:function(error){
			console.log(error);
		}
	});
	
}
</script>
</html>