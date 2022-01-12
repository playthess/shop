<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%

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

	NoticeDao noticeDao = new NoticeDao();
	Notice notice = noticeDao.selectNoticeOne(noticeNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
</head>
<body>
	<!-- submenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- submenu 인클루드 끝 -->
	<h1>공지사항</h1>
	<form method="post" action="<%=request.getContextPath()%>/admin/updateNoticeAction.jsp">
		<table border="1">
			<tr>
				<td>글번호</td>
				<td><input type="text" style="border:none" id="noticeNo" name="noticeNo" value="<%=notice.getNoticeNo() %>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" style="border:none" name="noticeTitle" value="<%=notice.getNoticeTitle() %>"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td width="600" height="400">
					<textarea rows="20" cols="100" style="resize: none; border:none;" name="noticeContent"><%=notice.getNoticeContent() %></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>