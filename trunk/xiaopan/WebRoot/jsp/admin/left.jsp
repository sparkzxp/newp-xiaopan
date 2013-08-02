﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<base href="<%=basePath%>">
    <title>无标题页</title>
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
               })
            })
        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <img src="<%=basePath%>css/images/main_21.gif" />
        <div class="left">
            <div class="top">栏目管理</div>
            <div class="item">
                <p><a href="arctype.aspx" target="I1">栏目管理</a></p>
                <p><a href="archives.aspx" target="I1">内容列表</a></p>
                <p><a href="add_archives.aspx" target="I1">添加内容</a></p>
            </div>
            <div class="top">分类管理</div>
            <div class="item">
                <p><a href="TypeList.aspx" target="I1">分类列表</a></p>
                <p><a href="Add_Type.aspx" target="I1">添加分类</a></p>
            </div>
            <div class="top">广告管理</div>
            <div class="item">
                <p><a href="AdsType.aspx" target="I1">广告位置</a></p>
                <p><a href="Add_Ads.aspx" target="I1">添加广告</a></p>
                <p><a href="Ads_list.aspx" target="I1">广告列表</a></p>
            </div>
            <div class="top">店铺管理</div>
            <div class="item">
                <p><a href="Shop.aspx" target="I1">店铺列表</a></p>
                <p><a href="Add_Shop.aspx" target="I1">添加店铺</a></p>
            </div>
            <div class="top">热词管理</div>
            <div class="item">
                <p><a href="key.aspx" target="I1">热词列表</a></p>
                <p><a href="Add_key.aspx" target="I1">添加热词</a></p>
            </div>
            <div class="top">系统设置</div>
            <div class="item">
                <p><a href="clear.aspx" target="I1">清除缓存</a></p>
                <p><a href="config.aspx" target="I1">网站配制</a></p>
                <p><a href="changepassword.aspx" target="I1">修改密码</a></p>
            </div>
        </div>
    </form>
</body>
</html>
