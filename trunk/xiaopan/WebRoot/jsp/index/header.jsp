<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
    <script type="text/javascript">
		var setting = {
			view: {
				dblClickExpand: false,
				showLine:false,
				showIcon:false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				onClick: onClick
			}
		};
		function onClick(e, treeId, treeNode) {
			window.location.href="<%=basePath%>web/main_toShow?site.id="+treeNode.id;
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
			if (!(event.target.id == "siteSel" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}
		$(function() {
	    	var zNodes = JSON.parse('<s:property value="siteJson" escape="false"/>');
        	$.fn.zTree.init($("#siteTree"), setting, zNodes);
        	$('#btnsearch').click(function(){
        		if($.trim($('#txtkeyword').val()) != ''){
        			window.location.href="<%=basePath%>web/main_toSearch?key.name="+$.trim($('#txtkeyword').val());
        		}
        	});
		});
	</script>
    <div class="top">
        <div class="t_left">欢迎来到校畔网，感谢您对校畔网的支持！</div>
        <div class="t_right">
            <a href="javascript:void(0);" onClick="window.external.addFavorite(document.location.href,document.title)" title="校畔网">加入收藏</a>|
            <a href="javascript:void(0);" onClick="var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('http://www.xiaopanwang.com/');" >设为首页</a>
        </div>
    </div>
    <div class="header">
        <div class="h_left"><a href="<%=basePath%>web/main_toShow">
            <img src="<%=basePath%>images/logo.jpg" height="60px" /></a><br />
			【<a id="siteSel" href="javascript:void(0)" onclick="showMenu();"><s:property value="site.name" /></a>】
        </div>
        <div class="h_right">
            <ul>
            	<s:iterator value="adss" var="parent">
	            	<s:if test="#parent.place == '头部广告'">
	                <li>
	                    <a href="<s:property value="#parent.weburl"/>"><img src="<s:property value="#parent.imageurl"/>" /></a>
	                </li>
	                </s:if>
	            </s:iterator>
            </ul>
        </div>
        <div class="clear"></div>
    </div>
    <div class="search1">
        <input type="text" id="txtkeyword" class="keyword" value="请输入关键字..." onfocus='if($(this).val()=="请输入关键字..."){$(this).val("");}' onblur='if($.trim($(this).val())==""||$.trim($(this).val())==null){$(this).val("请输入关键字...");}' />
        <input type="button" id="btnsearch" class="search" />
        <div class="hot">
            <ul>
                <li><strong>热门：</strong></li>
                <s:iterator value="keys" var="parent">
	                <li>
	                    <a href="<%=basePath%>web/main_toSearch?key.name=<s:property value="#parent.name"/>"><s:property value="#parent.name"/></a>
	                </li>
	            </s:iterator>
            </ul>
        </div>
        <div class="clear"></div>
    </div>
    <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
		<ul id="siteTree" class="ztree" style="clear:both;margin-top:0; width:130px; height: 80px;"></ul>
	</div>