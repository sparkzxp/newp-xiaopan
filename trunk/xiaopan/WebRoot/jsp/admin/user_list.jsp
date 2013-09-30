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
    <script language="javascript" >
        $(function() {
            $(".delete").each(function(i) {
                $(this).click(function() {
                	if(confirm("确定删除吗？")){
						var aid = $(this).attr("aid");
						$.post("<%=basePath%>sys/user_doDelete",{"user.id":aid},function(data){
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
    <form id="form1">
    <div class="top">
        <div class="t_left"></div>
        <div class="t_content"><a href="<%=basePath%>jsp/admin/index.jsp">首页</a>&gt;用户列表</div>
        <div class="t_right"></div>
        <div class="clear"></div>
    </div>
    <div class="content">
        <div class="c_l"></div>
        <div class="c_c">
            <div class="nav"><a href="<%=basePath%>sys/user_toEdit?user.id=">添加用户</a></div>
            <s:iterator value="users" var="parent">
                <div class="list">
                    <div class="list_l list0" aid="<s:property value="#parent.id" />">
                        <s:property value="#parent.username" />&nbsp;&nbsp;
                        (ID:<s:property value="#parent.id" />)&nbsp;&nbsp;
						(权限:<s:property value="#parent.role.name" />)
                    </div>
                    <div class="list_r">
                        <a href="<%=basePath%>sys/user_toEdit?user.id=<s:property value="#parent.id" />">修改</a>|
                        <a href="javascript:void(0);" aid="<s:property value="#parent.id" />" class="delete">删除</a>
                    </div>
                    <div class="clear"></div>
                </div>
            </s:iterator>
            <!--end list-->
        </div>
        <div class="c_r"></div>
    </div>
    <div class="bottom">
        <div class="b_l"></div>
        <div class="b_r"></div>
        <div class="clear"></div>
    </div>
    </form>
</body>
</html>
