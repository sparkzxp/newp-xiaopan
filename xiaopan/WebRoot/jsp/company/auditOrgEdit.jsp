<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("app.name.cn")}'/>_审核企业注册信息</title>
	
	<link href="<%=basePath%>plugin/jquery-validation-1.10.0/demo/css/screen.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/info.css" rel="stylesheet" type="text/css">
	
	<script type="text/javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/dialog/dialog.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/jquery-validation-1.10.0/jquery.validate.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/jquery-validation-1.10.0/lib/jquery.metadata.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/jquery-validation-1.10.0/dist/additional-methods.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/jquery-validation-1.10.0/localization/messages_zh.js"></script>
		
		<script type="text/javascript" src="<%=basePath%>js/css/info.js"></script>
		<script language="javascript">
			var api = frameElement.api, W = api.opener;
 			//提交表单
 			function subForm(temp){
 	 			if(temp=="no"){
 	 				if($.trim($("#org_auditerComment").val())==""){
						W.$.tips("请填写审核意见!");	
						return;
 	 	 			}
 	 	 		}
	   	   		if($('#editForm').valid()){
		   	   		$("#params").val(temp);
		   	   		var type='<s:property value="hazard.type"/>';
		   	   		$("#btn_yes").attr("disabled","true");
		   	   		$("#btn_no").attr("disabled","true");
	   	   			$.post("<%=basePath%>sys/indOrg_doAuditOrgEdit",$("#editForm").serialize(),function(data){
		   	   			if(data=="success"){
	   						W.$.success("操作成功!点击确定返回列表.",function(){
	   							W.pageLoad();
		   						setTimeout(function(){api.close();}, 500);
							}).lock(true);			   					 	
	   					}else if(data=="error"){
	   						W.$.tips("操作失败!");
	   						$("#btn_yes").removeAttr("disabled");
	   			   	   		$("#btn_no").removeAttr("disabled");
	   					}
	   				}); 
	   			}
   	   	   	}
		</script>

	</head>

	<body>
		<s:form id="editForm">
				<s:hidden name="params" id="params"></s:hidden>
			    <table class="editForm">
			    	<%--<tr>
			    		<td width="15%">
			    			登录账号
			    		</td>
			    		<td colspan="3">
			    			<s:property value="user.loginName"/>
			    		</td>
			        </tr>
			    	--%><tr>
						<td width="15%">
							<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>名称<s:hidden name="org.id"></s:hidden>
						</td>
						<td width="40%">
							<s:property value="org.name" />
						</td>
						<td width="15%">
							<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>编码
						</td>
						<td>
							<s:property value="org.code" />
						</td>
					</tr>
					<tr>
						<td>
							<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>法人<s:hidden name="org.legRep.id"></s:hidden>
						</td>
						<td>
							<s:property value="org.legRep.name" />
						</td>
						<td>
							法人联系电话
						</td>
						<td>
							<s:property value="org.legRep.cellPhone" />
						</td>
					</tr>
					<tr>
						<td>
							安全负责人<s:hidden name="org.orgx.secLeader.name.id"></s:hidden>
						</td>
						<td>
							<s:property value="org.orgx.secLeader.name" />
						</td>
						<td>
							安全负责人电话
						</td>
						<td>
							<s:property value="org.orgx.secLeader.cellPhone" />
						</td>
					</tr>
					<tr>
						<td>
							传真号码
						</td>
						<td>
							<s:property value="org.faxCode" />
						</td>
						<td>
							邮政编码
						</td>
						<td>
							<s:property value="org.postCode" />
						</td>
					</tr>
					<tr>
						<td>
							办公地址
						</td>
						<td colspan="3">
							<s:property value="org.officeAddr.lovName"  />
						</td>
					</tr>
					<tr>
						<td >
							办公详细地址
						</td>
						<td colspan="3">
							<s:property value="org.officeAddrDtl" />
						</td>
					</tr>
					<tr>
						<td>
							注册地址
						</td>
						<td colspan="3">
							<s:property value="org.regAddr.lovName"/>
						</td>
					</tr>
					<tr>
						<td >
							注册详细地址
						</td>
						<td colspan="3">
							<s:property value="org.regAddrDtl"/>
						</td>
					</tr>
					<tr>
						<td>
							隶属关系
						</td>
						<td>
							<s:property value="org.level.lovName"/>
						</td>
						<td >
							经济类型
						</td>
						<td>
							<s:iterator value="econCats" id="temp">
								<s:if test="#temp.lovVal == org.econCat">
									<s:property value="#temp.lovName"/>
								</s:if>
							</s:iterator>
						</td>
					</tr>
					<tr>
						<td >
							行业类型
						</td>
						<td>
							<s:property value="org.industryCat.lovName"/>
						</td>
						<td >
							邮箱地址
						</td>
						<td>
							<s:property value="org.email" />
						</td>
					</tr>
					<tr>
						<td>
							安全生产<br />许可证编号
						</td>
						<td>
							<s:property value="org.orgx.manufactureLesence" />
						</td>
						<td >
							安全生产许可证<br />有效期截止日期
						</td>
						<td>
							<s:property value="%{getText('global.datetime',{org.orgx.lesenceExpireDt})}" />
						</td>
					</tr>
					<tr>
						<td>
							审核意见
						</td>
						<td colspan="3">
							<s:textarea id="org_auditerComment" cols="75" rows="6" name="org.auditerComment" cssClass="{required:true, maxlengthCN:200}"></s:textarea>
						</td>
					</tr>
				<tr>
					<td style="text-align: center;" colspan="4" style="height: 70px;">
							<input type="button" class="sub" id="btn_yes" onclick="subForm('yes')" value="通过">
							&nbsp;
							<input type="button" class="sub" id="btn_no" onclick="subForm('no')" id="sub" value="不通过">
							&nbsp;
							<input type="button" class="sub"
								onClick="javascript:api.close();"
								value="返回">
					</td>
				</tr>
			</table>
		</s:form>
	</body>
</html>
