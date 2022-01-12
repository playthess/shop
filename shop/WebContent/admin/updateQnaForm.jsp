<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	if(request.getParameter("memberNo") == null) {
	response.sendRedirect("./index.jsp");
	return;
	}
	request.setCharacterEncoding("utf-8");

	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));

%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	
	<h1>Qna 수정</h1>
	<form method ="post" action ="updateQnaAction.jsp">
		<table border = "1">
			<tr>
				<td>memberNo</td>
				<td><input type = "text" name ="memberNo" value = <%=memberNo%> readonly><td>
				
			<tr>
				<td>QnaNo</td>
				<td><input type = "text" name ="qnaNo" value = <%=qnaNo%> readonly><td>
			<tr>
				<td>QnaCategory</td>
				<td>
					<input type ="radio" class ="qnaCategory" name ="qnaCategory" value ="전자책관련">전자책관련
						<input type ="radio" class ="qnaCategory" name ="qnaCategory" value ="개인정보관련">개인정보관련
						<input type ="radio" class ="qnaCategory" name ="qnaCategory" value ="기타">기타
				</td>
			<tr>	
			<tr>
				<td>QnaTitle</td>
				<td><input type = "text" name ="qnaTitle"><td>
			<tr>	
			<tr>
				<td>QnaContent</td>
				<td><textarea  name = "qnaContent" rows=15 cols=100 style="text-align:center;"></textarea><td>
			<tr>	
			<tr>
				<td>QnaSecret</td>
				<td><input type= "radio" name ="qnaSecret" value ="Y">Y
			   		<input type= "radio" name ="qnaSecret" value ="N">N</td>
			<tr>	
		</table>
		<button type ="submit">등록</button>
		<button type ="reset">초기화</button>
	</form>
</body>
</html>