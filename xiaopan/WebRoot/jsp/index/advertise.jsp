<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>欢迎使用校畔网</title>
	<script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
	
    <link type="text/css" href="<%=basePath%>css/public.css?1245" rel="Stylesheet" />
    <link type="text/css" href="<%=basePath%>css/style.css?1258" rel="Stylesheet" />
	<script type="text/javascript">
	function popupbox(boxid,o){
		var sh = boxid.height();
		var sw = boxid.width();
		var l = o.offset().left;
		var t = o.offset().top;
		var th= $(window).scrollTop()+$(window).height()/2-sh/2;
		var h =document.body.clientHeight;
		var rw =$(window).width()/2-sw/2;
		boxid.css({height:0,width:0,top:t,left:l});
		$("body").prepend("<div class='mask'></div>");
		$(".mask").css({opacity:0,height:h}).animate({opacity:0.5},500,function(){
			boxid.animate({top:th,opacity: 'show',left:rw,height:sh,width:sw},500);													 
		});
	}
	function toUrl(url){
		$("#frame_list").attr("src",url).load();
	}
	function popup(obj, lng, lat, title, address, tel){
		popupbox($("#showbox"),$(obj));
		$('#mapInfo').html('店铺名称：'+(title==''?'暂无':title)+' | 地址：'+(address==''?'暂无':address)+' | 电话：'+(tel==''?'暂无':tel));
		var str = '<%=basePath%>web/main_toMap?ads.longitude='+lng+'&ads.latitude='+lat;
		toUrl(str);
	}
	$(function(){
		$("#title").click(function(){
			$(this).parent().animate({top:-300,opacity: 'hide'},500);
			$(".mask").fadeOut("fast").remove();
		});
	});

	</script>
	<style type="text/css">
	.adsimg{
		float: left;
	    height: 100px;
	    margin-left: 2px;
	    margin-top: 2px;
	    width: 160px;
	}
	#showbox{
		background:#2a2a2a;
		display:none;
		position:absolute;
		border:1px solid;
		text-align:center;
		z-index:1000;
		color:#fff;
		width:600px;
		height: 500px;
	}
	#showbox span{
		float:right;
		cursor:pointer;
	}
	.mask{
		width:100%;
		background:#333;
		position:absolute;
		overflow:hidden;
		left:0;
		top:0;
		height:100%;
		z-index:990;
	}
	</style>
</head>
<body>
<div class="top">
    <div class="t_left">欢迎来到校畔网，感谢您对校畔网的支持！</div>
    <div class="t_right">
        <a href="javascript:void(0);" onClick="window.external.addFavorite(document.location.href,document.title)" title="校畔网">加入收藏</a>|
        <a href="javascript:void(0);" onClick="var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('http://www.xiaopanwang.com/');" >设为首页</a>
    </div>
</div>
<div class="main">
	<div style="margin-top:5px;">
	我要去：
	<s:iterator value="sites" var="parent">
		&nbsp;【<a target="_blank" href="<%=basePath%>web/main_toShow?site.id=<s:property value="#parent.id"/>"><s:property value="#parent.name"/></a>】
	</s:iterator>
	</div>
	<div class="clear"></div>
	<div>
	<s:iterator value="adss" var="parent">
		<p>
			<s:if test="#parent.weburl == null or #parent.weburl == ''">
			<a href="javascript:void(0)" 
				onclick="popup(this,'<s:property value="#parent.longitude"/>',
									'<s:property value="#parent.latitude"/>',
									'<s:property value="#parent.title"/>',
									'<s:property value="#parent.address"/>',
									'<s:property value="#parent.tel"/>');">
				<img src="<s:property value="#parent.imageurl"/>" class="adsimg" /></a>
			</s:if>
			<s:else>
			<a target="_blank" href="<s:property value="#parent.weburl"/>"><img src="<s:property value="#parent.imageurl"/>" class="adsimg" /></a>
			</s:else>
		</p>
	</s:iterator>
	</div>
	<div class="clear"></div>
</div>
<div id="showbox">
	<span id="title">
		<span>【X】</span><br>
		<span id="mapInfo"></span>
	</span>
	<div id="content" style="height: 90%;">
		<iframe width="100%" id="frame_list" height="100%" frameborder="0"
			marginwidth="100%" marginheight="100%"></iframe>
	</div>
</div>
<%@ include file="footer.jsp"%>
</body>
</html>
