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

$(function() {
	var curUrl = window.location.href; 
	var postNum = document.getElementById("post_num").value;
    $("#reply_button").on("click", function() {
    	alert('버튼 클릭');
       /*  $.ajax({
            url : "/board/" + postNum + "/write_comment",
            data : {
                commentContent : $("#commentContent").val()
            },
           
            success : function(data) {
                alert("comment ajax suc");
                alert("data : " + data);
            },
            
            error : function(err) {
            	alert("comment ajax err");
                alert(JSON.stringify(err));
            }
        }) */
    });
});

</script>



  	<span id="cpstalk_layer_close"><img src="resources/images/cpstalk_layer_close.png"  style="outline:none" alt="" /></span>
	<div class="cpstalk_itembox">       
        	<div class="cpstalk_top">
                <p class="user_pic"><img src="resources/upload/${post.writerImage} " style="border-radius:50px">
                </p>
                <p class="user_info"><span class="user_nick">망고바</span> | <span class="user_major">경영</span> </p>
                
                <div class="clear"></div>
        	</div>
        	<input type="text" id="post_num" value=${post.postNum}>
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
                <input type="submit" title="" name="" value="확인" id="reply_button"/>
                <div class="clear"></div>
            </div>
	</div>


