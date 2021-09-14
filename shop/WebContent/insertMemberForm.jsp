<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%   //로그인 상태에서는 페이지 접근 금지 
   if(session.getAttribute("loginMember") != null){
      //다시 브라우저에게 다른곳을 요청하도록 하기 위해 만든것 
      response.sendRedirect("./index.jsp");
      return;
   }
%>

   <h1>회원가입</h1>
   <form method = "post" action = "./insertMemberAction.jsp">
      <!--회원아이디-->
      <div>memberId :</div>
      <div><input type = "text" name ="memberId"></div>
      <!--회원비번-->
      <div>memberPw :</div>
      <div><input type = "password" name ="memberPw"></div>
      <!--회원이름-->
      <div>memberName :</div>
      <div><input type = "text" name ="memberName"></div>
      <!--회원나이-->
      <div>memberAge :</div>
      <div><input type = "text" name ="memberAge"></div>
      <!--회원 성별-->
      <div>memberGender :</div>
      <div>
         <input type = "radio" name ="memberGender" value = "남">남
         
         <input type = "radio" name ="memberGender" value = "여">여
       </div>
       
   
      <button type = "submit">등록</button>
      
   </form>
</body>
</html>