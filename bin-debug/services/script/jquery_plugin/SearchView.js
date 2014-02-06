// JavaScript Document

(function($) {


    $.fn.SearchView = function(options) {

	var data = null;
	var loadURL;
	var $item;
	var isOpen = false;
	var init = function ()
	{
			
		$(".advanced-search").click( function(e) {
				//print_r($($(this).find(".link")));
				open();
			});
	}
	var open = function ()
	{
	
		if (isOpen)
		{
			$(".advanced-search").animate({height: "20px"}, 200, function(){});
			
		} else 
		{
			$(".advanced-search").animate({height: "200px"}, 200);
			
		}
		isOpen = !isOpen;
	}
	
	
	var print_r = function( x )
	{
		
		var str = "";
		for (var m in x)
			str += m+" "+x[m]+"\n";
		alert(str);
	}
	

	init();
 $.fn.SearchView.defaults = {   

} //end function
}
})(jQuery);