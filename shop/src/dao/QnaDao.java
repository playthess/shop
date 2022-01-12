package dao;

import vo.*;

import commons.DBUtil;

import java.sql.*;
import java.util.*;

public class QnaDao {
	public void deleteQnaList(int qnaNo) throws ClassNotFoundException, SQLException {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM qna WHERE qna_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		stmt.executeQuery();
		
		System.out.println(conn +"<-----conn");
		System.out.println(stmt +"<-----conn");
		stmt.close();
		conn.close();
	}
	// Q&A 등록하기
		public static void insertQna(Qna qna) throws ClassNotFoundException, SQLException {
			System.out.println(qna.getQnaCategory() + " <--qnaCategory");
			System.out.println(qna.getQnaTitle() + " <--qnaTitle");
			System.out.println(qna.getQnaContent() + " <--qnaContent");
			System.out.println(qna.getQnaSecret() + " <--qnaSecret");
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "INSERT INTO qna(qna_category, qna_title, qna_content, qna_secret, member_no, create_date, update_date) VALUES (?, ?, ?, ?, 1, NOW(), NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, qna.getQnaCategory());
			stmt.setString(2, qna.getQnaTitle());
			stmt.setString(3, qna.getQnaContent());
			stmt.setString(4, qna.getQnaSecret());
			
			System.out.println(stmt + " <--stmt");
			ResultSet rs = stmt.executeQuery();
				System.out.println("입력완료");
			stmt.close();
			conn.close();
			rs.close();
		}
		
		// Q&A 수정
		public void updateQna(Qna qna) throws ClassNotFoundException, SQLException {
			System.out.println(qna.getQnaNo() + " <-- QnaNo");
			System.out.println(qna.getQnaCategory() + " <--qnaCategory");
			System.out.println(qna.getQnaTitle() + " <--qnaTitle");
			System.out.println(qna.getQnaContent() + " <--qnaContent");
			System.out.println(qna.getQnaSecret() + " <--qnaSecret");
		
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "UPDATE qna SET qna_category=?, qna_title, qna_content=? qna_secret=? WHERE qna_no=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, qna.getQnaCategory());
			stmt.setString(2, qna.getQnaTitle());
			stmt.setString(3, qna.getQnaContent());
			stmt.setString(4, qna.getQnaSecret());
			stmt.setInt(5, qna.getQnaNo());
			
			ResultSet rs = stmt.executeQuery();
				System.out.println("입력완료");
				System.out.println(stmt + " <--stmt");
			stmt.close();
			conn.close();
			rs.close();
		}

