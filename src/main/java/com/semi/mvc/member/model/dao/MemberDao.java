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

	public Member findById(Connection conn, String memberId) {
	    String sql = "SELECT * FROM member WHERE member_id = ?";
	    Member member = null;
	    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, memberId);
	        try (ResultSet rset = pstmt.executeQuery()) {
	            while (rset.next()) {
	                member = handleMemberResultSet(rset);
	            }
	        }
	    } catch (SQLException e) {
	        throw new MemberException(e);
	    }
	    return member;
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

	public int updateMemberRole(Connection conn, String memberId, MemberRole memberRole) {
		int result = 0;
		String sql = prop.getProperty("updateMemberRole");
		// update member set member_role = ? where member_id = ?
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, memberRole.name());
			pstmt.setString(2, memberId);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new MemberException(e);
		}
		return result;
	}

	public int deleteMember(Connection conn, String memberId) {
		int result = 0;
		String sql = prop.getProperty("deleteMember");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, memberId);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new MemberException(e);
		}
		return result;
	}



	public int insertMember(Connection conn, Member newMember) {
	    int result = 0;
	    String sql = prop.getProperty("insertMember");

	    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, newMember.getMemberId());
	        pstmt.setString(2, newMember.getPassword());
	        pstmt.setString(3, newMember.getName());
	        pstmt.setString(4, newMember.getPhone());
	        pstmt.setString(5, newMember.getAddress());
	        pstmt.setString(6, newMember.getGender() != null ? newMember.getGender().name() : null);
	     

	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        throw new MemberException(e);
	    }

	    return result;
	}

	public int updateMember(Connection conn, Member member) {
		int result = 0;
		String sql = prop.getProperty("updateMember");
		// update member set name = ?, gender = ?, phone = ?, address = ? where member_id = ?
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, member.getName());
			pstmt.setString(2, member.getGender() != null ? member.getGender().name() : null);
			pstmt.setString(3, member.getPhone());
			pstmt.setString(4, member.getAddress());
			pstmt.setString(5, member.getMemberId());	
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new MemberException(e);
		}
		return result;
	}
}
