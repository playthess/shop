<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 한글인코딩
	request.setCharacterEncoding("utf-8");

	// 관리자 로그인 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	// 로그인 멤버값이 없거나 memberLevel이 1미만(일반 사용자)일때는 접근 불가. 
	// 순서를 바꾸면안됨(바꾸면 null포인트 인셉션이 일어남).
	if(loginMember==null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	//검색어
	String searchNoticeTitle = "";
	if(request.getParameter("searchNoticeTitle")!=null){
		searchNoticeTitle = request.getParameter("searchNoticeTitle");
	}
	System.out.println(searchNoticeTitle+" <-- selectNoticeList searchNoticeTitle");

	//페이지
	int currentPage = 1;
	//currentPage는 값이 들어오면 1대신 그 값으로 바뀜
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage+" <-- selectNoticeList currentPage");
	
	//상수(fianl)
	//rowPerPage변수 10으로 초기화되면 끝까지 10이다(변하지 않음)
	final int ROW_PER_PAGE = 5;
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	NoticeDao noticeDao = new NoticeDao();
	
	ArrayList<Notice> noticeList = null;
	
	if(searchNoticeTitle.equals("") == true) { // 검색어가 없을때
		noticeList = noticeDao.selectNoticeListAllByPage(beginRow, ROW_PER_PAGE);
	} else { // 검색어가 있을때
		noticeList = noticeDao.selectNoticeListAllBySearchNoticeTitle(beginRow, ROW_PER_PAGE, searchNoticeTitle);
	}

	int totalCount = noticeDao.totalNoticeCount();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>
</head>
<body>
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<h1>공지사항 목록</h1>
	<table border="1">
		<%
			for(Notice n: noticeList) {
		%>
			
			<thead>
				<tr>
					<th>공지사항 번호</th>
					<th width="250">공지사항 제목</th>
					<th>작성자</th>
					<th>createDate</th>
					<th>updateDate</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><%=n.getNoticeNo() %></td>
					<td>
						<a href="<%=request.getContextPath() %>/admin/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo() %>"><%=n.getNoticeTitle() %></a>
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
	<a href="insertNoticeForm.jsp">공지작성</a>
	<div>
		<%
			// ISSUE : 페이지 잘되었는데... 검색한후 페이징하면 안된다 -> ISSUE 해결
			if (currentPage > 1) {
		%>
			<a href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp?currentPage=<%=currentPage-1%>&searchNoticeTitle=<%=searchNoticeTitle%>">이전</a>
		<%
			}
		%>
		<%		
			int lastPage = totalCount / ROW_PER_PAGE;
			
			if (totalCount % ROW_PER_PAGE != 0) {
				lastPage += 1;
			}
		
			if (currentPage < lastPage) {
		%>
			<a href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp?currentPage=<%=currentPage+1%>&searchNoticeTitle=<%=searchNoticeTitle%>">다음</a>
		<%
		}
		%>
	</div>
</body>
</html>