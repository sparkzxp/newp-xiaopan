<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
    <title>校畔网 店铺详细 <s:property value="shop.title"/></title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="<%=basePath%>plugin/jquery.mobile-1.3.2/jquery.mobile-1.3.2.min.css" type="text/css">
    
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/jquery.mobile-1.3.2/jquery.mobile-1.3.2.min.js"></script>
</head>
<body>
<!-- Home -->
<div data-role="page" id="page1">
    <div data-theme="e" data-role="header">
		<s:if test="type == null or type.name == null">
		<a data-role="button" class="ui-btn-right" href="<%=basePath%>mobile/mobile_toSearch?type.name=">
			 返回
        </a>
        </s:if>
        <s:else>
        <a data-role="button" class="ui-btn-right" href="<%=basePath%>mobile/mobile_toSearch?type.name=<s:property value="type.name" />">
			 返回
        </a>
        </s:else>
		<a data-role="button" class="ui-btn-left" href="<%=basePath%>mobile">
			首页
		</a>
        <h3>欢迎使用校畔网</h3>
    </div>
    <div data-role="content">
        <ul data-divider-theme="e" data-inset="true">
        	<li data-theme="c">
       			店铺：<s:property value="shop.title"/>
        	</li>
        	<li data-theme="c">
       			地址：<s:property value="shop.address"/>
        	</li>
        	<li data-theme="c">
   				电话：
   				<a style="clear: both;" href="tel:<s:property value="shop.tel"/>">
   					<s:property value="shop.tel"/>
   				</a>&nbsp;
   				<a href="tel:<s:property value="#parent.tel"/>" style="text-decoration:none;">
					<img style="width:20px; height: 20px;" alt="" src="<%=basePath%>images/tel.png">
				</a>
        	</li>
        	<li data-theme="c">
       			联系人：<s:property value="shop.contacter"/>
        	</li>
        	<li data-theme="c">
        		菜谱：
        		<s:iterator value="shop.types" var="child">
        		<div><s:property value="#child.name"/>(<s:property value="#child.price"/>元)</div>
        		</s:iterator>
        	</li>
        </ul>
    </div>
    <%@ include file="footer.jsp"%>
</div>
</body>
</html>
