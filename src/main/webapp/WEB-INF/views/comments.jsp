<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
  request.setCharacterEncoding("UTF-8");

%>

<ul class="cpstalk_replylist">
	<c:forEach var="cmt" items="${comments}">
		<li class="reply_item">
			<table class="reply_item_table">
				<tr style="border: 1px solid blue">
					<td class="user"><p class="user_pic">
							<img src="resources/upload/${cmt.writerImage}">
						</p></td>
					<td class="reply_content">
						<p class="user_nick">${cmt.writerNick}</p>
						<p class="reply_text">${cmt.content}</p>
						<div class="info">
							<span class="time">${cmt.createdAt}</span>
						</div>
					</td>
				</tr>
			</table>
		</li>
	</c:forEach>
</ul>