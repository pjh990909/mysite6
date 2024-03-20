package com.javaex.controller.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.GalleryService;
import com.javaex.vo.GalleryVo;

@Controller
public class ApiGalleryController {

	@Autowired
	private GalleryService galleryService;

	// 삭제
	@ResponseBody
	@RequestMapping(value = "/api/gallery/{no}", method = RequestMethod.DELETE)
	public int delete2(@PathVariable("no") int no, @ModelAttribute GalleryVo galleryVo) {
		System.out.println("ApiGalleryController.delete()");
		System.out.println(no);
		System.out.println(galleryVo);

		int count = galleryService.exeDelete(galleryVo);

		return count;
	}

}
