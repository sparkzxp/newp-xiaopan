/*
 * jQuery Miloc Plugin v0.0.1
 * http://www.miloce.com/
 *
 * Copyright (c) 2010 miloc
 */

//图片简单切换
//$("").imgtranstion();
//imgtransition
//imgtransition({speed: 3000, animate: 1000});
$.fn.imgtransition = function(o){
	var defaults = {
		speed : 4000,
		animate : 1000
	};
	o = $.extend(defaults, o);
	
	return this.each(function(){
		var arr_e = $("li", this);
		arr_e.css({position: "absolute"});
		arr_e.parent().css({margin: "0", padding: "0", "list-style": "none", overflow: "hidden"});
		
		function shownext(){
			var active = arr_e.filter(".active").length ? arr_e.filter(".active") : arr_e.first();
			var next =  active.next().length ? active.next() : arr_e.first();
	
			active.css({"z-index": 9});
			next.css({opacity: 0.0, "z-index": 10})
				.addClass('active')
				.animate({opacity: 1.0}, o.animate, function() {
					active.removeClass('active').css({"z-index": 8});
				});
		}
	
		arr_e.first().css({"z-index": 9});
		setInterval(function(){ shownext(); }, o.speed);
	});
};

//图片滚动
//$("").imgscroll();
//imgscroll({speed: 30,amount: 1,dir: "left"});
$.fn.imgscroll = function(o){
	var defaults = {
		speed: 30,
		amount: 1,
		dir: "left"
	};
	o = $.extend(defaults, o);
	
	return this.each(function(){
		var _li = $("li", this);
		_li.parent().parent().css({overflow: "hidden", position: "relative"}); //div
		_li.parent().css({margin: "0", padding: "0", overflow: "hidden", position: "relative", "list-style": "none"}); //ul
		_li.css({position: "relative", overflow: "hidden"}); //li
		if(o.dir == "left") _li.css({float: "left"});
		
		//初始大小
		var _li_size = 0;
		for(var i=0; i<_li.size(); i++)
			_li_size += o.dir == "left" ? _li.eq(i).outerWidth(true) : _li.eq(i).outerHeight(true);
		
		//循环所需要的元素
		if(o.dir == "left") _li.parent().css({width: (_li_size*3)+"px"});
		_li.parent().empty().append(_li.clone()).append(_li.clone()).append(_li.clone());
		_li = $("li", this);

		//滚动
		var _li_scroll = 0;
		function goto(){
			_li_scroll += o.amount;
			if(_li_scroll > _li_size) _li_scroll = 1;
			_li.parent().css(o.dir == "left" ? { left : -_li_scroll } : { top : -_li_scroll });
		}
		
		//开始
		var move = setInterval(function(){ goto(); }, o.speed);
		_li.parent().hover(function(){
			clearInterval(move);
		},function(){
			clearInterval(move);
			move = setInterval(function(){ goto(); }, o.speed);
		});
	});
};
