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
 						$.post("<%=basePath%>sys/ads_doDelete",{"ads.id":aid,"ads.imageurl":$(this).attr("aimageurl")},function(data){
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
</head>
<body>
    <form id="form1">
    <div class="top">
        <div class="t_left"></div>
        <div class="t_content"><strong>广告列表</strong></div>
        <div class="t_right"></div>
        <div class="clear"></div>
    </div>
    <div class="content">
        <div class="c_l"></div>
        <div class="c_c">
            <table border="0" cellpadding="0" cellspacing="0" class="list_table">
                <tr>
                    <th style="width:45px;">编号</th>
                    <th style="width:110px;">图片</th>
                    <th style="min-width:300px;">标题说明</th>
                    <th style="width:80px;">位置</th>
                    <th style="width:80px;">操作</th>
                </tr>
                <s:iterator value="adss" var="parent">
                    <tr class="<s:property value="#parent.id" />">
                        <td><s:property value="#parent.id" /></td>
                        <td><img alt="图片" src="<s:property value="#parent.imageurl" />" style="width:100px;margin:5px;" /></td>
                        <td><s:property value="#parent.title" /></td>
                        <td><s:property value="#parent.place" /></td>
                        <td>
                            <a href="<%=basePath%>sys/ads_toEdit?ads.id=<s:property value="#parent.id" />">修改</a>
                            <a href="javascript:void(0);" aid="<s:property value="#parent.id" />" aimageurl="<s:property value="#parent.imageurl" />" class="delete">删除</a>
                        </td>
                    </tr>
                </s:iterator>
            </table>
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
