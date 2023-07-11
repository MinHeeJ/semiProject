package com.semi.mvc.admin.model.service;

import static com.semi.mvc.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;

import com.semi.mvc.admin.model.dao.MemberDao;
import com.semi.mvc.member.model.vo.Member;

public class MemberService {
	private final MemberDao memberDao = new MemberDao();
	
	public List<Member> findAll() {
		List<Member> members = memberDao.findAll();
		Connection conn = getConnection();
		return members;
	}

}
