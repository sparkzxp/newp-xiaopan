﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<base href="<%=basePath%>">
    <title>校畔网</title>
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
    <script language="javascript" src="<%=basePath%>js/jquery.miloc.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/ztree/jquery.ztree.core-3.2.min.js"></script>
	
    <link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/select.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>plugin/ztree/css/zTreeStyle.css" type="text/css">
    <link type="text/css" href="<%=basePath%>css/public.css?1245" rel="Stylesheet" />
    <link type="text/css" href="<%=basePath%>css/style.css?1258" rel="Stylesheet" />
    
    <script type="text/javascript">
	    function popupbox(boxid,o){
	    	if($('#showbox').css('display') != 'none'){
	    		$('#showbox').hide();
	    	}
	    	if($('.mask').length > 0){
	    		$('.mask').remove();
	    	}
			var sh = boxid.height();
			var sw = boxid.width();
			var l = o.offset().left;
			var t = o.offset().top;
			var th= $(window).scrollTop()+$(window).height()/2-sh/2;
			var h =document.body.clientHeight;
			var rw =$(window).width()/2-sw/2;
			boxid.css({height:0,width:0,top:t,left:l});
			$("body").prepend("<div class='mask'></div>");
			$(".mask").css({opacity:0,height:h}).animate({opacity:0.5},500,function(){
				boxid.animate({top:th,opacity: 'show',left:rw,height:sh,width:sw},500);													 
			});
		}
		function popup(obj, name){
			var _o = $('#ul_'+obj);
			var _s = '<table style="width:100%;margin-top: 20px;padding-left:10px;"><tr><td colspan="4" style="color: #15229F;">'+((name==null||name=='')?'其他':name)+'：</td></tr>';
			var _count = 2;
			for(var i=0; i<_o.find('li').length;i++){
				if(i%4==0){
					_s += '<tr>';
					_count++;
				}
				if(i==_o.find('li').length-1){
					_s += '<td colspan="'+(4-_o.find('li').length%4)+'">'+$(_o.find('li')[i]).html()+'</td>';
				}else{
					_s += '<td>'+$(_o.find('li')[i]).html()+'</td>';
				}
				if(i%4==3 || i==_o.find('li').length-1){
					_s += '</tr>';
				}
			}
			_s += '</table>';
			$('#content').html(_s);
			$('#showbox').height((27*_count));
			popupbox($("#showbox"),_o);
		}
    	<%-- function toggleList(pre){
    		$('#ul_'+pre).toggle();
    		if($('#ul_'+pre).css('display')=='none'){
    			$('#img_'+pre).attr('src', '<%=basePath%>images/ico1.gif');
    			$('.main').height($('.middle').height()+'px');
    		}else{
    			$('#img_'+pre).attr('src', '<%=basePath%>images/ico2.gif');
    			$('.main').height($('.middle').height()+'px');
    		}
    	} --%>
		
    	$(function(){
    		$("#title").click(function(){
    			$(this).parent().animate({top:-300,opacity: 'hide'},500);
    			$(".mask").fadeOut("fast").remove();
    		});
    		var local = 'left';
    			num = 0;
    			left = $($('.left li')).find('ul');
    			middle = $($('.m_ads li')).find('ul');
    			right = $('.rightAds').find('ul');
    			side = 0;
    			tmp = 0;
    		var silder;
    			
    		function onesilder(){
    			if(local == 'left'){
    				if(side == 0){
	    				if(left.length == 0){
	    					num = 0;
	    					local = 'middle';
	    				}else{
	    					tmp = parseInt($(left[num]).css('margin-top').split('px')[0]);
		    				if(tmp >= 0){
		        				$(left[num]).css('margin-top', '0px');
		        				if(++num < left.length){
		        					
		        				}else{
		        					num = 0;
		        					local = 'middle';
		        				}
		        			}else{
		        				$(left[num]).css('margin-top', (tmp+4)>=0?0:(tmp+4)+'px');
		        			}
	    				}
    				}else{
    					if(left.length == 0 || num < 0){
    						clearInterval(silder);
    	    				initLeftSlider();
    					}else{
    						tmp = parseInt($(left[num]).css('margin-top').split('px')[0]);
    						if(tmp <= -82){
    							$(left[num]).css('margin-top', '-82px');
		        				if(--num > -1){
		        					
		        				}else{
		        					clearInterval(silder);
		    	    				initLeftSlider();
		        				}
    						}else{
    							$(left[num]).css('margin-top', (tmp-4)<=-82?-82:(tmp-4)+'px');
    						}
    					}
    				}
    			}else if(local == 'middle'){
    				if(side == 0){
	    				if(middle.length == 0){
	    					num = right.length-1;
	    					local = 'right';
	    				}else{
	    					tmp = parseInt($(middle[num]).css('margin-left').split('px')[0]);
		    				if(tmp >= 0){
		        				$(middle[num]).css('margin-left', '0px');
		        				if(++num < middle.length){
		        					
		        				}else{
		        					num = right.length-1;
		        					local = 'right';
		        				}
		        			}else{
		        				$(middle[num]).css('margin-left', (tmp+4)>=0?0:(tmp+4)+'px');
		        			}
	    				}
    				}else{
    					if(middle.length == 0 || num < 0){
    						num = left.length-1;
    						local = 'left';
    					}else{
    						tmp = parseInt($(middle[num]).css('margin-left').split('px')[0]);
    						if(tmp <= -122){
    							$(middle[num]).css('margin-left', '-122px');
		        				if(--num > -1){
		        					
		        				}else{
		        					num = left.length-1;
		    						local = 'left';
		        				}
    						}else{
    							$(middle[num]).css('margin-left', (tmp-4)<=-122?-122:(tmp-4)+'px');
    						}
    					}
    				}
    			}else if(local == 'right'){
    				if(side == 0){
	    				if(right.length == 0 || num < 0){
	    					clearInterval(silder);
	    					initRightSlider();
	    				}else{
	    					tmp = parseInt($(right[num]).css('margin-top').split('px')[0]);
		    				if(tmp <= -82){
		        				$(right[num]).css('margin-top', '-82px');
		        				if(--num > -1){
		        					
		        				}else{
		        					clearInterval(silder);
		        					initRightSlider();
		        				}
		        			}else{
		        				$(right[num]).css('margin-top', (tmp-4)<=-82?-82:(tmp-4)+'px');
		        			}
	    				}
	    			}else{
	    				if(right.length == 0){
	    					num = middle.length-1;
	    	    			local = 'middle';
	    				}else{
	    					tmp = parseInt($(right[num]).css('margin-top').split('px')[0]);
	    					if(tmp >= 0){
	    						$(right[num]).css('margin-top', '0px');
								if(++num < right.length){
		        					
		        				}else{
		        					num = middle.length-1;
			    	    			local = 'middle';
		        				}
	    					}else{
	    						$(right[num]).css('margin-top', (tmp+4)>=0?0:(tmp+4)+'px');
	    					}
	    				}
	    			}
    			}else{
    				alert('local:'+local+' num:'+num+' side:'+side);
    				clearInterval(silder);
    				initLeftSlider();
    			}
    		}
    		
    		function doSilder(){
    			silder = setInterval(onesilder, 50);
    		}
    		
    		function initLeftSlider(){
    			num = 0;
    			local = 'left';
    			side = 0;
    			setTimeout(doSilder, 5000);
    		}
    		
			function initRightSlider(){
    			num = 0;
    			local = 'right';
    			side = 1;
    			setTimeout(doSilder, 5000);
    		}
    		
    		setTimeout(doSilder, 2000);
    	});
    </script>
    <style type="text/css">
    #showbox{
		/* background:#2a2a2a; */
		background:#dfdfdf;
		display:none;
		position:absolute;
		border:1px solid #DFDFDF;
		text-align:center;
		z-index:1000;
		/* color:#fff; */
		width:420px;
		height:300px;
	}
	#showbox span{
		float:right;
		cursor:pointer;
	}
	#showbox a{
		color: #15229F;
	}
	.mask{
		width:100%;
		background:#333;
		position:absolute;
		overflow:hidden;
		left:0;
		top:0;
		height:100%;
		z-index:990;
	}
    </style>
