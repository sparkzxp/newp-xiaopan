<%@page import="com.iskyinfo.fw.ssi.common.Constants"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("app.name.cn")}'/>_地区隐患统计</title>
<base href="<%=basePath%>">
<link href="<%=basePath%>css/content_list.css" rel="stylesheet" type="text/css">
<link class="include" rel="stylesheet" type="text/css" href="<%=basePath%>plugin/jquery.jqplot.1.0.4r1121/jquery.jqplot.min.css" />

<!--[if lt IE 9]><script language="javascript" type="text/javascript" src="<%=basePath%>plugin/jquery.jqplot.1.0.4r1121/excanvas.js"></script><![endif]-->
<script type="text/javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>

<script type="text/javascript" src="<%=basePath%>plugin/dialog/dialog.js"></script>
<script type="text/javascript" src="<%=basePath%>js/form_util.js"></script>
<script class="include" type="text/javascript" src="<%=basePath%>plugin/jquery.jqplot.1.0.4r1121/jquery.jqplot.min.js"></script>
<script language="javascript" type="text/javascript" src="<%=basePath%>plugin/jquery.jqplot.1.0.4r1121/plugins/jqplot.barRenderer.min.js"></script>
<script language="javascript" type="text/javascript" src="<%=basePath%>plugin/jquery.jqplot.1.0.4r1121/plugins/jqplot.categoryAxisRenderer.min.js"></script>
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
		
		var d1 = [];
		var d2 = [];
		var ticks = [];
		var i = 0;
		var _max = 10;
		<s:iterator value="infoList">
			d1[i] = <s:property value="generalCount"/>;
			d2[i] = <s:property value="fatalCount"/>;
			ticks[i++] = '<s:property value="regionName"/>';
		</s:iterator>
		
		if(d1.length!=0){
			for(i=0; i<d1.length; i++){
				if(_max < d1[i]) _max = d1[i];
				if(_max < d2[i]) _max = d2[i]
			}
			
			var plot2 = $.jqplot('showPlot',[d1, d2],{
		       title: '地区隐患统计',
		       legend: {
		           show: true
		       },
		       seriesDefaults: {
		           renderer: $.jqplot.BarRenderer,
		           rendererOptions: {
		               barPadding: 2
		           }
		       },
		       series: [
		    	   {label: '一般事故隐患'},
		    	   {label: '重大事故隐患'}
		       ],
		       axes: {
		           xaxis: {
		               label: '地区',
		               renderer: $.jqplot.CategoryAxisRenderer,
		               tickRenderer: $.jqplot.CanvasAxisTickRenderer,
		               labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
		               ticks: ticks,
		               tickOptions: {
		                   angle: -30
		                }
		           },
		           yaxis: {
		               tickRenderer: $.jqplot.CanvasAxisTickRenderer,
		               max: _max,
		               min: 0,
		               tickOptions: {
		                   formatString: '%d',
		                   angle: -30
		                }
		           }
		       }
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
	<s:form action="cm_toHazardTypeList" namespace="/company"
		id="queryForm">
		<s:hidden name="clazzType" />
		<div class="content_title">地区隐患统计</div>
		<!-- <div id="brDiv"></div> -->
		<div class="content_list">
			<ul>
			    <li>隐患登记时间从&nbsp;<s:textfield readonly="true" name="dater.startDate"/>
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
					一般隐患数量
				</th>
				<th align="center">
					重大隐患数量
				</th>
			</tr>
			<s:iterator value="infoList">
				<tr onMouseOver="this.className='list_table_hilite'" onMouseOut="this.className=''">
					<td align="center"><s:property value="regionName"/>&nbsp;</td>
					<td align="center"><s:property value="generalCount"/>&nbsp;</td>
					<td align="center"><s:property value="fatalCount"/>&nbsp;</td>
				</tr>
			</s:iterator>
		</table>
		</div>
	</s:form>
	<div id="showPlot" class="graph"></div>
</body>
</html>