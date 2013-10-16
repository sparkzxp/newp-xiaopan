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
	
    <link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/select.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/zTreeStyle.css" type="text/css">
    <link type="text/css" href="<%=basePath%>/css/public.css" rel="Stylesheet" />
    <link type="text/css" href="<%=basePath%>/css/common.css" rel="Stylesheet" />
    
    <script language="javascript">
        $(function() {
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
        });
    </script>
</head>
<body>
    <s:form id="queryForm">
    <%@ include file="header.jsp"%>
    <div class="position"></div>
    <div class="main">
        <%@ include file="left.jsp"%>
        <div class="right">
            <div class="r_d">
                <div class="r_d_l">
                    <p><h3><s:property value="shop.title" /></h3></p>
                    <p>地址：<s:property value="shop.address" /></p>
                    <p>电话：<s:property value="shop.tel" /></p>
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
                <div class="l_title"><h3>菜单</h3></div>
                <div class="l_c">
                	<%-- <s:iterator value="">
                	</s:iterator> --%>
                	<s:property value="shop.contents" escape="false"/>
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
