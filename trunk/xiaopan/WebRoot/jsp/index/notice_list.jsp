<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<base href="<%=basePath%>">
    <title>校畔网</title>
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
    <script language="javascript" src="<%=basePath%>js/GetUrlData.js"></script>
    <script language="javascript" src="<%=basePath%>js/global.js"></script>
    <script language="javascript" src="<%=basePath%>js/common/pager.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/ztree/jquery.ztree.core-3.2.min.js"></script>
	
    <link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/select.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/zTreeStyle.css" type="text/css">
    <link type="text/css" href="<%=basePath%>css/public.css" rel="Stylesheet" />
    <link type="text/css" href="<%=basePath%>css/common.css" rel="Stylesheet" />
</head>
<body>
    <s:form id="queryForm">
    <%@ include file="header.jsp"%>
    <div class="position">
        <span>
			您现在的位置：<a href="<%=basePath%>web/main_toShow">首页</a>&gt;<a href="<%=basePath%>web/main_toNoticeList">网站公告</a>
        </span>
    </div>
    <div class="main">
        <%@ include file="about.jsp"%>
        <!--end left-->
        <div class="right">
            <div class="n_c">
                <ul>
                <s:iterator value="archives" var="parent">
                    <li><a href="<%=basePath%>web/main_toNotice?archive.id=<s:property value="#parent.id"/>"><s:property value="#parent.title"/></a></li>
                </s:iterator>
                </ul>
                <div class="clear"></div>
            </div>
            <%@ include file="../common/pager.jsp"%>
        </div>
        <!--end right-->
        <div class="clear"></div>
    </div>
    <%@ include file="footer.jsp"%>
    </s:form>
</body>
</html>
