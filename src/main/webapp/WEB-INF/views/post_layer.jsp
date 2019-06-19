<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"   isELIgnored="false"  %>
    
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");

%>   
<style> 
#image_view_in_post{width:400px;}
#image_preview_in_post{width:100px;}
</style>
<script src="<c:url value="/resources/js/autosize.js" />"></script>

  	<span id="cpstalk_layer_close"><img src="/resources/images/cpstalk_layer_close.png"  style="outline:none" alt="" /></span>
	<div class="cpstalk_itembox">       
        	<div class="cpstalk_top">
                <p class="user_pic"><img src="/resources/upload/profile/${post.writerImage} " style="border-radius:50px">
                </p>
                <p class="user_info"><span class="user_nick">${post.writerNick}</span> | <span class="user_major">${post.writerMajor}</span> </p>
                
                <div class="clear"></div>
        	</div>

        	<c:choose>
				<c:when test="${memberSid == post.writer}">
					<form id="post_update_form" enctype="multipart/form-data">
						<input type="hidden" class="post_num" name="post_num" value=${post.postNum}>
						
						<p><input type="text" name="title" class="cpstalk_title" value="${post.title}"
							style="border:1px solid rgba(228,228,228,1); width:90%">
						</p>
						<textarea rows="5" name="content" id="content_textarea" class="cpstalk_text" 
						style="width:90%; border:1px solid rgba(228,228,228,1); padding:10px;" >${post.content}</textarea>
						
						<div id="img_box">
						<c:choose>
							<c:when test="${post.imageFile != null}">
					        	<img src="/resources/upload/post/${post.imageFile}" id="image_view_in_post">
					        	<img src="" id="image_preview_in_post">
				        		<input id="del_file" type="button" value="이미지삭제">
				        		<p><input type="file" name="image_upload" id="upload_image_in_post" style="display:none;"></p>
				        	</c:when>
				        	<c:otherwise>
				        		<img src="" id="image_view_in_post">
				        		<p><input type="file" name="image_upload" id="upload_image_in_post"></p>
				        	</c:otherwise>
		        		</c:choose>
						</div>
						
					</form>
					<input type="button" id="post_update_btn" class="button_ok" value="수정">
					<input type="button" id="post_delete_btn"class="button_del" value="삭제">
				</c:when>
				
				<c:otherwise>
					<input type="hidden" class="post_num" value=${post.postNum}/>
		        	<p class="cpstalk_title" style="width:85%">${post.title }</p>
		        	
		        	<c:if test="${post.imageFile !=null }">
		        		<img src="/resources/upload/post/${post.imageFile}" style="width:400px;">
		        	</c:if>
		        	<p class="cpstalk_text" style="width:85%">${post.content }</p>
				
				</c:otherwise>
			</c:choose>
			
        	
        	
            <div class="info">
                 <span class="time">${post.createdAt} </span>
                 <span class="view">${post.hit}</span>
                 <!-- <span class="rec">5</span> -->
                 <span class="cmt">${fn:length(comments)} </span>
            </div>
            <div class="replybox">
            
            	<c:choose>
					<c:when test="${memberSid != null && memberImage != null}">
						<p class="user_pic"><img src="/resources/upload/profile/${memberImage}"></p>
					</c:when>
					
					<c:otherwise>
						<p class="user_pic"><img src="/resources/images/profile_default2.jpg"></p>
					</c:otherwise>
				</c:choose>
				
	                <textarea id="commentContent" name="commentContent" maxlength="1000" class="replyinput" title="댓글내용"></textarea>
	                <input type="hidden" id="post_num" value="${post.postNum}">
	                <input type="button" name="" value="확인" id="reply_button"/>
	                <div class="clear"></div>
					<div id="reply_wrap">
						<ul class="cpstalk_replylist">
						 <c:forEach var="cmt" items="${comments}" > 
						 
							<li class="reply_item">
								<table class="reply_item_table">
									<tr style="border: 1px solid blue">
										<td class="user"><p class="user_pic">
												<img src="/resources/upload/profile/${cmt.writerImage}">
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
	</div>
<script>
	autosize(document.getElementById('content_textarea'));
	
</script>
	
