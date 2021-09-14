<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="vo.*" %>
<%@ page import ="dao.*" %>
<!DOCTYPE html>
<%
	request.setCharacterEncoding("utf-8");

	//로그인 상태에서는 페이지 접근불가
	if(session.getAttribute("loginMember") != null) {
		// 다시 브라우즈에게 다른곳을 요청하도록 하는 메서드
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	// 회원가입 입력값 유효성 검사
	if(request.getParameter("memberId")==null || request.getParameter("memberPw")==null
		|| request.getParameter("memberName")==null || request.getParameter("memberAge")==null
		|| request.getParameter("memberGender")==null
	) {
		// 다시 브라우즈에게 다른곳을 요청하도록 하는 메서드
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
		return;
	}
	if(request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("")
			|| request.getParameter("memberName").equals("") || request.getParameter("memberAge").equals("")
			|| request.getParameter("memberGender").equals("")
		) {
			// 다시 브라우즈에게 다른곳을 요청하도록 하는 메서드
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
		return;
	}

	// request 값 저장
		String memberId = request.getParameter("memberId");
		String memberPw = request.getParameter("memberPw");
		String memberName = request.getParameter("memberName");
		int memberAge = Integer.parseInt(request.getParameter("memberAge"));
		String memberGender = request.getParameter("memberGender");
		// requst 매개값 디버깅 코드
		System.out.println(memberId+"<-- memberId");
		System.out.println(memberPw+"<-- memberPw");
		System.out.println(memberName+"<-- memberName");
		System.out.println(memberAge+"<-- memberAge");
		System.out.println(memberGender+"<-- memberGender");
		
		// MemberDao 객체 생성
		MemberDao memberDao = new MemberDao();
		
		// Member 객체 생성 후, 받아온 값 저장
		Member paramMember = new Member();
		paramMember.setMemberId(memberId);
		paramMember.setMemberPw(memberPw);
		paramMember.setMemberName(memberName);
		paramMember.setMemberAge(memberAge);
		paramMember.setMemberGender(memberGender);
		
		// 회원가입하는 memberDao의 insertMember 메서드 호출
		memberDao.insertMember(paramMember);
		System.out.println("회원가입 성공");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>