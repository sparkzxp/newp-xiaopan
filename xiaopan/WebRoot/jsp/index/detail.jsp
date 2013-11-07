<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<base href="<%=basePath%>">
    <title>店铺详细-校畔网</title>
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
    <script language="javascript" src="<%=basePath%>js/common/validation.js"></script>
    <script language="javascript" src="<%=basePath%>/js/jquery.miloc.js"></script>
    <script language="javascript" src="<%=basePath%>/js/GetUrlData.js"></script>
    <script language="javascript" src="<%=basePath%>/js/global.js"></script>
    <script type="text/javascript" src="<%=basePath%>plugin/ztree/jquery.ztree.core-3.2.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>plugin/jquery-spider-poll/jQuery.spider.poll.js"></script>
	
    <link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/select.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/zTreeStyle.css" type="text/css">
    <link type="text/css" href="<%=basePath%>/css/public.css" rel="Stylesheet" />
    <link type="text/css" href="<%=basePath%>/css/common.css" rel="Stylesheet" />
    <link href="<%=basePath%>plugin/jquery-spider-poll/jQuery.spider.poll.css" rel="stylesheet" type="text/css">
    <script language="javascript">
        $(function() {
        	$.post("<%=basePath%>web/main_queryVoteByShop", {
        		"vote.shopId":$('#queryForm_shop_id').val()
			},function(data){
				$("#poll_speed").poll("poll1",{
	        		title:'送餐速度',
	        		titleColor:'#ff6600',
	        		width:'600px',
	        		data:data,
	        		showPoll:true,
	        		multiple:false
	        	});
			});
        	
        	$('#vote').click(function(){
        		if($("#poll_speed").getChecked().length == 0){
        			alert('亲，投票前请先选择一项哦');
        		}else{
        			$.post("<%=basePath%>web/main_addVote", {
        				"vote.type":$($("#poll_speed").getChecked()[0]).val(),
        				"vote.shopId":$('#queryForm_shop_id').val()
        			},function(data){
        				if(data == 'success'){
        					location.reload();
        					//alert('感谢您的投票');
        				}else{
        					alert(data);
        				}
        			});
        		}
        	});
        	
        	$('#queryForm_comment_comment').val('');
        	$("#btn_submit").click(function(){
   				if($('#queryForm').valid()){
	 	   			$("#btn_submit").attr("disabled","true");
	 	   			$.post("<%=basePath%>web/main_addComment",$("#queryForm").serialize(),function(data){
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
        	$("#comment").click(function(){
        		$('html, body').animate({scrollTop: $(document).height()}, 'slow'); 
   	   		});
        });
    </script>
    
    <style type="text/css">
    .poll_div {
    	margin: 0;
    	background-color: #fff;
    }
    .poll_div div {
    	margin: 0;
    	background-color: #fff;
    }
    input[type=button]{
    	cursor: pointer;
    }
    </style>
</head>
<body>
    <s:form id="queryForm">
    <%@ include file="header.jsp"%>
    <div class="position"></div>
    <div class="main">
    	<s:hidden name="shop.id"/>
        <%@ include file="left.jsp"%>
        <div class="right">
            <div class="r_d">
                <div class="r_d_l">
                    <p><h3><s:property value="shop.title" /><s:if test="shop.isClosed.equals(\"1\")"><span style="color: red;">（本店已打烊）</span></s:if></h3></p>
                    <p>地址：<s:property value="shop.address" /></p>
                    <p>电话：<span style="font-weight: bold;color: red;"><s:property value="shop.tel" /></span></p>
                    <p>联系人：<s:property value="shop.contacter" /></p>
                    <p>
                        <strong>介绍：</strong><s:property value="shop.description" />
                    </p>
                </div>
                <div class="r_d_r">
                	<!-- onmouseover='$(this).width(300);' onmouseout='$(this).width(196)' -->
                    <p><img src="<s:property value="shop.imagePath" />" onerror='$(this).css("display","none");' /></p>
                </div>
                <div class="clear"></div>
            </div>
            <!--end r_d-->
            <div class="list">
            	<div id="poll_speed" class="poll_div"></div>
            	<div style="width:100%; text-align:center; padding-top:5px;">
            		<input type="button" value="我要投票" id="vote"/>
            		<input type="button" value="有话要说" id="comment"/>
            	</div>
                <div class="l_title"><h3>菜单</h3></div>
                <div class="l_c">
                	<s:set name="topid" value="-1"></s:set>
                	<s:iterator value="shop.types" var="parent">
                		<s:if test="#parent.topid != #topid">
                		<div style="width: 100%; float: left;font-weight:bold;margin-top:5px;"><s:property value="#parent.topname"/></div>
                		</s:if>
                		<div style="width: 50%; float: left;"><s:property value="#parent.name"/>
                		<s:property value="#parent.price"/></div>
                		<s:set name="topid" value="#parent.topid"></s:set>
                	</s:iterator>
                	<%-- <table style="width: 99%;border: 1px solid #3F3F3F;">
                		<tr>
                			<th style="width:15%;">名称</th><th style="width:10%;">价格</th>
                			<th style="width:15%;">名称</th><th style="width:10%;">价格</th>
                			<th style="width:15%;">名称</th><th style="width:10%;">价格</th>
                			<th style="width:15%;">名称</th><th style="width:10%;">价格</th>
                		</tr>
                	<s:set name="count" value="1"></s:set>
                	<s:iterator value="shop.types" var="parent">
                	<s:if test="#count != 1 and #count % 4 == 1">
                		<tr>
                	</s:if>
                		<td>
                			<s:property value="#parent.name"/>
                		</td>
                		<td>
                			<s:property value="#parent.price"/>
                		</td>
                	<s:if test="#count % 4 == 0">
                		</tr>
                	</s:if>
                	<s:set name="count" value="#count + 1"></s:set>
                	</s:iterator>
                	<s:if test="#count != 1 and #count % 4 != 0">
                		</tr>
                	</s:if>
                	</table> --%>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="list">
                <div class="l_title"><h3>描述说明</h3></div>
                <div class="l_c">
                	<s:property value="shop.contents" escape="false"/>
                    <div class="clear"></div>
                </div>
            </div>
            <!-- UY BEGIN -->
			<!-- <div id="uyan_frame"></div>
			<script type="text/javascript" id="UYScript" src="http://v2.uyan.cc/code/uyan.js?uid=1824940"></script> -->
			<!-- UY END -->
			<ul>
			<s:if test="comments == null or comments.size() == 0">
				<li><div style="text-align: center;color: red;">还没有人评论这家店铺，快来抢沙发！！</div></li>
			</s:if>
			<s:iterator value="comments" var="parent">
            	<li>
            		<div style="border: 2px solid #DFDFDF;float: left;width: 99%;">
             		<div style="float: left;width: 99%;margin-top: 3px;">
             			用户&nbsp;<s:property value="#parent.ipAddress"/>&nbsp;<s:property value="%{getText('global.datetime',{#parent.commentDT})}"/>&nbsp;说：<br/>
             			&nbsp;&nbsp;<s:property value="#parent.comment"/>
             		</div>
             		<s:if test="#parent.reply != null and #parent.reply != ''">
             		<div style="float: left;width: 99%; margin-left: 25px;">
             			<span style="color: blue;">店主&nbsp;<s:property value="%{getText('global.datetime',{#parent.replyDT})}"/>&nbsp;回复：</span><br/>
             			<s:property value="#parent.reply"/>
             		</div>
             		</s:if>
            		</div>
            	</li>
            </s:iterator>
            </ul>
            <%@ include file="../common/pager.jsp"%>
            <div class="clear"></div>
            <div style="border: 1px solid #DFDFDF;margin-top: 5px;">
	            <div>亲，用过餐了吗，如果觉得好请给我们好评哦：</div>
	            <div style="text-align: center;">
	            <input type="hidden" name="comment.shop.id" value="<s:property value="shop.id" />"/>
	            <s:textarea name="comment.comment" cssStyle="width: 99%;resize:none;" rows="5" cssClass="{required:true,maxlengthCN:1000}"></s:textarea>
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
