<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<%@ page import = "vo.*"%>
<%@ page import = "java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	//로그인시 접근불가(로그인상태와 회원가입정보가 null일때 접근 불가)
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){//로그인이 된 상태(로그인멤버값이 null인 상태)
		//브라우저에게 다른곳을 '요청'(위치로 보내는 것(go)이 아닌(보내주는 것이 아니라 간 것) 해당 위치로 내보내는(rollback) 것(쫒아내는 것,되돌리는 것))
		response.sendRedirect(request.getContextPath()+"/index.jsp");	//로그인이 된 상태니 인덱스로
		return;
		}
		
		String qnaCategory = request.getParameter("qnaCategory");
		String qnaTitle = request.getParameter("qnaTitle");
		String qnaContent = request.getParameter("qnaContent");
		String qnaSecret = request.getParameter("qnaSecret");
		
		//디버깅 request매게값 디버깅코드
		System.out.println("qnaCategory :"+qnaCategory);
		System.out.println("qnaTitle :"+qnaTitle);
		System.out.println("qnaContent :"+qnaContent);
		System.out.println("qnaSecret :"+qnaSecret);
		
		Qna qna = new Qna();
		qna.setQnaCategory(qnaCategory);
		qna.setQnaTitle(qnaTitle);
		qna.setQnaContent(qnaContent);
		qna.setQnaSecret(qnaSecret);
		
		QnaDao qnaDao = new QnaDao();
		
		QnaDao.insertQna(qna);
		
		response.sendRedirect(request.getContextPath()+"/index.jsp");

%>
