<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!doctype html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("app.name.cn")}'/>_行业分级管理</title>
		<base href="<%=basePath%>">
		<link href="<%=basePath%>css/content_list.css" rel="stylesheet" type="text/css">
		<link class="include" rel="stylesheet" type="text/css" href="<%=basePath%>plugin/jquery.jqplot.1.0.4r1121/jquery.jqplot.min.css" />
		<!--[if lt IE 9]><script language="javascript" type="text/javascript" src="<%=basePath%>plugin/jquery.jqplot.1.0.4r1121/excanvas.js"></script><![endif]-->
		<script type="text/javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/form_util.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/common/pager.js"></script>
		<script type="text/javascript" src="<%=basePath%>plugin/dialog/dialog.js"></script>
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
			$(function(){
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
				
				try{
					//更改页面标题等标识
					var titleParams = "行业分级管理";
					var labelParams = "行业";
					var typeParams = "<s:property value='params'  escape='false'/>";
					if('<s:property value="@com.iskyinfo.fw.ssi.common.Constants@LIST_OF_ADMINISTRATION_REGION" />'==typeParams){
						titleParams = "地区分级管理";
						labelParams = "地区";
						window.title = '<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("app.name.cn")}'/>_地区分级管理';
						$(".content_title").text("地区分级管理");
						$("#titleTH").text("地区");
					}
					//隔行显示颜色
					$(".mytable tr:odd").css("background", "#eeffff");
					<s:iterator value="grades" status="count">
						var d<s:property value="#count.count"/> = [];
					</s:iterator>
					var ticks = [];
					var i = 0;
					var _max = 10;
					<s:iterator value="gradeList">
						<s:iterator value="grades" status="count">
							d<s:property value="#count.count"/>[i] = <s:property value="cnt"/>;
						</s:iterator>
						ticks[i++] = '<s:property value="industryName"/>';
					</s:iterator>
					for(i=0; i<d1.length; i++){
						<s:iterator value="grades" status="count">
							if(_max < d<s:property value="#count.count"/>[<s:property value="#count.count"/>]) _max = d<s:property value="#count.count"/>[<s:property value="#count.count"/>];
						</s:iterator>
					}
					
					var plot2 = $.jqplot('showPlot',[
						<s:iterator value="grades" status="count">
							d<s:property value="#count.count"/><s:if test="grades.size() > #count.count">,</s:if>
						</s:iterator>
						],{
				       title: titleParams,
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
							<s:iterator value="grades" status="count">
								{label: '<s:property value="lovName"/>'}<s:if test="grades.size() > #count.count">,</s:if>
							</s:iterator>
				       ],
				       axes: {
				           xaxis: {
				               label: labelParams,
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
				}catch(e){//没有数据会有异常
				}
			});
			//重新提交表单刷新页面
			function pageLoad() {
				$("#queryForm").submit();
			}
		</script>	
	</head>
	
	<body>
	<s:form action="comGrade_toGradeManage" namespace="/company" id="queryForm">
		<s:hidden name="params" />
		<div class="content_title">行业分级管理</div>
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
				<%--<th width="5%">
					<input type="checkbox" id="checkAll" style="display: none;"/>
				</th>
				--%><th align="center" id="titleTH">
					行业名称
				</th>
				<s:iterator value="grades" status="count">
					<th align="center">
						<s:property value="lovName"/>
					</th>
				</s:iterator>
			</tr>
			<s:iterator value="gradeList">
				<tr onMouseOver="this.className='list_table_hilite'" onMouseOut="this.className=''">
					<%--<td align="center"><input type="checkbox"></td>--%>
					<td align="center"><s:property value="industryName"/></td>
					<s:iterator value="grades">		
						<td align="center"><s:property value="cnt"/></td>
					</s:iterator>
				</tr>
			</s:iterator>
		</table>
		</div>
	</s:form>
	<div id="showPlot" class="graph"></div>
	</body>
</html>