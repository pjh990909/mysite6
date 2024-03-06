package com.javaex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javaex.service.UserService;
import com.javaex.vo.UserVo;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping ("/user")
public class UserController {
	@Autowired
	private UserService userService;
	
	//로그인폼
	@RequestMapping(value="/loginform", method= {RequestMethod.GET, RequestMethod.POST})
	public String loginForm() {
		System.out.println("UserController.loginForm()");
		
		
		
		return "user/loginForm";
	}
	
	//로그인
	@RequestMapping(value="/login", method= {RequestMethod.GET, RequestMethod.POST})
	public String login(HttpSession session,@ModelAttribute UserVo userVo) {
		System.out.println("UserController.login()");
		
		System.out.println(userVo);
		
		UserVo authUser = userService.exeLogin(userVo);
		
		if(authUser != null) {
			
			session.setAttribute("authUser", authUser);
			return "redirect:/main";
		}else {
			
			return "redirect:/user/loginForm";
		}
		
	}
	
	//로그아웃
	@RequestMapping(value="/logout", method = {RequestMethod.GET, RequestMethod.POST})
	public String logout(HttpSession session){
		System.out.println("UserController.logout()");
		
		session.invalidate();
		
		return "redirect:/main";
	}
	
	
	//회원가입폼
	@RequestMapping(value="/joinForm", method= {RequestMethod.GET, RequestMethod.POST})
	public String joinForm() {
		System.out.println("UserController.joinForm()");
		
		
		return "user/joinForm";
	}
	
	//회원가입
	@RequestMapping(value="/join", method= {RequestMethod.GET, RequestMethod.POST})
	public String join(@ModelAttribute UserVo userVo) {
		System.out.println("UserController.join()");
		
		userService.exejoin(userVo);
		
		System.out.println(userVo);
		
		return "user/joinOk";
	}
	
	//회원정보수정폼
	@RequestMapping(value="/mform", method= {RequestMethod.GET, RequestMethod.POST})
	public String modifyForm(HttpSession session,Model model) {
		System.out.println("UserController.mform()");
		
		UserVo uNo = (UserVo)session.getAttribute("authUser");
		int no = uNo.getNo();
		
		UserVo userVo = userService.exemform(no);
		
		model.addAttribute("userVo", userVo);
		
		return "user/modifyForm";
	}
	
	//회원정보수정
	@RequestMapping(value="/modify", method= {RequestMethod.GET, RequestMethod.POST})
	public String modify(HttpSession session,@ModelAttribute UserVo userVo) {
		System.out.println("UserController.modify()");
		
		UserVo uNo = (UserVo)session.getAttribute("authUser");
		
		int no = uNo.getNo();
		
		userVo.setNo(no);
		userService.exeModify(userVo);
		
		session.setAttribute("authUser", userVo);
		
		return "redirect:/main";
	}
}
