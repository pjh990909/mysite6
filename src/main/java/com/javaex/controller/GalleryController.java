package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.GalleryService;
import com.javaex.vo.GalleryVo;
import com.javaex.vo.UserVo;

import jakarta.servlet.http.HttpSession;

@Controller
public class GalleryController {

	@Autowired
	private GalleryService galleryService;

	// 갤러리 홈,리스트
	@RequestMapping(value = "/gallery/list", method = { RequestMethod.GET, RequestMethod.POST })
	public String list(Model model) {
		System.out.println("GalleryController.list()");

		List<GalleryVo> galleryList = galleryService.exelist();

		model.addAttribute("gList", galleryList);

		return "gallery/list";
	}

	// 이미지경로등록
	@RequestMapping(value = "/gallery/upload", method = RequestMethod.POST)
	public String Upload(@RequestParam(value = "file") MultipartFile file, @ModelAttribute GalleryVo galleryVo,
						 HttpSession session, @RequestParam(value = "content") String content,
						 @RequestParam(value = "userNo") int userNo, Model model) {
		System.out.println("AttachController.Upload()");

		UserVo userVo = (UserVo) session.getAttribute("authUser");

		int no = userVo.getNo();

		galleryVo.setUser_no(no);

		String saveName = galleryService.exeupload(file, content, userNo);
		model.addAttribute("saveName", saveName);

		return "redirect:/gallery/list";

	}

}
