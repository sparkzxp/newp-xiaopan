<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
    <title>校畔网</title>
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/jquery.mobile-1.3.2/jquery.mobile-1.3.2.min.js"></script>
	
    <link rel="stylesheet" href="<%=basePath%>plugin/jquery.mobile-1.3.2/jquery.mobile-1.3.2.min.css" type="text/css">
</head>
<body>
<!-- Home -->
<div data-role="page" id="page1">
    <div data-theme="e" data-role="header">
        <h3 id="pageTitle">
            欢迎使用校畔网
        </h3>
    </div>
    <div data-role="content">
        <ul data-role="listview" data-divider-theme="e" data-inset="true">
            <li data-role="list-divider" role="heading">
                饮料
            </li>
            <li data-theme="c">
                果汁
            </li>
            <li data-theme="c">
                奶昔
            </li>
            <li data-role="list-divider" role="heading">
                Divider
            </li>
        </ul>
    </div>
    <div data-theme="e" data-role="footer">
        <h3>
            无锡校畔网&nbsp;@CopyRight 2013-2014
        </h3>
    </div>
</div>
</body>
</html>
