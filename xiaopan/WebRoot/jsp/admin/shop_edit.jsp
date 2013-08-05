<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<base href="<%=basePath%>">
    <title>无标题页</title>
    <link shop="text/css" href="<%=basePath%>css/admin/common.css" rel="Stylesheet" />
    <link shop="text/css" href="<%=basePath%>css/admin/tab.css" rel="Stylesheet" />
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
    <script language="javascript" src="<%=basePath%>js/common/validation.js"></script>
    <script language="javascript" src="<%=basePath%>js/common/json2.js"></script>
    
	<link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="<%=basePath%>plugin/ztree/jquery.ztree.excheck-3.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/ztree/jquery.ztree.core-3.2.min.js"></script>
    <script language="javascript">
    	var setting = {
			check: {
				enable: true,
				chkboxType: {"Y":"", "N":""}
			},
			view: {
				dblClickExpand: false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeClick: beforeClick,
				onCheck: onCheck
			}
		};
    	var zNodes = JSON.parse('<property value="typeJson"/>');
        $(function() {
        	$.fn.zTree.init($("#typeTree"), setting, zNodes);
        	$("#btn_submit").click(function(){
   				if($('#editForm').valid()){
	 	   			$("#btn_submit").attr("disabled","true");
	 	   			$.post("<%=basePath%>sys/shop_doEdit",$("#editForm").serialize(),function(data){
	 	   				data = JSON.parse(data);
		  	   			if(data.result=="success"){
		  	   					alert("编辑成功!");
		 						$('#editForm_shop_id').val(data.id);
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
    <s:hidden name="shop.id"/>
    <div class="top">
        <div class="t_left"></div>
        <div class="t_content"><strong>添加店铺</strong></div>
        <div class="t_right"></div>
        <div class="clear"></div>
    </div>
    <div class="content">
        <div class="c_l"></div>
        <div class="c_c">
            <table border="0" cellpadding="0" cellspacing="0" class="table">
                <tr>
                    <td width="120px" height="25px" align="right">名称：</td>
                    <td><s:textfield name="shop.title" cssStyle="width:200px;" cssClass="{required:true,maxlengthCN:80}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">关键词：</td>
                    <td><s:textfield name="shop.keyword" cssStyle="width:400px; height:60px;" cssClass="{required:true,maxlengthCN:200}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">描述：</td>
                    <td><s:textarea name="shop.description" cssStyle="width:400px; height:60px;" cssClass="{required:true,maxlengthCN:200}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">地址：</td>
                    <td><s:textfield name="shop.address" cssStyle="width:200px;" cssClass="{required:true,maxlengthCN:80}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">电话：</td>
                    <td><s:textfield name="shop.tel" cssStyle="width:200px;" cssClass="{required:true,maxlengthCN:80}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">联系人：</td>
                    <td><s:textfield name="shop.contacter" cssStyle="width:200px;" cssClass="{required:true,maxlengthCN:80}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">图片：</td>
                    <td><s:textfield name="shop.imagePath" cssStyle="width:200px;" cssClass="{required:true,maxlengthCN:80}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">所属站点：</td>
                    <td>
                    	<s:select name="shop.siteId" list="sites" listKey="id" listValue="name" headerKey="" headerValue="--请选择--" cssClass="{required:true}"></s:select>
                    </td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">菜谱：</td>
                    <td>
                    	<ul id="typeTree" class="ztree" style="margin-top:0; width:180px; height: 300px;"></ul>
                    	<s:textfield name="shop.typeIds" cssStyle="width:200px;" cssClass="{required:true,maxlengthCN:80}"/>
                    </td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">内容：</td>
                    <td><s:textfield name="shop.contents" cssStyle="width:200px;" cssClass="{required:true,maxlengthCN:80}"/></td>
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
