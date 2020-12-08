<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400&display=swap" rel="stylesheet">
<script>

//리뷰 리스트 만들기
function makeThumbnail(result){
		//$("#reviewBoard").children().remove();	
		$("#reviewBoard").html("");
		var listTag = "";
		for(var i = 0 ; i < result.length ; i++){
			
			listTag += "<div class ='boardlist'>";
			listTag += "<div class='reviewContents'>";
				
			listTag += "<div class ='left'>";
			listTag +=	"<a href='<%=request.getContextPath()%>/reviewView?noboard="+result[i].noboard+"'>";
			listTag +=	"<img src="+result[i].thumbnailImg+"/>";
			listTag +=	"</a>";
			listTag +=	"</div>";
					
			listTag +=	"<div class='right'>";
			listTag +=	"<div class= 'subtitle'>";
				
			listTag +=	"<ul>";
			listTag +=	"<li class='wordCut'>";
			listTag +=	"<a href='<%=request.getContextPath()%>/reviewView?noboard="+result[i].noboard+"'>";
			listTag +=	result[i].noboard+"&emsp;<span>"+result[i].subject+"</span>";
			listTag +=	"</a>";
			listTag +=	"<li>";
			listTag +=	"조회수 :"+result[i].hit;
			listTag +=	"</li>";
			listTag +=	"</li>";
			listTag +=	"</ul>";
			listTag +=	"</div>";
			listTag += "<br/><br/><br/>"
			listTag +=	"<ul>";
			listTag +=	"<li class='wordCut' id='reviewtext'>";
			listTag +=	"<a href='<%=request.getContextPath()%>/reviewView?noboard="+result[i].noboard+"'>";
			listTag +=	result[i].content;
			listTag +=	"</a>";
			listTag +=	"</li>";
			listTag +=	"</ul>";
							
			listTag +="<div class='writedate'>";
			listTag +="<ul>";
			listTag +="<li class='userid'>";
			listTag +="<img src='<%=request.getContextPath() %>/img/img_Review/review.png'/>";
			listTag += result[i].userid+"님의 생생한 후기";
			listTag +="</li>";
			listTag +="<li class='writedate'>"+result[i].writedate+"작성</li>"
			listTag +="</ul>";
			listTag +="</div>";
			listTag +="</div>";
					
			listTag +="</div>";
			listTag +="</div>";
		
			console.log(listTag); 
			console.log('----------------------------------');
		}
		$("#reviewBoard").html(listTag);
		console.log(listTag); 
	
}

// 페이징 리스트 만들기
function setPaging(vo){
	// 이전 페이징 삭제
	$("#paging").children().remove();
	var tag = "<ul>";
	
	if(vo.nowPage != 1){
		tag += "<li><a href='javascript:movePage("+(vo.nowPage -1)+")'> Prev </a></li>";
	}
	
	for(var i = vo.startPageNum ; i <= vo.startPageNum+vo.onePageNumCount -1 ; i++){
		if(vo.totalPage >= i){
			if(vo.nowPage == i){
				tag += "<li style='color:#00B0B0; font-weight:600;'>"+i+"</li>";
			}else{
				tag += "<li><a href='javascript:movePage("+i+")' style='color:black; font-weight:600;'>"+i+"</a></li>";
			}
		}
	}
	
	if(vo.nowPage != vo.totalPage){
		tag += "<li><a href='javascript:movePage("+(vo.nowPage +1)+")'>Next</a></li>"
	}

	tag += "</ul>";
	$("#paging").append(tag);
				
}


// 페이지 이동
function movePage(page){
	
	// 페이징 먼저 변경
	var url = "<%=request.getContextPath()%>/searchReviewPaging";
	var data = $("#searchReview").serialize();
		data += "&nowPage="+page+"&order="+$("input[name=order]:checked").val();
	
	
	$.ajax({
		type : 'POST',
		url : url,
		data : data,
		success : function(result){
			setPaging(result);
			nowPage = result.nowPage;
		},error : function(){
			console.log("페이징 오류");
		}
	});
	
	if($("#searchWordReview").val() ==""){
		url = "<%=request.getContextPath()%>/searchReviewAll";
	} else {
		url = "<%=request.getContextPath()%>/searchReviewOk";
	}
	$.ajax({
		type : 'POST',
		url : url,
		data : data,
		success : function(result){
			if( result.length <= 0 ){
				alert("검색 결과가 없습니다.");
			} else{ 
				makeThumbnail(result);
			}
		}, error : function(){
			console.log("페이지 + 검색 결과 호출 에러");
		}
	});
}

