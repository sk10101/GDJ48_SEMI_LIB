<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>북적북적 도서관</title>
<link rel="stylesheet" href="../resources/css/main.css">
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/5415520417.js" crossorigin="anonymous"></script>
<link rel="icon" href="../resources/img/favicon.png">
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
						<a class="loginTab" href="member/login">로그인</a>
					</c:when>
					<c:otherwise>
						<div class="loginTab">${sessionScope.loginId}(${sessionScope.mb_class})님, 반갑습니다.  <a class="loginTab" href="/member/logout.do">[ 로그아웃 ]</a></div>
					</c:otherwise>
                </c:choose>
                </li>
            </ul>
        </nav>
    </header>
    <!-- header end -->
    <section>
        <div class="logo" id="mainPageLogo">
            <a href="/"><img src="../resources/img/logo.png" class="logo"/><br/></a>
        </div>
        <form class="search" action="bookSearch.do" method="get">
            <div>
	            <select name="option">
	                <option value="all" selected>전체</option>
	                <option value="b_title">제목</option>
	                <option value="writer">저자</option>
	                <option value="publisher">출판사</option>
	            </select>
	            <input type="text"  class="searchBlock" name="word" placeholder="도서 검색"/>
            	<input type="submit" class="btn_search" value=""/>
            </div>
        </form>
        <div class="menuTab">
        	<table class="menuTable">
        		<tr>
        			<td>
        				<a class="links" href="/noticeList"><img src="../resources/img/notice.png"/><br/>공지사항</a>
        			</td>
        			<td>
	        			<c:choose>
		                	<c:when test="${sessionScope.loginId ne null and sessionScope.mb_class eq '관리자'}">
		                		<a class="links" href="/memberList.do"><img src="../resources/img/mypage.png"/><br/>관리자 페이지</a>
		                	</c:when>
		                	<c:otherwise>
			                    <a class="links" href="/myUpdateList"><img src="../resources/img/mypage.png"/><br/>마이 페이지</a>
		                	</c:otherwise>
	                	</c:choose>
                	</td>
                	<td>
                		<a class="links" href="/brwHistory"><img src="../resources/img/timeover.png"/><br/>도서 연장</a>
                	</td>
                	<td>
                		<c:choose>
		                	<c:when test="${sessionScope.loginId ne null and sessionScope.mb_class eq '관리자'}">
		                		<a class="links" href="/adminClaimList"><img src="../resources/img/qna.png"/><br/>건의사항</a>
		                	</c:when>
		                	<c:otherwise>
		                		<a class="links" href="/claimList"><img src="../resources/img/qna.png"/><br/>건의사항</a>
		                	</c:otherwise>
                		</c:choose>
                	</td>
                	<td>
                		<a class="links" href="/seat.go"><img src="../resources/img/seatIcon.png"/><br/>열람실</a>
                	</td>
        		</tr>
        	</table>
        </div>
    </section>
    
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