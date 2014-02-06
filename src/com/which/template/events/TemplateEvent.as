package com.which.template.events
{
	import flash.events.Event;
	
	public class TemplateEvent extends Event
	{
		public static var OPEN_URL:String = "OPEN_URL";
		public static var OPEN_NEWS:String = "OPEN_NEWS";
		public static var LOADED:String = "LOADED";
		public static var ERROR:String = "ERROR";
		public static var CLICK_BG:String = "CLICK_BG";
		public var url:String;
		
		public function TemplateEvent(type:String="", url:String="", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.url = url;
			super(type, bubbles, cancelable);
		}
	}
}