<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/main.css">
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style></style>
</head>
<body>
	<!-- header start -->
    <header id="main_header">
        <nav>
            <ul class="login_menu">
                <li>
                <c:choose>
					<c:when test="${sessionScope.loginId eq null}">
						<a href="member/login">로그인</a>
					</c:when>
					<c:otherwise>
						<div>${sessionScope.loginId}(${sessionScope.mb_class}) 님, 반갑습니다. <a href="member/logout.do">로그아웃</a></div>
					</c:otherwise>
                </c:choose>
                </li>
            </ul>
        </nav>
    </header>
    <!-- header end -->
    <section>
        <div class="logo">
            <a href="#"><img src="../resources/img/logo.png" class="logo"/><br/></a>
        </div>
        <form class="search" action="bookSearch.do" method="get">
            <select name="option">
                <option value="all" selected>전체</option>
                <option value="b_title">제목</option>
                <option value="writer">저자</option>
                <option value="publisher">출판사</option>
            </select>
            <input type="text" name="word" placeholder="도서 검색"/>
            <input type="submit" class="btn_search"/>
        </form>
        <div class="menu">
            <ul class="icons">
                <li>
                    <a href="/noticeList"><img src="../resources/img/mypage.png"/><br/>공지사항</a>
                </li>
                <li><!-- href 나중에 변경해야함 (임시.)-->
                    <a href="#"><img src="../resources/img/mypage.png"/><br/>마이페이지</a>
                </li>
                <li>
                    <a href="#"><img src="../resources/img/mypage.png"/><br/>도서반납연기</a>
                </li>
                <li>
                    <a href="/claimList"><img src="../resources/img/mypage.png"/><br/>건의사항</a>
                </li>
                <li>
                    <a href="seat.go"><img src="../resources/img/mypage.png"/><br/>열람실</a>
                </li>
            </ul>
        </div>
    </section>
    
    <table>
    <tr>
    	<td>ID</td>
    </tr>
    	<tr>
    	<td><a href="/myUpdateList">회원정보 수정 가기</a></td>
    	</tr>
    </table>
    
</body>
<script>
/*
function bookSearch() {
	var option=$('#bookSearchOption').val();
	var word=$('#bookSearchWord').val();
	console.log(option, word);
	
	$.ajax({
		type:'post',
		url:'bookSearch.ajax',
		data:{
			option : option,
			word : word
		},
		dataType:'json',
		success:function(data){
			console.log(data);
		},
		error:function(e){
			console.log(e);
		}
	});
	
}
*/
</script>
</html>