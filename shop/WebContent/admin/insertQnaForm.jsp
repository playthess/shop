<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} 
	
	QnaDao qnaDao = new QnaDao();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 등록</title>
</head>
<body>
	<!-- submenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- submenu 인클루드 끝 -->
	<h1>Q&A 작성</h1>
	<form method="post" action="<%=request.getContextPath() %>/admin/insertQnaAction.jsp">
		<table border="1">
			<tr>
				<td>Q&A 카테고리</td>
						<td>
							<select name="qnaCategory">
								<option value="전자책관련">전자책관련</option>
								<option value="개인정보관련">개인정보관련</option>
								<option value="기타">기타</option>
							</select>
						</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" style="border:none" id="qnaTitle" name="qnaTitle">
				</td>
			</tr>
			
			<tr>
				<td>내용</td>
				<td>
					<textarea id="qnaContent" name = "qnaContent" rows=20 cols=100></textarea>
				</td>
			</tr>
			<tr>
				<td>Q&A 공개, 비공개 여부</td>
				<td>
					<input type="radio" name="qnaSecret" value="Y">Y
					<input type="radio" name="qnaSecret" value="N">N
				</td>
			</tr>
		</table>
		<button type="submit">등록</button>
	</form>
</body>
</html>






