package com.javaex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javaex.service.RboardService;
import com.javaex.vo.RboardVo;

@Controller
@RequestMapping("/rboard")
public class RboardController {
	@Autowired
	private RboardService rboardservice;
	
	// 댓글 게시판폼
	@RequestMapping(value = "/commentform", method = { RequestMethod.GET, RequestMethod.POST })
	public String commentForm() {
		System.out.println("BoardController.commentForm()");

		return "rboard/commentForm";
	}

	// 계단형 리스트
	@RequestMapping(value = "/commentlist", method = { RequestMethod.GET, RequestMethod.POST })
	public String commentList(@ModelAttribute RboardVo rboardVo) {
		System.out.println();
		
		rboardservice.exeList(rboardVo);
		
		return "";
	}
}
