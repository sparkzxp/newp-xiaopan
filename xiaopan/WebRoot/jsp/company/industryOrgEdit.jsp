<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.iskyinfo.fw.ssi.common.Constants"%>
<%@ include file="../common/header.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("app.name.cn")}'/>_修改企业信息</title>
		<link href="<%=basePath%>css/info.css" rel="stylesheet" type="text/css">
		<link href="<%=basePath%>plugin/jquery-validation-1.10.0/demo/css/screen.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>plugin/jquery-validation-1.10.0/jquery.validate.js"></script>
		<script type="text/javascript" src="<%=basePath%>plugin/jquery-validation-1.10.0/lib/jquery.metadata.js"></script>
		<script type="text/javascript" src="<%=basePath%>plugin/jquery-validation-1.10.0/dist/additional-methods.js"></script>
		<script type="text/javascript" src="<%=basePath%>plugin/jquery-validation-1.10.0/localization/messages_zh.js"></script>
		<script type="text/javascript" src="<%=basePath%>plugin/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/common/json2.js"></script>
		<script type="text/javascript" src="<%=basePath%>plugin/dialog/dialog.js"></script>
		
		<script type="text/javascript" src="<%=basePath%>js/css/info.js"></script>
		<style type="text/css">
			th{
				font-family: "微软雅黑", "黑体";
				font-weight: normal;
				color: #FFF;
				background-image: url(<%=basePath%>images/img/tabletittle.png);
				line-height: 38px;
				height: 38px;
			}
		</style>
		<script language="javascript">
		$(function(){
			$("input[type=text]").css("width","200px");
			$("input[type=password]").css("width","200px"); 
			$("#org_safetyDate").addClass("Wdate").click(function(){
				WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'});
			});
			$('#editForm').validate();
			$("#org_name").attr("disabled","true");
			$("#org_code").attr("disabled","true");
			$("#industry_name").attr("disabled","true");
			$("#regProvince").attr("disabled","true");
			$("#regCity").attr("disabled","true");
			$("#regTowns").attr("disabled","true");
			$("#officeProvince").attr("disabled","true");
			$("#officeCity").attr("disabled","true");
			$("#officeTowns").attr("disabled","true");
			$("#org_level").attr("disabled","true");
			$("#org_econCat").attr("disabled","true");
		});
		
		function sub(){
			if($('#editForm').valid()){
				$("#save").attr("disabled","true");
	   				$.post("<%=basePath%>sys/indOrg_doEdit",$("#editForm").serialize(),function(data){
		   	   			if(data=="success"){
			   	   			$.success("修改成功!",function(){
			   	   				$("#save").removeAttr("disabled");
							}).lock(true);
	   					}else if(data=="error"){
	   						$.tips("修改失败!");	
	   						$("#save").removeAttr("disabled");
	   					}else{
	   						$.tips(data);	
	   						$("#save").removeAttr("disabled");
		   				}
	   				}); 
	   		}
			
		}
		function resetForm(){
			document.getElementById("editForm").reset();
		}
		//获取县区
		function seekTown(temp){
			var cityId = $(temp).val();
			$.post("<%=basePath%>regist/reg_seekTowns?params="+cityId,function(data){
				if(data!="error"){
					data = JSON.parse(data);
					$(temp).next("select").find("option").remove();
					$.each(data,function(index,info){
						$(temp).next("select").append("<option value='"+info.id+"'>"+info.name+"</option>");
					});
				}
			});
		}
		//清空数据
		function clearInfo(id){
			$("#"+id).val('');
		}
		</script>
	</head>

	<body>
		<s:form id="editForm">
			<s:hidden name="org.name"></s:hidden>
			<s:hidden name="org.code"></s:hidden>		
			<%@ include file="../common/industryOrgInfo.jsp"%>
			<table class="editForm">
			    <tr>	
					<td  colspan="4" style="height: 70px; text-align: center;">
						<input type="button" class="sub" onclick="resetForm()" value="重　填">
						&nbsp;
						<input type="button" class="sub"  onclick="sub()" id="save" value="提　交">
					</td>
				</tr>
			</table>
		</s:form>
	</body>
</html>
