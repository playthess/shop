<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>    
<!DOCTYPE html>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");

	//insertCommentAnswe에서 값가져오기 
	
  	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
  	String qnaCommentContent = request.getParameter("qnaCommentContent ");
  	//디버깅
  	
  	System.out.println(memberNo+"<--memberNo");
  	System.out.println(qnaCommentContent +"<--qnaCommentContent");
  	
  	//null 값 방어 코드 
  	if(request.getParameter("memberNo") == null ||  request.getParameter("qnaCommentContent") == null) {
  		response.sendRedirect(request.getContextPath()+"/admin/insertCommentAnswer.jsp");
  		return;
  	}
  	
  	//방어코드 
  	if(request.getParameter("memberNo").equals("") || request.getParameter("qnaCommentContent").equals("")) {
  		response.sendRedirect(request.getContextPath()+"/admin/insertCommentAnswer.jsp");
  		return;
  		}
  	//로그인된 레벨이 1보다 작은면 접속 불가 
  	Member loginMember = (Member)session.getAttribute("loginMember");
  	if(loginMember == null || loginMember.getMemberLevel() >= 1){
		response.sendRedirect(request.getContextPath()+"/insertCommentAnswer.jsp");
		return;
	}
  	
  	//객체 생성 
  	QnaCommentContentDao qnacontentDao = new QnaCommentContentDao();
  	QnaComment q = new QnaComment(); 
  	q.setQnaCommentContent(qnaCommentContent);
  	q.setMemberNo(memberNo);
  	
  	qnacontentDao.insertCommentAnswer(q);
  	// 답변이 없으면 index.jsp로 갈수 있게 설정 
  	response.sendRedirect(request.getContextPath() + "/index.jsp");
  	
%>