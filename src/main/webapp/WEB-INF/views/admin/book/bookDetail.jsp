<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/css/admin.css">
<style></style>
</head>
<body>
    <header>
        <div class="header-wrap">
            <div class="logo">
                <a href="/"><img src="../resources/img/logo.png" class="logo"></a>
            </div>
            <nav>
                <ul class="navi">
                    <li>***님 환영합니다.</li>
                    <li><a href="#">로그아웃</a></li>
                    <li><a href="#">관리자페이지</a></li>
                </ul>
            </nav>
        </div>
    </header>
    <aside id="menu">
        <h1>관리자페이지</h1>
        <hr/>
        <ul class="admin_menu">
            <li><a href="#">회원관리</a></li>
            <li><a href="#">도서관리</a></li>
            <li><a href="#">건의사항</a></li>
            <li><a href="#">블랙리스트</a></li>
            <li><a href="#">이용정지내역</a></li>
        </ul>
    </aside>
    <section>
        <div class="content">
            <form action="bookUpdate.do" method="post" enctype="multipart/form-data">
                <table class="book">
                    <tr>
                        <th>책ID</th>
                        <td><input type="hidden" name="b_id" value="${book.b_id}">${book.b_id}</td>
                    </tr>
                    <tr>
                        <th>책 표지</th>
                        <td><input type="file" name="b_img"/>
                        	<c:forEach items="${list}" var="path">
								<p><img src="/image/${path.newFileName}" height="200"/>
							</c:forEach>
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
                        <th>도서상태</th>
                        <td><select name="b_status" id="selectBox">
                            <option value="대출가능" ${book.b_status == '대출가능' ? 'selected="selected" ' : '' } >대출가능</option>
                            <option value="대출중" ${book.b_status == '대출중' ? 'selected="selected" ' : '' } >대출중</option>
                            <option value="도서준비중" ${book.b_status == '도서준비중' ? 'selected="selected" ' : '' } >도서준비중</option>
                            <option value="대출불가" ${book.b_status == '대출불가' ? 'selected="selected" ' : '' } >대출불가</option>
                        </select></td>
                    </tr>
                    <tr>
                    	<td>
                  			<input type="submit" value="수정하기"/>
                    		<input type="button" value="리스트" onclick="location.href='bookList.go' "/>
                    	</td>
                    </tr>
                </table>
            </form>
            <button onclick="location.href='bookList.go' ">목록보기</button>
        </div>
    </section>
</body>
<script>
var msg = "${msg}"
if (msg != "") {
	alert(msg);
}	
</script>
</html>