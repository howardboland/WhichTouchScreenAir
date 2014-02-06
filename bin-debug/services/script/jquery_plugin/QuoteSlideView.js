// JavaScript Document

(function($) {


    $.fn.QuoteSlideView = function(options) {

	var data = null;
	var loadURL;
	var $item;
	var isOpen = false;
	var $obj;
	var $group;
	var $row;
	var isAnimating = false;
	var $currentIndex = 0;
	var $colour_count = 0;
	var animationspeed = 200;
	var $timer;
	var $type =1;
	var isActivity = false;
	var activityTimer;
	
	var init = function ()
	{
	
		$obj = $('#testimonial-slider');
		$next = $($obj.find('.next'));
		$prev = $($obj.find('.previous'));		
	
		$obj.bind("update", update);
		activity(true);
		$next.click( function(e) {
			
				toggle("next");
				activity(true);
				
				
		});
		$prev.click( function(e) {
			
				toggle("previous");
				activity(true);
				
		});
		//toggle("next", true);
		
	}
	var update = function(e,t) {
		setType(t)
	}
	var setType = function(t) {
		$type = t;
		$currentIndex = 0;
		$($obj.find("h2")).text($type == 1 ? "OUR CLIENTS SAY" : "OUR CANDIDATES SAY" );
		activity(true);
		toggle("next", true);
	}
	
	var activity = function(a) 
	{
	//	alert(a);
		stopTimer();
		if (activityTimer!=null)
			clearTimeout(activityTimer);
		
		if (a)
		{
			
			activityTimer = setTimeout(activity, 10000, false);
		} else
		{
			if (a!=isActivity)
			{ 
				isActivity = a;
				startTimer();
			}
		}
		isActivity = a;
		
	}
	
	var stopTimer = function()
	{
		if ($timer!=null)
			clearTimeout($timer)
	}
	
	var startTimer = function()
	{
		if (!isActivity)
		{
			stopTimer();
			$timer = setTimeout(toggle, 5000, "next");
		}
	}
	
	
	var setData = function(data)
	{		

	
		$obj.find(".client").text(data.title);
		$obj.find(".signedby").text(data.signedby);
		
		$obj.find(".quote").show();
		$obj.find(".heading").css("min-height", "")
		var topY = Math.max(0, (80-$obj.find(".heading").height())/2);
		//$("#testimonial-slider h2").text( $obj.find(".heading").height()+"  "+topY);
		$obj.find(".heading").css("top", topY + "px").css("min-height", "60px");
		//$obj.find(".quote").hide();
		$($obj.find(".description")).html("&ldquo;"+data.description+"&rdquo;");	
	}
	
	var reset = function()
	{
		$row.animate( {left: 0+"px"}, animationspeed, function(){});
	}
	var toggle =function(method, firstTime)
	{ 

		
		$.ajax({
					type: "GET",
					url: "getQuote.php",
					dataType: 'json',
					data: {method: method, index: $currentIndex, type: $type },
					success: function(response) { 
					  
					
						
						$currentIndex = (response[0]["id"]);
						
						
						if (firstTime)
						{
							setData( response[0] );
						} else 
						{
						if (method=="next")              
							next(response[0])		
						if (method=="previous") 
							prev(response[0])  	
						}
					},
					failure: function(msg) {
						alert(msg);
					  
						//$('#output').text(msg);
					}
		});
	}
	
	var next = function(data)
	{
	
		if (!isAnimating)
		{
			isAnimating = true;
		
			
			
			$($obj.find(".quote")).stop(true,true).fadeOut( animationspeed, 'easeInOutQuad', function(){
				setData( data );
			
				$($obj.find(".quote")).fadeIn( animationspeed, 'easeInOutQuad', function(){isAnimating = false;startTimer(); });
				
			});
			
		}
	}
	
	var prev = function(data) 
	{
		if (!isAnimating)
		{
			isAnimating = true;
			
			
			$($obj.find(".quote")).stop(true,true).fadeOut( animationspeed, 'easeInOutQuad', function(){
				setData( data );
			
				$($obj.find(".quote")).fadeIn( animationspeed, 'easeInOutQuad', function(){ isAnimating = false;startTimer(); });
				
			});
		}
	}
	var timer = function() 
	{
	}
	
	
	
	var print_r = function( x )
	{
		
		var str = "";
		for (var m in x)
			str += m+" "+x[m]+"\n";
		alert(str);
	}
	

	init();
 $.fn.QuoteSlideView.defaults = {   

} //end function
}
})(jQuery);