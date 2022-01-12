<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));

	//디버깅
	System.out.println(qnaNo+"<-----qnaNo 삭제 완료");
	
	//방어코드
	if(request.getParameter("qnaNo") == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	
	QnaDao qnaDao = new QnaDao();
	qnaDao.deleteQnaList(qnaNo);
	
	response.sendRedirect(request.getContextPath() + "/index.jsp");
%>