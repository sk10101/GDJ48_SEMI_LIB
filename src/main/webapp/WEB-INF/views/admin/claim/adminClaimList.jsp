<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지 / 건의사항</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>
<link rel="stylesheet" href="resources/css/adminClaim.css">
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
	        <h3>관리자 페이지</h3>
	        <hr style="border:1px solid #333; display: block !important; width: 140px !important; margin:10px 5px 20px 5px;"/>
	        <a href="memberList.go">회원관리</a><br/>
	        <br/>
	        <a href="bookList.go">도서관리</a><br/>
	        <br/>
	        <a class="tabSelect" href="adminClaimList">건의사항</a><br/>
	        <br/>
	        <a href="blackList.go">블랙리스트</a><br/>
	        <br/>
	        <a href="penaltyList.go">이용정지내역</a>
	    </div>
	    <div class="section">
	    	<div class="claimTable-area">
			    <table class="claim_table" id="claim_table">
			       <thead>
			            <tr>
			                <th class="col1">No</th>
			                <th class="col2">제목</th>
			                <th class="col3">작성자</th>
			                <th class="col4">처리상태</th>
			                <th class="col5">작성일</th>
			                <th class="col6">삭제</th>
			            </tr>
			       </thead>
			       <tbody id="claimList">
			       
			       </tbody>
			       </table>
			       <div class="container">
	                  <nav aria-label="Page navigation" style="text-align:center">
	                        <ul class="pagination" id="pagination"></ul>               
	                  </nav>
	               </div>
	               <div class="noticeSearchOption">
                   	   <select class="selectBtn" id="pagePerNum">
		                   <option value="5">5</option>
		                   <option value="10" selected="selected">10</option>
		                   <option value="15">15</option>
		                   <option value="20">20</option>
	                   </select>
	                   <select class="selectBtn" id="option" name="option">
	                       <option value="제목">제목</option>
	                       <option value="작성자">작성자</option>
	                       <option value="처리상태">처리상태</option>
	                   </select>
	                   <input class="noticeSearchBlock" id="word" type="search" placeholder="검색" name="word" value=""/>
	                   <input class="noticeSearchDo" id="searchBtn" type="button" onclick="searchList(currPage)" value="검색"/>
			       </div>
			</div>
		</div>
	</div>
