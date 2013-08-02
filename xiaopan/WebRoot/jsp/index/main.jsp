<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<title><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("app.name.cn")}'/></title>
<link href="<%=basePath%>css/main.css" rel="stylesheet" type="text/css">
<link href="<%=basePath%>css/pop.css" rel="stylesheet" type="text/css">
<!-- <style type="text/css">
.permit{
	display: none;
}
</style> -->

<script type="text/javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/mainlayout.js"></script>
<%-- <script type="text/javascript" src="<%=basePath%>js/permit.js"></script> --%>
<script type="text/javascript" src="<%=basePath%>js/common/yanue.pop.js"></script>
<script type="text/javascript" src="<%=basePath%>plugin/dialog/dialog.js"></script>

<script type="text/javascript">
$.ajaxSetup({cache: false });
function logout(){
	$.confirm("确认退出本系统吗？",function(){
		$.post("<%=basePath%>sys/user_logout", null, function(data) {
			parent.location.href = "<%=basePath%>";
		});
	});
}

function toUrl(url){
	$("#frame_list").attr("src",url).load();
}

$(function(){
	<s:if test="org.type==1 && org.auditStatus != @com.iskyinfo.fw.ssi.common.Constants@ORG_AUDIT_STATUSES_PASSED">
		//审核不通过或未审核
		$("#frame_list").attr("src",'<%=basePath%>sys/user_toRejected');
	</s:if>
	<s:else>
		$("#frame_list").attr("src",'<%=basePath%>jsp/index/welcome.jsp');
		//getRemind();// 获取待办事项提醒
		//countUnread();// 获取未读消息和公告数量
		//isDistrict();// 是否是三级以后地区
	</s:else>
	$(".listMenuMain").find(".level_1").click(showMenu);
	$(".listMenuMain").find(".level_2,.level_3").click(function(event){
		$(".listMenuMain").find(".level_1").unbind();
		var ele = $(this).find(".listMenuTriangle").first();
		if(null != ele){
			ele.next().toggle();
			if(ele.next().css("display")!='none'){
				$(this).addClass("listChildren");
				if($(this).find("li").length <= 0){
					$(this).removeClass("listChildren");
				}
			}else{
				$(this).removeClass("listChildren");
			}
		}
		//阻止事件向上传递
		event.stopPropagation();
		$(".listMenuMain").find(".level_1").click(showMenu);
	});

	$(".permit[self='ftpTest']").show();
	$(".permit[self='jqGridTest']").show();
	$(".permit[self='easyuiGridTest']").show();
});
function menuClick(self){
	$(".permit[self='"+self+"']").click();
}
/**
 * 是否是三级以后地区
 */
function isDistrict(){
	$.post("<%=basePath%>sys/user_isDistrict", null, function(data) {
		if(data=='true'){
			$(".permit[self='67']").hide();
			$(".permit[self='203']").hide();
		}
	});
}
/**
 * 获取待办事项提醒
 */
function getRemind(){
	$.getJSON('<%=basePath%>sys/remind_getRemindInfo', null, function(json) {
		if(json.length > 0){
			var _con = '';
			if(json[0].type == '1'){
				if(json[0].waitAudit != 0){
					_con += '<div><a href="javascript:void(0)" onclick="menuClick(81)">待上报隐患数 [' + json[0].waitAudit + '] 个</a></div>';
				}
				if(json[0].waitRectify != 0){
					_con += '<div><a href="javascript:void(0)" onclick="menuClick(93)">待整改隐患数 [' + json[0].waitRectify + '] 个</a></div>';
				}
				if(json[0].waitReexamine != 0){
					_con += '<div><a href="javascript:void(0)" onclick="menuClick(98)">待复查隐患数 [' + json[0].waitReexamine + '] 个</a></div>';
				}
				if(json[0].waitClose != 0){
					_con += '<div><a href="javascript:void(0)" onclick="menuClick(104)">待销案隐患数 [' + json[0].waitClose + '] 个</a></div>';
				}
				if(_con == ''){
					_con = '<div>暂无待办事项！</div>';
				}
			}else if(json[0].type == '2'){
				if(json[0].committing != 0){
					_con += '<div><a href="javascript:void(0)" onclick="menuClick(87)">待审核的隐患 [' + json[0].committing + '] 个</a></div>';
				}
				if(json[0].fatalCount != 0){
					_con += '<div><a href="javascript:void(0)" onclick="menuClick(224)">待督办的重大隐患 [' + json[0].fatalCount + '] 个</a></div>';
				}
				if(json[0].generalCount != 0){
					_con += '<div><a href="javascript:void(0)" onclick="menuClick(224)">待督办的一般隐患 [' + json[0].generalCount + '] 个</a></div>';
				}
				if(json[0].closing != 0){
					_con += '<div><a href="javascript:void(0)" onclick="menuClick(109)">待处理的销案申请数 [' + json[0].closing + '] 个</a></div>';
				}
				if(_con == ''){
					_con = '<div>暂无待办事项！</div>';
				}
			}else if(json[0].type == '-1'){
				$(".permit[self='ftpTest']").show();
				$(".permit[self='jqGridTest']").show();
				$(".permit[self='easyuiGridTest']").show();
				return false;
			}
			//使用参数：1.标题，2.链接地址，3.内容简介
			var pop=new Pop("", "javascript:void(0)", _con);
		}
	});
}
/**
 * 获取未读消息和公告数量
 */
