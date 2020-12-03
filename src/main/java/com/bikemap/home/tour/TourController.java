package com.bikemap.home.tour;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bikemap.home.reply.ReplyDaoImp;
import com.bikemap.home.reply.ReplyPagingVO;
import com.bikemap.home.reply.ReplyVO;

@Controller
public class TourController {
	
	public SqlSession sqlSession ;
	
	public SqlSession getSqlSession() {
		return sqlSession;
	}
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 게시판 목록
	@RequestMapping("/tourList")
	public ModelAndView TourList(PagingVO vo) {
		ModelAndView mav = new ModelAndView();
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		PagingVO pagingVO = new PagingVO();
		List<TourVO> list = dao.selectAllTour(pagingVO);
	
		try {
			pagingVO.setTotalRecord(dao.getTotalTourRecord(vo));
			
		}catch(Exception e) {
			System.out.println("동행찾기게시판 페이징 에러"+ e.getMessage());
		}
	
		mav.addObject("paging", pagingVO);
		mav.addObject("viewAll",list);
		
		mav.setViewName("tour/tourList");
		return mav;
	}

	@RequestMapping("/tourPagingListAll")
	@ResponseBody
	public List<TourVO> tourAllSelectAll(PagingVO vo) {
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		List<TourVO> list = new ArrayList<TourVO>();
		try {
			vo.setTotalRecord(dao.getTotalTourRecord(vo));			
			list = dao.selectAllTour(vo);
		}catch(Exception e) {
			System.out.println("페이징 에러 " + e.getMessage());
		}
		
		return list;
	}
	
	@RequestMapping("/tourPagingList")
	@ResponseBody
	public List<TourVO> tourAllSelect(PagingVO vo) {
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		List<TourVO> list = new ArrayList<TourVO>();
		try {
			vo.setTotalRecord(dao.getTourRecord(vo));
			System.out.println(vo.getOnePageRecord());
			list = dao.selectAllTour(vo);
		}catch(Exception e) {
			System.out.println("페이징 에러 " + e.getMessage());
		}
		
		return list;
	}
																							
	//글보기
	@RequestMapping("/tourView")
	public ModelAndView TourView(int noboard) {
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		
		TourVO vo = dao.tourSelect(noboard);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("vo", vo);
		mav.setViewName("tour/tourView");
		
		return mav;
	}
	
	
	// 글쓰기 폼 이동
	@RequestMapping("/tourWriteForm")
	public String tourBoardWrite() {
		return "/tour/tourWriteForm";
	}
	
	// 글쓰기 등록 , produces="application/text;charset=UTF-8"
	@RequestMapping(value="/tourWriteFormOk", method= {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public int tourWriteFormOk(TourVO vo ,HttpServletRequest req, HttpSession ses) {
		vo.setIp(req.getRemoteAddr());
		vo.setUserid((String)ses.getAttribute("logId"));
		
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		
		int result=0;
		try {
			result = dao.tourInsert(vo);
			if(result == 1) {
				ComplistVO complist = new ComplistVO();
				complist.setNoboard(dao.lastTourNo(vo.getUserid()));
				complist.setUserid(vo.getUserid());
				complist.setState("2");
				
				result = dao.insertTourComplist(complist);
			}
			
		}catch(Exception e) {
			System.out.println("동행 모집 등록 에러" + e.getMessage());
			result = 0;
		}	

		return result;
	}
	//페이징 전체
	@RequestMapping(value="/searchTourPagingAll", method=RequestMethod.POST)
	@ResponseBody
	public PagingVO searchTourPagingAll(PagingVO vo) {	
		try {
			TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
			vo.setTotalRecord(dao.getTotalTourRecord(vo));
		}catch(Exception e) {
			System.out.println("페이징에러"+e.getMessage());
			e.printStackTrace();
		}
		return vo;
	}
	
	//페이징
	@RequestMapping(value="/searchTourPaging", method=RequestMethod.POST)
	@ResponseBody
	public PagingVO searchTourPaging(PagingVO vo) {	
		try {
			TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
			
//			String sql = sqlSession.getConfiguration().getMappedStatement("getTotalTourRecord").getBoundSql(vo).getSql();
//			System.out.println("sql->"+sql);
			vo.setTotalRecord(dao.getTourRecord(vo));
		}catch(Exception e) {
			System.out.println("페이징에러"+e.getMessage());
			e.printStackTrace();
		}
		return vo;
	}
	
}