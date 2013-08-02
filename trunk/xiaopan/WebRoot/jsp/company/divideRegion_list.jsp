<%@page import="com.iskyinfo.fw.ssi.common.Constants"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("app.name.cn")}'/>_企业分区管理</title>
<base href="<%=basePath%>">
<link href="<%=basePath%>css/content_list.css" rel="stylesheet" type="text/css">
<link class="include" rel="stylesheet" type="text/css" href="<%=basePath%>plugin/jquery.jqplot.1.0.4r1121/jquery.jqplot.min.css" />

<!--[if lt IE 9]><script language="javascript" type="text/javascript" src="<%=basePath%>plugin/jquery.jqplot.1.0.4r1121/excanvas.js"></script><![endif]-->
<script type="text/javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>

<script type="text/javascript" src="<%=basePath%>plugin/dialog/dialog.js"></script>
<script type="text/javascript" src="<%=basePath%>js/form_util.js"></script>
<script class="include" type="text/javascript" src="<%=basePath%>plugin/jquery.jqplot.1.0.4r1121/jquery.jqplot.min.js"></script>
<script class="include" type="text/javascript" src="<%=basePath%>plugin/jquery.jqplot.1.0.4r1121/plugins/jqplot.pieRenderer.min.js"></script>
<script language="javascript" type="text/javascript" src="<%=basePath%>plugin/My97DatePicker/WdatePicker.js"></script>

<style type="text/css">
div.graph
{
	width: 450px;
	height: 300px;
	float: left;
	border: 1px dashed gainsboro;
	margin-left: 25px;
}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		//隔行显示颜色
		$(".mytable tr:odd").css("background", "#eeffff");
		
		$("#queryForm_dater_startDate").addClass("Wdate").click(function(){
			WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'});
		});
		$("#queryForm_dater_endDate").addClass("Wdate").click(function(){
			WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'});
		});
		
		//查询
		$("#query").click(function(){
			var t1 = $("#queryForm_dater_startDate").val();
			var t2 = $("#queryForm_dater_endDate").val();
			var qssj = new Date(t1.replace("-", "/").replace("-", "/"));
			var jssj = new Date(t2.replace("-", "/").replace("-", "/"));
			if(DateDiff_Day(qssj, jssj)){
				pageLoad();
			}else{
				$.alert('查询结束时间要大于等于起始时间');
			}
		});
		//清空
		$("#clearQuery").click(function(){
			$("#queryForm_dater_startDate").val("");
			$("#queryForm_dater_endDate").val("");
		});
		
		var data = [];
		<s:iterator value="infoList">
			data.push(['<s:property value="regionName"/>',<s:property value="count"/>]);
		</s:iterator>
		
		if(data.length!=0){
			jQuery.jqplot.config.enablePlugins = true;
			var plot = jQuery.jqplot('showPie', [data], {
		      title: ' ',
		      seriesDefaults: {shadow: true, renderer: jQuery.jqplot.PieRenderer, rendererOptions: { showDataLabels: true } },
		      legend: { show:true }
			});
		}
	});
	//重新提交表单刷新页面
	function pageLoad() {
		$("#queryForm").submit();
	}
</script>
</head>
<body>
	<s:form action="cm_toList" namespace="/company"
		id="queryForm">
		<s:hidden name="clazzType" />
		<div class="content_title"><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>分区管理</div>
		<!-- <div id="brDiv"></div> -->
		<div class="content_list">
			<ul>
			    <li><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>生效时间从&nbsp;<s:textfield readonly="true" name="dater.startDate"/>
			    	至&nbsp;<s:textfield readonly="true" name="dater.endDate"/>
			    </li>
		    </ul>
		    <input type="button" class="sub" id="clearQuery" value="清空">
			<input type="button" class="sub" id="query" value="查询">
		</div>
		<div class="content_table">
		<table width="100%" class="mytable">
			<tr>
				<th align="center">
					地区名称
				</th>
				<th align="center">
					<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>数量
				</th>
			</tr>
			<s:iterator value="infoList">
				<tr onMouseOver="this.className='list_table_hilite'" onMouseOut="this.className=''">
					<td align="center"><s:property value="regionName"/>&nbsp;</td>
					<td align="center"><s:property value="count"/>&nbsp;</td>
				</tr>
			</s:iterator>
		</table>
		</div>
	</s:form>
	<div id="showPie" class="graph"></div>
</body>
</html>