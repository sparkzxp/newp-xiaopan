<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<base href="<%=basePath%>">
    <title>校畔网</title>
    <link type="text/css" href="<%=basePath%>css/admin/common.css" rel="Stylesheet" />
    <link type="text/css" href="<%=basePath%>css/admin/tab.css" rel="Stylesheet" />
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
    <script language="javascript" src="<%=basePath%>js/admin/global.js"></script>
    <script language="javascript" src="<%=basePath%>js/common/validation.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		$("#btn_submit").click(function(){
			if($('#editForm').valid()){
				$.post("<%=basePath%>sys/user_doManagePwd",$("#editForm").serialize(),function(data){
					if(data=="success"){
						alert("操作成功!");	
					}else if(data=="error"){
						alert("操作失败!");
   					}else{
   						alert(data);
	   				}
				});
			}
		});
	});
</script>
</head>
<body>
    <s:form id="editForm">
    <div class="top">
        <div class="t_left"></div>
        <div class="t_content"><strong>修改密码</strong></div>
        <div class="t_right"></div>
        <div class="clear"></div>
    </div>
    <div class="content">
        <div class="c_l"></div>
        <div class="c_c">
            <table border="0" cellpadding="0" cellspacing="0" class="tableg" style="margin-top:40px;">
                <tr>
                    <td width=200 align="right" height=40>新密码：</td>
                    <td><s:password name="user.password" cssStyle="width:200px;" cssClass="{required:true,minlength:6,maxlength:20}"/>
                </tr>
                <tr>
                    <td height=40 align=right>确认密码：</td>
                    <td><input type="password" id="repeatPwd" style="width:200px;" class="{required:true,minlength:6,maxlength:20,equalTo:'#editForm_user_password'}"/></td>
                </tr>
                <tr>
                    <td height=40></td>
                    <td><input type="button" id="btn_submit" value="提交"/></td>
                </tr>
            </table>
        </div>
        <div class="c_r"></div>
    </div>
    <div class="bottom">
        <div class="b_l"></div>
        <div class="b_r"></div>
        <div class="clear"></div>
    </div>
    </s:form>
</body>
</html>
