<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>403异常处理页面</title>
<style type="text/css">
/* content */
.full{width:560px; margin:0 auto;}
.full dl.error{width:560px;  background:#f5f5f5; border-bottom:1px solid #ebebeb; margin:100px 0 10px;}
.full dl.error dt{height:44px; line-height:44px;  background:url(<%=basePath%>images/error/pic_bg_jz.png) 0 0 no-repeat; text-align:left; padding:0 15px; vertical-align:center;}
/* .full dl.error dt img{padding-top:13px; width:167px; height:20px;  background:url(<%=basePath%>images/error/pic_bg.gif) -20px -309px no-repeat;} */
.full dl.error dd{text-align:center;}
.full dl.error dd span.error404{padding:50px 0px 10px 0; display:inline-block;}
.full dl.error dd span.error404 img{width:200px; height:100px;  background:url(<%=basePath%>images/error/pic_bg_jz.png) 0 -190px no-repeat;}
.full dl.error dd p{ text-align:left;}
.full dl.error dd span.error_404_text{padding:50px 0 10px 0; display:inline-block;}
.full dl.error dd span.error_404_text img{width:180px; height:100px;  background:url(<%=basePath%>images/error/pic_bg_jz.png) -220px -190px no-repeat;}
.full dl.error dd span.btn_back{padding:30px 0 50px 0; display:inline-block;}
.full dl.error dd span.btn_back img{width:122px; height:42px;  background:url(<%=basePath%>images/error/pic_bg_jz.png) 0 -440px no-repeat;}
</style>
</head>
<body>
	<div class="full">	
		<dl class="error">
			<dt>
				<h2>403 提示页面</h2>
			<dd>
				<span class="error404"><img src="<%=basePath%>images/error/pic_dot_jz.gif" alt="404" title="404"></span>
				<span class="error_404_text"><img src="<%=basePath%>images/error/pic_dot_jz.gif" alt="你懂的" title="你懂的"></span>
			</dd>
            <dd style="font-size:19px; font-family:Microsoft YaHei;">
            	小爬虫，禁止访问！点此<a href="<%=basePath%>web/main_toShow">返回首页</a>
            </dd>
			<dd>
				<span class="btn_back"><a href="<%=basePath%>web/main_toShow" ><img src="<%=basePath%>images/error/pic_dot_jz.gif" alt="返回" title="返回"></a></span> 
			</dd>
		</dl>
	</div>
</body>
</html>