</script>
<!-- 후기보기메인 -->
<div class="container">
<div class = "mainDiv">

	<div class="reviewBody">	
		<form class = "search" id="searchReview">
			<select name="searchType" id="searchKeyword">
				<option value="1">키워드</option>
				<option value="2">글제목</option>
				<option value="3">코스이름</option>
				<option value="4">작성자</option>				
			</select>

			<input type="text" id="searchWordReview" name="searchWord"> 
			<input type="submit" class="mint_Btn" value="검 색"/>
		</form>



<!--후기 제목 -->
		<div class= "reviewtitle">
			<div class="title">후기 게시판</div><br><br>
			<div class="orderRadio">
				<input type ="radio" name="order" id="orderNobard" value="noboard" checked/><label for="orderNobard" class="subTxt">최신순</label><span id="lBar">&ensp;|&ensp;</span>
				<input type ="radio" name="order" id="orderHit" value="hit"/><label for="orderRating" class="subTxt">추천순</label>
				<input type="button" class="gray_Btn" name="reviewWriteBoard" value="글쓰기" onclick="location.href='<%=request.getContextPath()%>/reviewWriteForm'" style='float:right; margin:0 25px 10px 0;'>
			</div>
		</div><br/>
		

<!-- 후기창 게시판 -->
		<hr style='border:1.5px solid black; background-color:black'/>
		<div id="reviewBoard">
		<c:forEach var="vo" items="${list }">
				<div class ="boardlist">
					<div class="reviewContents">
					
<!-- 						후기창 왼쪽 면 -->
						<div class ="left">
							<a href="<%=request.getContextPath()%>/reviewView?noboard=${vo.noboard }">
								<img src="${vo.thumbnailImg }"/>
							</a>
						</div>
						
<!-- 						후기창 오른쪽 면 -->
						<div class="right">
						
							<div id="subtitle">
								<ul>
									<li  class="wordCut">
										<a href="<%=request.getContextPath()%>/reviewView?noboard=${vo.noboard }">
											${vo.noboard }&emsp;<span>${vo.subject }</span>
										</a>
										<li>조회수 :${vo.hit}</li>
									</li>
								</ul>
							</div>
							
								<ul>
									<li class="wordCut" id="reviewtext">
										<a href="<%=request.getContextPath()%>/reviewView?noboard=${vo.noboard }">
											${vo.content }
										</a>
									</li>
								</ul>
								
							<div class="writedate">
								<ul>
									<li class="userid">
										<img src="<%=request.getContextPath() %>/img/img_Review/review.png"/>
										${vo.userid }님의 생생한 후기
									</li>
									<li class="writedate">${vo.writedate } 작성</li>
									
								</ul>
							</div>
						</div>
						
		 			</div>
				</div>
			</c:forEach>
			</div>
			
<!-- 		=============================페이징============================= -->
				<div id="paging">
					<ul>
					<!-- 이전 페이지 -->
						<c:if test="${pagingVO.nowPage != 1 }">
							<li><a href="javascript:movePage(${pagingVO.nowPage-1 })"> Prev </a></li>
						</c:if>
						<c:forEach var="page" begin="${pagingVO.startPageNum }" end="${pagingVO.startPageNum + pagingVO.onePageNumCount -1}">
							<c:if test="${pagingVO.totalPage >= page }">
								<c:if test="${pagingVO.nowPage == page }">
									<li style='color:#00B0B0; font-weight:600;'>${page }</li>
								</c:if>
								<c:if test="${pagingVO.nowPage != page }">
									<li><a href="javascript:movePage(${page })" style='color:black; font-weight:600;'>${page }</a></li>
								</c:if>
							</c:if>
						</c:forEach>
					<!-- 다음 페이지 -->
						<c:if test="${pagingVO.nowPage != pageVO.totalPage }">
							<li><a href="javascript:movePage(${pagingVO.nowPage+1})">Next</a></li>
						</c:if>
					</ul>
				</div><br/>
		<div id= "bottom"></div>
	</div>
</div>
</div>