<%@ page language="java" pageEncoding="UTF-8"%>
	<div data-theme="e" data-role="footer">
        <h3>无锡校畔网&nbsp;@CopyRight 2013-2014</h3>
    </div>
	<!-- <script src="http://s95.cnzz.com/stat.php?id=5351162&web_id=5351162&show=pic" language="JavaScript"></script> -->
    <%@ include file="../../cs.jsp" %>
	<%CS cs = new CS(5351162);cs.setHttpServlet(request,response);
	String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="50" height="12"  />	