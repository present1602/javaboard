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
	 <link href="<c:url value="/resources/css/common.css" />" rel="stylesheet">
 	
	<script src="<c:url value="/resources/js/jquery-3.2.1.js" />"></script>
	<script src="<c:url value="/resources/js/basic.js" />"></script>
</head>

<body>
<!-- <form method="post" action="/board/searcht">
<input type="text" name="search_text" value="tit">
<input type="submit" value="dd"> -->

<div id="header">
	<div id="in_header">
		<h1 class="logo" style="font-family: sans-serif; color: #fff">CAMPUS TALK</h1>
            
		<div class="searchbox">
			<form id="top_searchform" name="top_searchform" method="post" action="/board/search">
				<fieldset id="top_searchfield">
					<input type="text" title="search_text" name="search_text" id="top_searchtext" placeholder=""> 
					<img src="/resources/images/search.jpg" id="search_button"
					onclick="document.getElementById('top_searchform').submit();">
					
				</fieldset>
			</form>
			
			
		</div>
		<!-- <input type="image" src="/resources/images/search.jpg" 
					id="search_button" onclick="document.getElementById('top_searchform').submit()";> -->
		<div class="clear"></div>
	</div>
</div>
<script>
$("#search_button").click(function(e){
	
})
</script>
</body>
</html>