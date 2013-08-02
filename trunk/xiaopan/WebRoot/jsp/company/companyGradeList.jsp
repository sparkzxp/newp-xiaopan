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
		<title><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("app.name.cn")}'/>_企业分级配置</title>
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
				//分级
				$("#toGrade").click(function(){
					var ids = checkMess();
					if(ids.length > 0){
						$.show("<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue(\"user.label.enter\")}'/>等级配置",'<%=basePath%>company/comGrade_toGradeEdit?orgIds='+idToString()+'&params='+getNames(),800,555,"A");
					}else{
						$.tips("请选择一条数据!");
					}
				});	
				//详细
				$("#detail").click(function(){
					var ids = checkMess();
					if(ids.length==1){
						$.show("<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue(\"user.label.enter\")}'/>详细信息",'<%=basePath%>sys/indOrg_toDetail?org.id='+ids[0],800,550);
					}else{
						$.tips("请选择一条数据!");
					}
				});	
				//全选全不选
				$("#checkAll").click(function(){
					checkAll(this.checked);
				});	
				
			});
			//重新提交表单刷新页面
			function pageLoad(){
				$("#queryForm").submit();
			} 
		</script>	
	</head>
	
	<body>
	<s:form action="comGrade_show" namespace="/company" id="queryForm">
	<s:hidden name="org.auditStatus"></s:hidden>
	<div class="content_title"><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>分级配置</div><div id="brDiv"></div>
	<div class="content_list">
	  <ul>
	    <li></li>
	    </ul>
	    <input type="button" class="sub" id="toGrade" value="配置监管等级">
		<input type="button" class="sub" id="detail" value="详情">
	</div>
	
	<div class="content_table">
		<table border="0" cellspacing="0" cellpadding="0" width="100%" class="mytable">
			<tr class="trbg">
				<th width="5%">
					<input type="checkbox" id="checkAll" />
				</th>
				<th align="center">
					<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>名称
				</th>
				<th align="center">
					<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>编码
				</th>
				<th align="center">
					<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>等级
				</th>
				<th align="center">
					法人
				</th>
				<th align="center">
					法人联系电话
				</th>
			</tr>
			<s:iterator value="orgs">
				<tr onMouseOver="this.className='list_table_hilite'" onMouseOut="this.className=''">
					<td align="center"><input type="checkbox" value="<s:property value='id'/>"/><s:hidden name="name" /></td>
					<td align="center"><s:property value="name"/>&nbsp;</td>
					<td align="center"><s:property value="code"/>&nbsp;</td>
					<td align="center"><s:property value="orgx.superviseGrade.lovName"/>&nbsp;</td>
					<td align="center"><s:property value="legRep.name"/>&nbsp;</td>
					<td align="center"><s:property value="legRep.cellPhone"/>&nbsp;</td>
				</tr>								
			</s:iterator>
		</table>	
	    <%@ include file="../common/pager.jsp"%>
	</div>
	</s:form>
	</body>
</html>