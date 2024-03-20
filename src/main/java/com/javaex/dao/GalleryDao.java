package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.GalleryVo;
import com.javaex.vo.MemberVo;

@Repository
public class GalleryDao {
	@Autowired
	private SqlSession sqlSession;
	//리스트,홈
	public List<GalleryVo> galleryList() {
		System.out.println("GalleryDao.galleryList()");
		
		List<GalleryVo> galleryList = sqlSession.selectList("gallery.select");
		
		
		return galleryList;
	}
	//등록
	public void galleryInsert(GalleryVo galleryVo) {
		System.out.println("GalleryDao.galleryInsert()");
		
		
		sqlSession.insert("gallery.insert", galleryVo);
		
	}
	
	public int galleryDelete(GalleryVo galleryVo) {

		int count = sqlSession.delete("gallery.delete", galleryVo);
		return count;
	}
	
}
