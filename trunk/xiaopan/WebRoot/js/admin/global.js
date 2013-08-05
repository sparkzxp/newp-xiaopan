$(function() {
    var height = $(".top").height() + $(".content").height() + $(".bottom").height();
    if (height < $(window).height()) {
        $(".content").height($(window).height() - $(".top").height() - $(".bottom").height());
    }
});
