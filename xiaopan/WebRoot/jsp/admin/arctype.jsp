<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>校畔网 后台管理</title>
	<base href="<%=basePath%>">
	<link type="text/css" href="<%=basePath%>css/admin/common.css" rel="Stylesheet" />
    <link type="text/css" href="<%=basePath%>css/admin/tab.css" rel="Stylesheet" />
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
    <script language="javascript" src="<%=basePath%>js/admin/global.js"></script>
	<script language="javascript">
		$(function() {
			$(".list:first").css({
				borderTop : "solid 1px #d0e3b7"
			});
			$(".list0").each(function(i) {
				$(this).click(function() {
					$(".item").eq(i).toggle();
				})
			})
			$(".delete").each(function(i) {
				$(this).click(function() {
					var aid = $(this).attr("aid");
					Delete("Handler/DeleteArcType.ashx", aid);
				})
			})
		})
		function del() {

		}
	</script>
	<style type="text/css">
.nav {
	text-align: right;
	margin-right: 10px;
}

.list {
	line-height: 30px;
	margin-left: 10px;
	margin-right: 10px;
	border: solid 1px #d0e3b7;
	border-top: none;
}

.list_l {
	float: left;
	cursor: pointer;
	margin-left: 10px;
}

.list_r {
	float: right;
	margin-right: 10px;
}

.list_r a:hover {
	color: #ff0000;
	text-decoration: none;
}

.list_r a {
	margin-left: 3px;
	margin-right: 5px;
}

.l_item {
	border-top: dashed 1px #d0e3b7;
	background: #f7fbf1;
}

.item,.item1 {
	display: none;
}

.item .list_l {
	margin-left: 20px;
}

.list .item1 .list_r a {
	margin-left: 5px;
	margin-right: 6px;
}

.item1 .list_l {
	margin-left: 30px;
}
</style>
</head>
<body>
	<form id="form1" runat="server">
		<div class="top">
			<div class="t_left"></div>
			<div class="t_content">
				<a href="main.aspx">首页</a>>分类列表
			</div>
			<div class="t_right"></div>
			<div class="clear"></div>
		</div>
		<div class="content">
			<div class="c_l"></div>
			<div class="c_c">
				<div class="nav">
					<a href="Add_arctype.aspx">添加顶级分类</a>
				</div>
				<!-- <asp:Repeater ID="list" runat="server"
					OnItemDataBound="list_ItemDataBound">
					<ItemTemplate> -->
					<div class="list id">
						<div class="list_l list0" aid="id">typename&nbsp;&nbsp;
							(ID:id)&nbsp;&nbsp; （排序:sort)</div>
						<div class="list_r">
							<a href="Add_arctype.aspx?aid=id">添加下一级分类</a>| <a
								href="archives.aspx?aid=id">内容</a>| <a
								href="Edit_arctype.aspx?aid=id">修改</a>| <a href="#" aid="id"
								class="delete">删除</a>
						</div>
						<div class="clear"></div>
						<div class="item">
							<!-- <asp:Repeater ID="list_l" runat="server">
								<ItemTemplate> -->
								<div class="l_item id">
									<div class="list_l list1" aid="id">typename&nbsp;&nbsp;
										(ID:id)&nbsp;&nbsp; （排序:sort)</div>
									<div class="list_r">
										<a href="Add_arctype.aspx?aid=id">添加下一级分类</a>| <a
											href="archives.aspx?aid=id">内容</a>| <a
											href="Edit_arctype.aspx?aid=id">修改</a>| <a href="#" aid="id"
											class="delete">删除</a>
									</div>
									<div class="clear"></div>
								</div>
								<!-- </ItemTemplate>
							</asp:Repeater> -->
						</div>
					</div>
					<!-- </ItemTemplate>
				</asp:Repeater> -->
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
