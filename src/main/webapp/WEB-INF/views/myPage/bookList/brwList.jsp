<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="layout.css">
<style>
	table {
		width: 100%;
	}
	table,th,td {
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px;	
		}
</style>
</head>
<body>

	<div class="container">
            <!-- TOP -->
            <div class="top">
                <span>
                    <nav>
                        <ul>
                            <li>
                                000 님 반갑습니다.
                            </li>
                            <li>
                                로그아웃
                            </li>
                            <li>
                                마이페이지
                            </li>
                        </ul>
                    </nav>
                </span>
            </div>
            <!--MIDDLE-->
            <div class="middle">
                
                <div class="middle-left">
                    <span>
                        <table>
                            <thead>
                                <tr>
                                    <th>마이페이지</th>
                                </tr>
                                <tr>
                                    <th>도서내역</th>
                                </tr>
                                <tr>
                                    <th>건의사항</th>
                                </tr>
                                <tr>
                                    <th>회원정보</th>
                                </tr>
                            </thead>
                        </table>
                    </span>
                </div>
                <div class="middle-right">
                    <div class="middle-right-1">
                        <span>
                            <table>
                                <thead>
                                    <tr>
                                        <th><a href="borrowList">대출내역</a></th>
                                        <th><a href="beforeReservationLsit">이전대출내역</a></th>
                                        <th><a href="reservationLsit">예약내역</a></th>
                                    </tr>
                                </thead>
                            </table>
                        </span>
                    </div>
                    <div class="middle-right-2">
                        <span>
                            <table>
                                <thead id="head">
                                    <tr>
                                        <th>대출번호</th>
                                        <th>도서제목</th>
                                        <th>신청기간</th>
                                        <th>예약종류 사유</th>
                                        <th>대출신청</th>
                                        <th>취소</th>
                                    </tr>
                                </thead>
                            </table>
                        </span>
                    </div>    
            </div>
        </div>
        
</body>
<script></script>
</html>