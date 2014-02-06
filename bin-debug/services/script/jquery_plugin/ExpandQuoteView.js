// JavaScript Document

(function($) {


    $.fn.ExpandQuoteView = function(options) {

	var data = null;
	var loadURL;
	var index;
	var isOpen = false;
	var init = function ()
	{
		
		$(".clientquotes .quote").each( function(i,e) {
				
			$(e).click( function(el) {
				open(i);
			});
		});
		
	}
	var open = function(i)
	{
		// Note: if your clientqoutes is floating left - you get a sort of clitch
		var $e= $($(".clientquotes .quote")[i]);
		var $item= $($(".clientquotes .quote")[index]);
		if ($item!=null) {
				$item.find(".description").stop(true,true).animate({
				opacity: 0,
				height: 'hide',
				"margin-bottom": 'hide',
				"margin-top": 'hide'
			  }, 500, 
				'easeOutQuad'
				,function() {
					
				// Animation complete.
			  });
  				  
			}
		if (index==i)
		{ //same
			index = -1;
		} else
		{
			
			$e.find(".description").stop(true,true).animate({
			opacity: 1,
			height: 'show',
			"margin-bottom": 'show',
			"margin-top": 'show'
		  }, 500, 
			'easeOutQuad', function() {
			// Animation complete.
			
		  });
		  index = i;
			
			
			
		}
		
	}
	
	
	var print_r = function( x )
	{
		
		var str = "";
		for (var m in x)
			str += m+" "+x[m]+"\n";
		alert(str);
	}
	

	init();
 $.fn.ExpandQuoteView.defaults = {   

} //end function
}
})(jQuery);