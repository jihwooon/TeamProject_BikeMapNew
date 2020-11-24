package com.bikemap.home.admin;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bikemap.home.regist.RegistDaoImp;
import com.bikemap.home.regist.RegistVO;


@Controller
public class AdminController {
	SqlSession sqlSession;

	public SqlSession getSqlSession() {
		return sqlSession;
	}
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	//회원관리전체리스트
	@RequestMapping("/adminUser")	
	public ModelAndView adminUser() {
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		List<RegistVO>list = dao.registAllRecord();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.setViewName("admin/adminUserTable");
		return mav;
	}
	//동행찾기패널
	@RequestMapping("/adminPartner")
	public String adminPartner() {
		return "admin/adminPartnerTable";
	}
	//1대1문의패널
	@RequestMapping("/adminQuestion")
	public String admingQuestion() {
		return "admin/adminQuestionTable"; 
	}
	//리뷰패널
	@RequestMapping("/adminReview")
	public String adminReview() {
		return "admin/adminReviewTable";
	}
	
	@RequestMapping("/adminReplyWrite")
	public String adminReplyWrite() {
		return "admin/adminReplyWrite";
	}
	
	//유저 항목
	
	
}
