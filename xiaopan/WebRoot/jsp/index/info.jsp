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
	<script type="text/javascript" src="<%=basePath%>plugin/ztree/jquery.ztree.core-3.2.min.js"></script>
	
    <link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/select.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/zTreeStyle.css" type="text/css">
    <link type="text/css" href="<%=basePath%>css/public.css" rel="Stylesheet" />
    <link type="text/css" href="<%=basePath%>css/common.css" rel="Stylesheet" />
</head>
<body>
    <form id="form1">
    <%@ include file="header.jsp"%>
    <div class="position">
        <strong><s:property value="arctype.typename" /></strong>
    </div>
    <div class="main">
        <%@ include file="about.jsp"%>
        <!--end left-->
        <div class="right">
            <div class="n_c">
                <div class="n_title"><h2><s:property value="arctype.typename" /></h2></div>
                <div class="content">
                    <s:property value="arctype.contents" escape="false" />
                </div>
                <div class="clear"></div>
            </div>
        </div>
        <!--end right-->
        <div class="clear"></div>
    </div>
    <%@ include file="footer.jsp"%>
    </form>
</body>
</html>
