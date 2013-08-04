﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
    <script type="text/javascript" src="<%=basePath%>plugin/editor/kindeditor-min.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/editor/lang/zh_CN.js"></script>
    <script type="text/javascript">
    var editor;
	KindEditor.ready(function(K) {
		var item =['source', '|', 'undo', 'redo', '|', 'preview', 'print', 'code', 'cut', 'copy', 'paste',
		           'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
		           'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
		           'superscript', 'clearhtml', 'quickformat', '/',
		           'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
		           'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image',
		           'table', 'hr', 'emoticons', , 'pagebreak',
		           'anchor', 'link', 'unlink', '|', 'about'];
		editor = K.create('#editor_id', {
	        width : '600px',
	        height:'416px',
	        items :item,
	        resizeType:0,
	        uploadJson:'<%=basePath%>sys/arctype_uploadKindEditorImg'  
		});
	});

		$(function(){
   			$("#btn_submit").click(function(){
   				if($('#editForm').valid()){
	 	   			$("#btn_submit").attr("disabled","true");
	 	   			$.post("<%=basePath%>sys/arctype_doEdit",$("#editForm").serialize(),function(data){
		  	   			if(data.result=="success"){
		 						$('#editForm_atctype_id').val(data.id);
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
    <s:hidden name="arctype.id"/>
    <div class="top">
        <div class="t_left"></div>
        <div class="t_content"><a href="<%=basePath%>jsp/admin/main.jsp">首页</a>><a href="<%=basePath%>sys/arctype_toList">分类列表</a>>添加分类</div>
        <div class="t_right"></div>
        <div class="clear"></div>
    </div>
    <div class="content">
        <div class="c_l"></div>
        <div class="c_c">
            <table border="0" cellpadding="0" cellspacing="0" class="table">
                <tr>
                    <td width="120px" height="25px" align="right">标题名称：</td>
                    <td><s:textfield name="arctype.typename" cssStyle="width:200px;" cssClass="{required:true,maxlengthCN:50}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">SEO标题：</td>
                    <td><s:textfield name="arctype.seotitle" cssStyle="width:400px;" cssClass="{required:true,maxlengthCN:200}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">关键词：</td>
                    <td><s:textfield name="arctype.keyword" cssStyle="width:400px; height:60px;" cssClass="{required:true,maxlengthCN:200}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">描述：</td>
                    <td><s:textarea name="arctype.description" cssStyle="width:400px; height:60px;" cssClass="{required:true}"/></td>
                </tr>
                <tr>
                    <td align="right" height="25px">所属分类：</td>
                    <td>
                    	<s:select name="arctype.topid" list="arctypes" listKey="id" listValue="typename" headerKey="" headerValue="--请选择--" cssClass="{required:true}"></s:select>
                    </td>
                </tr>
                <tr>
                    <td align="right" height="25px">排序：</td>
                    <td><s:textfield name="arctype.sort" cssStyle="width:200px;" cssClass="{required:true,digits:true,max:9}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">内容：</td>
                    <td align="left">
                    	<textarea id="editor_id" style="float:left;"></textarea>
                    	<s:hidden name="arctype.contents"/>
                    	<div class="clear"></div>
                    </td>
                </tr>
                <tr>
                    <td height="45px"></td>
                    <td>
                        <input type="button" id="btn_submit" class="btn_submit" value="提交" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="c_r"></div>
        <div class="clear"></div>
    </div>
    <div class="bottom">
        <div class="b_l"></div>
        <div class="b_r"></div>
        <div class="clear"></div>
    </div>
    </s:form>
</body>
</html>
