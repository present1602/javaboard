<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"   isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
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
  
 	<link href="<c:url value="/resources/css/common.css" />" rel="stylesheet">
 	
	<script src="<c:url value="/resources/js/jquery-3.2.1.js" />"></script>
	<script src="<c:url value="/resources/js/basic.js" />"></script>
</head>
<body>
  <%@ include file="header.jsp" %>
  
  <div id="mainboard">
		<div id="left_sidebar">
			<div class="user_area">
				<c:choose>
					<c:when test="${memberSid != null}">
						<img class="profile_main" 
							src="resources/upload/${memberImage}" 
							style="width:100px; height:100px; border-radius:50px">
						<p>${memberName}</p>
						<p>${memberSid}</p>
						
						<p id="logout_button">
							<a href="#">로그아웃</a>
						</p>

					</c:when>
					<c:otherwise>

						<img class="profile_main"
							src="resources/images/profileimage_default.gif">
						<p id="login_button">
							<a href="#">로그인하기</a>
						</p>
						<p id="signup_button">
							<a href="public/signup.html">회원가입</a>
						</p>

					</c:otherwise>
				</c:choose>
			</div>
		</div>

		<div id="boardbox"> <!--캠퍼스톡보드박스 시작--> 
            <p class="tagtoggle"><img src="images/tagopen.jpg"></p>
            <ul class="toptag">
                <a href="#"><li class="taglist_item toptag_item">#어학2</li></a>
                <a href="#"><li class="taglist_item toptag_item">#취업</li></a>
                <a href="#"><li class="taglist_item toptag_item">#공모전</li></a>
                <a href="#"><li class="taglist_item toptag_item">#편입</li></a>
            </ul>
            
            <!-- <ul class="taglist" id="" style="display:none;"> 
                <a href="#"><li class="taglist_item">#인문</li></a>
            	<p class="tag_prevnext"><span class="tag_prev"><img src="images/tagtoleft.jpg"></span><span class="tag_next"><img src="images/tagtoright.jpg"></span></p>
            </ul> -->

            <!-- <div id="cpstalk_searchbox">
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
                <div class="listtype">
                	<span id="listview_opt1"><img src="images/listtype2.gif"></span>
                    <span id="listview_opt2"><img src="images/listtype1.gif"></span>
                </div>	

                <div class="clear"></div>
			</div>
 <c:forEach var="member" items="${membersList}" >     
   <tr align="center">
      <td>${member.id}</td>
      <td>${member.pwd}</td>
      <td>${member.name}</td>
      <td>${member.email}</td>
      <td>${member.joinDate}</td>
      <td><a href="${contextPath}/member/removeMember.do?id=${member.id }">삭제하기</a></td>
    </tr>
  </c:forEach>   
