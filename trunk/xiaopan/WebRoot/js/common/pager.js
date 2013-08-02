/**
 * 分页跳转JS事件<br>
 * 
 * struts的form名必须为queryForm<br>
 * 
 * @author 张霄鹏
 */
$(document).ready(function(){

	// 分页跳转按钮click事件
	$("#turnto").click(function(){
		if(/^\d*$/g.test($.trim($("#queryForm_pager_currentPage").val()))){
			$("#queryForm").submit();
		}else{
			$.alert("请您输入正整数！");
		}
	});
});

// 分页指定下一页
function pageLoadWithPager(p1, p2){
	if(p1==0) {
		$("#queryForm_pager_currentPage").val(p2);
	} else {
		$("#queryForm_pager_currentPage").val(parseInt($("#queryForm_pager_currentPage").val())+p1);
	}
	$("#queryForm").submit();
}