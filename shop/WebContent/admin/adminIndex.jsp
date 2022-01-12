<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} 
	NoticeDao noticeDao = new NoticeDao();
	QnaDao qnaDao = new QnaDao();
	// 최근 공지사항 5개
	ArrayList<Notice> createNoticeList = noticeDao.selectCreateEbookList();
	// 댓글없는 Q&A 게시판 리스트
	//ArrayList<QnaMemberComment> NoCommentQnaList = qnaDao.selectQnaNoComment(); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 관리자 메뉴 include -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<h1>관리자페이지</h1>
	<div><%=loginMember.getMemberId()%>님 반갑습니다.</div>
	<a href="<%=request.getContextPath()%>/index.jsp">메인페이지</a>
	<h2>공지사항</h2>
	<div>
		<table border="1">
			<%
				for(Notice n : createNoticeList) {
			%>		
				<thead>
					<tr>
						<th>공지사항 번호</th>
						<th>공지사항 제목</th>
						<th>memberNo</th>
						<th>createDate</th>
						<th>updateDate</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="text-align:right;"><%=n.getNoticeNo() %></td>
						<td style="text-align:center;">
							<a href="<%=request.getContextPath() %>/admin/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo() %>"><%=n.getNoticeTitle() %></a>
						</td>
						<td style="text-align:center;"><%=n.getMemberNo() %></td>
						<td><%=n.getUpdateDate() %></td>
						<td><%=n.getCreateDate() %></td>
					</tr>
				</tbody>
			<%
				}
			%>
		</table>
	</div>
</body>
</html>