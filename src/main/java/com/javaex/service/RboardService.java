package com.javaex.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.RboardDao;
import com.javaex.vo.RboardVo;

@Service
public class RboardService {
	@Autowired
	private RboardDao rboardDao;
	
	public RboardVo exeList(RboardVo rboardVo) {
		System.out.println("RboardService.exeList()");
		
		rboardDao.Rboardselect(rboardVo);
		
		return null;
	}
	
}
