<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/submenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<h1>메인페이지</h1>
<%
		// 로그인 전 = session의 loginMember가 null 일 때
		if(session.getAttribute("loginMember")==null) {
	%>
		<div><a href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a></div><br>
		<div><a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a></div>
	<%
		// 로그인 후
		// loginMember 객체에 session의 loginMember를 저장
		} else {
			Member loginMember = (Member)session.getAttribute("loginMember");
	%>
		<div>
			<div><%=loginMember.getMemberId()%> 님 반갑습니다. Level : <%=loginMember.getMemberLevel()%></div><br>
			<div><a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></div>
		</div>
	<%
		}
	%>
</body>
</html>