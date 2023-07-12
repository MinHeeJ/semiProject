package com.semi.mvc.member.model.service;

import static com.semi.mvc.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;

import com.semi.mvc.member.model.dao.MemberDao;
import com.semi.mvc.member.model.vo.Member;
import com.semi.mvc.member.model.vo.MemberRole;

public class MemberService {
	private final MemberDao memberDao = new MemberDao();
	
	public List<Member> findAll() {
		Connection conn = getConnection();
		List<Member> members = memberDao.findAll(conn);
		close(conn);
		return members;
	}

	public int updateMemberRole(String memberId, MemberRole memberRole) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = memberDao.updateMemberRole(conn, memberId, memberRole);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
		} finally {
			close(conn);
		}
		return result;
	}

	public int deleteMember(String memberId) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = memberDao.deleteMember(conn, memberId);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
		} finally {
			close(conn);
		}
		return result;
	}

}
