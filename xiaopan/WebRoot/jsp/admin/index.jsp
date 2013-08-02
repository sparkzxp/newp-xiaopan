<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<base href="<%=basePath%>">
    <title>后台管理系统</title>
</head>
<frameset rows="61,*,24" cols="*" framespacing="0" frameborder="no" border="0">
  <frame src="<%=basePath%>jsp/admin/top.jsp" name="topFrame" scrolling="No" noresize="noresize" id="topFrame" />
  <frame src="<%=basePath%>jsp/admin/center.jsp" name="mainFrame" id="mainFrame" />
  <frame src="<%=basePath%>jsp/admin/down.jsp" name="bottomFrame" scrolling="No" noresize="noresize" id="bottomFrame" />
</frameset>
<noframes>
<body>
    <form id="form1" runat="server">
    </form>
</body>
</noframes>
</html>
