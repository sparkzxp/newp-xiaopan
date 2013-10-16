<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<base href="<%=basePath%>">
    <title>校畔网</title>
    <link type="text/css" href="<%=basePath%>css/admin/common.css" rel="Stylesheet" />
    <link type="text/css" href="<%=basePath%>css/admin/tab.css" rel="Stylesheet" />
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
    <script language="javascript" src="<%=basePath%>js/admin/global.js"></script>
    <script language="javascript" src="<%=basePath%>js/common/validation.js"></script>
    <script language="javascript" src="<%=basePath%>js/common/pager.js"></script>
    <script language="javascript" >
        $(function() {
            $(".delete").each(function(i) {
                $(this).click(function() {
                	if(confirm("确定删除吗？")){
						var aid = $(this).attr("aid");
						$.post("<%=basePath%>sys/comment_doDelete",{"comment.id":aid},function(data){
		   					if(data=="success"){
		   						alert("操作成功！");
		   						location.reload();
		   					}else{
		   						alert("操作失败！");
		   					}
		   				});
					}
                });
            });
        });
        
        function showReply(fid){
        	if($('#form_'+fid).css('display') == 'none'){
        		$('#form_'+fid).show();
        	}else{
        		$('#form_'+fid).hide();
        	}
        }
        
        function reply(fid){
			if($('#form_'+fid).valid()){
	  			$("#btn_submit").attr("disabled","true");
	  			$.post("<%=basePath%>sys/comment_doReply",$('#form_'+fid).serialize(),function(data){
		   			if(data=="success"){
	 	   				location.reload();
					}else{
						alert(data.result);
					}
		   			$("#btn_submit").removeAttr("disabled");
				});
			}
        }
    </script>
    <style type="text/css">
        .nav{text-align:right;margin-right:10px;}
        .list{line-height:30px;margin-left:10px;margin-right:10px;border:solid 1px #d0e3b7;border-top:none;}
        .list_l{float:left;cursor:pointer;margin-left:10px;}
        .list_r{float:right;margin-right:10px;}
        .list_r a:hover{color:#ff0000;text-decoration:none;}
        .list_r a{margin-left:3px;margin-right:5px;}
        .l_item{border-top:dashed 1px #d0e3b7;background:#f7fbf1;}
        .item,.item1{display:none;}
        .item .list_l{margin-left:20px;}
        .list .item1 .list_r a{margin-left:5px;margin-right:6px;}
        .item1 .list_l{margin-left:30px;}
    </style>
</head>
<body>
    <div class="top">
        <div class="t_left"></div>
        <div class="t_content"><a href="<%=basePath%>jsp/admin/index.jsp">首页</a>&gt;用户评论列表</div>
        <div class="t_right"></div>
        <div class="clear"></div>
    </div>
    <div class="content">
        <div class="c_l"></div>
        <div class="c_c">
            <s:iterator value="comments" var="parent">
                <div class="list">
                    <div class="list_l list0" aid="<s:property value="#parent.id" />">
                    	<div style="float: left;width: 99%;">
                			用户&nbsp;<s:property value="#parent.ipAddress"/>&nbsp;<s:property value="%{getText('global.datetime',{#parent.commentDT})}"/>&nbsp;对店铺<span style="font-weight: bold;">【<s:property value="#parent.shop.title" />】</span>评论说：<br/>
                			<s:property value="#parent.comment"/>
                		</div>
                		<s:if test="#parent.reply != null and #parent.reply != ''">
                		<div style="float: left;width: 99%; margin-left: 25px;">
                			<span style="color: blue;"><s:property value="%{getText('global.datetime',{#parent.replyDT})}"/>&nbsp;回复：</span><br/>
                			<s:property value="#parent.reply"/>
                		</div>
                		</s:if>
                		<s:else>
                		<div style="float: left;width: 99%;text-align: center;color: red;">评论还未回复</div>
                		</s:else>
				        <form id="form_<s:property value="#parent.id" />" style="display:none;">
                		<div style="border: 1px solid #DFDFDF;margin-top: 5px;">
				            <div style="text-align: center;">
				            <input type="hidden" name="comment.id" value="<s:property value="#parent.id" />"/>
				            <s:textarea name="comment.reply" cssStyle="width: 99%;resize:none;" rows="4" cssClass="{required:true,maxlengthCN:1000}"></s:textarea>
				            <input type="button" value="提交" onclick="reply('<s:property value="#parent.id" />');"/>
				            </div>
			            </div>
				        </form>
                    </div>
                    <div class="list_r">
                    	<s:if test="#parent.reply == null or #parent.reply == ''">
                        <a href="javascript:void(0);" onclick="showReply('<s:property value="#parent.id" />');">回复</a>|
                        </s:if>
                        <a href="javascript:void(0);" aid="<s:property value="#parent.id" />" class="delete">删除</a>
                    </div>
                    <div class="clear"></div>
                </div>
            </s:iterator>
            <!--end list-->
        </div>
        <div class="c_r"></div>
        <%@ include file="../common/pager.jsp"%>
    </div>
    <div class="bottom">
        <div class="b_l"></div>
        <div class="b_r"></div>
        <div class="clear"></div>
    </div>
</body>
</html>
