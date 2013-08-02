<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>无标题文档</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	overflow:hidden;
}
-->
</style>
<script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
<script language="javascript" >
    $(function(){
        $('#I2').height($(window).height());
        $('#I1').height($(window).height());
    })
</script>
</head>

<body>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" style="table-layout:fixed">
  <tr>
    <td background="<%=basePath%>css/images/main_40.gif" style="width:3px;">&nbsp;</td>
    <td width="177"  style="border-right:solid 1px #9ad452;"><iframe id="I2" name="I2" height="100%" width="177" border="0" frameborder="0" src="<%=basePath%>jsp/admin/left.jsp">
		浏览器不支持嵌入式框架，或被配置为不显示嵌入式框架。</iframe></td>
    <td><iframe id="I1" name="I1" src="<%=basePath%>jsp/admin/main.jsp" height="100%" width="100%" border="0" frameborder="0">
		浏览器不支持嵌入式框架，或被配置为不显示嵌入式框架。</iframe></td>
    <td background="<%=basePath%>css/images/main_42.gif" style="width:3px;">&nbsp;</td>
  </tr>
</table>
</body>
</html>
