<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
    <title>校畔网 城市列表</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="<%=basePath%>plugin/jquery.mobile-1.3.2/jquery.mobile-1.3.2.min.css" type="text/css">
    
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/jquery.mobile-1.3.2/jquery.mobile-1.3.2.min.js"></script>
</head>
<body>
<!-- Home -->
<div data-role="page" id="page1">
	<div data-theme="e" data-role="header">
		<a data-role="button" class="ui-btn-left" href="<%=basePath%>mobile">
			返回
		</a>
        <h3>欢迎使用校畔网</h3>
    </div>
    <div data-role="content">
    	<div>
        	您当前所选择的城市<span style="font-weight: bold;">【<s:property value="city.name"/>】</span>
        </div>
   		<ul data-role="listview" data-divider-theme="e" data-inset="true">
        	<s:iterator value="citys" var="parent">
        	<li data-theme="c">
        		<a data-inline="true" href="<%=basePath%>mobile?city.id=<s:property value="#parent.id"/>">
				<s:property value="#parent.name"/></a>
        	</li>
        	</s:iterator>
        </ul>
    </div>
    <%@ include file="footer.jsp"%>
</div>
</body>
</html>
