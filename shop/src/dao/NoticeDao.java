package dao;

import vo.*;
import commons.DBUtil;
import java.sql.*;
import java.util.*;

public class NoticeDao {
	// 공지사항 총개수
	public int totalNoticeCount() throws ClassNotFoundException, SQLException {
		int totalCount = 0;
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리생성, 실행
		String sql = "SELECT count(*) FROM notice";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			totalCount = rs.getInt("count(*)");
			}
			return totalCount;
		}
	
	// 최근에 올라온 5개 공지사항 리스트
	public ArrayList<Notice> selectCreateEbookList() throws ClassNotFoundException, SQLException {
		// list라는 리스트를 사용하기 위해 생성
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		// DB 실행
		// dbUtil 객체 생성
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, member_no memberNo, create_date createDate, update_date updateDate FROM notice ORDER BY create_date DESC LIMIT 0,5";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// 디버깅 코드 : 쿼리내용과 표현식의 파라미터값 확인가능
		System.out.println(stmt + " <- stmt");
		
		// 데이터 가공
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			// Notice 객체 생성 후 저장
			Notice notice = new Notice();
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeTitle(rs.getString("noticeTitle"));
			notice.setNoticeContent(rs.getString("noticeContent"));
			notice.setMemberNo(rs.getInt("memberNo"));
			notice.setCreateDate(rs.getString("createDate"));
			notice.setUpdateDate(rs.getString("updateDate"));
			list.add(notice);
		}
		// 종료
		rs.close();
		stmt.close();
		conn.close();
				
		//list를 return
		return list;
	}
	
	// 공지사항 상세보기
	public Notice selectNoticeOne(int noticeNo) throws ClassNotFoundException, SQLException {
		// 디버깅
		System.out.println(noticeNo + " <-- noticeNo");
		Notice notice = null;
		// DB 실행
		// dbUtil 객체 생성
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, member_no memberNo, create_date createDate, update_date updateDate FROM notice WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// 디버깅 코드 : 쿼리내용과 표현식의 파라미터값 확인가능
		System.out.println(stmt + " <-- stmt");
		stmt.setInt(1, noticeNo);
		// 데이터 가공
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			// Notice 객체 생성 후 저장
			notice = new Notice();
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeTitle(rs.getString("noticeTitle"));
			notice.setNoticeContent(rs.getString("noticeContent"));
			notice.setMemberNo(rs.getInt("memberNo"));
			notice.setCreateDate(rs.getString("createDate"));
			notice.setUpdateDate(rs.getString("updateDate"));
		}
		// 종료
		rs.close();
		stmt.close();
		conn.close();
				
		//list를 return
		return notice;
	}
	
	// [관리자] 공지사항 리스트 관리(공지제목 출력)
		public ArrayList<Notice> selectNoticeListAllBySearchNoticeTitle(int beginRow, int rowPerPage, String searchNoticeTitle)
				throws ClassNotFoundException, SQLException {
			ArrayList<Notice> list = new ArrayList<Notice>();
			System.out.println(beginRow + "<--beinRow");
			System.out.println(rowPerPage + "<--rowPerPage");

			// db접속 메소드 호출
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			// 쿼리 생성 및 실행
			String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, member_no memberNo, create_date createDate, update_date updateDate FROM notice WHERE member_title LIKE ? ORDER BY create_date DESC LIMIT ?,?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + searchNoticeTitle + "%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			ResultSet rs = stmt.executeQuery();
			// 리스트에 값 넣기
			while (rs.next()) {
				Notice notice = new Notice();
				notice.setNoticeNo(rs.getInt("noticeNo"));
				notice.setNoticeTitle(rs.getString("noticeTitle"));
				notice.setNoticeContent(rs.getString("noticeContent"));
				notice.setMemberNo(rs.getInt("memberNo"));
				notice.setCreateDate(rs.getString("updateDate"));
				notice.setUpdateDate(rs.getString("createDate"));
				list.add(notice);
			}
			// 접속 종료
			rs.close();
			stmt.close();
			conn.close();
			// 값 리턴
			return list;
		}
		
		//[관리자] 공지사항 리스트 관리
		public ArrayList<Notice> selectNoticeListAllByPage(int beginRow,int rowPerPage) throws ClassNotFoundException, SQLException {
			ArrayList<Notice> list = new ArrayList<Notice>();
			System.out.println(beginRow + " <- beinRow");
			System.out.println(rowPerPage + " <- rowPerPage");
				
			// db접속 메소드 호출
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			// 쿼리 생성 및 실행
			String sql = "SELECT n.notice_no noticeNo, n.notice_title noticeTitle, n.notice_content noticeContent, n.member_no memberNo, n.create_date createDate, n.update_date updateDate, m.member_id MemberId, m.member_name MemberName FROM notice n INNER JOIN member m ON n.member_no = m.member_no ORDER BY n.create_date DESC LIMIT ?,?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			ResultSet rs = stmt.executeQuery();
			// 리스트에 값 넣기
			while (rs.next()) {
				Notice notice = new Notice();
				notice.setNoticeNo(rs.getInt("noticeNo"));
				notice.setNoticeTitle(rs.getString("noticeTitle"));
				notice.setNoticeContent(rs.getString("noticeContent"));
				notice.setMemberNo(rs.getInt("memberNo"));
				notice.setCreateDate(rs.getString("createDate"));
				notice.setUpdateDate(rs.getString("updateDate"));
				list.add(notice);
			}
			// 접속 종료
			rs.close();
			stmt.close();
			conn.close();
			return list;
		}
		
		//[관리자] 공지사항 작성 (공지사항 제목, 내용)
		public void insertNotice(Notice notice) throws ClassNotFoundException, SQLException {
			System.out.println(notice.getNoticeTitle() + " <--noticeTitle");
			System.out.println(notice.getNoticeContent() + " <--noticeContent");
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "INSERT INTO notice(notice_title, notice_content, member_no, create_date, update_date) VALUES (?, ?, 1, NOW(), NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeTitle());
			stmt.setString(2, notice.getNoticeContent());
			System.out.println(stmt + " <--stmt");
			int row = stmt.executeUpdate();
			if (row == 1) {
				System.out.println("입력완료");
			}
			stmt.close();
			conn.close();
		}
		
		//[관리자] 공지사항 수정 (공지사항 넘버가져오기, 제목, 내용)
		public void updateNotice(Notice notice) throws ClassNotFoundException, SQLException {
			System.out.println(notice.getNoticeNo() + " <-- NoticeNo");
			System.out.println(notice.getNoticeTitle() + " <-- NoticeTitle");
			System.out.println(notice.getNoticeContent() + " <--NoticeContent");
		
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "UPDATE notice SET notice_title=?, notice_content=? WHERE notice_no=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeTitle());
			stmt.setString(2, notice.getNoticeContent());
			stmt.setInt(3, notice.getNoticeNo());
			ResultSet rs = stmt.executeQuery();
			//디버깅
			System.out.println(stmt + " <-- update.stmt");
			System.out.println(rs + "<-- update.rs");
			rs.close();
			stmt.close();
			conn.close();
		}
		
		//[관리자] 공지사항 삭제
		public void deleteNotice(int noticeNo) throws ClassNotFoundException, SQLException {
			// 디버깅
			System.out.println(noticeNo + " <-- noticeNo");
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "DELETE FROM notice WHERE notice_no=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			ResultSet rs = stmt.executeQuery();
			
			// 디버깅
			System.out.println(stmt + " <-- delete.stmt");
			System.out.println(rs + " <-- delete.rs");
			
			rs.close();
			stmt.close();
			conn.close();
		}
}
