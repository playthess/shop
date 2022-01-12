<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<div>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
 	 <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">HOME</a>
		<ul class="navbar-nav">
			<li class="nav-item">
				<a class="nav-link" href="">[menuOne]</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="">[menu2]</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="">[menu3]</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="">[menu4]</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<%=request.getContextPath()%>/selectQnaList.jsp">[Q&A게시판]</a>
			</li>
		</ul>
	</nav>
</div>