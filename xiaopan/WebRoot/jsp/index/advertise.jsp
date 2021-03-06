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
	
	function toggleCityMenu(){
		$('#menu').css('left', $('#menubar').position().left);
		if($('#menu').css('visibility') == 'hidden'){
			menu.style.visibility='visible';
		}else{
			menu.style.visibility="hidden";
		}
	}

	$(function() {
		$('#nowCity').html('<s:property value="city.name"/>');
		
		$('.main').height(($($('.clear')[$('.clear').length-1]).offset().top-50)+'px');
		$("#title").click(function(){
			$(this).parent().animate({top:-300,opacity: 'hide'},500);
			$(".mask").fadeOut("fast").remove();
		});
		
		$('#menu').mouseleave(function(e, a, b){
			menu.style.visibility="hidden";
		});

		var total = $('p').length;
		var n, img, tmp=0, loop=0, doing=false;
		
		function doSilder(){
			if(doing){
				return false;
			}
			doing = true;
			n = parseInt(Math.random()*total);
			loop = 0;
			while(tmp == n && loop<10){
				n = parseInt(Math.random()*total);
				loop++;
			}
			tmp = n;
			img = $($('p')[n]).find('img');
			if($(img[0]).css('display') == 'none'){
				$(img[1]).fadeOut('fast', function(){
					$(img[0]).fadeIn('fast');
					doing = false;
				});
			}else{
				$(img[0]).fadeOut('fast', function(){
					$(img[1]).fadeIn('fast');
					doing = false;
				});
			}
		}
		
		var silder = setInterval(doSilder, 2000);
	});

	</script>
	<style type="text/css">
	body{
		background : url("<%=basePath%>images/top-bg_37f4dd0d08.png") repeat-x scroll 0 0 #F3F2F3;
	}
	.adsimg{
		float: left;
	    width: 260px;
	    height: 160px;
	    margin-left: 15px;
	    margin-top: 10px;
	    border: 1px solid #DFDFDF;
	}
	#showbox{
		background:#2a2a2a;
		display:none;
		position:absolute;
		border:1px solid #DFDFDF;
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
	.top{
		margin:auto;
	}
	</style>
</head>
<body>
<div class="top">
    <div class="t_left">
    	欢迎来到校畔网，感谢您对校畔网的支持！
    	<span id="nowCity">无锡</span>&nbsp;
       	<span id="citySpan">
       		<span id="menubar" onclick="toggleCityMenu();">[切换城市]</span>
			<div border=1  id="menu">
			<s:set name="count" value="1"></s:set>
			<s:iterator value="citys" var="parent">
			<s:if test="#count != 1 and #count % 5 == 1"><br></s:if>
			<a id="link" href="<%=basePath%>web/main_toAdvertise?city.id=<s:property value="#parent.id"/>"><s:property value="#parent.name"/></a>
			<s:set name="count" value="#count + 1"></s:set>
			</s:iterator>
			</div>
		</span>
    </div>
    <div class="t_right">
    	<a href="<%=basePath%>web/main_toFeedback" target="_blank" title="校畔网 联系我们">联系我们</a>
        <!-- |<a href="javascript:void(0);" onClick="window.external.addFavorite(document.location.href,document.title)" title="校畔网 加入收藏">加入收藏</a>|
        <a href="javascript:void(0);" onClick="var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('http://www.xiaopanwang.com/');" title="校畔网 设为首页">设为首页</a> -->
    </div>
</div>
<div class="main">
	<div class="clear"></div>
	<div>
	<s:set name="count" value="1"></s:set>
	<s:iterator value="adss" var="parent">
		<s:if test="#parent.indexShow == \"1\" and #count < 9">
			<s:if test="#count == 5">
				<div class="adsimg" style="font-size: 22px; font-weight: bold;text-align: center;">
				<!-- <div style="padding-top:5px;padding-bottom: 5px;">&nbsp;我要去：</div> -->
				<s:iterator value="sites" var="child">
				<span><img alt="" src="<%=basePath%>images/pointer.png" style="width:35px;height:19px;"/>【<a target="_blank" href="<%=basePath%>web/main_toShow?site.id=<s:property value="#child.id"/>"><s:property value="#child.name"/></a>】</span><br>
				</s:iterator>
				</div>
			</s:if>
			<p>
			<s:if test="#parent.weburl == null or #parent.weburl == \"\"">
			<a href="javascript:void(0)" 
				onclick="popup(this,'<s:property value="#parent.longitude"/>',
									'<s:property value="#parent.latitude"/>',
									'<s:property value="#parent.title"/>',
									'<s:property value="#parent.address"/>',
									'<s:property value="#parent.tel"/>');">
			</s:if>
			<s:else>
			<a target="_blank" href="<s:property value="#parent.weburl"/>">
			</s:else>
				<img src="<%=basePath%><s:property value="#parent.imageurl"/>" class="adsimg" />
				<s:if test="null == #parent.imageurl2 or \"\" == #parent.imageurl2">
   				<img src="<%=basePath%><s:property value="#parent.imageurl"/>" class="adsimg" style="display: none;"/>
   				</s:if>
   				<s:else>
   				<img src="<%=basePath%><s:property value="#parent.imageurl2"/>" class="adsimg" style="display: none;"/>
   				</s:else>
   			</a>
			<s:set name="count" value="#count + 1"></s:set>
			</p>
		</s:if>
	</s:iterator>
	<s:if test="adss == null or #count < 5">
	<div class="adsimg" style="font-size: 22px; font-weight: bold;text-align: center;">
		<!-- <div style="padding-top:5px;padding-bottom: 5px;">&nbsp;我要去：</div> -->
		<s:iterator value="sites" var="child">
		<span><img alt="" src="<%=basePath%>images/pointer.png" style="width:35px;height:19px;"/>【<a target="_blank" href="<%=basePath%>web/main_toShow?site.id=<s:property value="#child.id"/>"><s:property value="#child.name"/></a>】</span><br>
		</s:iterator>
	</div>
	</s:if>
	</div>
	<div class="clear"></div>
	<div style="margin-top: 10px;">
	<s:set name="count" value="1"></s:set>
	<s:iterator value="adss" var="parent">
		<s:if test="#parent.indexShow == \"2\"">
		<span class="bottomShow">
			<s:if test="#parent.weburl == null or #parent.weburl == \"\"">
			<a href="javascript:void(0)" 
				onclick="popup(this,'<s:property value="#parent.longitude"/>',
									'<s:property value="#parent.latitude"/>',
									'<s:property value="#parent.title"/>',
									'<s:property value="#parent.address"/>',
									'<s:property value="#parent.tel"/>');">
			</s:if>
			<s:else>
			<a target="_blank" href="<s:property value="#parent.weburl"/>">
			</s:else>
				<img src="<%=basePath%><s:property value="#parent.imageurl"/>" class="adsimg" style="width: 120px; height: 80px;" />
				<s:if test="null == #parent.imageurl2 or \"\" == #parent.imageurl2">
   				<img src="<%=basePath%><s:property value="#parent.imageurl"/>" class="adsimg" style="display: none;width: 120px; height: 80px;"/>
   				</s:if>
   				<s:else>
   				<img src="<%=basePath%><s:property value="#parent.imageurl2"/>" class="adsimg" style="display: none;width: 120px; height: 80px;"/>
   				</s:else>
   			</a>
			<s:set name="count" value="#count + 1"></s:set>
		</span>
		</s:if>
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
