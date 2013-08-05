<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<base href="<%=basePath%>">
    <title>无标题页</title>
    <link type="text/css" href="<%=basePath%>css/admin/common.css" rel="Stylesheet" />
    <link type="text/css" href="<%=basePath%>css/admin/tab.css" rel="Stylesheet" />
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
    <script language="javascript" src="<%=basePath%>js/common/validation.js"></script>
    <script language="javascript" src="<%=basePath%>js/common/json2.js"></script>
    <script language="javascript" src="<%=basePath%>js/admin/jquery.colorpicker.js"></script>
    <script language="javascript">
        $(function() {
        	$(".color").colorpicker({
                fillcolor: true,
                success: function(o, color) {
                    $(o).css("color",color);
                }
            });
        	
        	if($('#editForm_type_id').val() != ''){
        		$('#editForm_type_color').val('#333333');
        	}
        	
        	$("#btn_submit").click(function(){
   				if($('#editForm').valid()){
	 	   			$("#btn_submit").attr("disabled","true");
	 	   			$.post("<%=basePath%>sys/type_doEdit",$("#editForm").serialize(),function(data){
	 	   				data = JSON.parse(data);
		  	   			if(data.result=="success"){
		  	   					alert("编辑成功!");
		 						$('#editForm_type_id').val(data.id);
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
    <s:hidden name="type.id"/>
    <div class="top">
        <div class="t_left"></div>
        <div class="t_content"><strong>添加分类</strong></div>
        <div class="t_right"></div>
        <div class="clear"></div>
    </div>
    <div class="content">
        <div class="c_l"></div>
        <div class="c_c">
            <table border="0" cellpadding="0" cellspacing="0" class="table">
                <tr>
                    <td width="120px" height="25px" align="right">标题名称：</td>
                    <td><s:textfield name="type.name" cssStyle="width:200px;"/></td>
                </tr>
                <tr style="display:none;">
                    <td width="120px" height="25px" align="right">颜色：</td>
                    <td><s:textfield name="type.color" cssStyle="width:80px;" cssClass="color"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">SEO标题：</td>
                    <td><s:textfield name="type.seotitle" cssStyle="width:400px;"></s:textfield></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">关键词：</td>
                    <td><s:textfield name="type.keyword" cssStyle="width:400px; height:60px;"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">描述：</td>
                    <td><s:textarea name="type.description" cssStyle="width:400px; height:60px;"/></td>
                </tr>
                <tr>
                    <td align="right" height="25px">所属分类：</td>
                    <td>
                    	<s:select name="type.topid" list="types" listKey="id" listValue="name" headerKey="0" headerValue="顶级分类" cssClass="{required:true}"></s:select>
                    </td>
                </tr>
                <tr>
                    <td align="right" height="25px">排序：</td>
                    <td><s:textfield name="type.sort" cssStyle="width:200px" cssClass="{required:true,digits:true,max:9}"/></td>
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
