<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<script language="javascript" src="<%=basePath%>js/tween.js"></script>
	<script language="javascript" src="<%=basePath%>js/common/json2.js"></script>
    <script type="text/javascript">
		var setting = {
			view: {
				dblClickExpand: false,
				showLine:false,
				showIcon:false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				onClick: onClick
			}
		};
		function onClick(e, treeId, treeNode) {
			window.location.href="<%=basePath%>web/main_toShow?site.id="+treeNode.id;
		}
		function showMenu() {
			var typeObj = $("#siteSel");
			var typeOffset = $("#siteSel").offset();
			$("#menuContent").css({left:typeOffset.left + "px", top:typeOffset.top + typeObj.outerHeight() + "px"}).slideDown("fast");

			$("body").bind("mousedown", onBodyDown);
		}
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "siteSel" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}
		
		function showCityMenu(){
			if($('#menu').css('visibility') == 'hidden'){
				menu.style.visibility='visible';
			}else{
				menu.style.visibility="hidden";
			}
		}

		$(function() {
			$('#nowCity').html('<s:property value="city.name"/>');
			
	    	var zNodes = JSON.parse('<s:property value="siteJson" escape="false"/>');
        	$.fn.zTree.init($("#siteTree"), setting, zNodes);
        	$('#btnsearch').click(function(){
        		if($.trim($('#txtkeyword').val()) != ''){
        			window.location.href="<%=basePath%>web/main_toSearch?key.name="+$.trim($('#txtkeyword').val());
        		}
        	});
		});
		
		var pics = [];
	</script>
	<style type="text/css"> 
	img{border:0;}
	</style>
    <div class="top">
        <div class="t_left">
        	欢迎来到校畔网，感谢您对校畔网的支持！<span id="nowCity" style="cursor: pointer;">无锡</span>&nbsp;
        	<span style="position:absolute;width:160;height:40;z-index:1;visibility:visible;">
        		<span id="menubar" style="color: blue;cursor: pointer;" onclick="showCityMenu();">[切换]</span>
				<div border=1  id="menu" style="position:absolute;top:15;left:0; width:200px;height:10;z-index:2;visibility:hidden;background-color: #DFDFDF;">
				<s:set name="count" value="1"></s:set>
				<s:iterator value="citys" var="parent">
				<s:if test="#count != 1 and #count % 5 == 1"><br></s:if>
				<a id="link" style="color:blue;margin-left: 10px;" href="<%=basePath%>web/main_toAdvertise?city.id=<s:property value="#parent.id"/>"><s:property value="#parent.name"/></a>
				<s:set name="count" value="#count + 1"></s:set>
				</s:iterator>
				</div>
			</span>
        </div>
        <div class="t_right">
        	<a href="<%=basePath%>web/main_toFeedback" target="_blank" title="校畔网 联系我们">联系我们</a>|
            <a href="javascript:void(0);" onClick="window.external.addFavorite(document.location.href,document.title)" title="校畔网 加入收藏">加入收藏</a>|
            <a href="javascript:void(0);" onClick="var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('http://www.xiaopanwang.com/');" title="校畔网 设为首页">设为首页</a>|
            <a href="<%=basePath%>" >返回首页</a>|
            <a href="javascript:void(0);" onClick="history.back();" >返回上页</a>
        </div>
    </div>
    <div style="float: left;text-align: center;margin-left: 5px;">
    	<img src="<%=basePath%>images/qrcode_3g.jpg" alt="" style="height:100px;width:100px;"/>
    	<br><span>同步推出手机校畔网<br>请扫二维码</span>
    </div>
    <div class="header">
        <div class="h_left"><a href="<%=basePath%>web/main_toShow">
            <img src="<%=basePath%>images/logo.jpg" style="height:85px;" /></a><br />
			【<a id="siteSel" href="javascript:void(0)" onclick="showMenu();"><s:property value="site.name" /></a>】
        </div>
        <div class="h_right">
        <div id="picplayer" style="position:relative;overflow:hidden;width:695px;height:195px;clear:none;border:solid 1px #ccc;"> 
		</div>
           	<s:set name="count" value="1"></s:set>
           	<s:iterator value="adss" var="parent">
           		<s:if test="#parent.place == '头部广告'">
            	<script type="text/javascript">
            		var p<s:property value="#count"/> = {
            			url : '<%=basePath%><s:property value="#parent.imageurl"/>',
            			link : '<s:property value="%{(#parent.weburl==null || #parent.weburl==\"\")?\"javascript:void(0);\":#parent.weburl}"/>',
            			time : 6000
            		};
            		pics.push(p<s:property value="#count"/>);
            	</script>
                <s:set name="count" value="#count + 1"></s:set>
                </s:if>
            </s:iterator>
        </div>
        <div class="clear"></div>
    </div>
    <div class="search1">
        <input type="text" id="txtkeyword" class="keyword" value="请输入菜名或店铺名查询...." onfocus='if($(this).val()=="请输入菜名或店铺名查询...."){$(this).val("");}' onblur='if($.trim($(this).val())==""||$.trim($(this).val())==null){$(this).val("请输入菜名或店铺名查询....");}' />
        <input type="button" id="btnsearch" class="search" />
        <%-- <div class="hot">
            <ul>
                <li><strong>热门：</strong></li>
                <s:iterator value="keys" var="parent">
	                <li>
	                    <a href="<%=basePath%>web/main_toSearch?key.name=<s:property value="#parent.name"/>"><s:property value="#parent.name"/></a>
	                </li>
	            </s:iterator>
            </ul>
        </div> --%>
        <div class="clear"></div>
    </div>
    <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
		<ul id="siteTree" class="ztree" style="clear:both;margin-top:0; width:130px; height: 80px;"></ul>
	</div>
