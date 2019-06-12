// JavaScript Document

$(function(){
	$('#login_button').click(function() {
		$('#login_layer').css('display','block');

	});
	$('#login_layer_close').click(function() {
	   $('#login_layer').hide();
	});
	$('#login_layer').on('click', function (e) {
        //Check whether click on modal-content
        if (e.target !== this)
            return;
        $(this).hide();
    });
})

$(function(){
	$('#login_button').click(function() {
		$('#login_layer').css('display','block');

	});
	$('#login_layer_close').click(function() {
	   $('#login_layer').hide();
	});
	$('#login_layer').on('click', function (e) {
        //Check whether click on modal-content
        if (e.target !== this)
            return;
        $(this).hide();
    });
})



$(document).ready(function(){
	$('.tagtoggle').on('click', function(){
		if($('.taglist').css('display') =='none'){
			$('.taglist').css('display','block')
		}else{
			$('.taglist').css('display', 'none');
		}
    })
});
$(document).ready(function(){
	$('#listview_opt2').click(function(){
		$('.cpstalk_listitem').find('p.text').addClass('view2')
		$('.cpstalk_listitem').find('p.text').removeClass('view1');
	});
	$('#listview_opt1').click(function(){
		$('.cpstalk_listitem').find('p.text').addClass('view1');
		$('.cpstalk_listitem').find('p.text').removeClass('view2');
	})

}) 

$(document).ready(function(){
//	$('.cpstalk_itemsummary .text').click(function() {
//		$('#cpstalk_layer').css('display','block');
//
//	});
//	$('.cpstalk_itemsummary .text').click(function() {
//		
//	});
	
	$('#cpstalk_layer_close').click(function() {
	   $("#cpstalk_layer").hide();
	});
	$('#cpstalk_layer').on('click', function (e) {
        //Check whether click on modal-content
        if (e.target !== this)
            return;

        $(this).hide();
    });
});

$(document).ready(function (){
    $('#cpstalk_layer').on('click', function (e) {
        //Check whether click on modal-content
        if (e.target !== this)
            return;

        $(this).hide();
    });
});
$(function(){
	$('.user_pic').click(function() {
		$('#user_layer').css('display','block');

	});
	$('#user_layer .user_layer_close').click(function() {
	   $('#user_layer').hide();
	});
});
$(document).ready(function (){
    $('#user_layer').on('click', function (e) {
        //Check whether click on modal-content
        if (e.target !== this)
            return;

        $(this).hide();
    });
});

function cpstalkImageUploadClick(){
    var imageinput = document.getElementById("cpstalk_upload_image");
    imageinput.click();
}