function countUnread(){
	$('#msgAlert').show();
	$.getJSON('<%=basePath%>sys/msg_getUnRead', null, function(json) {
		if(json.length > 0){
			$('#msgCount').html(json[0].msgCount);
			$('#noticeCount').html(json[0].noticeCount);
		}
	});
}

function showMenu(){
	$("li").removeClass("listChildren");
	var ele = $(this).find(".listMenuTriangle").first();
	$(".listMenuTriangle").next("ul").hide();
	$(".listMenuMain").find("li").removeClass("listMenuActive");
	$(this).addClass("listMenuActive");
	if(null != ele){
		ele.next().toggle();
	}
}
</script>
</head>

<body scroll=no><!-- 
<div id="dialog">
</div> -->
<div id="header">
    <div id="login_info">
    	<p>欢迎：<s:property value="org.name"/></p>
    	<%-- <p><s:property value="title"/></p> --%>
        <p>[ <a href="javascript:logout();">退出</a>]</p>
    </div>
    <div style="clear:both;"></div>
    <div id="note">
   			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;欢迎进入<s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("app.name.cn")}'/>
   			<span id="msgAlert" style="display: none;">&nbsp;&nbsp;短信消息（<a id="msgCount" href="javascript:void(0)" onclick="menuClick(216)">0</a>）
   			&nbsp;&nbsp;通知公告（<a id="noticeCount" href="javascript:void(0)" onclick="menuClick(219)">0</a>）</span>
    </div>
