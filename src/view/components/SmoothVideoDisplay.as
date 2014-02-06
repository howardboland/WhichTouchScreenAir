package  view.components
{  
	import flash.display.DisplayObject;
	
	import spark.components.VideoDisplay;
	import spark.components.VideoPlayer;
	
	public class SmoothVideoDisplay extends VideoDisplay  
	{  
		// Public property exposed. Set this property to true to enable smoothing   
		public var smoothing:Boolean=false;  
		
		// Set default value for deblocking filter.  
		// 0 - automatically enable / disable deblocking filter as per required (recommended)  
		// 1 - disable deblocking  
		// 2 - enable deblocking  
		
		public var deblocking:int=0;  
		public function SmoothVideoDisplay()  
		{  
			super();  
		}  
		override public function addChild(child:DisplayObject):DisplayObject  
		{  
			// set the value to the video component inside VideoDisplay component  
			var video:VideoPlayer = VideoPlayer(child); 
			//video.smoothing=smoothing;  
			//video.deblocking=deblocking;
			return super.addChild(child);  
		}  
	}  
}  