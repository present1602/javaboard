<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"   isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  
<%@ page session="true" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>    

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>메인 페이지</title>
</head>
<body>
  <%@ include file="header.jsp" %>

  </p>
  <div id="mainboard">
		<div id="left_sidebar">
			<div class="user_area">
				<c:choose>
					<c:when test="${memberSid != null}">
						<img class="profile_main" 
							src="/resources/upload/profile/${memberImage}" 
							style="width:100px; height:100px; border-radius:50px">
						<p>${memberNick}</p>
						<p>
							<a href="/member/update">회원정보수정</a>
						</p>
						<p id="logout_button" style="margin-top:10px;">
							<a href="/member/logout">로그아웃</a>
						</p>
						

					</c:when>
					<c:otherwise>

						<img class="profile_main"
							src="/resources/images/profileimage_default.gif">
						<p id="login_button">
							<a href="/member/login">로그인하기</a>
						</p>
						<p id="signup_button">
							<a href="/member/signup">회원가입</a>
						</p>

					</c:otherwise>
				</c:choose>
			</div>
		</div>

		<div id="boardbox"> <!--캠퍼스톡보드박스 시작--> 
            <!-- 
            <p class="tagtoggle"><img src="images/tagopen.jpg"></p>
            <ul class="toptag">
                <a href="#"><li class="taglist_item toptag_item">#어학3</li></a>
                <a href="#"><li class="taglist_item toptag_item">#취업</li></a>
                <a href="#"><li class="taglist_item toptag_item">#공모전</li></a>
                <a href="#"><li class="taglist_item toptag_item">#편입</li></a>
            </ul>
            
            <ul class="taglist" id="" style="display:none;"> 
                <a href="#"><li class="taglist_item">#인문</li></a>
            	<p class="tag_prevnext"><span class="tag_prev"><img src="images/tagtoleft.jpg"></span><span class="tag_next"><img src="images/tagtoright.jpg"></span></p>
            </ul>

            <div id="cpstalk_searchbox">
                <a href="#"><span class="tag_selected taglist_item" style="float:left;">#경영학과</span></a>
                <form id="cpstalk_searchform">
                    <fieldset id="cpstalk_searchfield">
                        <input type="text" title="" name="" class="searchtext" placeholder="CAMPUS TALK">
                        <input type="image" src="images/search2.jpg" class="search_button">
                    </fieldset>
                </form>  
            </div>             -->
            
            
            <div id="cpstalk_sub">     
                <p class="writing">글쓰기</p>
                <div class="clear"></div>
			</div>
			<c:if test ="${fn:length(postlist)==0}">
            	<h2 style="padding:50px;text-align:center">검색 결과가 없습니다</h2>
           	</c:if>
            <ul id="cpstalk_list">
            	
            	 <c:forEach var="post" items="${postlist}" >
            	<li class="cpstalk_listitem"> 	 
            	
            		<table>
                    	<tr class="cpstalk_listitem_tr">
                        	<td class="user">
                            	<img class="user_pic" src="/resources/upload/profile/${post.writerImage}">
                       		</td>
                        	<td class="cpstalk_itemsummary">
                                <p class="user_info"><span class="user_nick">${post.writerNick} | ${post.writerMajor}</span> </p>
                                <input type="hidden" class="post_num" value=${post.postNum}>
                                <p class="text post_title">${post.title} </p>
                                </p>
                                <div class="info">    
                                    <span class="time">${post.createdAt}</span>
                                    <span class="view">${post.hit}</span>
                                    <!-- <span class="rec">5</span> -->
                                    <span class="cmt">${post.comment_count}</span>
	                            </div>
                            </td>
                        </tr>	
                    </table>
                </li>
                </c:forEach> 
                
            </ul>
 
          </div>   <!--보드박스 끝-->
          <div id="contents_sidebar">
        	<p style="font-size: 18px; padding: 6px 3px; margin-top: 10px; border-bottom: 1px solid rgba(214,214,214,1);">인기게시물</p>
            <br>
            <ul>
            
  	          <c:forEach var="bestpost" items="${postlist_best}" > 
            	<li>
            		<a href="#" class="post_title" style="font-weight:bold">${bestpost.title}</a>
            		<input type="hidden" class="post_num" value=${bestpost.postNum}>
           		</li>
               </c:forEach>
            </ul>
        
          </div>   
           
        <!-- <div id="right_sidebar">
        	<p><a href="#"><img src="images/adbanner1.jpg"></a></p>
        	<p><a href="#"><img src="images/adbanner2.jpg"></a></p>
        	<p><a href="#"><img src="images/adbanner3.jpg"></a></p>
        	
        </div> -->
    
        <div class="clear"></div>
      </div> <!--메인보드 끝--> 
 


