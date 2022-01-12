<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>    
<!DOCTYPE html>
<%
	//한글 인코딩
	request.setCharacterEncoding("utf-8");
	//방어 코드 
	if(request.getParameter("qnaCategory") == null || request.getParameter("qnaTitle") == null || request.getParameter("qnaContent") == null || request.getParameter("qnaSecret") == null || request.getParameter("memberNo") == null) {
	response.sendRedirect(request.getContextPath()+"/admin/updateQnaForm.jsp");
	return;
	}
	if(request.getParameter("qnaCategory").equals("") || request.getParameter("qnaTitle").equals("") || request.getParameter("qnaContent").equals("") || request.getParameter("qnaSecret").equals("") || request.getParameter("memberNo").equals("")) {
	response.sendRedirect(request.getContextPath()+"/admin/updateQnaForm.jsp");
	return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 0){
		response.sendRedirect(request.getContextPath()+"/updateQnaForm.jsp");
		return;
	}
	
	//값 가져오기 
	String qnaCategory = request.getParameter("qnaCategory");
	String qnaTitle = request.getParameter("qnaTitle");
	String qnaContent = request.getParameter("qnaContent");
	String qnaSecret = request.getParameter("qnaSecret");
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	
	//디버깅 
	System.out.println(qnaCategory+"<----qnaCategory");
	System.out.println(qnaTitle+"<----qnaTitle");
	System.out.println(qnaContent+"<----qnaContent");
	System.out.println(qnaSecret+"<----qndSecret");
	System.out.println(memberNo+"<----memberNo");
	System.out.println(qnaNo+"<----qnaNo");
	
	QnaDao qnaDao = new QnaDao();
	
	Qna qna = null;
	qna = new Qna();
	
	qna.setQnaCategory(qnaCategory);
	qna.setQnaTitle(qnaTitle);
	qna.setQnaContent(qnaContent);
	qna.setQnaSecret(qnaSecret);
	qna.setQnaNo(qnaNo);
	
	
	qnaDao.updateQna(qna);
	
	System.out.println("수정 성공");
	response.sendRedirect(request.getContextPath() + "/index.jsp");
%>