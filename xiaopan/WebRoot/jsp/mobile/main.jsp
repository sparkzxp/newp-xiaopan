<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta name="baidu-tc-verification" content="230142c1a26d097a9bf22c0abef7a5ff" />
	<base href="<%=basePath%>">
    <title>校畔网 首页</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="<%=basePath%>plugin/jquery.mobile-1.3.2/jquery.mobile-1.3.2.min.css" type="text/css">
    
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/jquery.mobile-1.3.2/jquery.mobile-1.3.2.min.js"></script>
    </script>
</head>
<body>
<!-- Home -->
<div data-role="page" id="page1">
    <div data-theme="e" data-role="header" class="clearfix" id="header">
        <h3>欢迎使用校畔网</h3>
    </div>
    <div data-role="content">
        <ul data-role="listview" data-divider-theme="e" data-inset="true">
        	<s:iterator value="sites" var="parent">
        	<li data-theme="c">
        		<a href="<%=basePath%>mobile/mobile_toTypeList?site.id=<s:property value="#parent.id"/>" data-transition="slide">
        			<s:property value="#parent.name"/>
        		</a>
        	</li>
        	</s:iterator>
        </ul>
    </div>
    <%@ include file="footer.jsp"%>
</div>
</body>
</html>
