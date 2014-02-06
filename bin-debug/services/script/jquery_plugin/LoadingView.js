// JavaScript Document

(function($) {


    $.fn.LoadingView = function(options) {

 	var options = $.extend({}, $.fn.LoadingView.defaults, options);
	
	var speed=options.speed;
	var width=options.width;
	var height=options.height;
	var totalFrames=options.totalFrames;
	var frameWidth=options.frameWidth;
	var src=options.src;
	var $obj = this;
	var $loader;
	var imageTimeout=false;
	var genImage;
	var cIndex=0;
	var cXpos=0;
	var SECONDS_BETWEEN_FRAMES=0;
	
	var init = function ()
	{
		
		//$("#loading").bind("open", open);
		//$("#loading").bind("close", close);
		$loader = $("<div/>").addClass("spinner");
		$loader.css({"z-index":"-10", 
		"position": "relative", 
		"left": (($obj.width()-width)/2)+"px", 
		"top": (($obj.height()-height)/2)+"px"  })
		$obj.prepend($loader);
		load(src, start);
		
	}
	var open = function(e, t)
	{
		$loader.stop(true,true).show();
		
	}
	var close = function(e, t)
	{
		$loader.stop(true,true).fadeOut('fast');
		
	}
	
	var print_r = function( x )
	{
		
		var str = "";
		for (var m in x)
			str += m+" "+x[m]+"\n";
		alert(str);
	}

	var start = function(){
		
		$loader.css('background-image','url("'+src+'")');
		$loader.css('width', width+'px');
		$loader.css('height', height+'px');
		
		//FPS = Math.round(100/(maxSpeed+2-speed));
		FPS = Math.round(100/speed);
		SECONDS_BETWEEN_FRAMES = 1 / FPS;
		
		setTimeout(goNext, SECONDS_BETWEEN_FRAMES/1000);
		
	}
	
	var goNext = function(){
		
		cXpos += frameWidth;
		//increase the index so we know which frame of our animation we are currently on
		cIndex += 1;
		 
		//if our cIndex is higher than our total number of frames, we're at the end and should restart
		if (cIndex >= totalFrames) {
			cXpos =0;
			cIndex=0;
		}
		$loader.css('backgroundPosition',(-cXpos)+'px 0');
		setTimeout(goNext, SECONDS_BETWEEN_FRAMES*1000);
	}
	
	var load = function(s, fun)//Pre-loads the sprites image
	{
		clearTimeout(imageTimeout);
		imageTimeout=0;
		genImage = $("<img/>");
		
		genImage.load(function (){ start() });
		genImage.error(function(){alert("Could not load the image")});
		genImage.attr("src", s);
	}
	
	
	init();
 $.fn.LoadingView.defaults = {   
	speed: 6 ,
	width: 20,
	height: 20,
	totalFrames: 12,
	frameWidth: 20,
	src: 'img/loader-dark-white.gif'
} //end function
}
})(jQuery);