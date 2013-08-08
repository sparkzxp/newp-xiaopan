<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<base href="<%=basePath%>">
    <title>店铺详细-校畔网</title>
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
    <script language="javascript" src="<%=basePath%>/js/jquery.miloc.js"></script>
    <script language="javascript" src="<%=basePath%>/js/GetUrlData.js"></script>
    <script language="javascript" src="<%=basePath%>/js/global.js"></script>
    <script type="text/javascript" src="<%=basePath%>plugin/ztree/jquery.ztree.core-3.2.min.js"></script>
	
    <link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/select.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/zTreeStyle.css" type="text/css">
    <link type="text/css" href="<%=basePath%>/css/public.css" rel="Stylesheet" />
    <link type="text/css" href="<%=basePath%>/css/common.css" rel="Stylesheet" />
</head>
<body>
    <form id="form1">
    <%@ include file="header.jsp"%>
    <div class="position"></div>
    <div class="main">
        <%@ include file="left.jsp"%>
        <div class="right">
            <div class="r_d">
                <div class="r_d_l">
                    <p><h3><s:property value="shop.title" /></h3></p>
                    <p>地址：<s:property value="shop.address" /></p>
                    <p>电话：<s:property value="shop.tel" /></p>
                    <p>联系人：<s:property value="shop.contacter" /></p>
                    <p>
                        <strong>介绍：</strong><s:property value="shop.description" />
                    </p>
                </div>
                <div class="r_d_r">
                	<!-- onmouseover='$(this).width(300);' onmouseout='$(this).width(196)' -->
                    <p><img src="<s:property value="shop.imagePath" />" onerror='$(this).css("display","none");' /></p>
                </div>
                <div class="clear"></div>
            </div>
            <!--end r_d-->
            <div class="list">
                <div class="l_title"><h3>菜单</h3></div>
                <div class="l_c">
                	<s:property value="shop.contents" escape="false"/>
                    <div class="clear"></div>
                </div>
            </div>
            <!-- UY BEGIN -->
            <div id="uyan_frame"></div>
            <script type="text/javascript" id="UYScript" src="http://v1.uyan.cc/js/iframe.js?UYUserId=1769632" async=""></script>
            <!-- UY END -->
        </div>
        <!--end right-->
        <div class="clear"></div>
    </div>
    <%@ include file="footer.jsp"%>
    </form>
</body>
</html>
