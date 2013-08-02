<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("app.name.cn")}'/>_企业等级配置</title>
		<link href="<%=basePath%>css/info.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>plugin/dialog/dialog.js"></script>
		<script language="javascript">
		var api = frameElement.api, W = api.opener;
		$(function(){
			//单选
			$("input[type=checkbox]").click(function(){
				if(this.checked){
					$("input[type=checkbox]:checked").removeAttr("checked");
					$(this).attr("checked","true");
				}else{
					$(this).removeAttr("checked");
				}
			});
   			$("#save").click(function(){
   	   			var temp = $($("input[type=checkbox]:checked")[0]).val();
   	   			if(temp && temp.length !=0){
	   				$("#save").attr("disabled","true");
	   				$.post("<%=basePath%>company/comGrade_doGradeEdit?params=<s:property value='params'  escape='false'/>&orgIds=<s:property value='orgIds'/>&grade.id="+$($("input[type=checkbox]:checked")[0]).val(),function(data){
	   					if(data=="success"){
	   						W.$.success("操作成功!点击确定返回列表.",function(){
			   					setTimeout(function(){api.close()},200);
							}).lock(true);			   					 	
	   					}else{
	   						W.$.tips("操作失败!");
	   						$("#save").removeAttr("disabled");
	   					}
					});
   	   			}else{
   	   				W.$.tips("请至少选择一条<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue(\"user.label.enter\")}'/>等级信息!");
   	   	   		}
   	   		});
   		});
		</script>

	</head>

	<body>
		<s:form id="editForm">
			<table class="editForm">
				<tr>
					<td style="text-align: center;">
						<div style="width:80%; height:500px;  border :1px solid Silver; overflow:auto;">
							<table class="editForm">
								<s:iterator value="grades" status="count" id="gr">
								  <s:if test="#count.odd||#cout.first">     
						              <tr>         
						          </s:if>  
										<td width="5%" style="text-align: center;">
											<input type="checkbox" value="<s:property value='id'/>"
													<s:if test="id == grade.id"> checked="checked"</s:if>
											/>
										</td>
										<td width="43%">
											<s:property value="lovName"/>
										</td>
									<s:if test="#count.even||#count.last">     
							            </tr>         
							        </s:if>  
								</s:iterator>
							</table>
						</div>
					</td>    
				</tr>
				<tr>
					<td style="text-align: center;">
						<input type="button" class="sub" id="save" value="保存">
						&nbsp;
						<input type="button" class="sub" onClick="api.close()" value="返回">
					</td>
				</tr>
				</table>
		</s:form>
	</body>
</html>
