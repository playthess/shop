<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} 
	
	NoticeDao noticeDao = new NoticeDao();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지작성</title>
</head>
<body>
	<!-- submenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- submenu 인클루드 끝 -->
	<h1>공지사항 작성</h1>
	<form method="post" action="<%=request.getContextPath() %>/admin/insertNoticeAction.jsp">
		<table border="1">
			<tr>
				<td>제목</td>
				<td>
					<input type="text" style="border:none" id="noticeTitle" name="noticeTitle">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea id="noticeContent" name = "noticeContent" rows=20 cols=100></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">등록</button>
	</form>
</body>
</html>