<div id="writebox_layer">
    <div id="write_box">
    	<form method="post" action="/board/write" enctype="multipart/form-data">
	        <h2 class="">
	            <strong><span class="icon"><img src="/resources/images/write_icon.jpg" style="width:22px" alt="" /></span> CAMPUS TALK</strong>
	        </h2>
	            <input type="text" name="title" value="" id="wr_subject" required class="write_title" placeholder="제목" />
	            <div class="write_content_box">
	                <textarea id="wr_content" name="content" class="write_content" maxlength="65536"></textarea>
	                <div id="preview_image_box" style="border:1px solid #e3e3e3">
	                     <img id="preview_image">                  
	                </div>
	                <input type="file" name="image_upload" id="cpstalk_upload_image">
	            
	            </div>
	           <!--  <input type="text" name="" value="" id="" required class="write_tag" placeholder="태그" /> -->
	     
	            <!-- <p class="tagtoggle" style="position:relative;float:right;"><img src="images/tagopen.jpg"></p>
	            <ul class="toptag in_writebox">
	                <li class="toptag_item taglist_item in_writebox">#인하대</li>
	                <li class="toptag_item taglist_item in_writebox">#경영학과</li>
	                <li class="toptag_item taglist_item in_writebox">#마케팅</li>
	                <li class="toptag_item taglist_item in_writebox">#편입</li>
	            </ul>
	                        
                <ul class="taglist in_writebox" id="" style="display:none;"> 
                    <li class="taglist_item in_writebox">#인문</li>
                    <p class="tag_prevnext"><span class="tag_prev"><img src="images/tagtoleft.jpg"></span><span class="tag_next"><img src="images/tagtoright.jpg"></span></p>
                </ul>
                -->
	            <div class="write_button">
	                <input type="submit" value="확인" class="button_ok"/>
	                <input type="button" value="취소" class="button_cancel" onclick="" />
	            </div> 
	            
	        </div>
        </form>
   </div>
</div>

<div id="cpstalk_layer" style="display:none">
</div>
<script>
$(function(){
	$('.writing').click(function() {
		
		
		$('#writebox_layer .button_cancel').click(function() {
			$('#writebox_layer').css('display','none');
		});	
		
		<c:choose>
	    	<c:when test="${not empty memberSid}">
       		$('#writebox_layer').css('display','block');
			$('#writebox_layer .button_cancel').click(function() {
				$('#writebox_layer').css('display','none');
			});
			</c:when>
			<c:otherwise>
			alert("글쓰기를 위해서는 로그인이 필요합니다");	
			</c:otherwise>
		</c:choose>
	});
	
	$('#writebox_layer').on('click', function (e) {
        //Check whether click on modal-content
        if (e.target !== this)
            return;
        $(this).hide();
    });
})


 
 var imagePreview = function(input, imgNode) {
 	if(input.files && input.files[0]){
 		var file = input.files[0];	
 		var reader = new FileReader();
 		reader.onload = function(e) {
 			$(imgNode).attr('src', e.target.result);
 	    }
 		reader.readAsDataURL(input.files[0]);
 	}
 };

 $('#cpstalk_upload_image').on('change', function(){
     imagePreview(this, "#preview_image");
 });



$(function() {   
	$(".post_title").click(function(e){	
		var parentNode = e.target.parentElement;
		var postNum = parentNode.getElementsByClassName("post_num")[0].value;
		$.ajax({
	        url:'/board/' + postNum
	            ,type:"get"
	            ,success:function(post){
	            	
	            	var postLayer = document.getElementById("cpstalk_layer")
	            	postLayer.innerHTML = post;
	            	postLayer.style.display = "block";
	            	
	            	handleComment();
	            	
	            	$("#del_file").click(function(){
	            		delete_file(postNum);
	            	});
	            	
	            	$("#upload_image_in_post").on('change', function(){
	                    imagePreview(this, "#image_preview_in_post");
	                });
	            	
	            	$("#post_delete_btn").click(function(){
	                    delete_post(postNum);
	                });
	            	
	            	$("#post_update_btn").click(function(){
	            		update_post();
	            	});
	            	
	            	$('#cpstalk_layer_close').click(function() {
	            		postLayer.style.display = "none";
            		});
	            }
	            ,error:function(err){
	            	alert('postnum ajax err');
	            	alert(JSON.stringify(err));
	            }
		})
	});
});

function delete_file(postNum){
	$("#upload_image_in_post").css("display", "block");
	$("#del_file").css("display", "none");
	$("#image_view_in_post").attr("src", "");
	$.ajax({
		url:'/board/delete_file'
	    ,type:"post"
	    ,data : {"postNum":postNum}
		,success : function(msg){
			alert(msg);	
		} 
		,error: function(err){
			alert("del file ajax err")
		}
	});
}

function update_post(){
	var form = new FormData(document.getElementById('post_update_form'));
	$.ajax({
	    url:'/board/update'
	    ,type:"post"
	    ,data : form
	    ,contentType:false
	    ,processData:false
	   	,success:function(msg){
	  		console.log("post update ajax suc");
	  		alert(msg);
	   	},error:function(err){
	   		alert('postupdate ajax err');
	       	alert(JSON.stringify(err));
	   	}
	});
}

function delete_post(postNum){
	$.ajax({
	    url:'/board/delete'
	    ,type:"post"
	    ,data : {"postNum" : postNum}
	   	,success:function(msg){
	  		console.log("post delete ajax suc");
	  		alert(msg);
	  		location.href="/board";
	  		
	   	},error:function(err){
	   		alert('post delete ajax err');
	       	alert(JSON.stringify(err));
	   	}
	});
}

function handleComment(){
	$("#reply_button").click(function(e){
		$.ajax({
			url:'/board/write_comment'
			,type:"post"
			,data: {postNum : $("#post_num").val(),
				commentContent : $("#commentContent").val(),}
			,success:function(data){
				$("#reply_wrap").html(data);
			}
			,error:function(err){
				alert("ajax err");
				alert(JSON.stringify(err));
			}
		});
	});
}


</script>




</body>
</html>

