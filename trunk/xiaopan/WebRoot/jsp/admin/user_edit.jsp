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
    <script language="javascript" src="<%=basePath%>js/common/validation.js"></script>
    <script language="javascript" src="<%=basePath%>js/common/json2.js"></script>
    <script language="javascript">
        $(function() {
        	if($('#editForm_user_id').val() == ''){
        		$('.pwd').show();
        	}
        	
        	$("#btn_submit").click(function(){
   				if($('#editForm').valid()){
	 	   			$("#btn_submit").attr("disabled","true");
	 	   			$.post("<%=basePath%>sys/user_doEdit",$("#editForm").serialize(),function(data){
	 	   				data = JSON.parse(data);
		  	   			if(data.result=="success"){
		  	   					alert("编辑成功!");
		 						$('#editForm_user_id').val(data.id);
		 					}else if(data.result=="error"){
		 						alert("编辑失败!");
		 					}else{
		 						alert(data.result);
		  				}
		  	   			$("#btn_submit").removeAttr("disabled");
		 			});
	   			}
   	   		});
        });
    </script>
</head>
<body>
    <s:form name="editForm" id="editForm">
    <s:hidden name="user.id"/>
    <div class="top">
        <div class="t_left"></div>
        <div class="t_content"><strong>添加用户</strong></div>
        <div class="t_right"></div>
        <div class="clear"></div>
    </div>
    <div class="content">
        <div class="c_l"></div>
        <div class="c_c">
            <table border="0" cellpadding="0" cellspacing="0" class="table">
                <tr>
                    <td width="120px" height="25px" align="right">用户名称：</td>
                    <td><s:textfield name="user.username" cssStyle="width:200px;" cssClass="{required:true,maxlengthCN:200}"/></td>
                </tr>
                <tr class="pwd" style="display: none;">
                    <td width="120px" height="25px" align="right">用户密码：</td>
                    <td><s:password name="user.password" cssStyle="width:200px;" cssClass="{required:true,minlength:6,maxlength:20}"/></td>
                </tr>
                <tr class="pwd" style="display: none;">
                    <td width="120px" height="25px" align="right">确认密码：</td>
                    <td><input type="password" id="repeatPwd" style="width:200px;" class="{required:true,minlength:6,maxlength:20,equalTo:'#editForm_user_password'}"/></td>
                </tr>
                <tr>
                    <td align="right" height="25px">角色名称：</td>
                    <td><s:select name="user.role.id" list="roles" listKey="id" listValue="name" headerKey="" headerValue="--请选择--" cssClass="{required:true}"></s:select></td>
                </tr>
                <tr>
                    <td height="45px"></td>
                    <td>
                        <input type="button" id="btn_submit" class="btn_submit" value="提交"/>
                    </td>
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
