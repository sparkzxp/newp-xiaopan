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
    <script language="javascript" src="<%=basePath%>js/common/pager.js"></script>
    <script type="text/javascript" src="<%=basePath%>plugin/ztree/jquery.ztree.core-3.2.min.js"></script>
	
    <link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/select.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/zTreeStyle.css" type="text/css">
    <link type="text/css" href="<%=basePath%>css/public.css" rel="Stylesheet" />
    <link type="text/css" href="<%=basePath%>css/common.css" rel="Stylesheet" />
</head>
<body>
    <s:form id="queryForm">
    <s:hidden name="key.name"/>
    <%@ include file="header.jsp"%>
    <div class="position">
        <span>
        	<s:if test="key == null or key.name == null or key.name == ''">
        	<strong>所有店铺信息</strong>
        	</s:if>
        	<s:else>
        	<strong><s:property value="key.name" /></strong>&nbsp;的搜索结果&nbsp;<a href="<%=basePath%>web/main_toSearch" style="color:green;">显示所有店铺</a>
        	</s:else>
        </span>
    </div>
    <div class="main">
        <%@ include file="left.jsp"%>
        <!--end left-->
        
        <div class="right">
            <table border="0" cellpadding="0" cellspacing="0" class="table">
                <tr>
                    <th style="width:160px;">店铺名称</th>
                    <th style="width:140px;">电话</th>
                    <th style="min-width:180px;">价格（元）</th>
                    <th style="width:80px;border-right:solid 1px #ededed;">详情</th>
                </tr>
                <s:if test="null == shops or shops.size() == 0">
                	<tr><td colspan="4">未查找到包含&nbsp;<strong><s:property value="key.name" /></strong>&nbsp;的店铺</td></tr>
                </s:if>
                <s:iterator value="shops" var="parent">
                    <tr>
                        <td><a href="<%=basePath%>web/main_toDetail?shop.id=<s:property value="#parent.id"/>"><s:property value="#parent.title"/></a></td>
                        <td><s:property value="#parent.tel"/></td>
                        <td style="text-align: left;">
                        	<s:iterator value="#parent.types" var="child">
                        		<s:if test="#child.name.indexOf(key.name) > -1">
                        		<s:property value="#child.name"/>(<s:property value="#child.price"/>)
                        		</s:if>
                        	</s:iterator>
                        </td>
                        <td><a href="<%=basePath%>web/main_toDetail?shop.id=<s:property value="#parent.id"/>">去看看</a></td>
                    </tr>
                 </s:iterator>
            </table>
            <%@ include file="../common/pager.jsp"%>
        </div>
        <!--end right-->
        <div class="clear"></div>
    </div>
    <%@ include file="footer.jsp"%>
    </s:form>
</body>
</html>
