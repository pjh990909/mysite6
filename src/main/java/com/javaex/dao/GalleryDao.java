package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.GalleryVo;

@Repository
public class GalleryDao {
	@Autowired
	private SqlSession sqlSeesion;
	//리스트,홈
	public List<GalleryVo> galleryList() {
		System.out.println("GalleryDao.galleryList()");
		
		List<GalleryVo> galleryList = sqlSeesion.selectList("gallery.select");
		
		
		return galleryList;
	}
	//등록
	public void galleryInsert(GalleryVo galleryVo) {
		System.out.println("GalleryDao.galleryInsert()");
		
		
		sqlSeesion.insert("gallery.insert", galleryVo);
		
	}
	
	
	
}
