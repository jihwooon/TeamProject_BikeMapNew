<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
<link rel="stylesheet" href="/home/css/route.css" type="text/css"/>
<div style='width:1200px; height:auto; margin:0 auto'>
	<div class="optionBar" >
		<form id="searchRoute" method="post" action="#">
			<select id="searchBarKey" name="searchBarKey" class="regionSelect">
	   		    <option value="title">코스이름</option>
			    <option value="userid">작성자</option>
			    <option value="region">지역</option>
			</select>
			<input type="text" id="searchBarWord" name="searchBarWord" class="schBar" style='padding-left:20px; color:#7F7F7F; font-size:17px; font-weight:bolder;'/>
			<input type="submit" class="mint_Btn" value="검 색" style='width:70px; height:40px'/>
		</form>
		<form id="pagingVO" method="post" action="/home/routeSearchView" style="diplay:none">
			<input type="hidden" name="nowPage" value="${pagingVO.nowPage }"/>
			<input type="hidden" name="searchKey" value="${pagingVO.searchKey }"/>
			<input type="hidden" name="searchWord" value="${pagingVO.searchKey }"/>
			<input type="hidden" name="noboard" value=""/>
		</form>
	</div>
	<div id="hitDiv">
		<div class="title">추천 루트</div>
		<div id="frame">
			<div id="poster" >
			</div>
		</div>
	</div>
	<div class="routeSearch">
		<div class="title">코스검색</div>
		<div class="orderRadio">
			<input type="radio"  name="order" id="orderNoboard" value="noboard" checked/><label for="orderNoboard" class="subTxt">최신순</label><span id="lBar">&ensp;|&ensp;</span>
			<input type="radio" name="order" id="orderRating" value="rating" /><label for="orderRating" class="subTxt" >평점순</label>
		</div>
	</div>
	<hr class='borderHr'/>
	<div id="content2"></div>
	<hr class='borderHr'/>
	<!-- ================댓글창============= -->
		<div id="paging" style='margin-bottom:115px'>
			<ul>
			<!-- 이전 페이지 -->
				<c:if test="${pagingVO.nowPage != 1 }">
					<li><a href="#">Prev</a></li>
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
				<c:if test="${pagingVO.nowPage != pagingVO.totalPage }">
					<li><a href="#">Next</a></li>
				</c:if>
			</ul>
		</div>
