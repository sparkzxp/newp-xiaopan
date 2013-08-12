<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
    <title>校畔网 菜谱列表</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="<%=basePath%>plugin/jquery.mobile-1.3.2/jquery.mobile-1.3.2.min.css" type="text/css">

    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/jquery.mobile-1.3.2/jquery.mobile-1.3.2.min.js"></script>
</head>
<body>
<!-- Home -->
<div data-role="page" id="page1">
    <div data-theme="e" data-role="header">
		<a data-role="button" class="ui-btn-right" href="<%=basePath%>mobile">
			 返回
        </a>
		<a data-role="button" class="ui-btn-left" href="<%=basePath%>mobile">
			首页
		</a>
        <h3>欢迎使用校畔网</h3>
    </div>
    <div data-role="content">
    	<div data-role="collapsible-set" data-content-theme="e">
        	<s:iterator value="types" var="parent">
        	<s:if test="#parent.topid == 0">
        	<div data-role="collapsible" data-collapsed="true">
        		<h3><s:property value="#parent.name"/></h3>
	        	<ul data-role="listview" data-divider-theme="e" data-inset="true">
	        	<s:iterator value="types" var="child">
	                <s:if test="#child.topid == #parent.id">
	                <li data-theme="c">
		                <a href="<%=basePath%>mobile/mobile_toSearch?type.name=<s:property value="#child.name"/>" data-transition="slide">
		        			<s:property value="#child.name"/>
		        		</a>
		        	</li>
	                </s:if>
	            </s:iterator>
	      		</ul>
      		</div>
        	</s:if>
        	</s:iterator>
        </div>
    </div>
    <%@ include file="footer.jsp"%>
</div>
</body>
</html>
