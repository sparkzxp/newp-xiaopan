$(function() {
    $(".i_t").each(function(i) {
        $(this).click(function() {
            $(this).find("p").toggleClass("p_toggle");
            $(".i_c").eq(i).toggle();
        })
    })
    var aid = $.query.get("aid");
    if (aid == "" || aid == null) {
        aid = 0;
    }
    var obj;
    obj = $("."+aid).parent().parent().parent();
    obj.find("p").addClass("p_toggle");
    obj.find(".i_c").css("display", "block");
    $(".tuijian img:first").css("display", "block").find("a");
    $(".tuijian li:first").find("a").css({ color: "#cc9900", fontWeight: "bold" });
    $(".tuijian li").each(function(i) {
        $(this).hover(function() {
            $(".tuijian img").css("display", "none");
            $(".tuijian a").css({ color: "#999999", fontWeight: "100" });
            $(this).find("img").css("display", "block");
            $(this).find("a").css({ color: "#cc9900", fontWeight: "bold" });
        });
    })


    $(".l_c li").each(function(i) {
        $(this).hover(function() {
            $(this).find("img").css({ display: "block", zIndex: "900" });
            $(".l_c li").css("z-index", "1");
            $(this).css("z-index", "500");
        }, function() {
            $(this).find("img").css({ display: "none" });
        });
    })

})