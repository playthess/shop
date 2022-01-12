<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));

	NoticeDao noticeDao = new NoticeDao();
	Notice notice = noticeDao.selectNoticeOne(noticeNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세보기</title>
</head>
<body>
	<!-- submenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- submenu 인클루드 끝 -->
	<h1>공지사항</h1>
	<table border="1">
		<tr>
			<td>제목</td>
			<td><%=notice.getNoticeTitle() %></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><%=notice.getNoticeContent() %></td>
		</tr>
	</table>
</body>
</html>