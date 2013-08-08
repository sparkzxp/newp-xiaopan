<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<base href="<%=basePath%>">
    <title>校畔网</title>
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
    <script language="javascript" src="<%=basePath%>js/jquery.miloc.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/ztree/jquery.ztree.core-3.2.min.js"></script>
	
    <link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/select.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/zTreeStyle.css" type="text/css">
    <link type="text/css" href="<%=basePath%>css/public.css?1245" rel="Stylesheet" />
    <link type="text/css" href="<%=basePath%>css/style.css?1258" rel="Stylesheet" />
</head>
<body>
    <form id="form1">
    <%@ include file="header.jsp"%>
    <!--end search-->
    <div class="main">
        <div class="left">
            <ul>
            <s:set name="count" value="1"></s:set>
            <s:iterator value="adss" var="parent">
            	<s:if test="#parent.place == '网页左面' and #count <= 5">
                <li>
                    <p><a href="<s:property value="#parent.weburl"/>"><img src="<s:property value="#parent.imageurl"/>" /></a></p>
                </li>
                <s:set name="count" value="#count + 1"></s:set>
                </s:if>
            </s:iterator>
            </ul>
        </div>
        <!--end left-->
        <div class="middle">
        	<s:iterator value="types" var="parent">
        		<s:if test="#parent.topid == 0">
        		<div class="item">
                    <ul>
                        <li><strong><s:property value="#parent.name"/></strong></li>
                        <s:iterator value="types" var="child">
                        	<s:if test="#child.topid == #parent.id">
                            <li><a href="<%=basePath%>web/main_toSearch?key.name=<s:property value="#child.name"/>"><s:property value="#child.name"/></a></li>
                            </s:if>
                        </s:iterator>
                    </ul>
                </div>
        		</s:if>
        	</s:iterator>
            <div class="clear"></div>
            <div class="m_ads">
                <ul>
                	<s:set name="count" value="1"></s:set>
                    <s:iterator value="adss" var="parent">
		            	<s:if test="#parent.place == '网页底部' and #count <= 4">
		                <li>
		                    <p><a href="<s:property value="#parent.weburl"/>"><img src="<s:property value="#parent.imageurl"/>" /></a></p>
		                </li>
		                <s:set name="count" value="#count + 1"></s:set>
		                </s:if>
		            </s:iterator>
                </ul>
            </div>
        </div>
        <!--end middle-->
        <div class="right">
            <div class="r_item">
                <div class="r_t"><strong>网站公告</strong></div>
                <div class="r_c">
                    <ul>
                    <s:iterator value="archives" var="parent">
		            	<s:if test="#parent.source == '网站公告'">
		                <li>
		                    <a href="<%=basePath%>web/index_toDetail?archive.id=<s:property value="#parent.id"/>"><s:property value="#parent.title"/></a>
		                </li>
		                </s:if>
		            </s:iterator>
                    </ul>
                    <div class="clear"></div>
                    <div style="text-align:right;line-height:30px"><a href="/xiao/list.aspx">更多>></a></div>
                </div>
            </div>
            <s:set name="count" value="1"></s:set>
            <s:iterator value="adss" var="parent">
            	<s:if test="#parent.place == '网页右面' and #count <= 3">
                    <p><a href="<s:property value="#parent.weburl"/>"><img src="<s:property value="#parent.imageurl"/>" width="100%" /></a></p>
                    <s:set name="count" value="#count + 1"></s:set>
                </s:if>
            </s:iterator>
        </div>
        <!--end right-->
        <div class="clear"></div>
    </div>
    <!--end main-->
    <%@ include file="footer.jsp"%>
    </form>
</body>
</html>
