<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
  request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헤더</title>
	
</head>

<body>
<div id="header">
	<div id="in_header">
		<h1 class="logo" style="font-family: sans-serif; color: #fff">CAMPUS TALK</h1>
		<!-- <ul class="gnb">
                <a href="#"><li id="gnbnav_cpstalk">캠퍼스톡</li></a>
                <a href="public/material_main.html"><li id="gnb_material">PPT·레포트</li></a>
            </ul> -->
            
		<div class="searchbox">
			<form id="top_searchform">
				<fieldset id="top_searchfield">
					<input type="text" title="" name="" id="top_searchtext"
						placeholder=""> <input type="image"
						src="/resources/images/search.jpg" class="search_button">
				</fieldset>
			</form>
		</div>
		
		<!-- <ul id="icon_menu">
                <li class="social_icon"><a href=""><img src="images/ficon.jpg"></a></li>
                <li class="social_icon"><a href=""><img src="images/bicon.jpg"></a></li>
                <li id=""><img src=""></li>
            </ul> -->
		<div class="clear"></div>
	</div>
</div>
</body>
</html>