</div>
<script>
	$(function(){
		
		$.ajax({
			url : "/home/route/getRecRoute",
			success : function(result){
				console.log(result);
				makeThumbnail(result, 1);
			}, error : function(err){
				console.log(err);
			}
		});
				
		$("#poster").on('mouseover',function(){
			step = 0;
		});
		
		$("#poster").on('mouseout', function(){
			step = 0.5;
		});
		
		var nowPage = $("input[name=nowPage]").val();
		// 페이지 로딩 시 전체 리스트 불러오기
		movePage(nowPage);
			
		// 검색
		$("#searchRoute").submit(function(){
			if($("#searchBarWord").val() == ""){
				alert("검색어를 입력하세요.");
				return false;
			};
			movePage(1);
			return false;
		});
		
		$("input[name=order]").on('change',function(){
			movePage(nowPage);
		});
	});
	
	var	timer = setInterval('postMove()',2.5);
	var left = 0;
	var step = 0.5;
	
	// 추천 루트 무한 루프
	function postMove(){
		left = left - step ;
		document.getElementById("poster").style.left = left +"px";
		
		var length = $("#poster>ul>li").length-1;
		if(left <= -300){
			left = 0;
			$("#poster>ul>li").eq(0).insertAfter($("#poster>ul>li").eq(length));
		}
	}
	
	//////////////////// function ///////////////////
	
	// 지도 썸네일 만들기
 	function makeThumbnail(result, type){
	
 		var mapId = 'map';
		if(type == 1){	mapId = 'recMap'; 	}
		
		var listTag = "<ul id='contentDivs'>";
		for(var i = 0 ; i < result.length ; i++){
			// 썸네일 작성부
			listTag += "<li class='contentDiv' onclick='goViewPage("+result[i].noboard+")'><div id='"+mapId+i+"' class='map'></div>";
			// 루트 설명 작성부
			listTag += "<div class='routeSubscript'><ul ><li class='wordCut' style='font-size:18px; color:#0f6767; font-weight:bold; margin:4px 0 2px 0'>"+result[i].title+"</li><li class='wordCut' style='font-size:15px; font-weight:bold'>"+result[i].region+"</li><li>총 거리 "+result[i].distance.toFixed(2)+"km</li>";
			var rateWidth =  (result[i].rating/5 *125);
			listTag += "<li style='text-align:right'>"+result[i].userid+"</li><li><span class='star-rating'><span style='width:"+rateWidth+"px'></span></span></li></ul></div></li>";
		}
		listTag +="</ul>";
		
		if(type == 1){	$("#poster").html(listTag);	}
		else{	$("#content2").html(listTag);	}
			
		for(var i = 0 ; i < result.length ; i++){
			var array = result[i].mapcenter.replace("(","").replace(")","").split(",");
			
			var container = document.getElementById(mapId+i);
			var options = {
					center : new kakao.maps.LatLng(array[0], array[1]),
					draggable: false,
					level : result[i].maplevel+2
			};
			
			var readyArray = result[i].polyline.replaceAll("),(","||").replace("(","").replace(")","").replaceAll("||",",").split(",");
			
			var linePath = [];
			for(var j = 0 ; j < readyArray.length ; j += 2) {
				var p = new kakao.maps.LatLng(readyArray[j], readyArray[j+1]);
				linePath.push(p);
			}
			
			var map = new kakao.maps.Map(container, options);
		    var polyline = new kakao.maps.Polyline({
			    path: linePath, // 선을 구성하는 좌표배열 입니다
			    strokeWeight: 5, // 선의 두께 입니다
			    strokeColor: '#FF0162', // 선의 색깔입니다
			    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
			    strokeStyle: 'solid' // 선의 스타일입니다
			});
	    	polyline.setMap(map);
		}
	}
	
	// 페이징 리스트 만들기
	function setPaging(vo){
		// 이전 페이징 삭제
		$("#paging").children().remove();
		var tag = "<ul>";
		
		if(vo.nowPage != 1){
			tag += "<li><a href='javascript:movePage("+(vo.nowPage -1)+");'>Prev</a></li>";
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
		var url = "<%=request.getContextPath()%>/searchRoutePaging";
		var data = "nowPage="+page+"&searchKey="+$("#searchBarKey").val()+"&searchWord="+$("#searchBarWord").val();
			data += "&order="+$("input[name=order]:checked").val();
		
		$.ajax({
			type : 'POST',
			url : url,
			data : data,
			success : function(result){
				if(result.totalRecord <= 0){
					toast("검색 결과가 없습니다.",1500);
					return false;
				}else{
					$("input[name=searchKey]").val($("#searchBarKey").val())
					$("input[name=searchWord]").val($("#searchBarWord").val())
					
					setPaging(result);
					nowPage = result.nowPage;
					$("input[name=nowPage]").val(nowPage);
				}
			},error : function(){
				console.log("페이징 오류");
			}
		});
		
		// 리스트 데이터 검색
		url = "<%=request.getContextPath()%>/searchRouteOk";
		$.ajax({
			type : 'POST',
			url : url,
			data : data,
			success : function(result){

				makeThumbnail(result);

			}, error : function(){
				console.log("페이지 + 검색 결과 호출 에러");
			}
		});
	}

	// 뷰페이지 이동
	function goViewPage(noboard){
		
		$("input[name=noboard]").val(noboard)
		var data = $("#pagingVO").serialize();
		data += "&order="+$("input[name=order]:checked").val();
		
		$("#pagingVO").submit();
	}
</script>