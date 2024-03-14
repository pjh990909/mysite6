package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.GuestDao;
import com.javaex.vo.MemberVo;

@Service
public class GuestService {
	@Autowired
	private GuestDao guestDao;
	
	// 등록
		public int exeWrite(MemberVo memberVo) {
			System.out.println("GuestService.exeWrite()");

			// PhonebookDao phonebookDao = new PhonebookDao();

			int count = guestDao.guestInsert(memberVo);

			return count;
		}

		// 리스트
		public List<MemberVo> exeList() {
			System.out.println("PhonebookService.exeList()");

			// PhonebookDao phonebookDao = new PhonebookDao();

			List<MemberVo> memberList = guestDao.guestSelect();

			return memberList;
		}
		//삭제
		public int exeDelete(MemberVo memberVo) {
			System.out.println("PhonebookService.exeDelete()");

			// PhonebookDao phonebookDao = new PhonebookDao();

			int count = guestDao.guestDelete(memberVo);

			return count;
		}

		//ajax등록 저장
		public MemberVo exeAddandGuest(MemberVo memberVo) {
			System.out.println("PhonebookService.exeAddandGuest()");
			
			System.out.println("전"+memberVo);
			guestDao.insertSelectKey(memberVo);
			System.out.println("후"+memberVo);
			
			MemberVo mVo = guestDao.guestbookSelectOne(memberVo.getNo());
			
			return mVo;
		}
		//ajax삭제
		public MemberVo exeDelete2(MemberVo memberVo) {
			System.out.println("PhonebookService.exeDelete()");

			// PhonebookDao phonebookDao = new PhonebookDao();
			
			guestDao.guestDelete2(memberVo);
			
			MemberVo mVo = guestDao.guestbookSelectOne(memberVo.getNo());

			return mVo;
		}
}
