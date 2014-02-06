// JavaScript Document

(function($) {


    $.fn.QuoteFadeView = function(options) {

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
	var isActivity = false;
	var activityTimer;
	
	var init = function ()
	{
	
		$obj = $('#testimonial');
		
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


		$($obj.find("blockquote span")).html(data.description);
		$($obj.find("#reference")).html(data.signedby);
		//$($obj.find(".description")).html("&ldquo;"+data.description+"&rdquo;");	
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
					data: {method: method, index: $currentIndex },
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
 $.fn.QuoteFadeView.defaults = {   

} //end function
}
})(jQuery);