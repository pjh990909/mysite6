package com.javaex.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.dao.GalleryDao;
import com.javaex.vo.GalleryVo;
import com.javaex.vo.MemberVo;

@Service
public class GalleryService {
	@Autowired
	private GalleryDao galleryDao;
	
	public List<GalleryVo> exelist() {
		System.out.println("GalleryService.exelist()");
		
		List<GalleryVo> galleryList = galleryDao.galleryList();
		
		 
		return galleryList;
	}
	
	
	
	
	//이미지경로 등록
	public String exeupload(MultipartFile file, String content, int userNo) {
	    System.out.println("GalleryService.exeupload()");
	    System.out.println(file.getOriginalFilename());
	    
	    // 파일 저장 폴더
	    String saveDir = "C:\\javaStudy\\upload";
	    
	    // (0) 파일 관련 정보수집
	    // 오리지날 파일명
	    String orgName = file.getOriginalFilename();
	    System.out.println("orgName:" + orgName);
	    
	    // 확장자
	    String exName = orgName.substring(orgName.lastIndexOf("."));
	    System.out.println("exName:" + exName);
	    
	    // 저장 파일명(겹치지 않아야 한다)
	    String saveName = System.currentTimeMillis() + UUID.randomUUID().toString() + exName;
	    System.out.println("saveName:" + saveName);
	    
	    // 파일 사이즈
	    long fileSize = file.getSize();
	    System.out.println("fileSize:" + fileSize);
	    
	    // 파일 전체 경로(저장파일명 포함)
	    String filePath = saveDir + "\\" + saveName;
	    System.out.println("filePath:" + filePath);
	    
	    
	    // (1) 파일정보를 DB에 저장
	    // * vo 묶어주고
	    GalleryVo galleryVo = new GalleryVo(userNo, content, filePath, orgName, saveName, fileSize);
	    
	    // * db에 저장
	    galleryDao.galleryInsert(galleryVo);
	    System.out.println(".......DB저장완료");
	    
	    // (2) 파일을 하드디스크에 저장
	    
	    // 파일 저장
	    try {
	        byte[] fileData = file.getBytes();
	        
	        OutputStream os = new FileOutputStream(filePath);
	        BufferedOutputStream bos = new BufferedOutputStream(os);
	        
	        bos.write(fileData);
	        bos.close();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    
	    return saveName;
	}

	public int exeDelete(GalleryVo galleryVo) {
		System.out.println("GalleryService.exeDelete()");

		// PhonebookDao phonebookDao = new PhonebookDao();

		int count = galleryDao.galleryDelete(galleryVo);

		return count;
	}

	
	
}
