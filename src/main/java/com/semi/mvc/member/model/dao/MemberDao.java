package com.semi.mvc.member.model.dao;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.semi.mvc.member.model.exception.MemberException;
import com.semi.mvc.member.model.vo.Gender;
import com.semi.mvc.member.model.vo.Member;
import com.semi.mvc.member.model.vo.MemberRole;

public class MemberDao {
	private Properties prop = new Properties();
	
	public MemberDao() {
		String filename = MemberDao.class.getResource("/sql/member/member-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<Member> findAll(Connection conn) {
		List<Member> members = new ArrayList<>();
		String sql = prop.getProperty("findAll");
		
		try (
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rset = pstmt.executeQuery();
		) {
			while(rset.next()) {
				Member member = handleMemberResultSet(rset);
				members.add(member);
			}
		} catch (SQLException e) {
			throw new MemberException(e);
		}
		return members;
	}

	private Member handleMemberResultSet(ResultSet rset) throws SQLException {
		String memberId = rset.getString("member_id");
		String passwoard = rset.getString("password");
		String name = rset.getString("name");
		String phone = rset.getString("phone");
		String address = rset.getString("address");
		String _gender = rset.getString("gender");
		Gender gender = Gender.valueOf(_gender);
		String _memberRole = rset.getString("member_role");
		MemberRole memberRole = MemberRole.valueOf(_memberRole);
		Member member = new Member(memberId, passwoard, name, phone, address, gender, memberRole);
		return member;
	}


}
