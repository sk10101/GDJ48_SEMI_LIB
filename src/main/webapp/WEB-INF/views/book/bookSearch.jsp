<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/css/book.css">

<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 

<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>
<style></style>
</head>
<body>
	<!-- header start -->
    <header>
        <div class="header-wrap">
            <div class="logo">
                <a href="/"><img src="../resources/img/logo.png" class="logo"></a>
            </div>
            <nav>
                <ul class="navi">
                    <li>***님 환영합니다.</li>
                    <li><a href="#">로그아웃</a></li>
                    <li><a href="#">마이페이지</a></li>
                </ul>
            </nav>
        </div>
    </header>
    <!-- header end -->
	
	<section>
        <form class="search" action="bookSearch.go" method="get">
            <select name="option">
                <option value="제목">제목</option>
                <option value="저자">저자</option>
                <option value="출판사">출판사</option>
            </select>
            <input type="text" name="word" placeholder="도서 검색"/>
            <input type="submit" class="btn_search" onclick=""/>
        </form>
        
        <div class="content"> 
           <div class="content-pagination">
             <select id="pagePerNum"> <!-- pagePerNum 을 ajax로 controller로 보내서 이에 따라 게시물 수 바꿔줄 것임 -->
                <option value="5">5</option>
                <option value="10" selected="selected">10</option>
                <option value="15">15</option>
                <option value="20">20</option>
             </select>
         </div>
         <!-- <p>"${param.option }"에서 "${param.word }"로 검색한 결과입니다.</p>  -->
       </div>       
           <table border="1">
               <thead>
                  <tr>
                      <th>책표지</th>
                      <th>제목</th>
                      <th>저자</th>
                      <th>출판사</th>
                      <th>도서상태</th>
                      <th>예약가능여부</th>                 
                  </tr>
               </thead>
               <tbody id="searchList">
               		
               </tbody>
               		<tr>
				<td colspan="6" id="paging">
					<div class="container">
						<nav aria-label="Page navigation" style="text-align:center">
								<ul class="pagination" id="pagination" >
								</ul>					
						</nav>
					</div>
				</td>
			</tr>
           </table>
   </section>	
</body>
<script>
//URL 에서 파라미터 가져오기
//let url = document.location.href; // url 가져오기
let query = window.location.search; //url query 부분 가져오기 ?option=writer
var param = new URLSearchParams(query); // url query의 파라미터 부분 가져오
var option = param.get("option");
var word = param.get("word");

console.log(option, word);
var currPage = 1;
listCall(currPage);

$('#pagePerNum').on('change',function(){ // pagePerNum 에 change가 일어나게 되면
   var word = $('#wordResult').html();
	console.log("currPage : " +currPage);
	console.log("word : "+word);
   
   // 페이지당 보여줄 수 변경 시 계산된 페이지 적용이 안된다. (플러그인의 문제)
   // 페이지당 보여줄 수 변경 시 기존 페이징 요소를 없애고 다시 만들어 준다.
   $("#pagination").twbsPagination('destroy');
   listCall(currPage); // listCall 함수 호출
   /*
   if(word==null || word==""){
		listCall(currPage);
	} else {
		searchList(currPage)
	}
   */
   
})

function listCall(page) {
	
	var pagePerNum = $('#pagePerNum').val();
	
   $.ajax({
      type:'get',
      url:'searchList.ajax',
      data:{
         cnt : pagePerNum,
         page : page,
         word : word,
         option:option
      },
      dataType:'json',
      success:function(data){
         console.log('테이블 그리기');
         console.log("data:"+data);
         drawList(data.searchList);
         currPage = data.currPage;
         
      	// 불러오기를 성공하면 플러그인을 이용해 페이징 처리를 한다.
         $("#pagination").twbsPagination({
            startPage:data.currPage, //시작페이지
            totalPages:data.pages,		//총 페이지 수 
            visiblePages: 5,	// 한 번에 보여줄 페이지 수
            onPageClick:function(e,page){
               console.log("클릭한 페이지 : " +page);
               console.log("입력한 검색어 : " +word);
               currPage = page;
               listCall(page);
               /*
               if(word==null){
					listCall(page);
				} else {
					searchList(page);
				}*/
            }
         });
      },
      error:function(e){
         console.log(e);
      }
   });
}

function drawList(searchList){
   var content = '';
   searchList.forEach(function(item) {
      console.log(item.reserve_able);
      content += '<tr>';
      content += ' <td><img src="/image/'+item.newFileName+' " height="200"/></td>';
      content += '<td><a href="bookDetail.do?b_id='+item.b_id +' ">'+item.b_title+'</a></td>';
      content += '<td>'+item.writer+'</td>';
      content += '<td>'+item.publisher+'</td>';
      content += '<td>'+item.b_status+'</td>';
      content += '<td>';
      	if(item.reserve_able == true) {
      		content += 'Y';
      	} else {
      		content += 'N';
      	}
      content += '</td>';
      content += '</tr>';
   });
   $('#searchList').empty();
   $('#searchList').append(content);
}
/*

/*
Array.from(parent.children).forEach(child => {
    console.log(child)
});
Array.from(selected_rows).forEach(item => console.log(item));
*/

</script>
</html>