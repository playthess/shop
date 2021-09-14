package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.*;
import commons.*;

public class MemberDao {
		public void insertMember(Member member) throws ClassNotFoundException, SQLException {
		System.out.println(member.getMemberId() + "<-MemberId");
		System.out.println(member.getMemberPw() + "<-MemberPw");
		System.out.println(member.getMemberName() + "<-MemberName");
		System.out.println(member.getMemberAge() + "<-MemberAge");
		System.out.println(member.getMemberGender() + "<-MemberGender");
		 
		/* as 생략 가능
		* INSERT INTO member (
		*  member_id,
		*  member_pw,
		*  member_level,
		*  member_name,
		*  member_age,
		*  member_gender,
		*  update_date,
		*  create_date
		* ) VALUES (
		* ?, PASSWORD(?), 0, ?, ?, NOW(), NOW()
		* )
		*/
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			System.out.println(conn + "<-- conn");
			String sql = "INSERT INTO member(member_id, member_pw, member_level, member_name, member_age, member_gender, update_date, create_date) VALUES (?,PASSWORD(?),0,?,?,?,NOW(),NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, member.getMemberId());
			stmt.setString(2, member.getMemberPw());
			stmt.setString(3, member.getMemberName());
			stmt.setInt(4, member.getMemberAge());
			stmt.setString(5, member.getMemberGender());
			// 디버깅 코드 : 쿼리내용과 표현식의 파라미터값 확인가능
			System.out.println(stmt + "<--- stmt");
			stmt.executeUpdate();
			
			stmt.close();
			conn.close();
	}
	public Member login(Member member) throws ClassNotFoundException, SQLException {
		Member returnMember = null;
		// 디버깅
		System.out.println(member.getMemberId() + "<-MemberId");
		System.out.println(member.getMemberPw() + "<-MemberPw");
		/*
		 * SELECT
		 *  member_no memberNo,
		 *  member_id memberId,
		 *  member_level memberLevel
		 * FROM
		 *  member
		 * WHERE member_id=? AND member_pw=PASSWORD(?)
		 */
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		
		// 디버깅 코드 : 쿼리내용과 표현식의 파라미터값 확인가능
		System.out.println(stmt + "<-- stmt");
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			returnMember = new Member();
			returnMember.setMemberNo(Integer.parseInt(rs.getString("memberNo")));
			returnMember.setMemberId(rs.getString("memberId"));
			returnMember.setMemberLevel(Integer.parseInt(rs.getString("memberLevel")));
		}
			rs.close();
			stmt.close();
			conn.close();
			
			return returnMember;
		
	}
}
