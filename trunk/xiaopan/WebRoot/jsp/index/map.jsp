<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>欢迎使用校畔网</title>
<script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
$(function() {
	var latlng = '<s:property value="ads.longitude"/>,<s:property value="ads.latitude"/>';
	var str = "http://api.map.baidu.com/staticimage?width=600&height=500&center="+latlng+"&zoom=13";
	str += "&markers="+latlng+"&markerStyles=l,A,";
	//str += "&labels="+latlng+"&labelStyles=江大,1,14,,,1";
	$('#map').attr('src', str);
});
</script>
<style type="text/css">
body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;}
</style>
</head>
<body>
<img id="map" alt="地图" src="">
</body>
</html>
