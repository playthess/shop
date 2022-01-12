package dao;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.*;

public class QnaCommentDao {
	//등록하기
	public void insertComment(QnaComment qnacomment) throws ClassNotFoundException, SQLException {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql ="INSERT INTO qna_comment(qna_comment_content, member_no, create_date, update_date) VALUES (?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,qnacomment.getQnaCommentContent());
		stmt.setInt(2, qnacomment.getMemberNo());
		//디버깅 
		System.out.println(conn +"<--stmt");
		System.out.println(stmt +"<--stmt");
		
		stmt.executeQuery();
		//접속종료 
		stmt.close();
		conn.close();
	}
	//댓글 보기
	public ArrayList<QnaComment> selectQnaCommentList(int beginRow, int rowPerPage, int qnaNo) throws ClassNotFoundException, SQLException{
		ArrayList<QnaComment> list = new ArrayList<QnaComment>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT qna_comment_content qnaCommentContent, create_date createDate, update_date updateDate FROM qna_comment WHERE qna_no=? ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		
		// 디버깅 코드 : 쿼리내용과 표현식의 파라미터값 확인가능
		System.out.println(stmt + "<-- stmt");
		
		// 데이터 가공 (자료구조화)
		// ResultSet이라는 특수한 타입에서 ArrayList라는 일반화된 타입으로 변환(가공)
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			// 객체 생성 후 저장
			QnaComment qnaComment = new QnaComment();
			
			qnaComment.setQnaCommentContent(rs.getString("qnaCommentContent"));
			qnaComment.setCreateDate (rs.getString("createDate"));
			qnaComment.setUpdateDate (rs.getString("updateDate"));
			list.add(qnaComment);
		}
		// 종료
		rs.close();
		stmt.close();
		conn.close();
				
		//list를 return
		return list;
	}
}
