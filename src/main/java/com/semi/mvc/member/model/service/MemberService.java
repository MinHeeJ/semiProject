package com.semi.mvc.member.model.service;

import static com.semi.mvc.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;

import com.semi.mvc.member.model.dao.MemberDao;
import com.semi.mvc.member.model.vo.Member;

public class MemberService {
	private final MemberDao memberDao = new MemberDao();
	
	public List<Member> findAll() {
		Connection conn = getConnection();
		List<Member> members = memberDao.findAll(conn);
		close(conn);
		return members;
	}

}