</body>
<script>
   var msg = "${msg}"
   if (msg != "") {
      alert(msg);
   }
   
   // 관리자 임을 알 수 있는 회원등급과 현재 페이지 정보를 변수에 담는다.
	var mb_id = "${sessionScope.loginId}";
	var mb_class = "${sessionScope.mb_class}";
	var word = $('#word').val();
	var option = $('#option').val();
	var currPage = 1;
	
	listCall(currPage);
   
	// cnt 변경 (한 번에 보여줄 게시글 수 변경) 시에 초기화
	$('#pagePerNum').on('change',function(){
		console.log(currPage);
		// 페이지 당 보여줄 게시글 수 변경시에 기존 페이징 요소를 없애고 다시 만들어 준다. (다시 처음부터 그리기)
		$("#pagination").twbsPagination('destroy');
		// 검색어가 들어갔을 때와 아닐때를 구분
		if(word == null && word == ''){
			listCall(currPage);
		} else if (word != null && word != '') {
			searchList(currPage)
			console.log(word);
		}
	});
   
	// 검색 버튼 클릭했을 때 한 번 초기화
	$('#searchBtn').on('click',function(){	
		$("#pagination").twbsPagination('destroy');
		searchList(currPage);
	});
   
	
   function listCall(page) {
      
      var pagePerNum = $('#pagePerNum').val();
      console.log("param page : " + page);
      
      $.ajax({
         type:'GET',
         url:'claimList.ajax',
         data:{
            cnt : pagePerNum,
            page : page,
            mb_id : mb_id,
            mb_class : mb_class
         },
         dataType:'JSON',
         success:function(data){
            console.log(data);
            drawList(data.claimList);
            currPage = data.currPage;
            // 불러오기를 성공하면 플러그인을 이용해 페이징 처리를 한다.
            $("#pagination").twbsPagination({
               startPage: data.currPage, // 시작 페이지
               totalPages: data.pages, // 총 페이지 수(전체 게시물 수 / 한 페이지에 보여줄 게시물 수)
               visiblePages: 5, // 한 번에 보여줄 페이지 수 ( ex)[1],[2],[3],[4],[5] ...)
               onPageClick: function(e, page) {
                  console.log("클릭한 페이지 : "+page); // 사용자가 클릭한 페이지
                  console.log("입력한 검색어 : "+word);
                  currPage = page;
                  listCall(page);
               }
            });
            
         },
         error:function(e){
            console.log(e);
         }
      });
   }
   
   
   // 검색 결과 출력
   function searchList(page) {
      var pagePerNum = $('#pagePerNum').val();
      word = $('#word').val();
      option = $('#option').val();
      
      $.ajax({
         type: 'GET',
         url: 'claimList.ajax',
         data:{
            cnt : pagePerNum,
            page : page,
            word : word,
            option : option,
            mb_id : mb_id,
            mb_class : mb_class
         },
         dataType:'JSON',
         success: function(data){
            // 테이블 초기화
            $("#claimList").empty();
            drawList(data.claimList);
            currPage = 1;
            // 불러오기를 성공하면 플러그인을 이용해 페이징 처리를 한다.
            $("#pagination").twbsPagination({
               startPage: 1, // 시작 페이지
               totalPages: data.pages, // 총 페이지 수(전체 게시물 수 / 한 페이지에 보여줄 게시물 수)
               visiblePages: 5, // 한 번에 보여줄 페이지 수 ( ex)[1],[2],[3],[4],[5] ...)
               onPageClick: function(e, page) {
                  console.log(page); // 사용자가 클릭한 페이지
                  currPage = page;
                  searchList(page);
               }
            });
         },
         error:function(e){
            console.log(e);
         }
      })
   }
   
   function drawList(claimList) {
      var content = '';
      var date = new Date();
      claimList.forEach(function(item){
         //console.log(item.status);
         content += '   <tr cID="' + item.claim_id + '" cSt="' + item.status + '">';
         content += '      <td id="claimID">'+item.claim_id+'</td>';
         content += '      <td class="claimTitle"><a href="adminClaimDetail?claim_id='+item.claim_id+'">'+item.claim_title+'</a></td>';
         content += '      <td class="mbID">'+item.mb_id+'</td>';
         content += '      <td class="claimStatus">'+item.status+'</td>';
         content += '      <td>'+item.claim_date+'</td>';
         content += '      <td class="delete">';
         if(item.status=="미처리") {
            content += '         <button class="delBtn" onclick="clickEvt(this)">삭제</button>';
         }
         content += '      </td>';
         content += '   </tr>';
      });
      // 혹시 모를 상황을 대비해 깨끗하게 비워두고 쌓는다. (append 는 있는 것에 계속해서 이어 붙이는 기능이기 때문)
      $("#claimList").empty();
      $("#claimList").append(content);
   }
   // 삭제 버튼 기능구현 (동적으로 생성한 버튼은 javascript 로 구현)
   function clickEvt(btn) {
      var claim_id = $(btn).parent().parent().attr("cID");
      console.log($(btn));
         location.href='/claimDel.do?claim_id=' + claim_id;
   }
   
   /* 삭제 기능 다른 방법
   $(document).ready(function() {
      $("#claim_table").on('click', '.delBtn', function() {
         console.log($(this));
         console.log($(this).parent().parent().attr("no"));
         var claim_id = $(this).parent().parent().attr("no");
         location.href='/claimDel.do?claim_id='+claim_id;
      });
   });
   */
</script>
</html>