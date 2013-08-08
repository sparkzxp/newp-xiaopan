<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="left">
     <div class="l_item">
    
        <div class="item">
            <div class="i_t"><p><strong>校畔网</strong></p></div>
            <div class="i_c" style="display:block;">
                <ul>
                <s:set name="count" value="1"></s:set>
                <s:iterator value="archives" var="parent">
                	<s:if test="#parent.source == '网站公告' and #count <= 5">
                    <li><a href="<%=basePath%>web/main_toNotice?archive.id=<s:property value="#parent.id"/>"><s:property value="#parent.title"/></a></li>
                    <s:set name="count" value="#count + 1"></s:set>
                    </s:if>
                </s:iterator>
                <li>
                	<div style="text-align:right;line-height:30px">
                		<a href="<%=basePath%>web/main_toNoticeList">更多公告&gt;&gt;&nbsp;</a>
                	</div>
                </li>
                </ul>
                <div class="clear"></div>
            </div>
        </div>
     </div>
     <!--end item-->
     <div class="tuijian">
        <div class="t_title"><strong>热门推荐</strong></div>
        <div class="t_c">
            <ul>
            <s:iterator value="suportShops" var="parent">
                <li>
                    <p><a href="<%=basePath%>web/main_toDetail?shop.id=<s:property value="#parent.id"/>"><s:property value="#parent.title"/></a></p>
                    <p><a href="<%=basePath%>web/main_toDetail?shop.id=<s:property value="#parent.id"/>"><img src="<s:property value="#parent.imagePath"/>" onerror='$(this).remove()' /></a></p>
                </li>
            </s:iterator>
            </ul>
            <div class="clear"></div>
        </div>
    </div>
</div>