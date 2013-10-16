<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<base href="<%=basePath%>">
    <title>校畔网</title>
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
    <script language="javascript" src="<%=basePath%>js/common/validation.js"></script>
    <script language="javascript" src="<%=basePath%>js/GetUrlData.js"></script>
    <script language="javascript" src="<%=basePath%>js/global.js"></script>
    <script language="javascript" src="<%=basePath%>js/common/pager.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/ztree/jquery.ztree.core-3.2.min.js"></script>
	
    <link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/select.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/zTreeStyle.css" type="text/css">
    <link type="text/css" href="<%=basePath%>css/public.css" rel="Stylesheet" />
    <link type="text/css" href="<%=basePath%>css/common.css" rel="Stylesheet" />
    
    <script language="javascript">
        $(function() {
        	$('#queryForm_feedback_feedback').val('');
        	$("#btn_submit").click(function(){
   				if($('#queryForm').valid()){
	 	   			$("#btn_submit").attr("disabled","true");
	 	   			$.post("<%=basePath%>web/main_addFeedback",$("#queryForm").serialize(),function(data){
		  	   			if(data=="success"){
			  	   			location.reload();
	  	   					//alert("编辑成功!");
	 					}else{
	 						alert(data.result);
		  				}
		  	   			$("#btn_submit").removeAttr("disabled");
		 			});
	   			}
   	   		});
        });
    </script>
</head>
<body>
    <s:form id="queryForm">
    <%@ include file="header.jsp"%>
    <div class="position">
        <span>
			您现在的位置：<a href="<%=basePath%>web/main_toShow">首页</a>&gt;<a href="<%=basePath%>web/main_toFeedback">联系我们</a>
        </span>
    </div>
    <div class="main">
        <%@ include file="about.jsp"%>
        <!--end left-->
        <div class="right">
            <div class="n_c">
                <ul>
                <s:if test="feedbacks == null or feedbacks.size() == 0">
                	<div style="text-align: center;color: red;">还没有人联系我们，快来做第一人吧！！</div>
                </s:if>
                <s:iterator value="feedbacks" var="parent">
                	<li>
                		<div style="border: 2px solid #DFDFDF;float: left;width: 99%;">
	                		<div style="float: left;width: 99%;">
	                			用户&nbsp;<s:property value="#parent.ipAddress"/>&nbsp;<s:property value="%{getText('global.datetime',{#parent.feedbackTime})}"/>&nbsp;说：<br/>
	                			<s:property value="#parent.feedback"/>
	                		</div>
	                		<s:if test="#parent.reply != null and #parent.reply != ''">
	                		<div style="float: left;width: 99%; margin-left: 25px;">
	                			<span style="color: blue;">校畔网&nbsp;<s:property value="%{getText('global.datetime',{#parent.replyTime})}"/>&nbsp;回复：</span><br/>
	                			<s:property value="#parent.reply"/>
	                		</div>
	                		</s:if>
	                		<s:else>
	                		<div style="float: left;width: 99%;text-align: center;color: red;">建议正在处理中了哦</div>
	                		</s:else>
                		</div>
                	</li>
                </s:iterator>
                </ul>
                <div class="clear"></div>
            </div>
            <%@ include file="../common/pager.jsp"%>
            <div class="clear"></div>
            <div style="border: 1px solid #DFDFDF;margin-top: 5px;">
	            <div>请留下您宝贵的建议，我们会及时给你回复：</div>
	            <div style="text-align: center;">
	            <s:textarea name="feedback.feedback" cssStyle="width: 99%;resize:none;" rows="5" cssClass="{required:true,maxlengthCN:1000}"></s:textarea>
	            <input type="button" id="btn_submit" value="提交"/>
	            </div>
            </div>
        </div>
        <!--end right-->
        <div class="clear"></div>
    </div>
    <%@ include file="footer.jsp"%>
    </s:form>
</body>
</html>
