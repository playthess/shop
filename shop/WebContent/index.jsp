<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
</head>
<body>
<div>
	<!-- submenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- submenu 인클루드 끝 -->
	<div>
	<h1>index</h1>
		<!-- 로그인 작업 -->
			<%
				if(session.getAttribute("loginMember") == null) {
			%>
					<div><a href="<%=request.getContextPath() %>/loginForm.jsp" class="btn btn-outline-dark">로그인</a></div>
					<div><a href="<%=request.getContextPath() %>/insertMemberForm.jsp" class="btn btn-outline-dark">회원가입</a></div>
					<div><a href="<%=request.getContextPath() %>/noticeForm.jsp" class="btn btn-outline-dark">공지사항</a></div>
			<%		
				} else {
					Member loginMember = (Member)session.getAttribute("loginMember");
			%>
				<!-- 로그인 후-->
				<div>
					<%=loginMember.getMemberId()%>님 반갑습니다.
					<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
					<a href="<%=request.getContextPath()%>">회원정보</a>
					<a href="<%=request.getContextPath()%>/selectOrderListByMember.jsp">나의주문</a>
				</div>
				
				<!-- 관리자 페이지로 가는 링크 -->
			<%
					if(loginMember.getMemberLevel() > 0) {
			%>
						<div><a href="<%=request.getContextPath()%>/admin/adminIndex.jsp">관리자 페이지</a></div>
			<%
					}
				}
			%>
	</div>
	<!-- 상품 목록 -->
	<%
		// 페이징
		int currentPage = 1;
		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
		int beginRow = (currentPage - 1) * ROW_PER_PAGE;
	
		// 전체 목록
		EbookDao ebookDao = new EbookDao();
		
		ArrayList<Ebook> ebookList = ebookDao.selectEbookList(beginRow, ROW_PER_PAGE);
		
		// 인기 목록 5개(많이 주문된 5개의 ebook)
		ArrayList<Ebook> popularEbookList = ebookDao.selectPopularEbookList();
		// 신상품 목록 5개
		ArrayList<Ebook> createEbookList = ebookDao.selectCreateEbookList();
		NoticeDao noticeDao = new NoticeDao();
		// 최근 공지사항 5개
		ArrayList<Notice> createNoticeList = noticeDao.selectCreateEbookList();
	%>
	<h2>공지사항</h2>
	<div>
		<table border="1">
			<%
				for(Notice n: createNoticeList) {
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
						<td><%=n.getNoticeNo() %></td>
						<td>
							<a href="<%=request.getContextPath() %>/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo() %>"><%=n.getNoticeTitle() %></a>
						</td>
						<td><%=n.getMemberNo() %></td>
						<td><%=n.getUpdateDate() %></td>
						<td><%=n.getCreateDate() %></td>
					</tr>
				</tbody>
			<% 
				}
			%>
		</table>
	
	</div>
	
	<h2>신상품 목록</h2>
	<div>
		<table border="1">
		<tr>
			<%
				for(Ebook e: createEbookList) {
			%>
					<td>
						<div>
							<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>">
								<img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200">
							</a>
						</div>
						<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></div>
						<div>₩ <%=e.getEbookPrice()%></div>
					</td>
			<%
				}
			%>
		</tr>
	</table>
	</div>
	
	<h2>인기 상품 목록</h2>
	<table border="1">
		<tr>
			<%
				for(Ebook e: popularEbookList) {
			%>
					<td>
						<div>
							<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>">
								<img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200">
							</a>
						</div>
						<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></div>
						<div>₩ <%=e.getEbookPrice()%></div>
					</td>
			<%
				}
			%>
		</tr>
	</table>
	
	<h2>전체 상품 목록</h2>
	<table border="1">
		<tr>
			<%
				int i = 0;
				for(Ebook e : ebookList) {
			%>	
					<td>
						<div>
							<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200"></a>
						</div>
						<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></div>
						<div>₩ <%=e.getEbookPrice()%></div>
					</td>	
			<%
					i+=1; // i=i+1; i++; for문 끝날때마다 i는 1씩 증가
					if(i%5 == 0) {
			%>
						</tr><tr><!-- 줄바꿈 -->
			<%			
					}
				}
			%>
		</tr>
	</table>
	<div>copyright goodee GDJ40</div>
</div>
</body>
</html>