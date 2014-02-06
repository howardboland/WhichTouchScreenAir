// JavaScript Document

(function($) {


    $.fn.SlideView = function(options) {

	var data = null;
	var loadURL;
	var $item;
	var isOpen = false;
	var $obj;
	var $group;
	var $row;
	var isAnimating = false;
	var $currentIndex = [];
	var $colour_count = 0;
	var animationspeed = 800;
	var $timer;
	var isActivity = false;
	var activityTimer;
	
	var init = function ()
	{
		$obj = $('#adverts');
		$row = $($obj.find('.row'));
		$group = $($obj.find('.group'));
		$next = $($obj.find('.next'));
		$prev = $($obj.find('.previous'));
		
		activity(true);
		$next.click( function(e) {
				toggle("next");
				activity(true);
				
		});
		$prev.click( function(e) {
				toggle("previous");
				activity(true);
		});
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
	
	var getColourSet = function()
	{
		var colourGroup = [['#929497', '#637ba0', '#74a0a0'],
							['#9693A4', '#627387', '#78A9B7'],
							['#6C7B63', '#B8A560', '#7193AD'],
							['#AE728F', '#6598B7', '#486D65'],
							['#93A2A4', '#5FA1AD', '#71AD91']];
		$colour_count = ($colour_count+1) % (colourGroup.length-1);
		return colourGroup[ $colour_count ];
	}
	
	var setColours = function($g)
	{
		var cols = getColourSet();
		$g.children("div").each( function(i,e)
		{
			$(e).css({background: cols[i]})
		});
		
	}
	
	var setData = function($g,data)
	{
		$g.children("div").each( function(i,e)
		{
			
			var obj = data[i % data.length];
			
			$($(e).find("h3")).text(obj.title.split("-")[0]);
			$($(e).find("h4")).text(obj.title.indexOf("-")!=-1 ? obj.title.split("-")[1] : "");
			//$($(e).find("h3")).text(obj.title);
			//$($(e).find("h4")).text(obj.category);
			$($(e).find(".place")).text(obj.region);
			
			$($(e).find(".main")).html(Utils.summarise(obj.description, 250));
			$($(e).find(".salary")).html(obj.salary);
			$($(e).find("a")).attr("href", "#listing|"+obj.sector+"?id="+obj.id);
			// Ensure ref is split nicely if it is long
			if (obj.reference!=null)
			{
			$($(e).find(".date")).html("Ref:<br/>"+((obj.reference.length>4 && (obj.reference.length%2==0 || obj.reference.length>6)) ? obj.reference.substring(0,4)+"<br/>"+obj.reference.substring(4,obj.reference.length) : obj.reference).toUpperCase() );
			$($(e).find(".ref")).text("");
			}
			//$($(e).find(".date")).text(minimiseDate(obj.posted));
			//$($(e).find(".id")).text(obj.id);
		
		});
		
	}
	var minimiseDate = function (str)
	{
		var d = new Date(str * 1000);
		var today=new Date();
		var diff =  ( - d.getTime() + today.getTime() ) / (1000*60*60*24);
		var output = (diff<1) ? "Just in" : d.getDate()+" | "+d.getMonth();
		return output;
	}
	
	var reset = function()
	{
		$row.animate( {left: 0+"px"}, animationspeed, function(){});
	}
	var toggle =function(method, firstTime)
	{ 


		$.ajax({
					type: "GET",
					url: "saveJob.php",
					dataType: 'json',
					data: {method: method, index: $currentIndex.join("|") },
					success: function(response) { 
					  
						$currentIndex =  [];
						for (var i=0;i<response.length;i++)
						{
							$currentIndex.push(response[i]["id"])
						}
						//alert($currentIndex.join("|"))
						if (firstTime)
						{
							setData( $($group.find(".innergroup")), response );
						} else 
						{
						if (method=="next")              
							next(response)		
						if (method=="previous") 
							prev(response)  	
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
			$groupNew = $group.clone(true)
				$groupNew.prependTo($row);
			
			setColours($($groupNew.find(".innergroup")));
			setData( $($groupNew.find(".innergroup")), data );
			
			$row.css({left: -$group.width()+"px"});
			$row.stop(true,true).animate( {left: 0+"px"}, animationspeed, 'easeInOutQuad', function(){
				$group.remove();
				$group = $groupNew;
				$row.css({left: 0+"px"});
				isAnimating = false;
				startTimer();
			});
		}
	}
	
	var prev = function(data) 
	{
		if (!isAnimating)
		{
			isAnimating = true;
			$groupNew = $group.clone(true)
		
		$groupNew.appendTo($row);
			setColours($($groupNew.find(".innergroup")));
			setData( $($groupNew.find(".innergroup")), data );
			$row.stop(true,true).animate( {left: -$group.width()+"px"}, animationspeed, 'easeInOutQuad', function(){
				$group.remove();
				$group = $groupNew;
				$row.css({left: 0+"px"});
				isAnimating = false;
				startTimer();
			});
		}
	}
	var timer = function() 
	{
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
 $.fn.SlideView.defaults = {   

} //end function
}
})(jQuery);