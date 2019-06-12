<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"   isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ page session="true" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");

%>    


  	<span id="cpstalk_layer_close"><img src="resources/images/cpstalk_layer_close.png"  style="outline:none" alt="" /></span>
	<div class="cpstalk_itembox">       
        	<div class="cpstalk_top">
                <p class="user_pic"><img src="resources/upload/${post.writerImage} " style="border-radius:50px">
                </p>
                <p class="user_info"><span class="user_nick">망고바</span> | <span class="user_major">경영</span> </p>
                
                <div class="clear"></div>
        	</div>
        	<input type="hidden" id="post_num" value=${post.postNum}>
        	<p class="cpstalk_title">${post.title }</p>
        	<p class="cpstalk_text">${post.content }</p>
        	<p class="info_tag"><a href="#"><span class="tag">#황금연휴</span></a><a href="#"><span class="tag">#해외여행</span></a>
            </p>
            <div class="info">
                 <span class="time">${post.createdAt} </span>
                 <span class="view">43</span>
                 <span class="rec">5</span>
                 <span class="cmt">57</span>
            </div>
            <div class="replybox">
            
            	<c:choose>
					<c:when test="${memberSid != null && memberImage != null}">
						<p class="user_pic"><img src="resources/upload/${memberImage}"></p>
					</c:when>
					
					<c:otherwise>
						<p class="user_pic"><img src="resources/images/profile_default2.jpg"></p>
					</c:otherwise>
				</c:choose>
				
	                <textarea id="commentContent" name="commentContent" maxlength="1000" class="replyinput" title="댓글내용"></textarea>
	                <input type="hidden" id="post_num" value="${post.postNum}">
	                <input type="button" name="" value="확인" id="reply_button"/>
	                <div class="clear"></div>

					<ul class="cpstalk_replylist">
					 <c:forEach var="cmt" items="${comments}" > 
					 
						<li class="reply_item">
							<table class="reply_item_table">
								<tr style="border: 1px solid blue">
									<td class="user"><p class="user_pic">
											<img src="resources/images/${cmt.writerImage}">
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
		</div>

	</div>
	
	
