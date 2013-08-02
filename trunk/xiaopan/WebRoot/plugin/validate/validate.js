var reg_float = /^(\d+)(\.?\d{0,2})?$/;
var reg_int = /^[1-9]*[1-9][0-9]*$/;
var reg_minus = /^(-|\d?)\d+$/;
var reg_identity = /\d{15}|\d{17}(\d|x)/i;
var reg_phone = /(\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$/;
var reg_negative = /^(-?\d+)(\.?\d{0,2})?$/;
var reg_email = /^(\w)+(\.\w+)*@(\w)+((\.\w{2,3}){1,3})$/;
var reg_simplePhone = /^[-0-9]{7,20}$/;
$(document).ready(function(){
	initValidate();
});
function initValidate(){
	//初始化悬浮气泡
	$(".notempty").each(function(){
		var tag = this.tagName;
		power($(this),tag == "INPUT" ? "必填项,请输入内容" : "必选项,请选择相应的选项");
	});
	power($(".integer"),"请输入一个大于零的正整数");
	power($(".identity"),"请输入一个正确格式的身份证号码,可以是18位或15位的身份证号码,可以以x或X结尾");
	power($(".phone"),"请输入一个正确格式的电话号码,例如:010-12345678,12345678,13012345678");
	power($(".negative"),"请输入一个至多两位小数的数字,可以有符号,例如:12.5,12.55,-12.55,-12");
	power($(".float"),"请输入一个至多两位小数的数字,不能有符号,例如:12.5,12.55,12");
	power($(".email"),"请输入一个正确格式的电子邮箱,例如:jack@hotmail.com");
	power($(".minus"),"请输入一个数字,可以是零或负数");
	power($(".simplePhone"),"请输入一个介于7位和20位的电话号码,只能填-或者0到9");
}
function power(selector,msg){
	selector.attr("msg","<font style='font-size:12px;' color='#5B5B5B'>" + msg + "</font>").powerFloat({eventType:"focus",edgeAdjust:false, targetMode:"remind", targetAttr:'msg', position:"2-1"});
	return selector;
}
function checkFormat(formId){
	var selector = null;
	if(null != formId && formId.length > 0){
		selector = $("#" + formId).find(".notempty,.integer,.phone,.negative,.float,.email,.integer,.minus,.simplePhone");
	} else {
		selector = $(".notempty,.integer,.phone,.negative,.float,.email,.integer,.minus,.simplePhone");
	}
	var rslt = true;
	selector.each(function(){
		if(checkFiled($(this))){
			rslt = false
			return rslt;
		}
	});
	return rslt;
}
function notempty(s){
	if(s.is("select")){
		var val = s.find("option:selected").val();
		return val == "" || val == "0";
	} else {
		return s.val().length == "";
	}
}
function checkFiled(s){
	var val = s.val();
	var rslt = s.hasClass("notempty") && notempty(s);
	rslt += s.hasClass("integer") && val.length > 0 && !reg_int.test(val);
	rslt += s.hasClass("phone") && val.length > 0 && !reg_phone.test(val);
	rslt += s.hasClass("negative") && val.length > 0 && !reg_negative.test(val);
	rslt += s.hasClass("float") && val.length > 0 && !reg_float.test(val);
	rslt += s.hasClass("email") && val.length > 0 && !reg_email.test(val);
	rslt += s.hasClass("minus") && val.length > 0 && !reg_minus.test(val);
	rslt += s.hasClass("simplePhone") && val.length > 0 && (val=='' || !reg_simplePhone.test(val));
	if(rslt > 0){
		var msg = s.attr("msg").replace("#5B5B5B","#FF0000");
		s.attr("msg",msg);
		s.bind("change",function(){
			var msg = s.attr("msg").replace("#FF0000","#5B5B5B");
			s.attr("msg",msg);
		}).focus();
	}
	return rslt > 0;
}

var jsFile ='<link rel="stylesheet" href="plugin/validate/float.css" type="text/css"></link>'+
'<script type="text/javascript" src="plugin/validate/power.js"></script>';
document.write(jsFile);