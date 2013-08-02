<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    <title></title>
    <script type="text/javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/dialog/dialog.js"></script>
	<script type="text/javascript">
		//详细
		function detail(id){
			$.show("<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue(\"user.label.gov\")}'/>详细信息",'<%=basePath%>sys/org_toDetail?org.id='+id,800,500);
		}
	</script>
  </head>
  
  <body>
   <s:if test="user.org.type==1 && user.org.auditStatus == @com.iskyinfo.fw.ssi.common.Constants@ORG_AUDIT_STATUSES_REJECTED">
		很抱歉,您的注册信息未通过审核.<br/>
		上级主管部门意见:&nbsp;[<s:property value="user.org.auditerComment"/>]&nbsp;<br />
		具体详情请联系您的主管部门<s:if test="null != org">[ <a href="javascript:void(0);" onclick="detail('<s:property value="org.id"/>')"><s:property value="org.name"/></a> ]</s:if>
		<a href="javascript:void(0);" onclick="parent.location.href = '<%=basePath%>regist/reg_toRegist?org.id=<s:property value="user.org.id"/>'">点此重新申请!</a>
		
   </s:if>
   <s:elseif test="user.org.type==1 && user.org.auditStatus == @com.iskyinfo.fw.ssi.common.Constants@ORG_AUDIT_STATUSES_WAITING">
		很抱歉,您的注册信息正在审核中.<br/>
		详情请联系您的主管部门<s:if test="null != org">[ <a href="javascript:void(0);" onclick="detail('<s:property value="org.id"/>')"><s:property value="org.name"/></a> ]</s:if>
   </s:elseif>
   
  </body>
</html>
