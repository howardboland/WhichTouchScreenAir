package view.components
{
	import mx.core.INavigatorContent;
	import mx.core.UIComponent;
	
	public class UIComponentView extends UIComponent implements INavigatorContent
	{
		public function UIComponentView()
		{
			super();
		}
		
		public function get label():String
		{
			return null;
		}
		
		public function get icon():Class
		{
			return null;
		}
		
		public function get creationPolicy():String
		{
			return null;
		}
		
		public function set creationPolicy(value:String):void
		{
		}
		
		public function createDeferredContent():void
		{
		}
		
		public function get deferredContentCreated():Boolean
		{
			return false;
		}
	}
}