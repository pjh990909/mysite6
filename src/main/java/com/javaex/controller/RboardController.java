package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javaex.service.RboardService;
import com.javaex.vo.RboardVo;
import com.javaex.vo.UserVo;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/rboard")
public class RboardController {
	@Autowired
	private RboardService rboardservice;

	// 댓글 게시판홈폼
	@RequestMapping(value = "/commentlist", method = { RequestMethod.GET, RequestMethod.POST })
	public String commentList(Model model) {
		System.out.println("BoardController.commentForm()");

		List<RboardVo> rList = rboardservice.exeList();

		model.addAttribute("rList", rList);

		return "rboard/commentList";
	}

	// 댓글쓰기 폼
	@RequestMapping(value = "/commentform", method = { RequestMethod.GET, RequestMethod.POST })
	public String commentForm(Model model) {
		System.out.println("BoardController.commentForm()");

		List<RboardVo> rList = rboardservice.exeList();

		model.addAttribute("rList", rList);
		
		return "rboard/commentForm";
	}

	// 댓글 등록
	@RequestMapping(value = "/write", method = { RequestMethod.GET, RequestMethod.POST })
	public String write(HttpSession session, @ModelAttribute RboardVo rboardVo) {
		System.out.println("BoardController.write()");

		UserVo userVo = (UserVo) session.getAttribute("authUser");
		int no = userVo.getNo();

		rboardVo.setUser_no(no);

		rboardservice.exeInsert(rboardVo);

		return "redirect:/rboard/commentlist";
	}
	
	//그냥 게시글 등록
	

}
