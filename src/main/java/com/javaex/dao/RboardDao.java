package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.RboardVo;

@Repository
public class RboardDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<RboardVo> Rboardselect() {
		System.out.println("RboardDao.Rboardselect");
		
		List<RboardVo> rList = sqlSession.selectList("rboard.select");
		
		return rList;
	}
	
	public void RboardUpdat(RboardVo rboardVo) {
		System.out.println("RboardDao.RboardUpdat");
		
		sqlSession.update("rboard.update", rboardVo);
		
	}
	
	public void RboardInsert(RboardVo rboardVo) {
		System.out.println("RboardDao.RboardInsert");
		
		sqlSession.insert("rboard.insert", rboardVo);
	}
}
