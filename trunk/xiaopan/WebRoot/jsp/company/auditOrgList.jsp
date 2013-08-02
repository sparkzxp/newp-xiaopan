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
		<title><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("app.name.cn")}'/>_审核企业注册信息</title>
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
				<s:if test="org.auditStatus==@com.iskyinfo.fw.ssi.common.Constants@ORG_AUDIT_STATUSES_WAITING">
					//审核
					$("#audit").click(function(){
						var ids = checkMess();
						if(ids.length==1){
							//验证是否可以审核
							$.post("<%=basePath%>sys/indOrg_checkAudit?org.id="+ids[0],function(data){
				   	   			if(data=="success"){
				   	   				$.show('审核<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>注册信息','<%=basePath%>sys/indOrg_toAuditOrgEdit?org.id='+ids[0],800,550,"A");	   					 	
			   					}else{
			   						$.tips(data);
			   					}
			   				}); 
						}else{
							$.tips("请选择一条数据!");
						}
					});	
					$(".tit").text("等待审核中");
				</s:if>
				<s:else>
					$(".tit").text("审核为通过");
				</s:else>
				//详细
				$("#detail").click(function(){
					var ids = checkMess();
					if(ids.length==1){
						$.show('<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>详细信息','<%=basePath%>sys/indOrg_toDetail?org.id='+ids[0],800,600);
					}else{
						$.tips("请选择一条数据!");
					}
				});	
				
			});
			//重新提交表单刷新页面
			function pageLoad(){
				$("#queryForm").submit();
			} 
		</script>	
	</head>
	
	<body>
	<s:form action="indOrg_toAuditOrgList" namespace="/sys" id="queryForm">
	<s:hidden name="clazzType"/>
	<s:hidden name="org.auditStatus" />
	<div class="content_title"><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>资料审核</div><div id="brDiv"></div>
	<div class="content_list">
	  <ul>
	    <li></li>
	    </ul>
	    <s:if test="org.auditStatus==@com.iskyinfo.fw.ssi.common.Constants@ORG_AUDIT_STATUSES_WAITING" >
	    	<input type="button" class="sub" id="audit" value="审核">
	    </s:if>
		<input type="button" class="sub" id="detail" value="详情">
	</div>
	
	<div class="content_table">
		<table border="0" cellspacing="0" cellpadding="0" width="100%" class="mytable">
			<tr class="trbg">
				<th width="5%">
					<input type="checkbox" id="checkAll" style="display: none;"/>
				</th>
				<th align="center">
					<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>名称
				</th>
				<th align="center">
					<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>编码
				</th>
				<th align="center">
					法人
				</th>
				<th align="center">
					法人联系电话
				</th>
				<th align="center">
					审核状态
				</th>
			</tr>
			<s:iterator value="orgs">
				<tr onMouseOver="this.className='list_table_hilite'" onMouseOut="this.className=''">
					<td align="center"><input type="checkbox" value="<s:property value='id'/>"/><s:hidden name="name" /></td>
					<td align="center"><s:property value="name"/>&nbsp;</td>
					<td align="center"><s:property value="code"/>&nbsp;</td>
					<td align="center"><s:property value="legRep.name"/>&nbsp;</td>
					<td align="center"><s:property value="legRep.cellPhone"/>&nbsp;</td>
					<td align="center" class="tit"></td>
				</tr>								
			</s:iterator>
		</table>	
	    <%@ include file="../common/pager.jsp"%>
	</div>
	</s:form>
	</body>
</html>