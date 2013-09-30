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
    
    <link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/select.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="<%=basePath%>plugin/ztree/jquery.ztree.core-3.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/ztree/jquery.ztree.excheck-3.2.min.js"></script>
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
				onCheck: onCheck
			}
		};
		
		function onCheck(e, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("resourceTree"),
			nodes = zTree.getCheckedNodes(true);
			var v = "";
			var k = "";
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
				k += nodes[i].id + ",";
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			if (k.length > 0 ) k = k.substring(0, k.length-1);
			$("#resourceSel").attr("value", v);
			$("#editForm_resourceIds").attr("value", k);
		}

		function showMenu() {
			var resourceObj = $("#resourceSel");
			var resourceOffset = $("#resourceSel").offset();
			$("#menuContent").css({left:resourceOffset.left + "px", top:resourceOffset.top + resourceObj.outerHeight() + "px"}).slideDown("fast");

			$("body").bind("mousedown", onBodyDown);
		}
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "menuBtn" || event.target.id == "resourceSel" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}
		
        $(function() {
        	var zNodes = JSON.parse('<s:property value="resourceJson" escape="false"/>');
        	$.fn.zTree.init($("#resourceTree"), setting, zNodes);
        	
        	var zTree = $.fn.zTree.getZTreeObj("resourceTree"),
			nodes = zTree.getCheckedNodes(true);
			var v = "";
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			$("#resourceSel").attr("value", v);
			
        	$("#btn_submit").click(function(){
   				if($('#editForm').valid()){
	 	   			$("#btn_submit").attr("disabled","true");
	 	   			$.post("<%=basePath%>sys/role_doEdit",$("#editForm").serialize(),function(data){
	 	   				data = JSON.parse(data);
		  	   			if(data.result=="success"){
		  	   					alert("编辑成功!");
		 						$('#editForm_role_id').val(data.id);
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
    <s:hidden name="role.id"/>
    <div class="top">
        <div class="t_left"></div>
        <div class="t_content"><strong>添加角色</strong></div>
        <div class="t_right"></div>
        <div class="clear"></div>
    </div>
    <div class="content">
        <div class="c_l"></div>
        <div class="c_c">
            <table border="0" cellpadding="0" cellspacing="0" class="table">
                <tr>
                    <td width="120px" height="25px" align="right">角色名称：</td>
                    <td><s:textfield name="role.name" cssStyle="width:200px;" cssClass="{required:true,maxlengthCN:200}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">所属站点：</td>
                    <td>
                    	<s:select name="role.siteId" list="sites" listKey="id" listValue="name" headerKey="" headerValue="全部站点"></s:select>
                    </td>
                </tr>
                <tr>
                    <td align="right" height="25px">拥有资源：</td>
                    <td>
                    	<textarea id="resourceSel" readonly="readonly" style="width:400px; height:60px;" onclick="showMenu();"></textarea>
                    	&nbsp;<a id="menuBtn" href="javascript:void(0)" onclick="showMenu();" style="font-size:12px;">选择</a>
                    	<s:hidden name="resourceIds" cssClass="{maxlengthCN:500}"/>
					</td>
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
    <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
		<ul id="resourceTree" class="ztree" style="clear:both;margin-top:0; width:250px; height: 300px;"></ul>
	</div>
</body>
</html>
