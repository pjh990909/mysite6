package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.MemberVo;

@Repository
public class GuestDao {
	@Autowired
	private SqlSession sqlSession;

	public List<MemberVo> guestSelect() {
		System.out.println("GuestDao.guestSelect()");

		List<MemberVo> memberList = sqlSession.selectList("guest.select");

		System.out.println(memberList);

		return memberList;
	}

	// 등록
	public int guestInsert(MemberVo memberVo) {

		int count = sqlSession.insert("guest.insert", memberVo);

		return count;
	}

	// 삭제
	public int guestDelete(MemberVo memberVo) {

		int count = sqlSession.delete("guest.delete", memberVo);
		return count;
	}

	// ajax등록 인썰트
	public int insertSelectKey(MemberVo memberVo) {
		System.out.println("GuestDao.insertSelectKey()");
		System.out.println(memberVo);

		int count = sqlSession.insert("guest.insertSelectKey", memberVo);
		System.out.println(memberVo);

		return count;
	}

	// ajax등록 셀렉원
	public MemberVo guestbookSelectOne(int no) {
		System.out.println("GuestDao.guestbookSelectOne()");

		MemberVo memberVo = sqlSession.selectOne("guest.selectOne", no);
		

		return memberVo;
	}

	// ajax삭제
	public int guestDelete2(MemberVo memberVo) {

		int count = sqlSession.delete("guest.delete", memberVo);
		return count;
	}

}