	//댓글 없는 Q&A게시판 리스트(글제목검색)
	/*
	public ArrayList<QnaMemberComment> selectQnaNoComment() throws ClassNotFoundException, SQLException {
		ArrayList<QnaMemberComment> list = new ArrayList<QnaMemberComment>();

		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "SELECT q.*, qc.* FROM qna q LEFT JOIN qna_comment qc ON q.qna_no = qc.qna_no WHERE qc.qna_no IS NULL;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		// 리스트에 값 넣기
		while (rs.next()) {
			
			QnaMemberComment qmc = new QnaMemberComment();
			
			Qna q = new Qna();
			q.setQnaNo(rs.getInt("qnaNo"));
			q.setQnaCategory(rs.getString("qnaCategory"));
			q.setQnaTitle(rs.getString("qnaTitle"));
			q.setQnaContent(rs.getString("qnaContent"));
			q.setQnaSecret(rs.getString("qnaSecret"));
			q.setMemberNo(rs.getInt("memberNo"));
			q.setCreateDate(rs.getString("createDate"));
			q.setUpdateDate(rs.getString("updateDate"));
			qmc.setQna(q);
			
			Member m = new Member();
			m.setMemberId(rs.getString("memberId"));
			m.setMemberName(rs.getString("memberName"));
			qmc.setMember(m);
			
			QnaComment c = new QnaComment();
			c.setQnaCommentContent(rs.getString("qnaCommentContent"));
			qmc.setComment(c);
			
			list.add(qmc);
		}
		// 접속 종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return list;
	}
	*/
	// [관리자] Q&A게시판 리스트(글제목검색)
	public ArrayList<QnaMemberComment> selectQnaListAllBySearchQnaTitle(int beginRow, int rowPerPage, String SearchQnaTitle) throws ClassNotFoundException, SQLException {
		ArrayList<QnaMemberComment> list = new ArrayList<QnaMemberComment>();
		System.out.println(beginRow + " <- beinRow");
		System.out.println(rowPerPage + " <- rowPerPage");
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "SELECT q.qna_no qnaNo, q.qna_category qnaCategory, q.qna_title qnaTitle, q.qna_content qnaContent, m.member_id MemberId, m.member_name MemberName, q.qna_secret qnaSecret, q.member_no memberNo, q.create_date createDate, q.update_date updateDate FROM qna q INNER JOIN member m ON q.member_no = m.member_no WHERE q.qna_title LIKE ? ORDER BY q.create_date DESC limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + SearchQnaTitle + "%");
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		// 리스트에 값 넣기
		while (rs.next()) {
			QnaMemberComment qm = new QnaMemberComment();
			
			Qna q = new Qna();
			q.setQnaNo(rs.getInt("qnaNo"));
			q.setQnaCategory(rs.getString("qnaCategory"));
			q.setQnaTitle(rs.getString("qnaTitle"));
			q.setQnaContent(rs.getString("qnaContent"));
			q.setQnaSecret(rs.getString("qnaSecret"));
			q.setMemberNo(rs.getInt("memberNo"));
			q.setCreateDate(rs.getString("createDate"));
			q.setUpdateDate(rs.getString("updateDate"));
			qm.setQna(q);
				
			Member m = new Member();
			m.setMemberId(rs.getString("memberId"));
			m.setMemberName(rs.getString("memberName"));
			qm.setMember(m);
			
			list.add(qm);
		}
		// 접속 종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return list;
		
	}
	// [관리자] Q&A게시판 리스트(글제목검색)
	public ArrayList<QnaMemberComment> selectQnaListAllByPage(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<QnaMemberComment> list = new ArrayList<QnaMemberComment>();
		System.out.println(beginRow + " <- beinRow");
		System.out.println(rowPerPage + " <- rowPerPage");
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "SELECT q.qna_no qnaNo, q.qna_category qnaCategory, q.qna_title qnaTitle, q.qna_content qnaContent, m.member_id MemberId, m.member_name MemberName, q.qna_secret qnaSecret, q.member_no memberNo, q.create_date createDate, q.update_date updateDate FROM qna q INNER JOIN member m ON q.member_no = m.member_no ORDER BY q.create_date DESC limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		// 리스트에 값 넣기
		while (rs.next()) {
			QnaMemberComment qmc = new QnaMemberComment();
				
			Qna q = new Qna();
			q.setQnaNo(rs.getInt("qnaNo"));
			q.setQnaCategory(rs.getString("qnaCategory"));
			q.setQnaTitle(rs.getString("qnaTitle"));
			q.setQnaContent(rs.getString("qnaContent"));
			q.setQnaSecret(rs.getString("qnaSecret"));
			q.setMemberNo(rs.getInt("memberNo"));
			q.setCreateDate(rs.getString("createDate"));
			q.setUpdateDate(rs.getString("updateDate"));
			qmc.setQna(q);
					
			Member m = new Member();
			m.setMemberId(rs.getString("memberId"));
			m.setMemberName(rs.getString("memberName"));
			qmc.setMember(m);
				
			list.add(qmc);
		}
		// 접속 종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return list;
	}
	// 총 Q&A 갯수
	public int totalQnaCount() throws ClassNotFoundException, SQLException {
		int totalCount = 0;
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리생성, 실행
		String sql = "SELECT count(*) FROM qna";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			totalCount = rs.getInt("count(*)");
		}
			return totalCount;
	}
	
	// Q&A 상세보기
	public Qna selectQnaOne(int qnaNo) throws ClassNotFoundException, SQLException {
		// 디버깅
		System.out.println(qnaNo + " <- qnaNo");
		
		Qna qna = null;
		// DB접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT q.qna_no qnaNo, q.qna_category qnaCategory, q.qna_title qnaTitle, q.qna_content qnaContent, m.member_id MemberId, m.member_name MemberName, q.qna_secret qnaSecret, q.member_no memberNo, q.create_date createDate, q.update_date updateDate FROM qna q INNER JOIN member m ON q.member_no = m.member_no WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		ResultSet rs= stmt.executeQuery();
		if(rs.next()) { 
			qna = new Qna();
			qna.setQnaNo(rs.getInt("qnaNo"));
			qna.setQnaCategory(rs.getString("qnaCategory"));
			qna.setQnaTitle(rs.getString("qnaTitle"));
			qna.setQnaContent(rs.getString("qnaContent"));
			qna.setQnaSecret(rs.getString("qnaSecret"));
			qna.setMemberNo(rs.getInt("memberNo"));
			qna.setCreateDate(rs.getString("createDate"));
			qna.setUpdateDate(rs.getString("updateDate"));
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return qna;
	}
}
