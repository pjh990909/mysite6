package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.BoardDao;
import com.javaex.vo.RboardVo;

@Service
public class BoardService {
	@Autowired
	private BoardDao boardDao;
	
	public List<RboardVo> exeBoardList(){
		
		List<RboardVo> boardList = boardDao.boardSelect();
		
		return boardList;
	}
	
	public RboardVo exeBoardRead(int no) {
		
		RboardVo boardVo = boardDao.boardSeletone(no);
		
		return boardVo;
	}
	
	public int exeBoardModify(RboardVo boardVo) {
		
		int count = boardDao.boardUpdate(boardVo);
		
		return count;
	}
	
	public int exeBoardDelete(int no) {
		
		int count = boardDao.boardDelete(no);
		
		return count;
	}
	
	public int exeBoardwrite(RboardVo boardVo) {
		
		int count = boardDao.boardInsert(boardVo);
		
		return count;
	}
	
}
