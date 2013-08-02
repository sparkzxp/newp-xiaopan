<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<%@page import="com.iskyinfo.fw.ssi.common.Constants"%>
<!doctype html>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("app.name.cn")}'/>_企业注册</title>
		<link href="<%=basePath%>css/regist.css" rel="stylesheet" type="text/css">
		<link href="<%=basePath%>plugin/jquery-validation-1.10.0/demo/css/screen.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>plugin/jquery-validation-1.10.0/jquery.validate.js"></script>
		<script type="text/javascript" src="<%=basePath%>plugin/jquery-validation-1.10.0/lib/jquery.metadata.js"></script>
		<script type="text/javascript" src="<%=basePath%>plugin/jquery-validation-1.10.0/dist/additional-methods.js"></script>
		<script type="text/javascript" src="<%=basePath%>plugin/jquery-validation-1.10.0/localization/messages_zh.js"></script>
		<script type="text/javascript" src="<%=basePath%>plugin/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/common/json2.js"></script>
		<script type="text/javascript" src="<%=basePath%>plugin/dialog/dialog.js"></script>
		<script language="javascript">
		$(function(){
			/* $("body").css("height",document.documentElement.clientHeight+"px"); */
			$("#login_bg").css("height", ($(window).height()-100)+"px");
			$("input[type=text]").css("width","200px");
			$("input[type=password]").css("width","200px");
			$("#org_safetyDate").addClass("Wdate").click(function(){
				WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'});
			});
			$('#editForm').validate();
		});
		
		function sub(){
			if($('#editForm').valid()){
				$("#save").attr("disabled","true");
				<s:if test="null == org || null == org.id">
	   	   			$.post("<%=basePath%>regist/reg_doEdit",$("#editForm").serialize(),function(data){
		   	   			if(data=="success"){
			   	   			$.success("信息已提交,等待审核!",function(){
			   	   				window.location.href="<%=basePath%>";
							}).lock(true);
	   					}else if(data=="error"){
	   						$.tips("提交失败!");	
	   						$("#save").removeAttr("disabled");
	   					}else{
	   						$.tips(data);	
	   						$("#save").removeAttr("disabled");
		   				}
	   				}); 
   				</s:if>
   				<s:else>
   					$("#params").val("doRegistEdit");
	   				$.post("<%=basePath%>sys/indOrg_doEdit",$("#editForm").serialize(),function(data){
		   	   			if(data=="success"){
			   	   			$.success("信息已提交,等待审核!",function(){
				   	   			$.post("<%=basePath%>sys/user_logout", null, function(data) {
				   	 				parent.location.href = "<%=basePath%>";
				   	 			});
							}).lock(true);
	   					}else if(data=="error"){
	   						$.tips("提交失败!");	
	   						$("#save").removeAttr("disabled");
	   					}else{
	   						$.tips(data);	
	   						$("#save").removeAttr("disabled");
		   				}
	   				}); 
   				</s:else>
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
		//行业
		function showIndustry(){
			$.show('行业类型','<%=basePath%>bp/si_toEdit?clazzType=<%=Constants.ORG_XM_INDUSTRY %>&params=showIndustryByIndustry&org.id=-1',800,600,"A");
		}
		//填充数据
		function toInfo(){
			var json = eval("("+$("#industry_json").val()+")");
			var infoId = "";
   	   		var infoName = "";
   	   		$.each(json,function(key,info){
	   	   		infoName += info.name+",";
				infoId += info.id+",";
	   	   	});
			infoId = $.trim(infoId);
			infoName = $.trim(infoName);
			$("#industry_id").val(infoId.length > 1 ? infoId.substring(0,infoId.length-1):infoId);
			$("#industry_name").val(infoName.length > 1 ? infoName.substring(0,infoName.length-1):infoName);
		}
		function clearInfo(temp){}
		</script>

	</head>

	<body>
	<s:form id="editForm"><s:hidden name="params" id="params"></s:hidden>
		<div id="login_bg">
		<%@ include file="../common/industryOrgInfo.jsp"%>
			 <p>
		 		<a href='javascript: <s:if test="null == org || null == org.id">window.location.href="<%=basePath%>";</s:if><s:else>window.history.go(-1)</s:else>'>返　回</a>
				<a href="javascript:resetForm();">重　填</a><a href="javascript:void(0);" onclick="sub()" id="save">提　交</a>
			 </p>
		 </div>
		</s:form>
		
	</body>
</html>
