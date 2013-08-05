<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<base href="<%=basePath%>">
		<title>无标题页</title>
		<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}

.date,.STYLE1 {
	color: #43860c;
	font-size: 12px;
}

#Map {
	cursor: pointer;
}
</style>
</head>
<body>
<form id="form1">
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		style="table-layout: fixed;">
		<tr>
			<td height="9"
				style="line-height:9px; background-image:url(<%=basePath%>css/images/main_04.gif)"><table
					width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="97" height="9"
							background="<%=basePath%>css/images/main_01.gif">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="47" background="<%=basePath%>css/images/main_09.gif">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="38" height="47"
							background="<%=basePath%>css/images/main_06.gif">&nbsp;</td>
						<td width="59"><table width="100%" border="0"
								cellspacing="0" cellpadding="0">
								<tr>
									<td height="29"
										background="<%=basePath%>css/images/main_07.gif">&nbsp;</td>
								</tr>
								<tr>
									<td height="18"
										background="<%=basePath%>css/images/main_14.gif"><table
											width="100%" border="0" cellspacing="0" cellpadding="0"
											style="table-layout: fixed;">
											<tr>
												<td style="width: 1px;">&nbsp;</td>
												<td><span class="STYLE1">Admin</span></td>
											</tr>
										</table></td>
								</tr>
							</table>
						</td>
						<td width="155" background="<%=basePath%>css/images/main_08.gif">&nbsp;</td>
						<td><table width="100%" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<td height="23" valign="bottom"><img
										src="<%=basePath%>css/images/main_12.gif" width="367"
										height="23" border="0" usemap="#Map" /></td>
								</tr>
							</table>
						</td>
						<td width="200" background="<%=basePath%>css/images/main_11.gif"><table
								width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="11%" height="23">&nbsp;</td>
									<td width="89%" valign="bottom"><span class="date"
										id="date">日期：2008年7月22日 星期二</span></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="5"
				style="line-height:5px; background-image:url(<%=basePath%>css/images/main_18.gif)"><table
					width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="180" background="<%=basePath%>css/images/main_16.gif"
							style="line-height: 5px;">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<map name="Map" id="Map">
		<area shape="rect" coords="3,1,49,22" href="#"
			onclick="javascript:top.location.href='<%=basePath%>jsp/admin/index.jsp'" />
		<area shape="rect" coords="52,2,95,21" href="#"
			onclick="javascript:history.go(-1)" />
		<area shape="rect" coords="102,2,144,21" href="#" onclick="javascript:history.go(1)" />
		<area shape="rect" coords="150,1,197,22" href="#"
			onclick="javascript:top.location.href='<%=basePath%>jsp/admin/index.jsp'" />
		<area shape="rect" coords="210,2,304,20" href="<%=basePath%>sys/user_toManagePwd"
			target="I1" />
		<area shape="rect" coords="314,1,361,23" href="<%=basePath%>sys/user_logout" target="I1" />
	</map>
	<script language="javascript">
		function show() {
			var date = new Date();
			var year = date.getFullYear();
			var month = date.getMonth() + 1;
			var day = date.getDate();
			var hour = date.getHours();
			var minute = date.getMinutes();
			var second = date.getSeconds();
			if (month < 10) {
				month = "0" + month;
			}
			if (day < 10) {
				day = "0" + day;
			}
			if (hour < 10) {
				hour = "0" + hour;
			}
			if (minute < 10) {
				minute = "0" + minute;
			}
			if (second < 10) {
				second = "0" + second;
			}
			var time = year + "年" + month + "月" + day + "日&nbsp;&nbsp;"
					+ hour + ":" + minute + ":" + second;
			document.getElementById("date").innerHTML = time;
			setTimeout("show()", 1000);
		}
		window.onload = show;
	</script>
</form>
</body>
</html>
