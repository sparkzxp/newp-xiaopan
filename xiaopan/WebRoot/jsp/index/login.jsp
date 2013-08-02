<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("app.name.cn")}'/>_登录</title>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>plugin/dialog/dialog.js"></script>

<style type="text/css">
*{margin:0px;
padding:0px;}
body{
	background-color: #102954;	
	}
#login_bg {
	background-image: url(images/img/login.png);
	width: 1024px;
	margin-right: auto;
	margin-left: auto;
}
#login_bg form {
	height: 240px;
	width: 435px;
	margin-right: auto;
	margin-left: auto;
	padding-top: 320px;
}
#login_bg form input {
	background-color: transparent;
	border: none;
	line-height: 75px;
	height: 75px;
	width: 300px;
	float: right;
	font-size: 36px;
	color: #FFF;
}
#login_bg form a {
	background-image: url(images/img/login_button.png);
	height: 49px;
	width: 146px;
	text-align: center;
	display: block;
	line-height: 49px;
	color: #FFF;
	text-decoration: none;
	font-size: 18px;
	font-family: "微软雅黑", "黑体";
	float: left;
	margin-top: 30px;
	margin-right: 10px;
	margin-left: 10px;
}
#login_bg form a:hover {
	background-image:url(images/img/login_button_hover.png);
}
</style>
<SCRIPT type="text/javascript">
$(document).ready(function(){
	$("#login_bg").css("height",document.documentElement.clientHeight+"px");
	if(window.parent!=window){
		top.location.href = "<%=basePath%>";
	}
	
	if($('#user_loginName').val()==''){
		$('#user_loginName').focus();
	}else if($('#user_password').val()==''){
		$('#user_password').focus();
	}
	document.onkeydown = function(e){
		var ev = document.all ? window.event : e;
		if(ev.keyCode==13) {
			if($('#user_loginName').val()==''){
				$('#user_loginName').focus();
			}else if($('#user_password').val()==''){
				$('#user_password').focus();
			}else{
				submitForm1();
			}
		};
	};
	
	if($('#form1_failureReason').val() != ''){
		$.tips($('#form1_failureReason').val());
	} 
});

function submitForm1(){
	if($.trim($("#user_loginName").val())==""){
		$.tips("用户名不能为空!");
	}else if($.trim($("#user_password").val())==""){
		$.tips("密码不能为空!");
	}else{
		$("#user_loginName").val($.trim($("#user_loginName").val()));
		$("#form1").submit();
	}
}
</SCRIPT>
</head>

<body>
<div id="login_bg">
  <s:form id="form1" name="form1" method="post"  namespace="/sys" action="user_login">
    	<s:textfield name="user.loginName" id="user_loginName"/>
        <s:password name="user.password" id="user_password"/>
        <s:hidden name="failureReason"/>
      	<a href="<%=basePath%>regist/reg_toRegist">注　册</a>
   	  	<a href="javascript:submitForm1();">登　录</a> 
   	  	<!-- <a href="javascript:void(0)" style="background-image:none; display:inline; width:60px; font-size:14px;">忘记密码</a> -->
   </s:form>
</div>
</body>
</html>
