<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>校畔网 后台管理 登陆个人管理</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/admin/common.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/admin/login.css" />
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
    <script type="text/javascript">
	$(document).ready(function(){
		$("#login_bg").css("height",document.documentElement.clientHeight+"px");
		if(window.parent!=window){
			top.location.href = "<%=basePath%>admin";
		}
		
		if($('#loginForm_user_username').val()==''){
			$('#loginForm_user_username').focus();
		}else if($('#loginForm_user_password').val()==''){
			$('#loginForm_user_password').focus();
		}
		document.onkeydown = function(e){
			var ev = document.all ? window.event : e;
			if(ev.keyCode==13) {
				if($('#loginForm_user_username').val()==''){
					$('#loginForm_user_username').focus();
				}else if($('#loginForm_user_password').val()==''){
					$('#loginForm_user_password').focus();
				}else{
					submitLoginForm();
				}
			};
		};
	});
	
	function submitLoginForm(){
		if($.trim($("#loginForm_user_username").val())==""){
			$.tips("用户名不能为空!");
		}else if($.trim($("#loginForm_user_password").val())==""){
			$.tips("密码不能为空!");
		}else{
			$("#loginForm_user_username").val($.trim($("#loginForm_user_username").val()));
			$("#loginForm").submit();
		}
	}
	</script>
	<style type="text/css">
	.code_validate {
		height: 30px;
		width: 77px;
	}
	</style>
</head>
<body>
    <s:form id="loginForm" name="loginForm" method="post" namespace="/sys" action="user_login">
        <div class="login">
            <img src="<%=basePath%>css/images/login_logo.jpg" alt="" />
            <div class="l_c">
                <div class="error"><s:property value="failureReason"/></div>
                <table border="0">
                    <tr>
                        <td align="right">用户名：</td>
                        <td><s:textfield name="user.username" cssStyle="width:100px;"/></td>
                    </tr>
                    <tr>
                        <td align="right">密码：</td>
                        <td><s:password name="user.password" cssStyle="width:100px;"/></td>
                    </tr>
                    <tr>
                        <td align="right">验证码：</td>
                        <td>
				            <input type="text" id="kaptcha" name="kaptcha" maxlength="4" class="code_frame" required="true">
				            <span> <img src="<%=basePath%>sys/kaptcha" class="code_validate" id="kaptchaImage" style="cursor: pointer" onClick="document.getElementById('kaptchaImage').src='<%=basePath%>sys/kaptcha?update='+Math.random();"/> 
				            </span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="button" class="btn" value="提交" 
                                onclick="submitLoginForm()" />
                            <input type="reset" value="重置" class="btn" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="l_bottom"><P>Copyright &copy; 2013-2014 <a href="<%=basePath%>web/main_toShow">返回首页</a></P></div>
    </s:form>
</body>
</html>
