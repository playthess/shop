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
	//검색어
	String searchQnaTitle = "";
	if(request.getParameter("searchQnaTitle")!=null){
		searchQnaTitle = request.getParameter("searchQnaTitle");
	}
	System.out.println(searchQnaTitle+" <--selectQnaList searchQnaTitle");

	//페이지
	int currentPage = 1;
	//currentPage는 값이 들어오면 1대신 그 값으로 바뀜
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage+" <-selectNoticeList currentPage");
	
	//상수(fianl)
	//rowPerPage변수 10으로 초기화되면 끝까지 10이다(변하지 않음)
	final int ROW_PER_PAGE = 10;
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	QnaDao qnaDao = new QnaDao();
	
	ArrayList<QnaMemberComment> qnaList = null;
	
	if(searchQnaTitle.equals("") == true) { // 검색어가 없을때
		qnaList = qnaDao.selectQnaListAllByPage(beginRow, ROW_PER_PAGE);
	} else { // 검색어가 있을때
		qnaList = qnaDao.selectQnaListAllBySearchQnaTitle(beginRow, ROW_PER_PAGE, searchQnaTitle);
	}

	int totalCount = qnaDao.totalQnaCount();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 게시판</title>
</head>
<body>
	<!-- submenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- submenu 인클루드 끝 -->
	<h1>Q&A목록</h1>
	<table border="1">
		<%
			for(QnaMemberComment qmc : qnaList){
		%>
		<thead>
			<tr>
				<th>Q&A 번호</th>
				<th>Q&A 목록</th>
				<th>Q&A 제목</th>
				<th>Q&A 공개여부</th>
				<th>작성자</th>
				<th>createDate</th>
				<th>updateDate</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><%=qmc.getQna().getQnaNo() %><a href="<%=request.getContextPath()%>/admin/updateQnaForm.jsp">Q&A 수정하기</a></td>
				<td><%=qmc.getQna().getQnaCategory() %></td>
				<td>
					<a href="<%=request.getContextPath() %>/admin/selectQnaOne.jsp?qnaNo=<%=qmc.getQna().getQnaNo()%>"><%=qmc.getQna().getQnaTitle() %></a>
				</td>
				<td>
				<%
					if(qmc.getQna().getQnaSecret().equals("Y")){
				%>
						<span>비공개</span>
				<%
					} else if(qmc.getQna().getQnaSecret().equals("N")){
				%>
						<span>공개</span>
				<%
					}
				%>
				</td>
				<td><%=qmc.getMember().getMemberName() %></td>
				<td><%=qmc.getQna().getCreateDate() %></td>
				<td><%=qmc.getQna().getUpdateDate() %></td>
			</tr>	
		</tbody>
		<%
			}
		%>
	</table>
	<div>
		<%
			// ISSUE : 페이지 잘되었는데... 검색한후 페이징하면 안된다 -> ISSUE 해결
			if (currentPage > 1) {
		%>
			<a href="<%=request.getContextPath()%>/admin/selectQnaList.jsp?currentPage=<%=currentPage-1%>&searchQnaTitle=<%=searchQnaTitle%>">이전</a>
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
			<a href="<%=request.getContextPath()%>/admin/selectQnaList.jsp?currentPage=<%=currentPage+1%>&searchQnaTitle=<%=searchQnaTitle%>">다음</a>
		<%
		}
		%>
	</div>
	<div><a href="<%=request.getContextPath()%>/admin/insertQnaForm.jsp">Q&A 작성하기</a></div>
</body>
</html>









