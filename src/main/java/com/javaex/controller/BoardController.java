package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.BoardService;
import com.javaex.vo.BoardVo;
import com.javaex.vo.UserVo;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping ("/board")
public class BoardController {
	@Autowired
	private BoardService boardService;
	
	//게시판
	@RequestMapping(value="/list", method= {RequestMethod.GET, RequestMethod.POST})
	public String List(Model model) {
		
		List<BoardVo> boardList = boardService.exeBoardList();
		
		model.addAttribute("boardList",boardList);
		
		return "board/list";
	}
	
	//게시판읽기
	@RequestMapping(value="/read", method= {RequestMethod.GET, RequestMethod.POST})
	public String Read(@RequestParam int no,Model model) {
		
		BoardVo boardVo = boardService.exeBoardRead(no);
		
		model.addAttribute(boardVo);
		
		return "board/read";
	}
	
	//수정폼
	@RequestMapping(value="/mform", method= {RequestMethod.GET, RequestMethod.POST})
	public String modifyForm(@RequestParam int no,Model model) {
		
		BoardVo boardVo = boardService.exeBoardRead(no);
		
		model.addAttribute(boardVo);
		
		return "board/modify";
		
	}
	
	//수정
	@RequestMapping(value="/modify", method= {RequestMethod.GET, RequestMethod.POST})
	public String modify(@ModelAttribute BoardVo boardVo) {
		
		boardService.exeBoardModify(boardVo);
		
		return "redirect:/board/list";
	}
	
	//삭제
	@RequestMapping(value="/delete", method= {RequestMethod.GET, RequestMethod.POST})
	public String delete(@RequestParam int no) {
		
		boardService.exeBoardDelete(no);
		
		return "redirect:/board/list";
	}
	
	//등록폼
	@RequestMapping(value="/wform", method= {RequestMethod.GET, RequestMethod.POST})
	public String writeForm() {
		
		return "board/writeForm";
	}
	
	//등록
	@RequestMapping(value="/write", method= {RequestMethod.GET, RequestMethod.POST})
	public String write(HttpSession session,@ModelAttribute BoardVo boardVo) {
		
		
		UserVo userVo = (UserVo)session.getAttribute("authUser");
		
		int no = userVo.getNo();
		
		boardVo.setUser_no(no);
		boardService.exeBoardwrite(boardVo);
		
		
		return "redirect:/board/list";
	}
}
