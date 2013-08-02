<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("app.name.cn")}'/>_隐患管理</title>
		<base href="<%=basePath%>">
		<link href="<%=basePath%>css/content_list.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/form_util.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/common/pager.js"></script>
		<script type="text/javascript" src="<%=basePath%>plugin/dialog/dialog.js"></script>
		<script type="text/javascript">
			$(function(){
				//隔行显示颜色
				$(".mytable tr:odd").css("background", "#eeffff");
				//详细
				$("#detail").click(function(){
					var ids = checkMess();
					if(ids.length==1){
						$.show('<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>详细信息','<%=basePath%>sys/indOrg_toDetail?org.id='+ids[0],800,600);
					}else{
						$.tips("请选择一条数据!");
					}
				});
				//清空
				$('#clearQuery').click(function(){
					$('#queryForm_org_name').val('');
					$('#queryForm_org_code').val('');
					$('#queryForm_org_industryCat_lovName').val('');
					$('#queryForm_org_regAddr_lovName').val('');
				});
				//查询
				$('#query').click(function(){
					pageLoad();
				});
				
			});
			//重新提交表单刷新页面
			function pageLoad(){
				$("#queryForm").submit();
			}
			function showDetail(id){
				$.show('<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>详细信息','<%=basePath%>sys/indOrg_toDetail?org.id='+id,800,600);
			}
		</script>	
	</head>
	
	<body>
	<s:form action="indOrg_toAuditOrgList" namespace="/sys" id="queryForm">
	<s:hidden name="clazzType"/>
	<s:hidden name="org.auditStatus" />
	<div class="content_title"><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>隐患管理</div>
	<div class="content_list">
		<ul>
		    <li><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>名称&nbsp;<s:textfield name="org.name" /></li>
		    <li><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>编码&nbsp;<s:textfield name="org.code" /></li>
		    <li>行业类型&nbsp;<s:textfield name="org.industryCat.lovName" /></li>
		    <li>注册地址&nbsp;<s:textfield name="org.regAddr.lovName" /></li>
	    </ul>
	    <input type="button" class="sub" id="clearQuery" value="清空">
		<input type="button" class="sub" id="query" value="查询">
		<input type="button" class="sub" id="detail" value="详情">
	</div>
	
	<div class="content_table">
		<table width="100%" class="mytable">
			<tr class="trbg">
				<th style="width: 30px;">
					<input type="checkbox" id="checkAll" style="display: none;"/>
				</th>
				<th style="min-width: 120px;" align="center">
					<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>名称
				</th>
				<th style="width: 110px;" align="center">
					<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>编码
				</th>
				<th style="width: 130px;" align="center">
					行业类型
				</th>
				<th style="width: 110px;" align="center">
					一般事故隐患
				</th>
				<th style="width: 110px;" align="center">
					重大事故隐患
				</th>
			</tr>
			<s:iterator value="orgs">
				<tr onMouseOver="this.className='list_table_hilite'" onMouseOut="this.className=''">
					<td align="center"><input type="checkbox" value="<s:property value='id'/>"/><s:hidden name="name" /></td>
					<td align="center"><a href="javascript:void(0);" onclick="showDetail('<s:property value='id'/>')"><s:property value="name"/></a></td>
					<td align="center"><s:property value="code"/></td>
					<td align="center"><s:property value="industryCatName"/></td>
					<td align="center"><s:property value="generalCount"/></td>
					<td align="center"><s:property value="fatalCount"/></td>
				</tr>								
			</s:iterator>
		</table>	
	    <%@ include file="../common/pager.jsp"%>
	</div>
	</s:form>
	</body>
</html>