// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
function tmp_user(){
	var gender;
	if ($("#gender_male").attr('checked')){
		gender = "남자";
	} else if ($("#gender_female").attr('checked') ) {
		gender = "여자";
	}
	var age = $("#age").val();
	if ( gender && age ){
		var value ='{"gender": "'+gender+'", "age":"'+age+'"}';
		$.cookie('tmp_user' , value, { expires : 30000, path : '/' });
		if ($.cookie('uniq_key') == null){
			var uniq_key = new Date() + Math.random();
			$.cookie('uniq_key' , uniq_key, { expires : 30000, path : '/' });	
		}
		var replace_table = "<table class ='table'><tr><th colspan='3'>현재상태(익명 보장)</th></tr><tr><td>&nbsp;성별 : " + gender + "</td></td><td>&nbsp;연령 : " + age +"</td><td><a href='#' class='btn' onclick='tmp_user_delete(); return false;'>변경</a></tr></table>"
		$("#tmp_user").html(replace_table);
		notify('입력 완료');
	} else{
		notify('모두 입력해 주세요');
	}
}

function tmp_user_delete(){
	$.cookie('tmp_user', null, { path : '/' });
	var replace_table ='<table class ="table"><tr><th colspan="3">필수정보(익명 보장)</th></tr><tr><td>남 <input id="gender_male" name="gender" type="radio" value="male" />여<input id="gender_female" name="gender" type="radio" value="female" /></td><td>연령 <select id="age" name="age"><option value=""></option><option value="10대">10대 </option><option value="20대">20대 </option><option value="30대">30대 </option><option value="40대↑">40대↑</option></select></td><td><a href="#" class="btn" onclick="tmp_user(); return false;">확인</a></td></tr></table>'; 
	$("#tmp_user").html(replace_table);
}



