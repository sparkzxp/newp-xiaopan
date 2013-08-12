<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
    <title>校畔网 菜谱搜索 <s:if test="type != null and type.name != null"><s:property value="type.name" /></s:if></title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="<%=basePath%>plugin/jquery.mobile-1.3.2/jquery.mobile-1.3.2.min.css" type="text/css">
    
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/jquery.mobile-1.3.2/jquery.mobile-1.3.2.min.js"></script>
</head>
<body>
<!-- Home -->
<div data-role="page" id="page1">
	<div data-theme="e" data-role="header">
		<a data-role="button" class="ui-btn-right" href="<%=basePath%>mobile/mobile_toTypeList">
			 返回
        </a>
		<a data-role="button" class="ui-btn-left" href="<%=basePath%>mobile">
			首页
		</a>
        <h3>欢迎使用校畔网</h3>
    </div>
    <div data-role="content">
    	<form id="queryForm" action="<%=basePath%>mobile/mobile_toSearch">
	    	<div data-role="fieldcontain">
	            <input name="type.name" id="searchinput1" placeholder="输入菜谱查询...." value="" type="search">
	        </div>
        </form>
    	<div>
    		<s:if test="type == null or type.name == null or type.name == ''">
    			<span style="font-weight: bold;">所有店铺信息</span>
    		</s:if>
    		<s:else>
        	<span style="font-weight: bold;"><s:property value="type.name" /></span>&nbsp;的搜索结果&nbsp;
        	<a href="<%=basePath%>mobile/mobile_toSearch?type.name=" data-transition="fade" style="color:green;">显示所有店铺</a>
        	</s:else>
        </div>
   		<ul data-role="listview" data-divider-theme="e" data-inset="true">
        	<s:iterator value="shops" var="parent">
        	<li data-theme="c">
        		<table style="width:100%;">
        			<tr>
        				<td style="width:80%;">
        					<div style="margin-bottom: 10px;"><a href="<%=basePath%>mobile/mobile_toShop?shop.id=<s:property value="#parent.id"/>" data-transition="slide"><s:property value="#parent.title"/></a></div>
        					<div><a href="tel:<s:property value="#parent.tel"/>"><s:property value="#parent.tel"/></a></div>
        				</td>
        				<td style="width:20%;">
        					<a data-inline="true" href="<%=basePath%>mobile/mobile_toShop?shop.id=<s:property value="#parent.id"/>">
							去看看</a>
						</td>
        			</tr>
        		</table>
        		<%-- <s:iterator value="#parent.types" var="child">
               		<s:if test="#child.name.indexOf(type.name) > -1">
               		<s:property value="#child.name"/>(<s:property value="#child.price"/>&nbsp;元)
               		</s:if>
               	</s:iterator> --%>
        	</li>
        	</s:iterator>
        </ul>
    </div>
    <div style="text-align: center;">
    <a data-role="button" data-inline="true" href="<%=basePath%>mobile/mobile_toSearch?type.name=<s:property value="type.name"/>&pager.currentPage=1">
		首页
    </a>
    <a data-role="button" data-inline="true" href="<%=basePath%>mobile/mobile_toSearch?type.name=<s:property value="type.name"/>&pager.currentPage=<s:property value="%{pager.currentPage - 1}"/>">
		上页
    </a>
    <a data-role="button" data-inline="true" href="<%=basePath%>mobile/mobile_toSearch?type.name=<s:property value="type.name"/>&pager.currentPage=<s:property value="%{pager.currentPage + 1}"/>">
		下页
    </a>
    <a data-role="button" data-inline="true" href="<%=basePath%>mobile/mobile_toSearch?type.name=<s:property value="type.name"/>&pager.currentPage=<s:property value="pager.totalPage" />">
		末页
    </a>
    </div>
    <%@ include file="footer.jsp"%>
</div>
</body>
</html>
