$(function() {
    var height = $(".top").height() + $(".content").height() + $(".bottom").height();
    if (height < $(window).height()) {
        $(".content").height($(window).height() - $(".top").height() - $(".bottom").height());
    }
//    alert("height:" + height + "---window:" + $(window).height());
})
function Delete(handlerurl, id) {
    $.ajax({
        url: handlerurl,
        async: true,
        dataType: "json",
        type: "POST",
        data: { id: id },
        success: function(msgs) {
        $.each(msgs, function() {
                if (msgs.msg == 1) {
                    alert("删除成功！");
                    $("." + id).remove();
                }
                else {
                    alert(msgs.msg);
                }
            })
        },
        error: function(msg) {
            alert(msg);
        }
    })
}

function ajaxFileUpload() {
    //loading(); //动态加载小图标
    $.ajaxFileUpload({
        url: '/admin/Handler/UpFile.ashx',
        secureuri: false,
        fileElementId: 'file',
        dataType: 'json',
		success: function (data, status)
		{				
			if(typeof(data.error) != 'undefined')
			{
				if(data.error != '')
				{
					alert(data.error);
				}else
				{
					alert(data.msg);
				}
			}
		},
        error: function(de) {
            alert(e);
        }
    })
    return false;
}
function loading() {
    $("#loading ").ajaxStart(function() {
        $(this).show();
    }).ajaxComplete(function() {
        $(this).hide();
    });
} 
