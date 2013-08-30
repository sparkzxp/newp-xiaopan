<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<base href="<%=basePath%>">
    <title>校畔网</title>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>plugin/jquery-impromptu/jquery-impromptu.css">
    <link type="text/css" href="<%=basePath%>css/admin/common.css" rel="Stylesheet" />
    <link type="text/css" href="<%=basePath%>css/admin/tab.css" rel="Stylesheet" />
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-1.7.2.min.js"></script>
    <script language="javascript" src="<%=basePath%>js/admin/global.js"></script>
    <script language="javascript" src="<%=basePath%>js/common/validation.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/common/fileEveryWhere.js"></script>
    <script type="text/javascript" src="<%=basePath%>plugin/jquery-impromptu/jquery-impromptu.js"></script>
    <script type="text/javascript">
	
	function selOneShop(obj){
		$('.selShop').removeClass('selOneShop');
		$(obj).addClass('selOneShop');
	}
	
    $(function() {
    	$("input:file").fileEveryWhere({
			ButtonText : "浏览"
		});
		
		$("input[name=imgFile]").next("input[type=text]").val($('#editForm_ads_imageurl').val());
		$("input[name=imgFile2]").next("input[type=text]").val($('#editForm_ads_imageurl2').val());
		if($('#editForm_uploadStatus').val() == 'success'){
				alert("操作成功!");
			}else if($('#editForm_uploadStatus').val()=="error"){
			alert("操作失败!");
		}else if($('#editForm_uploadStatus').val()!=""){
			alert($('#editForm_uploadStatus').val());	
		}

    	$("#btn_submit").click(function(){
    		if($("input[name=imgFile]").next("input[type=text]").val()==''){
				alert("请上传广告图片!");
				return;
   	   		}
			if($('#editForm').valid()){
				if($('input[name=imgFile]').val() != ''){
					$("#editForm_pathStatus").val("true");
		   	   	}
				if($('input[name=imgFile2]').val() != ''){
					$("#editForm_pathStatus2").val("true");
		   	   	}
				
				$("#btn_submit").attr("disabled","true");
				$("#editForm").submit();
   			}
   		});
    	
    	$('#selShop').click(function(){
    		var siteId = $('#editForm_ads_siteId').val();
    		$.getJSON('<%=basePath%>sys/shop_getSelShop?shop.siteId='+siteId, function(data){
        		var txt = '<table style="font-size:13px;">';
        		for(var i=0; i<data.length; i++){
        			if(i%4 == 0){
        				txt += '<tr>';
        			}
        			if(i == data.length-1){
        				txt += '<td colspan="'+(5-(data.length%4))+'">';
        			}else{
        				txt += '<td style="width:25%;">';
        			}
        			txt += '<a href="javascript:void(0);" siteId="'+data[i].id+'" class="selShop" onclick="selOneShop(this)">'+data[i].name+'</a></td>';
        			
        			if(i%4 == 3 || i == data.length-1){
        				txt += '</tr>';
        			}
        		}
        		txt += '</table>';
        		$.prompt(txt, {
        			title: "<span style='font-weight:bold;'>"+$('#editForm_ads_siteId [value='+siteId+']').text()+"</span> 的店铺有",
        			buttons: { "确认": true, "取消": false },
        			submit: function(e,v,m,f){
        				if(v && m.find('.selOneShop').attr('siteId') != null){
        					$('#editForm_ads_weburl').val('web/main_toDetail?shop.id='+m.find('.selOneShop').attr('siteId'));
        				}
        			}
        		});
    		});
    	});
    });
    </script>
    <style type="text/css">
    .selOneShop{
    	background-color: yellow;
    }
    div.jqi{ 
		width: 600px;
	}
    </style>
