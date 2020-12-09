package com.bikemap.home.review;

import java.util.List;

import com.bikemap.home.route.RoutePagingVO;
import com.bikemap.home.route.RouteVO;


public interface ReviewDaoImp {


	//전체 레코드 선택
	public List<ReviewVO> reviewAllRecord(ReviewPagingVO pagingVO);
	
	//레코드 추가 - 글쓰기
	public int reviewInsert(ReviewVO vo);
	
	//레코드 1개 선택
	public ReviewVO reviewSelect(int noboard);
	
	//조회수 증가
	public int hitCount(int noboard);

	//글수정
	public int reviewUpdate(ReviewVO vo);

	//글삭제
	public int reviewDelete(int noboard, String userid);
	
	// 페이징할 레코드  숫자 구하기
	public int searchTotalRecord(ReviewPagingVO vo);
	
}
