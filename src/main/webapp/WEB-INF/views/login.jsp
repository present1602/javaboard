<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"   isELIgnored="false"  %>
<%
  request.setCharacterEncoding("UTF-8");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%@ include file="header.jsp" %>


<!-- <div id="login_layerbox">
   	<p class="logo">CAMPUS TALK</p>
    <form method = "post" action = "">
         <input type = "image" id = "login_layer_close" src = "images/login_close.jpg">
         <input type = "text" id = "login" placeholder = "login_email" name = "">
         <input type = "password" id = "password" name = "login_password" placeholder = "***">
         <input type = "submit" id = "dologin" value = "로그인">
	</form>
       <p id="forgot_password" style="margin-left:210px">비밀번호를 잊으셨나요?</p>

 </div>
 --> 
 
<div id="login_layerbox">
	<p class="logo">CAMPUS TALK</p>
	<h2 style="margin:15px 0">로그인</h2>
	<form method="post">
		<p><input type="text" id="login" name="email" value="em@naver.com"></p>
 		<p><input type="password" id="password" name="password" value="1234"></p>
 		<p><input type="submit" id="dologin" value="확인"></p>
	   	<p id="to_signup">아직 회원이 아니신가요?<a href="/member/signup">회원가입</a></p>
   	</form>
</div>
            
</body>
</html>