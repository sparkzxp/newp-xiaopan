<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="left">
    <div class="l_item">
    <s:iterator value="types" var="parent">
   		<s:if test="#parent.topid == 0">
        <div class="item">
            <div class="i_t"><p><strong><s:property value="#parent.name"/></strong></p></div>
            <div class="i_c">
                <ul>
                <s:iterator value="types" var="child">
                   	<s:if test="#child.topid == #parent.id">
                    <li class="<s:property value="#child.name"/>"><a href="<%=basePath%>web/main_toSearch?key.name=<s:property value="#child.name"/>"><s:property value="#child.name"/></a></li>
                    </s:if>
                </s:iterator>
                </ul>
                <div class="clear"></div>
            </div>
        </div>
        </s:if>
    </s:iterator>
    </div>
    <!--end l_item-->
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