<%@page import="java.util.Enumeration"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<title>手机</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="<%=basePath%>plugin/jquery.mobile-1.3.2/jquery.mobile-1.3.2.min.css" type="text/css">
    
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/jquery.mobile-1.3.2/jquery.mobile-1.3.2.min.js"></script>
<%
//取手机号
String mobile = "" ;
String MO="";
String temvit = "";
String version = "";

Enumeration headerNames = request.getHeaderNames();
while(headerNames.hasMoreElements()) {
	String headerName = (String)headerNames.nextElement();
	if (headerName.equals("x-up-calling-line-id")) {
		temvit=request.getHeader(headerName);
		if (temvit.substring(0,3).trim().equals("861")) {
			mobile=temvit.substring(2,13);
		}
		if (temvit.substring(0,2).trim().equals("13")) {
			mobile=temvit;
		}
	}
	
	if (headerName.equals("user-agent")) {
		MO=request.getHeader(headerName);
	}
	
	if (headerName.equals("x-up-calling-line-id")) {
		temvit=request.getHeader(headerName);
		if (temvit.substring(0,2).trim().equals("13")) {
			mobile=temvit;
		}
	}
}

String Mobile_GPRS = request.getHeader("X-up-calling-line-id"); 
String Mobile_CDMA = request.getHeader("x-up-subno"); 
String Mobile_INFO = request.getHeader("x-network-info"); 
String Mobile_DEVI = request.getHeader("deviceid");
%>
<script type="text/javascript">
function successCallback(position) {
	$("#pos").html('latitude:'+position.coords.latitude+" - longitude="+position.coords.longitude);
}

function errorCallback(error) {
	$("#pos").html('error:'+error);
}

if (navigator.geolocation) {
	navigator.geolocation.getCurrentPosition(successCallback,errorCallback,{maximumAge:600000, timeout:2000, enableHighAccuracy:true});
}
else{
	errorCallback(null);
}
</script>
</head>
<body>
<div data-role="page" id="SignIn">   
   <div data-theme="e" data-role="header">
		<a data-role="button" class="ui-btn-left" href="<%=basePath%>mobile">
			首页
		</a>
        <h3>欢迎使用校畔网</h3>
    </div>
   <div data-role="content">
   <div>这个页面只是测试使用，您可以在这查看一些您爱机的基本信息，请放心浏览，我们承诺并不会收集您的信息，以保证每位用户的隐私。</div>
   <div>-</div>
   <%
   headerNames = request.getHeaderNames();
   while(headerNames.hasMoreElements()) {
	String headerName = (String)headerNames.nextElement();
	%>
	<div><%=headerName %>:<%=request.getHeader(headerName) %></div>
	<%
   }
	%>
   <div>-</div>
   <div>浏览器是否支持GPS<span id="pos">loading....</span></div>
   <div>-</div>
   <div>mobile:<%=mobile %></div>
   <div>MO:<%=MO %></div>
   <div>temvit:<%=temvit %></div>
   <div>version:<%=version %></div>
   <div>-</div>
   <div>Mobile_GPRS:<%=Mobile_GPRS %></div>
   <div>Mobile_CDMA:<%=Mobile_CDMA %></div>
   <div>Mobile_INFO:<%=Mobile_INFO %></div>
   <div>Mobile_DEVI:<%=Mobile_DEVI %></div>
  </div>
   <%@ include file="footer.jsp"%>
</div>
</body>
</html>