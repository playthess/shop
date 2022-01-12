<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
		// 인코딩 
		request.setCharacterEncoding("utf-8");
		// 로그인이 안되어있으면 댓글 작성 불가 
		 Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember == null) {
			response.sendRedirect(request.getContextPath()+"/index.jsp");
			return;
		}
		if(request.getParameter("memberNo") == null || request.getParameter("qnaComment") == null ){
			response.sendRedirect(request.getContextPath()+"/selectQnaOne");	
			return;
		}
		//방어코드 
		if(request.getParameter("memberNo").equals("") || request.getParameter("qnaComment").equals("")){
			response.sendRedirect(request.getContextPath()+"/selectQnaOne");	
			return;
		}	
		
	//값 가져오기 
	int memberNo  = Integer.parseInt(request.getParameter("memberNo"));
	String qnaComment = request.getParameter("qnaComment");
	
	//디버깅 
	System.out.println(memberNo +"<--memberNo");
	System.out.println(qnaComment +"<--qnaComment");

	//가져온 값을 넣어줄 객체 생성 
	QnaComment qnacomment = new QnaComment();
	qnacomment.setMemberNo(memberNo);
	qnacomment.setQnaCommentContent(qnaComment);
	
	//객체 생성 
	QnaCommentDao qnaCommentDao = new QnaCommentDao();
	qnaCommentDao.insertComment(qnacomment);

	response.sendRedirect(request.getContextPath() + "/index.jsp");
	
	
%>