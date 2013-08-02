$(function() {
    //隐藏所有权限按钮
    $('.permit').hide();
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp    
	var curWwwPath=window.document.location.href;    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp    
	var pathName=window.document.location.pathname;    
	var pos=curWwwPath.indexOf(pathName);    //获取主机地址，如： http://localhost:8083    
	var localhostPaht=curWwwPath.substring(0,pos);    //获取带"/"的项目名，如：/uimcardprj    
	var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);    
	var url = localhostPaht+projectName+"/sys/user_queryPermit";
    //显示对应权限的按钮
    $.post(url, function(data) {
       data = $.parseJSON(data);
       if (null != data && data.length > 0) {
          for ( var i in data) {
            $(".permit[self='" + data[i] + "']").show();
		  }
       }
     });
});