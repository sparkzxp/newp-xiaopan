<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<base href="<%=basePath%>">
    <title>校畔网</title>
    <link shop="text/css" href="<%=basePath%>css/admin/common.css" rel="Stylesheet" />
    <link shop="text/css" href="<%=basePath%>css/admin/tab.css" rel="Stylesheet" />
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
    <script language="javascript" src="<%=basePath%>js/common/validation.js"></script>
    <script language="javascript" src="<%=basePath%>js/common/json2.js"></script>
    
    <link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/select.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="<%=basePath%>plugin/ztree/jquery.ztree.core-3.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/ztree/jquery.ztree.excheck-3.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/editor/kindeditor-min.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/editor/lang/zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common/fileEveryWhere.js"></script>
    <script language="javascript">
	    var editor;
		KindEditor.ready(function(K) {
			var item =['source', '|', 'undo', 'redo', '|', 'preview', 'cut', 'copy', 'paste',
			           'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
			           'justifyfull', 'insertorderedlist', 'insertunorderedlist',
			           'clearhtml', 'quickformat', '/',
			           'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
			           'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image',
			           'table', 'hr', 'emoticons'];
			editor = K.create('#editor_id', {
		        width : '600px',
		        height:'416px',
		        items :item,
		        resizeType:0,
		        uploadJson:'<%=basePath%>sys/shop_uploadKindEditorImg',
		        afterCreate : function() { 
		        	this.sync(); 
	        	}, 
	        	afterBlur:function(){ 
		        	this.sync(); 
	        	}
			});
			if($('#editForm_shop_id').val() != ''){
				editor.html($('#editForm_shop_contents').val());
			}
		});
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
			var zTree = $.fn.zTree.getZTreeObj("typeTree"),
			nodes = zTree.getCheckedNodes(true);
			var v = "";
			var k = "";
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
				k += nodes[i].id + ",";
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			if (k.length > 0 ) k = k.substring(0, k.length-1);
			$("#typeSel").attr("value", v);
			$("#editForm_typeIds").attr("value", k);
		}

		function showMenu() {
			var typeObj = $("#typeSel");
			var typeOffset = $("#typeSel").offset();
			$("#menuContent").css({left:typeOffset.left + "px", top:typeOffset.top + typeObj.outerHeight() + "px"}).slideDown("fast");

			$("body").bind("mousedown", onBodyDown);
		}
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "menuBtn" || event.target.id == "typeSel" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}
		
        $(function() {
        	$("input:file").fileEveryWhere({
   				ButtonText : "浏览"
   			});
	    	var zNodes = JSON.parse('<s:property value="typeJson" escape="false"/>');
        	$.fn.zTree.init($("#typeTree"), setting, zNodes);
        	
        	var zTree = $.fn.zTree.getZTreeObj("typeTree"),
			nodes = zTree.getCheckedNodes(true);
			var v = "";
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			$("#typeSel").attr("value", v);
			
			
			$("input[type=file]").next("input[type=text]").val($('#editForm_shop_imagePath').val());
			if($('#editForm_uploadStatus').val() == 'success'){
  				alert("操作成功!");
  			}else if($('#editForm_uploadStatus').val()=="error"){
				alert("操作失败!");
			}else if($('#editForm_uploadStatus').val()!=""){
				alert($('#editForm_uploadStatus').val());	
			}

        	$("#btn_submit").click(function(){
        		if($("input[type=file]").next("input[type=text]").val()==''){
					alert("请上传店铺图片!");
					return;
	   	   		}
   				if($('#editForm').valid()){
   					$('#editForm_shop_contents').val($('#editor_id').val());
   					if($('input[type=file]').val() != ''){
						$("#editForm_pathStatus").val("true");
			   	   	}
   					
   					$("#btn_submit").attr("disabled","true");
   					$("#editForm").submit();
	   			}
   	   		});
        });
    </script>
</head>
<body>
    <s:form name="editForm" id="editForm" action="shop_doEdit" namespace="/sys" enctype="multipart/form-data">
    <s:hidden name="shop.id"/>
	<s:hidden name="shop.imagePath"/>
	<s:hidden name="pathStatus" value="false"/>
	<s:hidden name="uploadStatus"/>
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
                    <td><s:textarea name="shop.keyword" cssStyle="width:400px; height:60px;" cssClass="{maxlengthCN:200}"></s:textarea></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">描述：</td>
                    <td><s:textarea name="shop.description" cssStyle="width:400px; height:60px;" cssClass="{maxlengthCN:200}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">地址：</td>
                    <td><s:textfield name="shop.address" cssStyle="width:200px;" cssClass="{required:true,maxlengthCN:200}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">电话：</td>
                    <td><s:textfield name="shop.tel" cssStyle="width:200px;" cssClass="{required:true,maxlengthCN:50}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">联系人：</td>
                    <td><s:textfield name="shop.contacter" cssStyle="width:200px;" cssClass="{maxlengthCN:50}"/></td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">图片：</td>
                    <td>
                    	<input type="file" name="imgFile"/>
                    </td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">所属站点：</td>
                    <td>
                    	<s:select name="shop.siteId" list="sites" listKey="id" listValue="name" cssClass="{required:true}"></s:select>
                    </td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">菜谱：</td>
                    <td>
                    	<textarea id="typeSel" readonly="readonly" style="width:400px; height:60px;" onclick="showMenu();"></textarea>
                    	&nbsp;<a id="menuBtn" href="javascript:void(0)" onclick="showMenu();" style="font-size:12px;">选择</a>
                    	<s:hidden name="typeIds" cssClass="{maxlengthCN:500}"/>
                    </td>
                </tr>
                <tr>
                    <td width="120px" height="25px" align="right">内容：</td>
                    <td>
                    	<textarea id="editor_id"></textarea>
                    	<s:hidden name="shop.contents"/>
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
		<ul id="typeTree" class="ztree" style="clear:both;margin-top:0; width:250px; height: 300px;"></ul>
	</div>
</body>
</html>
