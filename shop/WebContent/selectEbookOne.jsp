<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품상세보기(주문)</title>
</head>
<body>
	<h1>상품상세보기</h1>
	<div>
		<!-- 상품상세출력 -->
		<%
			EbookDao ebookDao = new EbookDao();
			Ebook ebook = ebookDao.selectEbookOne(ebookNo);
			// 구현
		%>
	</div>
	<div>
		<h2>전자책 주문</h2>
		<%
			Member loginMember = (Member)session.getAttribute("loginMember");
			if(loginMember == null) {
		%>
				<div>
					로그인 후에 주문이 가능합니다. 
					<a href="<%=request.getContextPath()%>/loginForm.jsp">로그인 페이지로</a>
				</div>
		<%		
			} else {
		%>
				<form method="post" action="<%=request.getContextPath()%>/insertOrderAction.jsp">
					<input type="hidden" name="ebookNo" value="<%=ebookNo%>">
					<input type="hidden" name="memberNo" value="<%=loginMember.getMemberNo()%>">
					<input type="hidden" name="ebookPrice" value="<%=ebook.getEbookPrice()%>">
					<button type="submit">주문하기</button>
				</form>
		<%
			}
		%>
	</div>
	
	<div>
		<h2>상품 후기</h2>
		<!-- 이 상품의 별점의 평균 -->
		<!-- select avg(order_score) from order_comment where ebook_no=? order by ebook_no -->
		<div>
			<%
			OrderCommentDao orderCommentDao = new OrderCommentDao();
			double avgScore = orderCommentDao.selectOrderScoreAvg(ebookNo);
			%>
			별점 평균 : <%=avgScore%>
		</div>
		<div>
			<h2>후기 목록(페이징)</h2>
			
							<!-- 이 상품의 상품 후기(페이징) -->
				<%
				// 페이징
				// 페이지번호 = 전달 받은 값이 없으면 currentPage를 1로 디폴트
				int currentPage = 1;
				// current가 null이 아니라면 값을 int 타입으로로 바꾸어서 페이지 번호로 사용
				if(request.getParameter("currentPage") != null) { 
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				}
				// 디버깅
				System.out.println("currentPage(현재 페이지 번호) : "+currentPage);
				
				// limit 값 설정 beginRow부터 rowPerPage만큼 보여주세요
				// ROW_PER_PAGE 변수를 상수로 설정하여서 10으로 초기화하면 끝까지 10이다.
				final int ROW_PER_PAGE = 10;
				int beginRow = (currentPage-1) * ROW_PER_PAGE;
				
				ArrayList<OrderComment> commentList = new ArrayList<OrderComment>();
				commentList = orderCommentDao.selectCommentList(beginRow, ROW_PER_PAGE, ebookNo);
				
				// 마지막 페이지(lastPage)를 구하는 orderCommentDao의 메서드 호출
				// int 타입의 lastPage에 저장
				// 전체 행을 COUNT 하는 selectCommentListLastPage메서드 호출
				int lastPage = orderCommentDao.selectCommentListLastPage(ROW_PER_PAGE, ebookNo);
				
				// 화면에 보여질 페이지 번호의 갯수
				int displayPage = 10;
				
				// 화면에 보여질 시작 페이지 번호
				// ((현재페이지번호 - 1) / 화면에 보여질 페이지 번호) * 화면에 보여질 페이지 번호 + 1
				// (currentPage - 1)을 하는 이유는 현재페이지가 10일시에도 startPage가 1이기 위해서
				int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
					
				// 화면에 보여질 마지막 페이지 번호
				// 만약에 마지막 페이지 번호(lastPage)가 화면에 보여질 페이지 번호(displayPage)보다 작다면 화면에 보여질 마지막 페이지번호(endPage)를 조정한다
				// 화면에 보여질 시작 페이지 번호 + 화면에 보여질 페이지 번호 - 1
				// -1을 하는 이유는 페이지 번호의 갯수가 10개이기 때문에 statPage에서 더한 1을 빼준다
				int endPage = 0;
				if(lastPage<displayPage){
					endPage = lastPage;
				} else if (lastPage>=displayPage){
					endPage = startPage + displayPage - 1;
				}
				
				// 디버깅
				System.out.println("startPage(화면에 보여질 시작 페이지 번호) : "+startPage+", endPage(화면에 보여질 마지막 페이지 번호) : "+endPage);
				%>
				<table class="table mt-1">
					<tr>
						<td style="width:10%; text-align:center">GRADE</td>
						<td>COMMENT</td>
						<td style="width:10%; text-align:center">DATE</td>
					</tr>
					<%
						for(OrderComment c : commentList) {
					%>
							<tr>
								<td><%=c.getOrderScore()%></td>
								<td><%=c.getOrderCommentContent()%></td>
								<td><%=c.getCreateDate()%></td>
							</tr>
					<%
						}
					%>
				</table>
				
				<%
				// 처음으로 버튼
				// 제일 첫번째 페이지로 이동할때 = 1 page로 이동
				if(currentPage != 1){
				%>
					<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=1%>&ebookNo=<%=ebookNo%>" class="btn btn-outline-secondary center-block">◀처음</a>
				<%
				}
					
				// 이전 버튼
				// 화면에 보여질 시작 페이지 번호가 화면에 보여질 페이지 번호의 갯수보다 크다면 이전 버튼을 생성
				if(startPage > displayPage){
				%>
					<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=startPage-displayPage%>&ebookNo=<%=ebookNo%>" class="btn btn-outline-secondary">&lt;이전</a>
				<%
				}
							
				// 페이징버튼
				// 화면에 보여질 시작 페이지 번호를 화면에 보여질 마지막 페이지 번호까지 반복하면서 페이지 번호 생성
				// 만약에 화면에 보여질 마지막 페이지 번호가 마지막 페이지보다 크다면 for문을 break로 종료시킴
				for(int i=startPage; i<=endPage; i++){
					if(currentPage == i){
				%>
						<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=i%>&ebookNo=<%=ebookNo%>" class="btn btn-secondary"><%=i%></a>
				<%
					} else if(endPage<lastPage || endPage == lastPage){
				%>
						<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=i%>&ebookNo=<%=ebookNo%>" class="btn btn-outline-secondary"><%=i%></a>
				<%	
					} else if(endPage>lastPage){
						break;
					}
				}
					
				// 다음 버튼
				// 화면에 보여질 마지막 페이지 번호가 마지막페이지보다 작다다면 이전 버튼을 생성
				if(endPage < lastPage){
				%>
					<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=startPage+displayPage%>&ebookNo=<%=ebookNo%>" class="btn btn-outline-secondary">다음></a>
				<%
					}
							
				// 끝으로 버튼
				// 가장 마지막 페이지로 바로 이동하는 버튼
				if(currentPage != lastPage){
				%>
					<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=lastPage%>&ebookNo=<%=ebookNo%>" class="btn btn-outline-secondary">끝▶</a>
				<%
				}
				%>
			
		</div>
	</div>
</body>
</html>





