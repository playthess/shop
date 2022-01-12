<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");

	// 로그인 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	// 로그인 멤버값이 없거나 memberLevel이 1미만(일반 사용자)일때는 접근 불가. 
	// 순서를 바꾸면안됨(바꾸면 null포인트 인셉션이 일어남).
	if(loginMember==null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	int memberNo =Integer.parseInt(request.getParameter("memberNo"));
	QnaDao qnaDao = new QnaDao();
	Qna qna = qnaDao.selectQnaOne(qnaNo);
	
	Member member = new Member();
	MemberDao memberDao = new MemberDao();
	
	member = memberDao.selectMemberOne(memberNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A상세보기</title>
</head>
	<!-- submenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- submenu 인클루드 끝 -->
<body>
	<table border="1">
		<tr>
			<td>글번호</td>
			<td><%=qnaNo %></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><%=qna.getQnaTitle() %></td>
		</tr>
		<tr>
			<td>내용</td>
			<td width="600" height="400"><%=qna.getQnaContent() %></td>
		</tr>
		<tr>
			<td style="text-align:center;" colspan="3">
				댓글
			</td>
		</tr>
		<tr>
		</tr>
	</table>

</body>
</html>