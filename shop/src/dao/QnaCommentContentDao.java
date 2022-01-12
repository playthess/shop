package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import commons.DBUtil;
import vo.QnaComment;

public class QnaCommentContentDao {

	//[관리자 Qna 질문 답변]
		public void insertCommentAnswer(QnaComment qnacomment) throws ClassNotFoundException, SQLException {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql ="INSERT INTO qna_comment_content(qna_no, qna_comment_content, member_no ,create_date, update_date) VALUES(?,?,?,NOW(),NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, qnacomment.getQnaNo());
			stmt.setString(2, qnacomment.getQnaCommentContent());
			stmt.setInt(3, qnacomment.getMemberNo());
			
			//디버깅 
			System.out.println(conn +"<-----stmt");
			System.out.println(stmt +"<-----stmt");
			stmt.executeQuery();
			
			//접속종료 
			stmt.close();
			conn.close();
			
		}
	
}