<script>
	var p = $('#picplayer');
	if(pics.length > 0){
	initPicPlayer(pics, p.css('width').split('px')[0], p.css('height').split(
			'px')[0]);
	}
	function initPicPlayer(pics, w, h) {
		//选中的图片 
		var selectedItem;
		//选中的按钮 
		var selectedBtn;
		//自动播放的id 
		var playID;
		//选中图片的索引 
		var selectedIndex;
		//容器 
		var p = $('#picplayer');
		p.text('');
		p.append('<div id="piccontent"></div>');
		var c = $('#piccontent');
		for ( var i = 0; i < pics.length; i++) {
			//添加图片到容器中 
			c.append('<a href="'+pics[i].link+'" ><img id="picitem'+i+'" style="display: none;z-index:'+i+'" src="'+pics[i].url+'" /></a>');
		}
		//按钮容器，绝对定位在右下角 
		p.append('<div id="picbtnHolder" style="position:absolute;top:'
				+ (h - 25) + 'px;width:' + w
				+ 'px;height:20px;z-index:10000;"></div>');
		// 
		var btnHolder = $('#picbtnHolder');
		btnHolder.append('<div id="picbtns" style="float:right; padding-right:1px;"></div>');
		var btns = $('#picbtns');
		// 
		for ( var i = 0; i < pics.length; i++) {
			//增加图片对应的按钮 
			btns.append('<span id="picbtn'+i+'" style="cursor:pointer; border:solid 1px #ccc;background-color:#eee;color:#000; display:inline-block;width:15px;line-height: 15px;text-align: center;margin-right: 1px;">'
							+ (i + 1) + ' </span> ');
			$('#picbtn' + i).data('index', i);
			$('#picbtn' + i)
					.click(
							function(event) {
								if (selectedItem.attr('src') == $(
										'#picitem' + $(this).data('index'))
										.attr('src')) {
									return;
								}
								setSelectedItem($(this).data('index'));
							});
		}
		btns.append(' ');
		/// 
		setSelectedItem(0);
		//显示指定的图片index 
		function setSelectedItem(index) {
			selectedIndex = index;
			clearInterval(playID);
			//alert(index); 
			if (selectedItem)
				selectedItem.fadeOut('fast');
			selectedItem = $('#picitem' + index);
			selectedItem.fadeIn('slow');
			// 
			if (selectedBtn) {
				selectedBtn.css('backgroundColor', '#eee');
				//selectedBtn.css('color', '#000');
			}
			selectedBtn = $('#picbtn' + index);
			selectedBtn.css('backgroundColor', '#aaa');
			//selectedBtn.css('color', '#000');
			//自动播放 
			playID = setInterval(function() {
				var index = selectedIndex + 1;
				if (index > pics.length - 1)
					index = 0;
				setSelectedItem(index);
			}, pics[index].time);
		}
	}
</script>