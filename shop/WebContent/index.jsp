<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
  <!-- https://www.w3schools.com/ 부트스트랩 적용 -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- submenu 인클루드(include) 시작 -->
	<div class="container-fluid">
	<!-- 배너 -->
	<jsp:include page="/partial/banner.jsp"></jsp:include>
		<!-- start : mainMenu include -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	</div>
	<!-- submenu 인클루드 끝 -->
	<div>
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
	<div class="container-fluid" style="text-align: center">
		<br>
		<h1>공지사항</h1>
		<br>
		<table class="table">
		<%
		for(Notice n : createNoticeList)	{
		%>
			<tr>		
				<td>
					<div><a href="<%=request.getContextPath()%>/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle() %></a></div>
				</td>
				
			</tr>
		<%
		}
		%>
		</table>
	</div>
	
	<!-- 신간도서 5개 출력 -->
	<div class="container-fluid" style="text-align: center">
		<br>
		<h1>신간도서</h1>
		<br>
		<table class="table">
			<tr>
				<%
				for(Ebook e : createEbookList)	{
				%>
				<td>
					<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath() %>/image/<%=e.getEbookImg() %>" width="170" height="200"></a></div>
					<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle() %></a></div>
					<div>₩ <%=e.getEbookPrice() %></div>
				</td>
				<%
				}
				%>
			</tr>
		</table>
	</div>
	
	<!-- 베스트셀러 5개 출력 -->
	<div class="container-fluid" style="text-align: center">
		<br>
		<h1>베스트셀러</h1>
		<br>
		<table class="table">
			<tr>
				<%
				for(Ebook e : popularEbookList)	{
				%>
				<td>
					<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath() %>/image/<%=e.getEbookImg() %>" width="170" height="200"></a></div>
					<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle() %></a></div>
					<div>₩ <%=e.getEbookPrice() %></div>
				</td>
				<%
				}
				%>
			</tr>
		</table>
	</div>
	
	<div class="container-fluid" style="text-align: center">
	<br>
	<h2>전체 상품 목록</h2>
	<br>
	<table class="table">
			<tr>
			<%
				int b = 0;
				for(Ebook e : ebookList){
			%>
					
						<td>
							<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath() %>/image/<%=e.getEbookImg() %>" width="170" height="200"></a></div>
							<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle() %></a></div>
							<div>₩ <%=e.getEbookPrice() %></div>
						</td>
					
			<%
					b= b+1;
					if(b%5 == 0){
			%>
					</tr><tr>
			<%			
					}
				}
			%>
			</tr>
		</table>
	</div>
	<div>copyright goodee GDJ40</div>
</div>
</body>
</html>