</table>
            <ul id="cpstalk_list">
            	 <c:forEach var="post" items="${postlist}" > 
            	<li class="cpstalk_listitem"> 	 
                	<table>
                    	<tr class="cpstalk_listitem_tr">
                        	<td class="user">
                            	<img class="user_pic" src="resources/upload/${post.writerImage}">
                       		</td>
                        	<td class="cpstalk_itemsummary">
                                <p class="user_info"><span class="user_nick">${post.writer} : 망고바 | 경영</span> </p>
                                <p class="text">${post.title} </p>
                                <p class="info_tag"><a href="#"><span class="tag">#토익</span></a><a href="#"><span class="tag">#토익후기</span></a>
                                </p>
                                <div class="info">    
                                    <span class="time">${post.createdAt}</span>
                                    <span class="view">${post.hit}</span>
                                    <span class="rec">5</span>
                                    <span class="cmt">57</span>
	                            </div>
                            </td>
                        </tr>	
                    </table>
                </li>
                </c:forEach> 
              
                <li class="cpstalk_listitem">  
                	<table>
                    	<tr class="">
                        	<td class="user">
                            	<img class="user_pic" src="images/profile_default2.jpg">
                       		</td>
                        	<td class="cpstalk_itemsummary">
                                <p class="user_info"><span class="user_nick">망고바 | 경영</span> </p>
                                <p class="text">토익 이번에 어려웠나요? RC 시간 모자라서 두지문 못풀었는데 점수 저번보다 떨어질까요 독해파트 신유형 메신저대화 부분 내용이 잘 이해가 안돼서..  마지막에 두지문 거의 찍다시피 풀었어요 이번토익이 난이도가 높았던걸까요 그냥 제가 망할 걸까요 </p>
                                <p class="info_tag"><a href="#"><span class="tag">#토익</span></a><a href="#"><span class="tag">#토익후기</span></a>
                                </p>
                                <div class="info">    
                                    <span class="time">2시간 전</span>
                                    <span class="view">43</span>
                                    <span class="rec">5</span>
                                    <span class="cmt">57</span>
	                            </div>
                            </td>
                        </tr>	
                    </table>
                </li>
                
            </ul>
            <!-- 유저레이어--> 
            <div id="user_layer">
                <div class="user_info">
                    <p class="user_pic"><img src="images/profile_default2.jpg" width="50" height="45" alt="" /></p>
                    <p class="user_id">perser@naver.com</p>
                    <p class="user_nick">닉네임 : 망고바</p>
                    <p class="user_school">학교 : 비공개</p>
                    <p class="user_major">전공 : 경영</p>
                    <div class="user_cmt">
                        코멘트(소개)
                    </div>
                    <a href="#" class="user_info_btn">작성글보기</a>
                    <span class="user_layer_close"><img src="http://campust.eowork.co.kr/theme/campust/images/user_layer_close.jpg"  alt="" /></span>
                </div>
			</div> <!-- 유저레이어끝-->

          </div>   <!--보드박스 끝-->
          <div id="contents_sidebar">
        	<p>Daily UP</p>
            <br>
            <ul>
            	<li><a href="#">미러리스 추천 좀 해주세요</a></li>
                <li><a href="#">학사편입 질문입니다</a></li>
                <li><a href="#">토익 만료가 다음달인데 다시 봐야할까요?</a></li>
                <li><a href="#">앱개발 배우고 싶은데 독학 힘들겠죠?</a></li>
                <li><a href="#">복수전공과 부전공 차이가 뭘까요?</a></li>
                <li><a href="#">노트북 가벼우면서 성능 적당히 괜찮은 걸로 추천 좀 해주세요</a></li>
                <li><a href="#">싱가폴 교환학생 갔다오신분 계신가요?</a></li>
                <li><a href="#">신입생인데 미련이 좀 남아서 반수해볼까요 해요 해보신분들</a></li>
            </ul>
        
          </div>   
           
        <!-- <div id="right_sidebar">
        	<p><a href="#"><img src="images/adbanner1.jpg"></a></p>
        	<p><a href="#"><img src="images/adbanner2.jpg"></a></p>
        	<p><a href="#"><img src="images/adbanner3.jpg"></a></p>
        	
        </div> -->
    
        <div class="clear"></div>
      </div> <!--메인보드 끝--> 
 
 
 
<style>


#writebox_layer{position:fixed;display:none;width:100%;height:100%;top:0px;left:0px;background:rgba(0,0,0,0.7); z-index:99; position: fixed; margin: 0px auto; }

/**#write_box *{outline:1px solid green} **/
#write_box{width:650px; overflow-y:scroll; padding:40px; margin:0 auto; margin-top:30px; border:1px solid rgba(242,242,242,1); background:#fff; overflow-y:auto;max-height:calc(80vh)}

