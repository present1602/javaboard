<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"   isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ page session="true" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");

%>    
<script>
$(function() {   
	alert('post_layer.jsp load');
});
</script>



  	<span id="cpstalk_layer_close"><img src="resources/images/cpstalk_layer_close.png"  style="outline:none" alt="" /></span>
	<div class="cpstalk_itembox">       
        	<div class="cpstalk_top">
                <p class="user_pic"><img src="images/profile_default2.jpg">
                </p>
                <p class="user_info"><span class="user_nick">망고바</span> | <span class="user_major">경영</span> </p>
                
                <div class="clear"></div>
        	</div>
        	<p class="cpstalk_title">${post.title }</p>
        	<p class="cpstalk_text">${post.content }</p>
        	<p class="info_tag"><a href="#"><span class="tag">#황금연휴</span></a><a href="#"><span class="tag">#해외여행</span></a>
            </p>
            <div class="info">
                 <span class="time">1시간 전</span>
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
				
                <textarea id="" name="" maxlength="1000" class="replyinput" title="댓글내용"></textarea>
                <input type="submit" title="" name="" value="확인" class="reply_button"/>
                <div class="clear"></div>
            </div>
	</div>


