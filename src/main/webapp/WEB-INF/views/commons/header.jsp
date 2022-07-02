<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="resources/css/header.css">
<div class="headerContainer">
		<div class="headerLogo-area">
		<a href="/"><img id="headerLogo" src="resources/img/logo.png" alt=""></a>
		</div>
		<div class="headerMyInfo">
			<c:choose>
				<c:when test="${sessionScope.loginId eq null}">
					<a class="headerLoginTab" href="login.go">로그인</a>
				</c:when>
				<c:otherwise>
					<div>${sessionScope.loginId}(${sessionScope.mb_class})님, 반갑습니다.&nbsp;&nbsp;<a class="headerLoginTab" href="logout.do">[ 로그아웃 ]</a></div>
				</c:otherwise>
	        </c:choose>
        </div>
		<nav>
			<%-- <ul>
				<li style="margin-left:150px">${sessionScope.loginId}(${sessionScope.mb_class}) 님 안녕하세요</li>
				<li><a href="member/logout.do">[로그아웃]</a></li>
				<li><a href="mypage.go">[마이페이지]</a></li>
			</ul> --%>
		</nav>
</div>