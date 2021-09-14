<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	request.setCharacterEncoding("utf-8"); //인코딩	
	//인증 방어 코드 : 로그인 전 session.getAttribute("loginMember") == null 인 경우
	if(session.getAttribute("loginMember")!=null){
		System.out.println("이미 로그인 되어 있음");
		response.sendRedirect("./index.jsp"); //로그인 되면 회원가입 하면 안됨
		return;
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>loginForm.jsp</h1>
	<form method="post" action="./loginAction.jsp">
		<div>Id :</div>
		<div><input type = "text" name = "memberId"></div>
		<div>Pw : </div>
		<div><input type = "password" name = "memberPw"></div>
		<div>
			<button type="submit">로그인</button>
		</div>
	</form>
</body>
</html>