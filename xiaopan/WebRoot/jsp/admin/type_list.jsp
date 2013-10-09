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
            $(".list:first").css({ borderTop: "solid 1px #d0e3b7" });
            $(".list0").each(function(i) {
                $(this).click(function() {
                	if($(this).attr('refreshid')=='true'){
                		$(this).attr('refreshid', 'false');
	                	$.getJSON("<%=basePath%>sys/type_getTypeMenu", "type.topid="+$(this).attr('aid'), function(data){
	                		if(data.success){
	                			var _html = '';
	                			for(var n=0; n<data.list.length; n++){
	                				_html += '<div class="l_item"><div class="list_l list1" aid="'+data.list[n].id+'" refreshid="true" onclick="clickList1(this)">';
	                				_html += data.list[n].name+'&nbsp;&nbsp;(价格:'+data.list[n].price+'&nbsp;元)&nbsp;&nbsp;';
	                				_html += '(ID:'+data.list[n].id+')&nbsp;&nbsp;(排序:'+data.list[n].sort+')</div>';
	                				_html += '<div class="list_r">';
	                				_html += '<a href="<%=basePath%>sys/type_toEdit?type.id='+data.list[n].id+'">修改</a>|';
	                				_html += '<a href="javascript:void(0);" aid="'+data.list[n].id+'" class="delete">删除</a>';
	                				_html += '</div><div class="clear"></div><div class="item1"></div></div>';
	                			}
	                			$(".item").eq(i).html(_html);
	                        	$(".item").eq(i).toggle();
	                		}
	                	});
                	}else{
                		$(".item").eq(i).toggle();
                	}
                });
            });
            
            $(".delete").each(function(i) {
                $(this).click(function() {
                	if(confirm("删除前请先确定有没有下级分类，确定删除吗？")){
						var aid = $(this).attr("aid");
						$.post("<%=basePath%>sys/type_doDelete",{"type.id":aid},function(data){
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
        
        function clickList1(o){
        	if($(o).attr('refreshid')=='true'){
        		$(o).attr('refreshid', 'false');
            	$.getJSON("<%=basePath%>sys/type_getTypeMenu", "type.topid="+$(o).attr('aid'), function(data){
            		if(data.success){
            			var _html = '';
            			for(var n=0; n<data.list.length; n++){
            				_html += '<div class="l_item"><div class="list_l list2" aid="'+data.list[n].id+'">';
            				_html += data.list[n].name+'&nbsp;&nbsp;(价格:'+data.list[n].price+'&nbsp;元)&nbsp;&nbsp;';
            				_html += '(ID:'+data.list[n].id+')&nbsp;&nbsp;(排序:'+data.list[n].sort+')</div>';
            				_html += '<div class="list_r">';
            				_html += '<a href="<%=basePath%>sys/type_toEdit?type.id='+data.list[n].id+'">修改</a>|';
            				_html += '<a href="javascript:void(0);" aid="'+data.list[n].id+'" class="delete">删除</a>';
            				_html += '</div><div class="clear"></div><div class="item2"></div></div>';
            			}
            			$(o).parent().find(".item1").html(_html);
            			$(o).parent().find(".item1").toggle();
            		}
            	});
        	}else{
        		$(o).parent().find(".item1").toggle();
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
    <form id="form1">
    <div class="top">
        <div class="t_left"></div>
        <div class="t_content"><a href="<%=basePath%>jsp/admin/index.jsp">首页</a>&gt;分类列表</div>
        <div class="t_right"></div>
        <div class="clear"></div>
    </div>
    <div class="content">
        <div class="c_l"></div>
        <div class="c_c">
            <div class="nav"><a href="<%=basePath%>sys/type_toEdit?type.id=">添加分类</a></div>
            <s:iterator value="types" var="parent">
            	<s:if test="#parent.topid == 0">
                    <div class="list">
                        <div class="list_l list0" aid="<s:property value="#parent.id" />" refreshid="true">
                            <s:property value="#parent.name" />&nbsp;&nbsp;
                            (ID:<s:property value="#parent.id" />)&nbsp;&nbsp;
  							(排序:<s:property value="#parent.sort" />)
                        </div>
                        <div class="list_r">
                            <a href="<%=basePath%>sys/type_toEdit?type.id=<s:property value="#parent.id" />">修改</a>|
                            <a href="javascript:void(0);" aid="<s:property value="#parent.id" />" class="delete">删除</a>
                        </div>
                        <div class="clear"></div>
                        <div class="item"></div>
                            <%-- <s:iterator value="types" var="child">
								<s:if test="#child.topid == #parent.id">
                                <div class="l_item">
                                    <div class="list_l list1" aid="<s:property value="#child.id" />">
                                        <s:property value="#child.name" />&nbsp;&nbsp;
                                        (价格:<s:property value="#child.price" />&nbsp;元)&nbsp;&nbsp;
                                        (ID:<s:property value="#child.id" />)&nbsp;&nbsp;
										(排序:<s:property value="#child.sort" />)
                                    </div>
                                    <div class="list_r">
                                        <a href="<%=basePath%>sys/type_toEdit?type.id=<s:property value="#child.id" />">修改</a>|
                                        <a href="javascript:void(0);" aid="<s:property value="#child.id" />" class="delete">删除</a>
                                    </div>
                                    <div class="clear"></div>
                                    <div class="item1"></div>
                                </div>
                                </s:if>
                             </s:iterator>
                         </div> --%>
                    </div>
                </s:if>
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