</div>
<div id="left">
	<ul class="listMenuMain">
		<li self="64" class="permit level_1"><img src="images/img/mainList1.png" /><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>资料审核
        	<span class="listMenuTriangle"></span>
        	<ul style="display: none;">
                <li self="64" class="permit level_2" onclick="toUrl('<%=basePath %>sys/indOrg_toAuditOrgList?org.auditStatus=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@ORG_AUDIT_STATUSES_WAITING" />')">等待审核中</li>
                <li self="64" class="permit level_2" onclick="toUrl('<%=basePath %>sys/indOrg_toAuditOrgList?org.auditStatus=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@ORG_AUDIT_STATUSES_REJECTED" />')">审核未通过</li>
           </ul>
        </li>
		<li self="57" class="permit level_1"><img src="images/img/mainList1.png" /><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>信息管理
        	<span class="listMenuTriangle"></span>
        	<ul style="display: none;">
            	<li self="58" class="permit level_2" onclick="toUrl('<%=basePath%>regist/reg_toRegist?params=industryOrgEdit&org.id=<s:property value="user.org.id"/>')"><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>信息管理</li>
            	<li self="61" class="permit level_2" onclick="toUrl('<%=basePath%>sys/user_managePwd?clazzType=enter')"><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>密码管理</li>
                <li self="202" class="permit level_2" onclick="toUrl('<%=basePath %>company/comGrade_show?org.auditStatus=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@ORG_AUDIT_STATUSES_PASSED" />')"><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>分级配置</li>
                <li self="67" class="permit level_2" onclick="toUrl('<%=basePath %>company/cm_toList?clazzType=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@LIST_OF_ADMINISTRATION_REGION" />')"><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>分区管理</li>
                <li self="68" class="permit level_2" onclick="toUrl('<%=basePath %>company/cm_toList?clazzType=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@LIST_OF_INDUSTRY" />')"><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>分类管理</li>
                <li self="69" class="permit level_2" onclick="toUrl('<%=basePath %>company/comGrade_toGradeManage?params=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@LIST_OF_INDUSTRY" />')">行业分级管理</li>
                <li self="203" class="permit level_2" onclick="toUrl('<%=basePath %>company/comGrade_toGradeManage?params=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@LIST_OF_ADMINISTRATION_REGION" />')">地区分级管理</li>
                <li self="70" class="permit level_2" onclick="toUrl('<%=basePath %>sys/indOrg_toAuditOrgList?clazzType=manageTotal&org.auditStatus=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@ORG_AUDIT_STATUSES_PASSED" />')"><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>综合管理</li>
           </ul>
        </li>
		<li self="71" class="permit level_1"><img src="images/img/mainList2.png" />隐患自查自报
        	<span class="listMenuTriangle"></span>
        	<ul style="display: none;">
            	<li self="72" class="permit level_2" onclick="toUrl('<%=basePath%>bp/ic_toDetail')">排查标准查看</li>
                <li self="75" class="permit level_2" onclick="toUrl('<%=basePath%>hazard/hazard_show?params=<s:property value="@com.iskyinfo.fw.ssi.common.ConstantUtil@HAZARD_REQUEST_BASE" />')">隐患自查登记</li>
                <li self="81" class="permit level_2" onclick="toUrl('<%=basePath%>hazard/hazard_show?params=<s:property value="@com.iskyinfo.fw.ssi.common.ConstantUtil@HAZARD_REQUEST_REQUEST" />')">隐患上报管理</li>
           </ul>
        </li>
		<li self="86" class="permit level_1"><img src="images/img/mainList3.png" />隐患排查治理
        	<span class="listMenuTriangle"></span>
        	<ul style="display: none;">
        		
            	<li self="87" class="permit level_2" onclick="toUrl('<%=basePath%>hazard/hazardAudit_toList?clazzType=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@LIST_OF_HAZARD_RELEASE_REQ_TYPE_ADD" />&hazard.status=<s:property
    				value="@com.iskyinfo.fw.ssi.common.Constants@LIST_OF_COMMITTED_WAIT_TO_AUDIT" />')">隐患上报审核</li>
   				<li self="224" class="permit level_2" onclick="toUrl('<%=basePath%>hazard/hazard_show?params=<s:property
   				value="@com.iskyinfo.fw.ssi.common.ConstantUtil@HAZARD_REQUEST_MANAGER" />')">上报隐患管理</li>
    				
                <%-- <li class="permit level_2" onclick="alert('积极开发中，请期待！')">一般隐患管理</li>
                <li class="permit level_2" onclick="alert('积极开发中，请期待！')">重大隐患管理</li> --%>
			</ul>
        </li>
		<li self="92" class="permit level_1"><img src="images/img/mainList4.png" />隐患整改治理
        	<span class="listMenuTriangle"></span>
        	<ul style="display: none;">
            	<li self="93" class="permit level_2" onclick="toUrl('<%=basePath%>hazard/hazard_show?params=<s:property
    				value="@com.iskyinfo.fw.ssi.common.ConstantUtil@HAZARD_REQUEST_PLAN" />')">隐患整改计划</li>
                <li self="98" class="permit level_2" onclick="toUrl('<%=basePath%>hazard/hazard_show?params=<s:property
    				value="@com.iskyinfo.fw.ssi.common.ConstantUtil@HAZARD_REQUEST_REVIEW" />')">隐患整改复查</li>
           </ul>
        </li>
		<li self="103" class="permit level_1"><img src="images/img/mainList5.png" />重大隐患销案
        	<span class="listMenuTriangle"></span>
        	<ul style="display: none;">
            	<li self="104" class="permit level_2" onclick="toUrl('<%=basePath%>hazard/hazard_show?params=<s:property
    				value="@com.iskyinfo.fw.ssi.common.ConstantUtil@HAZARD_REQUEST_CLOSECASE" />')">隐患销案申请</li>
                <li self="109" class="permit level_2" onclick="toUrl('<%=basePath%>hazard/hazardAudit_toList?clazzType=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@LIST_OF_HAZARD_RELEASE_REQ_TYPE_REMOVE" />&hazard.status=<s:property
    				value="@com.iskyinfo.fw.ssi.common.Constants@LIST_OF_RECTIFIED_CLOSING_CASE" />')">隐患销案审批</li>
           </ul>
        </li>
        <li self="217" class="permit level_1" onclick="toUrl('<%=basePath%>hazard/hazard_show?params=<s:property
    				value="@com.iskyinfo.fw.ssi.common.ConstantUtil@HAZARD_REQUEST_END" />')"><img src="images/img/mainList6.png" />已整改隐患管理</li>
		<li self="114" class="permit level_1"><img src="images/img/mainList6.png" />隐患统计分析
        	<span class="listMenuTriangle"></span>
        	<ul style="display: none;">
            	<li self="115" class="permit level_2" onclick="toUrl('<%=basePath %>sys/indOrg_toAuditOrgList?clazzType=enterpriseHazard&org.auditStatus=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@ORG_AUDIT_STATUSES_PASSED" />')"><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>隐患统计</li>
                <li self="116" class="permit level_2" onclick="toUrl('<%=basePath %>company/cm_toHazardTypeList?clazzType=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@LIST_OF_ADMINISTRATION_REGION" />')">地区隐患统计</li>
                <li self="117" class="permit level_2" onclick="toUrl('<%=basePath %>company/cm_toHazardTypeList?clazzType=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@LIST_OF_INDUSTRY" />')">行业隐患统计</li>
                <li self="118" class="permit level_2" onclick="toUrl('<%=basePath %>company/cm_toHazardStatusList?clazzType=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@LIST_OF_ADMINISTRATION_REGION" />')">地区整改统计</li>
                <li self="201" class="permit level_2" onclick="toUrl('<%=basePath %>company/cm_toHazardStatusList?clazzType=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@LIST_OF_INDUSTRY" />')">行业整改统计</li>
           </ul>
        </li>
        <li self="221" class="permit level_1"><img src="images/img/mainList7.png" />安全知识学习
        	<span class="listMenuTriangle"></span>
        	<ul style="display: none;">
            	<li self="222" class="permit level_2" onclick="toUrl('<%=basePath %>sys/nlg_show?params=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@KNOWLEDGE_TYPE_LAW" />')">法律知识学习</li>
                <li self="223" class="permit level_2" onclick="toUrl('<%=basePath %>sys/nlg_show?params=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@KNOWLEDGE_TYPE_CRITERIA" />')">标准规范学习</li>
           </ul>
        </li>
        <li self="119" class="permit level_1"><img src="images/img/mainList7.png" />业务参数配置
        	<span class="listMenuTriangle"></span>
        	<ul style="display: none;">
            	<li self="120" class="permit level_2" onclick="toUrl('<%=basePath%>bp/lov_manage?clazzType=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@LIST_OF_ADMINISTRATION_REGION" />')">行政区划管理</li>
                <li self="127" class="permit level_2" onclick="toUrl('<%=basePath%>bp/lov_manage?clazzType=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@LIST_OF_INDUSTRY" />')">行业类别管理</li>
                <li self="134" class="permit level_2" onclick="toUrl('<%=basePath%>bp/si_show?clazzType=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@ORG_XM_DIVISION" />')">监管区域配置</li>
                <li self="140" class="permit level_2" onclick="toUrl('<%=basePath%>bp/si_show?clazzType=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@ORG_XM_INDUSTRY" />')">监管行业配置</li>
                <li self="200" class="permit level_2" onclick="toUrl('<%=basePath%>bp/grade_show')">监管等级配置</li>
                <%-- <li class="permit level_2" onclick="toUrl('<%=basePath%>jsp/bizParam/requestCycle.jsp')">上报周期设置</li> --%>
                <li self="146" class="permit level_2" onclick="toUrl('<%=basePath%>bp/lov_manage?clazzType=<s:property value="@com.iskyinfo.fw.ssi.common.Constants@LIST_OF_ITEM_CAT" />')">排查项类别管理</li>
                <li self="153" class="permit level_2" onclick="toUrl('<%=basePath%>bp/ii_toList')">排查项管理</li>
                <li self="159" class="permit level_2" onclick="toUrl('<%=basePath%>bp/ic_toList')">排查标准管理</li>
           </ul>
        </li>
        <li self="165" class="permit level_1"><img src="images/img/mainList8.png" />系统参数配置
        	<span class="listMenuTriangle"></span>
        	<ul  style="display: none;">
        		<li self="ftpTest" class="permit level_2" onclick="toUrl('<%=basePath %>sys/ftp_toShow')">FTP测试</li>
        		<li self="jqGridTest" class="permit level_2" onclick="toUrl('<%=basePath %>sys/jqGrid_toShow')">jqGrid测试</li>
        		<li self="easyuiGridTest" class="permit level_2" onclick="toUrl('<%=basePath %>sys/jqGrid_toShowUI')">easyuiGrid测试</li>
        		<li self="166" class="permit level_2"><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.gov")}'/>管理
        			<span class="listMenuTriangle"></span>
               	 	 <ul style="display: none;">
                    	<li  self="167" class="permit level_3" onclick="toUrl('<%=basePath %>sys/org_show?params=<s:property value="@com.iskyinfo.fw.ssi.common.ConstantUtil@ROLE_CODE_ADMIN" />')"><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue(\"user.label.gov\")}'/>管理</li>
                        <li  self="168" class="permit level_3" onclick="toUrl('<%=basePath %>sys/indOrg_show?params=<s:property value="@com.iskyinfo.fw.ssi.common.ConstantUtil@ROLE_CODE_ADMIN" />')"><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>管理</li>
                    </ul>
                </li>
            	<li self="180" class="permit level_2">用户管理
            		<span class="listMenuTriangle"></span>
               	 	 <ul style="display: none;">
                    	<li  self="214" class="permit level_3" onclick="toUrl('<%=basePath%>sys/user_show?params=<s:property value="@com.iskyinfo.fw.ssi.common.ConstantUtil@ROLE_CODE_GOVERNMENT" />')"><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue(\"user.label.gov\")}'/>人员管理</li>
                        <li  self="215" class="permit level_3" onclick="toUrl('<%=basePath%>sys/user_show?params=<s:property value="@com.iskyinfo.fw.ssi.common.ConstantUtil@ROLE_CODE_ENTERPRISE" />')"><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>人员管理</li>
                    </ul>
            	</li>
            	 <li self="188" class="permit level_2">密码管理
                	<span class="listMenuTriangle"></span>
               	 	<ul style="display: none;">
                    	<li self="212" class="permit level_3" onclick="toUrl('<%=basePath%>sys/user_managePwdToList?clazzType=gov')"><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue(\"user.label.gov\")}'/>密码管理</li>
                        <li self="213" class="permit level_3" onclick="toUrl('<%=basePath%>sys/user_managePwdToList?clazzType=enter')"><s:property value='%{@com.iskyinfo.fw.ssi.common.ConfigReaderUtil@getPropertyValue("user.label.enter")}'/>密码管理</li>
                    </ul>
                </li>
 				<li self="189" class="permit level_2" onclick="toUrl('<%=basePath%>sys/role_show')">角色管理</li>
                <%--<li class="level_2" onclick="toUrl('<%=basePath%>sys/resc_show')">资源管理</li> --%>
                <li self="197" class="permit level_2" onclick="toUrl('<%=basePath%>sys/log_queryByPager')">日志管理</li>
                <li self="216" class="permit level_2" onclick="toUrl('<%=basePath%>sys/msg_toMsgManage')">消息管理</li>
                <li self="218" class="permit level_2">公告管理
                	<span class="listMenuTriangle"></span>
               	 	<ul style="display: none;">
                    	<li self="219" class="permit level_3" onclick="toUrl('<%=basePath%>sys/msg_toMsgPlacardList')">公告信息管理</li>
                        <li self="220" class="permit level_3" onclick="toUrl('<%=basePath%>sys/msg_toMsgPlacardList?params=<s:property value="@com.iskyinfo.fw.ssi.common.ConstantUtil@MSG_STATUS_ARCHIVED" />')">已归档公告管理</li>
                    </ul>
                </li>
        	</ul>
        </li>
    </ul>
</div>
<div id="foot">
	<p>copyright@2012-2014</p>
</div>
<div id="content">
	<iframe width="100%" id="frame_list" height="97%" frameborder="0" marginwidth="100%" marginheight="100%" ></iframe>
</div>

<!--jquery右下角pop弹窗start -->
<div id="pop" style="display:none;">
	<div id="popHead">
	<a id="popClose" title="关闭">关闭</a>
	<h2>温馨提示</h2>
	</div>
	<div id="popContent">
	<dl>
		<dt id="popTitle"><a href="javascript:void(0)" target="_blank"></a></dt>
		<dd id="popIntro"></dd>
	</dl>
	<p id="popMore"><a href="javascript:void(0)" onclick="getRemind()">刷新 »</a></p>
	</div>
</div>
<!--右下角pop弹窗 end-->
</body>
</html>
