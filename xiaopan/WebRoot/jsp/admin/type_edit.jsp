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
			var zTree = $.fn.zTree.getZTreeObj("siteTree"),
			nodes = zTree.getCheckedNodes(true);
			var v = "";
			var k = "";
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
				k += nodes[i].id + ",";
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			if (k.length > 0 ) k = k.substring(0, k.length-1);
			$("#siteSel").attr("value", v);
			$("#editForm_siteIds").attr("value", k);
		}

		function showMenu() {
			var typeObj = $("#siteSel");
			var typeOffset = $("#siteSel").offset();
			$("#menuContent").css({left:typeOffset.left + "px", top:typeOffset.top + typeObj.outerHeight() + "px"}).slideDown("fast");

			$("body").bind("mousedown", onBodyDown);
		}
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "menuBtn" || event.target.id == "siteSel" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}


    	var settingType = {
			check: {
				enable: true,
				chkStyle: "radio",
				radioType: "all"
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				onCheck: onCheckType
			}
		};
		function onCheckType(e, treeId, treeNode) {
			if(treeNode.checked){
				$("#typeSel").attr("value", treeNode.name);
				$("#editForm_type_topid").attr("value", treeNode.id);
			}else{
				$("#typeSel").attr("value", '');
				$("#editForm_type_topid").attr("value", '');
			}
		}

		function showMenuType() {
			var typeObj = $("#typeSel");
			var typeOffset = $("#typeSel").offset();
			$("#menuContentType").css({left:typeOffset.left + "px", top:typeOffset.top + typeObj.outerHeight() + "px"}).slideDown("fast");

			$("body").bind("mousedown", onBodyDownType);
		}
		function hideMenuType() {
			$("#menuContentType").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDownType);
		}
		function onBodyDownType(event) {
			if (!(event.target.id == "menuBtnType" || event.target.id == "typeSel" || event.target.id == "menuContentType" || $(event.target).parents("#menuContentType").length>0)) {
				hideMenuType();
			}
		}
		
        $(function() {
        	if(<s:property value="isAdmin"/>){
        		$('#typesite').show();
	            var zNodes = JSON.parse('<s:property value="siteJson" escape="false"/>');
	        	$.fn.zTree.init($("#siteTree"), setting, zNodes);
	        	
	        	var zTree = $.fn.zTree.getZTreeObj("siteTree"),
				nodes = zTree.getCheckedNodes(true);
				var v = "";
				for (var i=0, l=nodes.length; i<l; i++) {
					v += nodes[i].name + ",";
				}
				if (v.length > 0 ) v = v.substring(0, v.length-1);
				$("#siteSel").attr("value", v);
        	}
			
			var zNodesType = JSON.parse('<s:property value="typeJson" escape="false"/>');
        	$.fn.zTree.init($("#typeTree"), settingType, zNodesType);
        	
        	var zTreeType = $.fn.zTree.getZTreeObj("typeTree"),
        	nodesType = zTreeType.getCheckedNodes(true);
        	if(nodesType.length == 1){
				$("#typeSel").attr("value", nodesType[0].name);
        	}
        	
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
                    <td width="120px" height="25px" align="right">名称：</td>
                    <td><s:textfield name="type.name" cssStyle="width:200px;" cssClass="{required:true,maxlengthCN:80}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">价格：</td>
                    <td><s:textfield name="type.price" cssStyle="width:180px;" cssClass="{required:true,maxlengthCN:50}"/></td>
                </tr>
                <tr style="display:none;">
                    <td width="120px" height="25px" align="right">颜色：</td>
                    <td><s:textfield name="type.color" cssStyle="width:80px;" cssClass="color"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">SEO标题：</td>
                    <td><s:textfield name="type.seotitle" cssStyle="width:400px;" cssClass="{maxlengthCN:80}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">关键词：</td>
                    <td><s:textarea name="type.keyword" cssStyle="width:400px; height:60px;" cssClass="{maxlengthCN:200}"></s:textarea></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">描述：</td>
                    <td><s:textarea name="type.description" cssStyle="width:400px; height:60px;" cssClass="{maxlengthCN:200}"/></td>
                </tr>
                <tr>
                    <td align="right" height="25px">所属分类：</td>
                    <td>
                    	<%-- <s:select name="type.topid" list="types" listKey="id" listValue="name" headerKey="0" headerValue="顶级分类" cssClass="{required:true}"></s:select> --%>
                    	<input type="text" id="typeSel" readonly="readonly" style="width:200px;" onclick="showMenuType();"/>
                    	&nbsp;<a id="menuBtnType" href="javascript:void(0)" onclick="showMenuType();" style="font-size:12px;">选择</a>
                    	<s:hidden name="type.topid"/>
                    </td>
                </tr>
                <tr id="typesite" style="display: none;">
                    <td width="120px" height="25px" align="right">所属站点：</td>
                    <td>
                    	<textarea id="siteSel" readonly="readonly" style="width:400px; height:60px;" onclick="showMenu();"></textarea>
                    	&nbsp;<a id="menuBtn" href="javascript:void(0)" onclick="showMenu();" style="font-size:12px;">选择</a>
                    	<s:hidden name="siteIds" cssClass="{maxlengthCN:500}"/>
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
    <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
		<ul id="siteTree" class="ztree" style="clear:both;margin-top:0; width:220px; height: 200px;"></ul>
	</div>
    <div id="menuContentType" class="menuContent" style="display:none; position: absolute;">
		<ul id="typeTree" class="ztree" style="clear:both;margin-top:0; width:250px; height: 300px;"></ul>
	</div>
</body>
</html>
