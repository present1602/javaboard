<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.mbskin{width:620px; margin:0 auto; border:1px solid #ccc; margin:20px auto;padding:30px;}
.user_join{width:430px; padding-left:200px; margin:0 auto; margin-top:40px; position:relative;}
.user_join .user_upload{position:absolute; top:0; left:0;}
.user_join .user_upload .user_pic{}
.user_join .user_upload .user_pic img{border:1px solid #e3e3e3;}
.user_join .user_upload  label{display:block; border:1px solid #064984; width:150px; font-size:13px; line-height:13px; color:#064984; padding:10px 0; text-align:center; margin-top:10px; border-radius:35px;}
.user_join .user_upload #user_file{display:none;}
.user_join .join_info{}
.user_join .join_info dt{clear:both; width:110px; float:left; line-height:34px; margin-bottom:12px}
.user_join .join_info dt label{font-size:13px; color:#333; font-weight:bold;}
.user_join .join_info dd{float:left; width:310px; margin-bottom:12px}
.user_join .join_info dd .it_txt{width:100%; height:34px; border:1px solid #e3e3e3; background-color:#f7f7f7; text-indent:10px; font-size:13px; line-height:40px; color:#333; font-family:'Doutm', serif;}
.user_join .join_info dd .it_txt_200{width:200px; height:34px; border:1px solid #e3e3e3; background-color:#f7f7f7; text-indent:10px;}
.user_join .join_info dd .it_area{width:100%; height:80px; border:1px solid #e3e3e3; background-color:#f7f7f7; box-sizing:border-box; padding:10px; resize:none; font-size:13px; line-height:20px; color:#333; font-family:'dotum', serif;}
.user_join .join_info dd .it_duplicate{width:80px; height:34px; border:0 none; background-color:#a6a6a6; font-size:12px; color:#fff; text-align:center; font-weight:bold; margin-left:8px; cursor:pointer;}

.join_ps{font-size:13px; line-height:20px; color:#333; text-align:center; margin-top:20px;}
.join_btn{margin-top:30px; text-align:center;}
.join_btn .btn_ok{width:90px; height:34px; background-color:rgba(65,128,255,1); font-size:13px; color:#fff; font-weight:bold; text-align:center; border:0 none; margin:0 3px; cursor:pointer;}
.join_btn .btn_modify{width:90px; height:34px; background-color:rgba(65,128,255,1); font-size:13px; color:#fff; font-weight:bold; text-align:center; border:0 none; margin:0 3px; cursor:pointer;}
.join_btn .btn_cancel{width:90px; height:34px; background-color:#ccc; font-size:13px; color:#fff; font-weight:bold; text-align:center; border:0 none; margin:0 3px; cursor:pointer;}
.join_btn .btn_del{width:90px; height:34px; background-color:#4c4c4c; font-size:13px; color:#fff; font-weight:bold; text-align:center; border:0 none; margin:0 3px; cursor:pointer;}

</style>
</head>
<body>

<%@ include file="header.jsp" %>
  

<div class="mbskin mbbox">
    
    <form id="fregisterform" name="fregisterform" action="/member/signup" 
        method="post" enctype="multipart/form-data">
       
	<h2 class="title_center"><strong>회원가입</strong></h2>
    <div class="user_join" style="padding-left: 0;">
        <dl class="join_info">
			<dt><label for="email">이메일아이디</label></dt>
			<dd><input type="text" name="email" class="it_txt" id="emailInput" required value="em@naver.com"></dd>
			<p id="checkEmailMsg" style="text-align:center; color:red; margin-bottom:8px;"></p>
			<dt><label for="password">비밀번호</label></dt>
			<dd><input type="password" name="password" value="1234" id="user_pw" class="it_txt" required /></dd>
			<dt><label for="password2">비밀번호 확인</label></dt>
			<dd><input type="password" name="password2" value="1234" id="user_pw2" class="it_txt" required /></dd>
			<dt><label for="nick">닉네임</label></dt>
			<dd><input type="text" name="nick" required  value="nick00" id="reg_mb_nick" class="it_txt"/>
			</dd>
			<dt><label for="username">이름</label></dt>
			<dd><input type="text" name="username" required  value="이름" id="user_name" class="it_txt"/></dd>
			<dt><label for="user_hp">휴대폰</label></dt>
			<dd><input type="text" name="phone" required value="010000" id="reg_mb_hp" class="it_txt"/></dd>
			<dt><label for="user_sc">학교</label></dt>
			<dd><input type="text" name="univ" value="한국대" id="user_sc" class="it_txt"/></dd>
			<dt><label for="user_major">전공</label></dt>
			<dd><input type="text" name="major" value="경영" id="user_major" class="it_txt"/></dd>
			
			<dt><label for="user_image">프로필이미지</label></dt>
			
			
			<img id="imgPreview" src="/resources/images/profile_default2.jpg" style="width:70px; height:70px;border-radius:35px;">
			<input type="file" id="profile_image" name="profile_image">
          	
		</dl>
	</div>
	<div class="clear"></div>
		<div class="join_btn">
		<input type="submit" name="" value="확인" class="btn_ok"/><input type="button" name="" value="취소" class="btn_cancel"/>
	</div>



    </form>

    <script>
    $(function() {
        /* $("#reg_zip_find").css("display", "inline-block"); */

    	$("#emailInput").focusout(function(e){
    		var emailText = e.target.value;
    		$("#checkEmailMsg").html("");
    		/* alert("fs emailText : " + emailText); */
    		$.ajax({
    			url : "/member/emailCheck?text=" + emailText,
    			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    			success : function(data){
    				if(data == "email exists"){
    					$("#checkEmailMsg").html("이미 가입된 이메일입니다");
    				}
    			},
    			error : function(err){
    				alert(JSON.stringify(err));
    			}
    			
    		});
    	});
    });

    // submit 최종 폼체크
    function fregisterform_submit(f)
    {
        // 회원아이디 검사
        if (f.w.value == "") {
            var msg = reg_mb_id_check();
            if (msg) {
                alert(msg);
                f.mb_id.select();
                return false;
            }
        }

        if (f.w.value == "") {
            if (f.mb_password.value.length < 3) {
                alert("비밀번호를 3글자 이상 입력하십시오.");
                f.mb_password.focus();
                return false;
            }
        }

        if (f.mb_password.value != f.mb_password_re.value) {
            alert("비밀번호가 같지 않습니다.");
            f.mb_password_re.focus();
            return false;
        }

        if (f.mb_password.value.length > 0) {
            if (f.mb_password_re.value.length < 3) {
                alert("비밀번호를 3글자 이상 입력하십시오.");
                f.mb_password_re.focus();
                return false;
            }
        }

        // 이름 검사
        if (f.w.value=="") {
            if (f.mb_name.value.length < 1) {
                alert("이름을 입력하십시오.");
                f.mb_name.focus();
                return false;
            }

            /*
            var pattern = /([^가-힣\x20])/i;
            if (pattern.test(f.mb_name.value)) {
                alert("이름은 한글로 입력하십시오.");
                f.mb_name.select();
                return false;
            }
            */
        }

        
        // 닉네임 검사
        if ((f.w.value == "") || (f.w.value == "u" && f.mb_nick.defaultValue != f.mb_nick.value)) {
            var msg = reg_mb_nick_check();
            if (msg) {
                alert(msg);
                f.reg_mb_nick.select();
                return false;
            }
        }

		/*
        // E-mail 검사
        if ((f.w.value == "") || (f.w.value == "u" && f.mb_email.defaultValue != f.mb_email.value)) {
            var msg = reg_mb_email_check();
            if (msg) {
                alert(msg);
                f.reg_mb_email.select();
                return false;
            }
        }
		*/

                // 휴대폰번호 체크
        var msg = reg_mb_hp_check();
        if (msg) {
            alert(msg);
            f.reg_mb_hp.select();
            return false;
        }
        
        if (typeof f.mb_10 != "undefined") {
            if (f.mb_10.value) {
                if (!f.mb_10.value.toLowerCase().match(/.(gif)$/i)) {
                    alert("회원아이콘이 gif 파일이 아닙니다.");
                    f.mb_10.focus();
                    return false;
                }
            }
        }

        

        if (!chk_captcha()) return false;

        document.getElementById("btn_submit").disabled = "disabled";

        return true;
    }

	function mb_id_exist(){
		var msg = reg_mb_id_check();
		if (msg) {
			$("#mb_id_msg").text(msg);
			f.mb_id.select();
			return false;
		}else
			$("#mb_id_msg").text("사용 가능한 아이디입니다.");
	}
    </script>

</div>

<script>

$("#profile_image").change(function(e) {
    readURL(this)
});

function readURL(input) {
	var path = input.value;
	
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$('#imgPreview').attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}
</script>

</body>
</html>