<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<center id="commonPager" style="font-size: 12px;">
	每页显示<s:select label="每页显示行数" name="pager.pageSize" list="{'10','20','50'}"></s:select>行
	
	显示第<s:property value="pager.startIndex" />到<s:property value="pager.endIndex" />条记录&nbsp;&nbsp; 
	第
	<s:property value="pager.currentPage" />
	页&nbsp;&nbsp;共
	<s:property value="pager.totalPage" />
	页&nbsp;&nbsp;
	
	<input type="button" class="bottomcss" style="width:35px;" id="turnto" value="跳到">&nbsp;第
	<s:textfield name="pager.currentPage" cssStyle="width:20px;"/>&nbsp;页&nbsp;&nbsp;
	
	<s:if test="pager.currentPage>1">
		<input type="button" class="bottomcss" style="width:60px;" onclick="pageLoadWithPager(0,1)" value="最前一页">
	</s:if>
	<s:if test="pager.currentPage>1">
		<input type="button" class="bottomcss" style="width:45px;" onclick="pageLoadWithPager(-1,0)" value="上一页">
	</s:if>
	<s:if test="pager.currentPage<pager.totalPage">
		<input type="button" class="bottomcss" style="width:45px;" onclick="pageLoadWithPager(1,0)" value="下一页">
	</s:if>
	<s:if test="pager.currentPage<pager.totalPage">
		<input type="button" class="bottomcss" style="width:60px;" onclick="pageLoadWithPager(0,<s:property value="pager.totalPage" />)" value="最后一页">
	</s:if>
	
	<%-- <s:url id="url_begin" value="sys/log_queryByPager">
		<s:param name="pager.currentPage" value="1"></s:param>
	</s:url>
	<s:if test="pager.currentPage>1">
		<s:a href="%{url_begin}">最前一页</s:a>
	</s:if>
	
	<s:url id="url_pre" value="sys/log_queryByPager">
		<s:param name="pager.currentPage" value="pager.currentPage-1"></s:param>
	</s:url>
	<s:if test="pager.currentPage>1">
		<s:a href="%{url_pre}">上一页</s:a>
	</s:if>

	<s:url id="url_next" value="sys/log_queryByPager">
		<s:param name="pager.currentPage" value="pager.currentPage+1"></s:param>
	</s:url>
	<s:if test="pager.currentPage<pager.totalPage">
		<s:a href="%{url_next}">下一页</s:a>
	</s:if>
	
	<s:url id="url_end" value="sys/log_queryByPager">
		<s:param name="pager.currentPage" value="pager.totalPage"></s:param>
	</s:url>
	<s:if test="pager.currentPage<pager.totalPage">
		<s:a href="%{url_end}">最后一页</s:a>
	</s:if> --%>
	<%-- <s:hidden name="pager.currentPage" /> --%>
</center>