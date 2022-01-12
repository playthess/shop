<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  	//인코딩 
	request.setCharacterEncoding("utf-8");
  	//selectQnaOne에서 값 가져오기 
  
  	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
  	String qnaComment = request.getParameter("qnaComment");
  
  	//디버깅
  	System.out.println(memberNo +"<--memberNo");
  	System.out.println(qnaComment +"<--qnaComment");
  	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<h1>Qna 관리자 댓글달기</h1>
		<form method ="post" action ="<%=request.getContextPath()%>/admin/insertCommentAnswerAction.jsp">
			<table border="1">
				<tr>
					<td>memberNo</td>
					<td><input type ="text" name ="memberNo" value ="<%=memberNo%>" readonly></td>
				</tr>
				<tr>
					<td>qnaComment</td>
					<td><textarea  name = "qnaComment"  rows=10 cols=20 style="text-align:center;" readonly><%=qnaComment%></textarea></td>
				</tr>
				<tr>
					<td>관리자 댓글달기</td>
					<td><textarea  name = "qnaCommentContent " rows=5 cols=20 style="text-align:center;"></textarea></td>
				</tr>
			</table>
			<button type = "submit">등록</button>
			<button type = "reset">초기화</button>
		</form>
</body>
</html>