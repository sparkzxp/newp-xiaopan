<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<base href="<%=basePath%>">
    <title>搜索-校畔网</title>
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
        <span>
        <strong><s:property value="key.name" /></strong>的搜索结果
        </span>
    </div>
    <div class="main">
        <%@ include file="left.jsp"%>
        <!--end left-->
        
        <div class="right">
            <table border="0" cellpadding="0" cellspacing="0" class="table">
                <tr>
                    <th style="width:160px;">商家名称</th>
                    <th style="width:140px;">电话</th>
                    <th style="min-width:180px;">价格（元）</th>
                    <th style="width:80px;border-right:solid 1px #ededed;">详情</th>
                </tr>
                <s:iterator value="shops" var="parent">
                    <tr>
                        <td><a href="<%=basePath%>web/main_toDetail?shop.id=<s:property value="#parent.id"/>"><s:property value="#parent.title"/></a></td>
                        <td><s:property value="#parent.tel"/></td>
                        <td><s:property value="#parent.score"/></td>
                        <td><a href="<%=basePath%>web/main_toDetail?shop.id=<s:property value="#parent.id"/>">去看看</a></td>
                    </tr>
                 </s:iterator>
            </table>
            <div class="page">
                <ul>
                </ul>
            </div>
        </div>
        <!--end right-->
        <div class="clear"></div>
    </div>
    <%@ include file="footer.jsp"%>
    </form>
    <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
		<ul id="siteTree" class="ztree" style="clear:both;margin-top:0; width:130px; height: 80px;"></ul>
	</div>
</body>
</html>