.writebox_sub{border:1px solid #e3e3e3; width:100%; border-top:0}
.writebox_sub .upload_image{text-align:center; width:62px;}
.writebox_sub .upload_video{text-align:center; width:68px;}
.writebox_sub #upload_image_button{background-color:rgba(234,234,242,1); border-radius:5px; border:0; padding:3px 12px}
.writebox_sub #upload_file_button{background-color:rgba(234,234,242,1); border-radius:5px; border:0; padding:3px 12px;}
.writebox_sub #filename{width:400px; border:1px solid rgba(232,232,232,1);height:20px}

#write_box .write_title{width:100%; height:42px; border:1px solid #e3e3e3; font-size:14px; line-height:50px; color:#333; margin-top:10px; text-indent:13px; box-sizing:border-box;}
#write_box .write_tag{width:100%; height:42px; border:1px solid #e3e3e3; font-size:14px; line-height:50px; color:#333; margin-top:15px; margin-bottom:10px; text-indent:13px; box-sizing:border-box;}

#write_box .write_content{display:block; width:100%; height:240px; border:1px solid #e3e3e3; font-size:13px; line-height:22px; color:#333; margin-top:10px; padding:13px; box-sizing:border-box;}

#write_box .write_file{position:relative; padding-left:95px; margin-top:20px;}
#write_box .write_file h3{width:75px; font-size:15px; line-height:15px; color:#333; padding-left:20px; position:absolute; top:0; left:0;}
#write_box .write_button{margin-top:30px; text-align:center;}
/*.write_box .write_btn .btn_ok{width:135px; height:40px; background-color:#064984; font-size:16px; color:#fff; font-weight:bold; text-align:center; border-radius:40px; border:0 none; margin:0 3px; cursor:pointer;}
.write_box .write_btn .btn_cancel{width:135px; height:40px; background-color:#4c4c4c; font-size:16px; color:#fff; font-weight:bold; text-align:center; border-radius:40px; border:0 none; margin:0 3px; cursor:pointer;}
*/

#write_box .write_button .button_ok{width:90px; height:34px; background-color:rgba(65,128,255,1); font-size:13px; color:#fff; font-weight:bold; text-align:center; border:0 none; margin:0 3px; cursor:pointer;}
#write_box .write_button .button_modify{width:90px; height:34px; background-color:rgba(65,128,255,1); font-size:13px; color:#fff; font-weight:bold; text-align:center; border:0 none; margin:0 3px; cursor:pointer;}
#write_box .write_button .button_cancel{width:90px; height:34px; background-color:#ccc; font-size:13px; color:#fff; font-weight:bold; text-align:center; border:0 none; margin:0 3px; cursor:pointer;}
#write_box .write_button .button_del{width:90px; height:34px; background-color:#4c4c4c; font-size:13px; color:#fff; font-weight:bold; text-align:center; border:0 none; margin:0 3px; cursor:pointer;}

.in_writebox .toptag_item{}
.in_writebox .taglist_item{}

.write_content_box textarea{border:0; resize:none;}
.writebox_top{width:100%; display:table; height:50px;}

#write_box .write_file{position:relative; padding-left:95px; margin-top:20px;}
#write_box .write_file h3{width:75px; font-size:15px; line-height:15px; color:#333; padding-left:20px; position:absolute; top:0; left:0;}
#write_box .write_button{margin-top:30px; text-align:center;}


.preview_imagelist img{max-width:120px; max-height:120px; padding:10px;}

</style> 

<div id="writebox_layer">
    <div id="write_box">
    	<form method="post" action="/board/write" enctype="multipart/form-data">
	        <h2 class="">
	            <strong><span class="icon"><img src="resources/images/write_icon.jpg" style="width:22px" alt="" /></span> CAMPUS TALK</strong>
	        </h2>
	            <input type="text" name="title" value="" id="wr_subject" required class="write_title" placeholder="제목" />
	            <div class="write_content_box">
	                <textarea id="wr_content" name="content" class="write_content" maxlength="65536">
	                </textarea>
	                <div class="preview_imagelist" style="border:1px solid #e3e3e3">
	                                        
	                </div>
	                <table class="writebox_sub">
	                <input type="file" name="image_upload" id="cpstalk_upload_image">
	            
	            </div>
	           <!--  <input type="text" name="" value="" id="" required class="write_tag" placeholder="태그" /> -->
	     
	            <p class="tagtoggle" style="position:relative;float:right;"><img src="images/tagopen.jpg"></p>
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
	            <div class="write_button">
	                <input type="submit" title="" name="" value="확인" class="button_ok"/>
	                <input type="button" title="" name="" value="취소" class="button_cancel" onclick="" />
	            </div>
	        </div>
        </form>
   </div>

<script>
$(function(){
	$('.writing').click(function() {
		$('#writebox_layer').css('display','block');
		
		$('#writebox_layer .button_cancel').click(function() {
			$('#writebox_layer').css('display','none');
		});	
	})
	
	;
	$('#writebox_layer').on('click', function (e) {
        //Check whether click on modal-content
        if (e.target !== this)
            return;
        $(this).hide();
    });
})


function cpstalkImageUploadClick(){
    var imageinput = document.getElementById("cpstalk_upload_image");
    imageinput.click();
}
//images preview in browser
$(function() {    
    var imagePreview = function(input, insertImagePreview) {
    	/*
    	var fileinput = document.getElementById("cpstalk_upload_file");
    	var textinput = document.getElementById("filename");
    	textinput.value = fileinput.value;
    	*/
        if (input.files) {
            var filesAmount = input.files.length;
            for (i = 0; i < filesAmount; i++) {
                var reader = new FileReader();
                reader.onload = function(event) {
                    $($.parseHTML('<img>')).attr('src', event.target.result).appendTo(insertImagePreview);
                }
                reader.readAsDataURL(input.files[i]);
            }
        }

    };

    $('#cpstalk_upload_image').on('change', function(){
        imagePreview(this, 'div.preview_imagelist');
    });
});


function cpstalkFileUploadClick(){
    var fileinput = document.getElementById("cpstalk_upload_file");
    fileinput.click();
}
function cpstalkFileHandleChange(){
	
}


</script>
</body>
</html>