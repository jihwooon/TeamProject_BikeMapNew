<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device, initial-scale=1"/>
<link rel="stylesheet" href="/home/css/admin.css" type="text/css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.0/jquery-ui.js"></script> 



<title>Bike Map</title>
<script>
	
	
	
	/* $(function(){  //페이지 보여주기 방식 변경
		
		//회원관리게시판, 처음 관리자화면 초기페이지
		$("#userAdmin").click(function(){
			var url = "/admin/ajaxObject";
			$.ajax({
				url:url,
				success:function(result){
					var tag ="<ul>";
					tag += "<li>번호 = "+result.no+"</li>";
					tag += "<li>이름 = "+result.username+"</li>";
					tag += "<li>주소 = "+result.addr+"</li>";
					tag += "</ul>";
					
					$("#tableDiv").append(tag);
				},error:function(){
					console.log("객체받기에러");
				}
			});
		});
		
		//동행모집게시판 클릭
		$("#partnerfreeboardAdmin").click(function(){
			$(this).css('color','red');
			$("#tableDiv").load('/WEB-INF/views/admin/partnerfreeboardTable.html');
		});
		//후기게시판 클릭
		$("#reviewfreeboardAdmin").click(function(){
			$(this).css('color','red');
			$("#tableDiv").append('/reviewFreeboardTable.html');
		});
		//1:1 문의 게시판 클릭
		$("#inqAdmin").click(function(){
			$("#tableDiv").append('/inqTable.html');
		});	
	});*/
    function wrapWindowByMask() {
        //화면의 높이와 너비를 구한다.
        var maskHeight = $(document).height(); 
        var maskWidth = $(window).width();

        //문서영역의 크기 
        console.log( "document 사이즈:"+ $(document).width() + "*" + $(document).height()); 
        //브라우저에서 문서가 보여지는 영역의 크기
        console.log( "window 사이즈:"+ $(window).width() + "*" + $(window).height());        

        //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
        $('#mask').css({
            'width' : maskWidth,
            'height' : maskHeight
        });

        //애니메이션 효과
        //$('#mask').fadeIn(1000);      
        $('#mask').fadeTo("slow", 0.5);
    }

    function popupOpen() {
        $('.layerpop').css("position", "absolute");
        //영역 가운에데 레이어를 뛰우기 위해 위치 계산 
        $('.layerpop').css("top",(($(window).height() - $('.layerpop').outerHeight()) / 2) + $(window).scrollTop());
        $('.layerpop').css("left",(($(window).width() - $('.layerpop').outerWidth()) / 2) + $(window).scrollLeft());
        $('.layerpop').draggable();
        $('#layerbox').show();
    }

    function popupClose() {
        $('#layerbox').hide();
        $('#mask').hide();
    }

    function goDetail() {

        /*팝업 오픈전 별도의 작업이 있을경우 구현*/ 

        popupOpen(); //레이어 팝업창 오픈 
        wrapWindowByMask(); //화면 마스크 효과 
    }


	
</script>
</head>
<body>
<%
	String pagefile = request.getParameter("page");
	
	if(pagefile == null){//처음보여주는 페이지는 회원관리 페이지
		pagefile="userTable";
	}
	
	
	//dao 선언
	//총레코드수
	int totalRecord = 30;//총레코드수
	int onePageRecord = 5;//한페이지당 출력할 레코드 수
	int nowPage = 1;//현재페이지 번호 
	int totalPage = 0;//총페이지 수
	int onePageNum = 5;//한번에 표시할 페이지 수
	int startPage = 1; //페이지 번호의 시작번호
	//
	//-----------------------------------------------
	//현재페이지 정보 구하기
	String nowPageStr = request.getParameter("nowPage");
	if(nowPageStr != null){
		nowPage = Integer.parseInt(nowPageStr);
	}
	//총페이지 수 계산하기 
	totalPage = (int)Math.ceil(totalRecord/(double)onePageRecord);
	//페이지 번호의 시작번호 구하기
	startPage = ((nowPage-1)/onePageNum*onePageNum)+1;
	
	//전체레코드 구하기 페이지별 변경
	//List<FreeboardVO> list = dao.getAllRecord(nowPage, onePageRecord, totalPage, totalRecord);
	

%>
<div id="adminTop">
	<img src="<%=request.getContextPath()%>/img/img_logo/logo_footer.png">
</div>
<div id="adminHome">
	<!-- Page Container -->
	
	<!-- Side Bar -->
	<div class="navigation">
	
		<ul id="sidebar">
			<li>
				<span class ="icon">회원 관리</span>
				<a href="/home/adminHome?page=userTable">회원목록/검색</a>
			</li>
			
			<li>
				<span class ="icon">게시판 관리</span>
				<a href="/home/adminHome?page=partnerTable">
					<span class="title">동행모집 게시판</span>
				</a>
				<a href="/home/adminHome?page=reviewTable">
					<span class="title">후기 게시판</span>
				</a>
			</li>
			<li>
				<a href="/home/adminHome?page=questionTable">
					<span class ="icon">1:1 문의사항</span>
				</a>
			</li>
			
		</ul>
		
		
		
	</div>
	<!-- /Page Sidebar -->
	
	<!-- Page Content -->
	<div class="adminContent">
		<select name="choice">
			<%
				if(pagefile.equalsIgnoreCase("userTable")){
			%>
			  <option value="username">회원 이름</option>
			<%
				}else if(pagefile.equalsIgnoreCase("partnerTable")||pagefile.equalsIgnoreCase("reviewTable")){
			%>  
				<option value="subject" selected>제목</option>
			<%
				}else if(pagefile.equalsIgnoreCase("questionTable")){			 
			%>
			 	<option value="subject" selected>제목</option>
			 	<option value="IsReply">답변여부</option>
			<% 
				}else{
					System.out.println(pagefile);
				}
			 %>
			 <option value="userid" selected>회원 아이디</option>
		</select>
	
				<input type="text" name="searchWord" id="searchWord" maxlength="20" placeholder="검색어 입력"/>
				<input type="button" name="search" id="searchBtn" value="검색" style="background-color: rgb(0,176,176)"/>
		
		
			<jsp:include page ='<%=pagefile+".jsp"%>'/>
		
	
	
		<div id="paging">
			<ul>
				<!-- 이전페이지 -->
				<li>
					<%if(nowPage==1){ %>
					◀
					<%}else{ %>
						<a href="/home/adminHome?page=<%=pagefile %>&nowPage=<%=nowPage-1 %>">◀</a>
					<%} %>
				</li>
				<% for(int p=startPage; p<startPage+onePageNum; p++){ 
					if(p<=totalPage){
						if(p==nowPage){
				 %>
					<li>
						<a href="/home/adminHome?page=<%=pagefile %>&nowPage=<%=p %>"style="color:rgb(0,176,176);"><%=p %></a>
					</li>
					
				<%} else {%>
				<li>
					<a href="/home/adminHome?page=<%=pagefile %>&nowPage=<%= p%>"><%=p %></a>
			
				</li>
				<%}
				}//if
			}//for%>
			<li>
				<%if(nowPage<totalPage){ //다음페이지가 없을 경우
				%>
					<a href="/home/adminHome?page=<%=pagefile %>&nowPage=<%=nowPage+1 %>">▶</a>
				<%} %>
			</ul>
			
				
		</div><!-- paging -->
	</div><!-- adminContent -->
</div><!-- adminhome -->
<!-- Page Content -->
</body>
</html>