</head>
<body>
    <form id="form1">
    <%@ include file="header.jsp"%>
    <!--end search-->
    <div class="main">
        <div class="left">
            <ul>
            <s:set name="count" value="1"></s:set>
            <s:iterator value="adss" var="parent">
            	<s:if test="#parent.place == '网页左面' and #count <= 5">
                <li>
                	<div style="position: relative;height:82px;overflow: hidden;">
               			<ul style="margin-top: -82px">
               				<s:if test="null == #parent.imageurl2 or '' == #parent.imageurl2">
               				<li style="overflow: hidden;margin:0;padding:0;height: 82px;">
               					<a href="<s:property value="%{(#parent.weburl==null || #parent.weburl==\"\")?\"javascript:void(0);\":#parent.weburl}"/>">
               					<img src="<%=basePath%><s:property value="#parent.imageurl"/>" /></a>
               				</li>
               				</s:if>
               				<s:else>
               				<li style="overflow: hidden;margin:0;padding:0;height: 82px;">
               					<a href="<s:property value="%{(#parent.weburl==null || #parent.weburl==\"\")?\"javascript:void(0);\":#parent.weburl}"/>">
               					<img src="<%=basePath%><s:property value="#parent.imageurl2"/>" /></a>
               				</li>
               				</s:else>
               				<li style="overflow: hidden;margin:0;padding:0;height: 82px;">
               					<a href="<s:property value="%{(#parent.weburl==null || #parent.weburl==\"\")?\"javascript:void(0);\":#parent.weburl}"/>">
               					<img src="<%=basePath%><s:property value="#parent.imageurl"/>" /></a>
               				</li>
               			</ul>
                	</div>
                </li>
                <s:set name="count" value="#count + 1"></s:set>
                </s:if>
            </s:iterator>
            </ul>
        </div>
        <!--end left-->
        <div class="middle">
        	<s:iterator value="types" var="parent">
        		<s:if test="#parent.topid == 0">
        		<div class="item">
                    <ul id="ul_<s:property value="#parent.id"/>">
                        <li><strong><s:property value="#parent.name"/></strong></li>
                        <s:set name="count" value="1"></s:set>
                        <s:iterator value="types" var="child">
                        	<s:if test="#child.topid == #parent.id">
                        		<s:if test="#count == 11">
                        		<li>
                        		<%-- <a href="javascript:void(0);" style="color:#777777;" onclick="toggleList('<s:property value="#parent.id"/>_<s:property value="#parent.name"/>');"> --%>
                        		<a href="javascript:void(0);" style="color:#777777;" onclick="popup('<s:property value="#parent.id"/>_<s:property value="#parent.name"/>');">
                        		<img id="img_<s:property value="#parent.id"/>_<s:property value="#parent.name"/>" alt="" src="<%=basePath%>images/ico1.gif"/>&nbsp;其他</a></li>
                        		<ul id="ul_<s:property value="#parent.id"/>_<s:property value="#parent.name"/>" style="display:none;">
                        		</s:if>
	                        	<s:if test="#count < 11">
	                            <li><a href="javascript:void(0);"<%-- "<%=basePath%>web/main_toSearch?key.name=<s:property value="#child.name"/>" --%> 
	                            		onclick="popup('<s:property value="#child.id"/>_<s:property value="#child.name"/>', '<s:property value="#child.name"/>');"><s:property value="#child.name"/></a></li>
	                            	<ul id="ul_<s:property value="#child.id"/>_<s:property value="#child.name"/>" style="display:none;">
	                            	<s:iterator value="types" var="leaf">
                        			<s:if test="#leaf.topid == #child.id">
                        			<li><a href="<%=basePath%>web/main_toSearch?key.name=<s:property value="#leaf.name"/>"><s:property value="#leaf.name"/></a></li>
                        			</s:if>
                        			</s:iterator>
	                            	</ul>
	                            <s:set name="count" value="#count + 1"></s:set>
	                            </s:if>
	                            <s:else>
	                            <%-- <li><a href="<%=basePath%>web/main_toSearch?key.name=<s:property value="#child.name"/>"><s:property value="#child.name"/></a></ --%>li>
	                            <li><a href="javascript:void(0);"<%-- "<%=basePath%>web/main_toSearch?key.name=<s:property value="#child.name"/>" --%> 
	                            		onclick="popup('<s:property value="#child.id"/>_<s:property value="#child.name"/>', '<s:property value="#child.name"/>');"><s:property value="#child.name"/></a></li>
	                            	<ul id="ul_<s:property value="#child.id"/>_<s:property value="#child.name"/>" style="display:none;">
	                            	<s:iterator value="types" var="leaf">
                        			<s:if test="#leaf.topid == #child.id">
                        			<li><a href="<%=basePath%>web/main_toSearch?key.name=<s:property value="#leaf.name"/>"><s:property value="#leaf.name"/></a></li>
                        			</s:if>
                        			</s:iterator>
	                            	</ul></li>
	                            <s:set name="count" value="#count + 1"></s:set>
	                            </s:else>
                            </s:if>
                        </s:iterator>
                        <s:if test="#count > 10"></ul></s:if>
                    </ul>
                </div>
        		</s:if>
        	</s:iterator>
            <div class="clear"></div>
            <div class="m_ads">
                <ul>
                	<s:set name="count" value="1"></s:set>
                    <s:iterator value="adss" var="parent">
		            	<s:if test="#parent.place == '网页底部' and #count <= 4">
		            	<s:if test="#count == 1">
		            	<li style="width:122px;height: 82px;margin-left: 0px;">
		            	</s:if>
		            	<s:else>
	               		<li style="width:122px;height: 82px;">
	               		</s:else>
		            		<div style="position: relative;width:122px;height: 82px;overflow: hidden;">
		               			<ul style="margin-left: -122px;width:244px;">
		               				<s:if test="null == #parent.imageurl2 or '' == #parent.imageurl2">
		               				<li style="overflow: hidden;margin:0;padding:0;width:122px;height: 82px;float: left;">
		               					<a href="<s:property value="%{(#parent.weburl==null || #parent.weburl==\"\")?\"javascript:void(0);\":#parent.weburl}"/>">
		               					<img src="<%=basePath%><s:property value="#parent.imageurl"/>" /></a>
		               				</li>
		               				</s:if>
		               				<s:else>
		               				<li style="overflow: hidden;margin:0;padding:0;width:122px;height: 82px;float: left;">
		               					<a href="<s:property value="%{(#parent.weburl==null || #parent.weburl==\"\")?\"javascript:void(0);\":#parent.weburl}"/>">
		               					<img src="<%=basePath%><s:property value="#parent.imageurl2"/>" /></a>
		               				</li>
		               				</s:else>
		               				<li style="overflow: hidden;margin:0;padding:0;width:122px;height: 82px;float: left;">
		               					<a href="<s:property value="%{(#parent.weburl==null || #parent.weburl==\"\")?\"javascript:void(0);\":#parent.weburl}"/>">
		               					<img src="<%=basePath%><s:property value="#parent.imageurl"/>" /></a>
		               				</li>
		               			</ul>
	                		</div>
	               		</li>
		                <s:set name="count" value="#count + 1"></s:set>
		                </s:if>
		            </s:iterator>
                </ul>
            </div>
        </div>
        <!--end middle-->
        <div class="right">
            <div class="r_item">
                <div class="r_t"><strong>网站公告</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=basePath%>web/main_toNoticeList">更多&gt;&gt;</a></div>
                <div class="r_c">
                    <ul>
                    <s:iterator value="archives" var="parent">
		            	<s:if test="#parent.source == '网站公告'">
		                <li>
		                    <a href="<%=basePath%>web/main_toNotice?archive.id=<s:property value="#parent.id"/>"><s:property value="#parent.title"/></a>
		                </li>
		                </s:if>
		            </s:iterator>
                    </ul>
                    <div class="clear"></div>
                </div>
            </div>
            <s:set name="count" value="1"></s:set>
            <s:iterator value="adss" var="parent">
            	<s:if test="#parent.place == '网页右面' and #count < 5">
        		<div class="rightAds" style="position: relative;height:82px;overflow: hidden;margin-top: 4px;">
           			<ul style="margin-top: 0px">
           				<li style="overflow: hidden;margin:0;padding:0;height: 82px;">
           					<a href="<s:property value="%{(#parent.weburl==null || #parent.weburl==\"\")?\"javascript:void(0);\":#parent.weburl}"/>">
           					<img src="<%=basePath%><s:property value="#parent.imageurl"/>" /></a>
           				</li>
           				<s:if test="null == #parent.imageurl2 or '' == #parent.imageurl2">
           				<li style="overflow: hidden;margin:0;padding:0;height: 82px;">
           					<a href="<s:property value="%{(#parent.weburl==null || #parent.weburl==\"\")?\"javascript:void(0);\":#parent.weburl}"/>">
           					<img src="<%=basePath%><s:property value="#parent.imageurl"/>" /></a>
           				</li>
           				</s:if>
           				<s:else>
           				<li style="overflow: hidden;margin:0;padding:0;height: 82px;">
           					<a href="<s:property value="%{(#parent.weburl==null || #parent.weburl==\"\")?\"javascript:void(0);\":#parent.weburl}"/>">
           					<img src="<%=basePath%><s:property value="#parent.imageurl2"/>" /></a>
           				</li>
           				</s:else>
           			</ul>
            	</div>
                <s:set name="count" value="#count + 1"></s:set>
                </s:if>
            </s:iterator>
        </div>
        <!--end right-->
        <div class="clear"></div>
    </div>
    <div id="showbox">
		<span id="title">
			<span>【X】</span><br>
		</span>
		<div id="content" style="height: 95%;">
		</div>
	</div>
    <!--end main-->
    <%@ include file="footer.jsp"%>
    </form>
</body>
</html>
