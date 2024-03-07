package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.RboardDao;
import com.javaex.vo.RboardVo;

@Service
public class RboardService {
	@Autowired
	private RboardDao rboardDao;
	
	public List<RboardVo> exeList() {
		System.out.println("RboardService.exeList()");
		
		List<RboardVo> rList = rboardDao.Rboardselect();
		
		return rList;
	}
	
	public void exeInsert(RboardVo rboardVo) {
		System.out.println("RboardService.exeInsert()");
		
		rboardDao.RboardUpdat(rboardVo);
		
		rboardDao.RboardInsert(rboardVo);
	}
	
	
}
