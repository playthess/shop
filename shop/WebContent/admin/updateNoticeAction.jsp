<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 한글 인코딩
	request.setCharacterEncoding("utf-8");

	//관리자 로그인 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	// 로그인 멤버값이 없거나 memberLevel이 1미만(일반 사용자)일때는 접근 불가. 
	// 순서를 바꾸면안됨(바꾸면 null포인트 인셉션이 일어남).
	if(loginMember==null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	Notice notice = null;
	notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	NoticeDao noticeDao = new NoticeDao();
	
	noticeDao.updateNotice(notice);
	response.sendRedirect(request.getContextPath() + "/admin/selectNoticeList.jsp");
%>

