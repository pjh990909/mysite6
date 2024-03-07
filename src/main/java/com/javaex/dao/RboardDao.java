package com.javaex.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.RboardVo;

@Repository
public class RboardDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public RboardVo Rboardselect(RboardVo rboardVo) {
		System.out.println("RboardDao.Rboardselect");
		
		sqlSession.selectList("rboard.select");
		
		return null;
	}
}