</head>
<body>
    <s:form name="editForm" id="editForm" action="ads_doEdit" namespace="/sys" enctype="multipart/form-data">
    <s:hidden name="ads.id"/>
	<s:hidden name="ads.imageurl"/>
	<s:hidden name="pathStatus" value="false"/>
	<s:hidden name="ads.imageurl2"/>
	<s:hidden name="pathStatus2" value="false"/>
	<s:hidden name="uploadStatus"/>
    <div class="top">
        <div class="t_left"></div>
        <div class="t_content"><strong>添加广告</strong></div>
        <div class="t_right"></div>
        <div class="clear"></div>
    </div>
    <div class="content">
        <div class="c_l"></div>
        <div class="c_c">
            <table border="0" cellpadding="0" cellspacing="0" class="table">
                <tr>
                    <td width="120px" align="right" height="25px">标题说明：</td>
                    <td><s:textfield name="ads.title" cssStyle="width:400px;" cssClass="{required:true,maxlengthCN:200}"/></td>
                </tr>
                <tr>
                    <td width="120px" align="right" height="25px">网址：</td>
                    <td>
                    	<s:textfield name="ads.weburl" cssStyle="width:400px;" cssClass="{maxlengthCN:200}"/>
                    	<input id="selShop" type="button" value="选择站内店铺"/><br>
                    	此处如需填写外网地址，请加前缀&nbsp;http://
                    </td>
                </tr>
                <tr>
                    <td width="120px" align="right" height="25px">图片：</td>
                    <td>
                        <input type="file" name="imgFile"/>
                    </td>
                </tr>
                <tr>
                    <td width="120px" align="right" height="25px">背面图片：</td>
                    <td>
                        <input type="file" name="imgFile2"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" height="25">所属站点：</td>
                    <td>
                        <s:select name="ads.siteId" list="sites" listKey="id" listValue="name" cssClass="{required:true}"></s:select>
                    </td>
                </tr>
                <tr>
                    <td align="right" height="25">位置：</td>
                    <td>
                        <s:select name="ads.place" list="#{'不显示':'不显示','头部广告':'头部广告','网页左面':'网页左面','网页右面':'网页右面','网页底部':'网页底部' }" cssClass="{required:true}"></s:select>
                    </td>
                </tr>
                <tr>
                    <td align="right" height="25">引导页显示：</td>
                    <td>
                        <s:radio name="ads.indexShow" list="#{'0':'不显示','1':'大图显示','2':'底部显示' }" theme="simple" cssClass="{required:true}"></s:radio>
                    </td>
                </tr>
                <tr>
                	<td colspan="2">以下4条信息将在引导页点击广告图片时显示，如上面已填写网址，可以忽略不填</td>
                </tr>
                <tr>
                    <td width="120px" align="right" height="25px">地址：</td>
                    <td><s:textfield name="ads.address" cssStyle="width:400px;" cssClass="{maxlengthCN:200}"/></td>
                </tr>
                <tr>
                    <td width="120px" align="right" height="25px">电话：</td>
                    <td><s:textfield name="ads.tel" cssStyle="width:400px;" cssClass="{maxlengthCN:200}"/></td>
                </tr>
                <tr>
                    <td width="120px" align="right" height="25px">纬度：</td>
                    <td><s:textfield name="ads.latitude" cssStyle="width:400px;" cssClass="{number:true,maxlength:50}"/></td>
                </tr>
                <tr>
                    <td width="120px" align="right" height="25px">经度：</td>
                    <td><s:textfield name="ads.longitude" cssStyle="width:400px;" cssClass="{number:true,maxlength:50}"/></td>
                </tr>
                <tr>
                    <td width="120px" align="right" height="25px"></td>
                    <td><input type="button" id="btn_submit" class="btn_submit" value="提交"/></td>
                </tr>
            </table>
        </div>
        <div class="c_r"></div>
    </div>
    <div class="bottom">
        <div class="b_l"></div>
        <div class="b_r"></div>
        <div class="clear"></div>
    </div>
    </s:form>
</body>
</html>
