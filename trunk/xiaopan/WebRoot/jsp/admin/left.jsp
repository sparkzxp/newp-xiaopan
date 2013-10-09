<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<base href="<%=basePath%>">
    <title>校畔网</title>
    <link type="text/css" href="<%=basePath%>css/admin/common.css" rel="Stylesheet" />
    <style type="text/css">
        a
        {
        	color:#000000;
        }
        .left
        {
        	display:inline-block;
        	height:100%;
        	width:177px;
        	background:url(<%=basePath%>css/images/main_23.gif) left top repeat-x;
        	height:300px;
        	position:relative;
        }
        .top
        {
        	font-weight:bold;
        	cursor:pointer;
        	text-align:center;
        	width:177px;
        	height:30px;
        	line-height:30px;
        	overflow:hidden;
        	color:#1f4906;
        	background:url(<%=basePath%>css/images/li_bg.gif) left top repeat-x;
        }
        .item
        {
        	display:none;
        	text-align:center;
        	line-height:30px;
        }
        .item p
        {
        	border-bottom:dashed 1px #ededed;
        }
        .item p:hover
        {
        	background:#f2ffe3;
        }
    </style>
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
    <script language="javascript" >
        $(function(){
            $(".top").each(function(i){
               $(this).click(function(){
                   $(".item").css({display:"none"});
                   $(".item").eq(i).css({display:"block"});
               });
            });
            $.getJSON("<%=basePath%>sys/user_getResource",function(data){
				for(var t = 0; t < $('.top').length; t++){
					for(var r in data){
						if($($('.top')[t]).text() == data[r].resourceName){
							$($('.top')[t]).show();
							break;
						}
					}
				}
			});
        });
    </script>
</head>
<body>
    <form id="form1">
        <img src="<%=basePath%>css/images/main_21.gif" />
        <div class="left">
            <div class="top" style="display: none;">站点管理</div>
            <div class="item">
                <p><a href="<%=basePath%>sys/site_toList" target="I1">站点列表</a></p>
                <p><a href="<%=basePath%>sys/site_toEdit?site.id=" target="I1">添加站点</a></p>
            </div>
            <div class="top" style="display: none;">栏目管理</div>
            <div class="item">
                <p><a href="<%=basePath%>sys/arctype_toList" target="I1">栏目列表</a></p>
                <p><a href="<%=basePath%>sys/arctype_toEdit?arctype.id=" target="I1">添加栏目</a></p>
                <p><a href="<%=basePath%>sys/archive_toList" target="I1">内容列表</a></p>
                <p><a href="<%=basePath%>sys/archive_toEdit?archive.id=" target="I1">添加内容</a></p>
            </div>
            <div class="top" style="display: none;">菜单管理</div>
            <div class="item">
                <p><a href="<%=basePath%>sys/type_toList?type.id=" target="I1">菜单列表</a></p>
                <p><a href="<%=basePath%>sys/type_toEdit?type.id=" target="I1">添加菜单</a></p>
            </div>
            <div class="top" style="display: none;">店铺管理</div>
            <div class="item">
                <p><a href="<%=basePath%>sys/shop_toList" target="I1">店铺列表</a></p>
                <p><a href="<%=basePath%>sys/shop_toEdit?shop.id=" target="I1">添加店铺</a></p>
            </div>
            <div class="top" style="display: none;">广告管理</div>
            <div class="item">
                <p><a href="<%=basePath%>sys/ads_toList" target="I1">广告列表</a></p>
                <p><a href="<%=basePath%>sys/ads_toEdit?ads.id=" target="I1">添加广告</a></p>
            </div>
            <%-- <div class="top" style="display: none;">热词管理</div>
            <div class="item">
                <p><a href="<%=basePath%>sys/key_toList" target="I1">热词列表</a></p>
                <p><a href="<%=basePath%>sys/key_toEdit?key.id=" target="I1">添加热词</a></p>
            </div> --%>
            <div class="top" style="display: none;">资源管理</div>
            <div class="item">
                <p><a href="<%=basePath%>sys/resource_toList" target="I1">资源列表</a></p>
                <p><a href="<%=basePath%>sys/resource_toEdit?resource.id=" target="I1">添加资源</a></p>
            </div>
            <div class="top" style="display: none;">角色管理</div>
            <div class="item">
                <p><a href="<%=basePath%>sys/role_toList" target="I1">角色列表</a></p>
                <p><a href="<%=basePath%>sys/role_toEdit?role.id=" target="I1">添加角色</a></p>
            </div>
            <div class="top" style="display: none;">用户管理</div>
            <div class="item">
                <p><a href="<%=basePath%>sys/user_toList" target="I1">用户列表</a></p>
                <p><a href="<%=basePath%>sys/user_toEdit?user.id=" target="I1">添加用户</a></p>
            </div>
            <div class="top" style="display: none;">系统设置</div>
            <div class="item">
                <!-- <p><a href="clear.jsp" target="I1">清除缓存</a></p>
                <p><a href="config.jsp" target="I1">网站配制</a></p> -->
                <p><a href="#" target="I1">模拟网络忙</a></p>
            </div>
        </div>
    </form>
</body>
</html>
