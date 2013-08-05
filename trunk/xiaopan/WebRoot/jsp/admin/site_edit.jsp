<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<base href="<%=basePath%>">
    <title>无标题页</title>
    <link site="text/css" href="<%=basePath%>css/admin/common.css" rel="Stylesheet" />
    <link site="text/css" href="<%=basePath%>css/admin/tab.css" rel="Stylesheet" />
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
    <script language="javascript" src="<%=basePath%>js/common/validation.js"></script>
    <script language="javascript" src="<%=basePath%>js/common/json2.js"></script>
    <script language="javascript">
        $(function() {
        	$("#btn_submit").click(function(){
   				if($('#editForm').valid()){
	 	   			$("#btn_submit").attr("disabled","true");
	 	   			$.post("<%=basePath%>sys/site_doEdit",$("#editForm").serialize(),function(data){
	 	   				data = JSON.parse(data);
		  	   			if(data.result=="success"){
		  	   					alert("编辑成功!");
		 						$('#editForm_site_id').val(data.id);
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
    <s:hidden name="site.id"/>
    <div class="top">
        <div class="t_left"></div>
        <div class="t_content"><strong>添加站点</strong></div>
        <div class="t_right"></div>
        <div class="clear"></div>
    </div>
    <div class="content">
        <div class="c_l"></div>
        <div class="c_c">
            <table border="0" cellpadding="0" cellspacing="0" class="table">
                <tr>
                    <td width="120px" height="25px" align="right">站点名称：</td>
                    <td><s:textfield name="site.name" cssStyle="width:200px;" cssClass="{required:true,maxlengthCN:80}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">描述：</td>
                    <td><s:textarea name="site.description" cssStyle="width:400px; height:60px;" cssClass="{required:true,maxlengthCN:200}"/></td>
                </tr>
                <tr>
                    <td align="right" height="25px">排序：</td>
                    <td><s:textfield name="site.sort" cssStyle="width:200px" cssClass="{required:true,digits:true,max:9}"/></td>
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
