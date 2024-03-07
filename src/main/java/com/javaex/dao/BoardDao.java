package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.RboardVo;

@Repository
public class BoardDao {
	@Autowired
	private SqlSession sqlSession;
	
	public List<RboardVo> boardSelect(){
		
		List<RboardVo> boardList = sqlSession.selectList("board.select");
		
		return boardList;
	}
	
	public RboardVo boardSeletone(int no) {
		
		RboardVo boardVo = sqlSession.selectOne("board.selectone", no);
		
		return boardVo;
	}
	
	public int boardUpdate(RboardVo boardVo) {
		
		int count = sqlSession.update("board.update", boardVo);
		
		return count;
	}
	
	public int boardDelete(int no) {
		
		int count = sqlSession.delete("board.delete", no);
		
		return count;
	}
	
	public int boardInsert(RboardVo boardVo) {
		
		int count = sqlSession.insert("board.insert", boardVo);
		
		return count;
	}
}
