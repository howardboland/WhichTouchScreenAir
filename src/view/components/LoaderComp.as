package view.components
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	public class LoaderComp extends UIComponent
	{
		protected var loader:LoaderBitmap;
		public function LoaderComp()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,init);
			super();
		}
		protected function init( e:Event =null) :void
		{
			loader = new LoaderBitmap();
			var mc:MovieClip = new MovieClip();
			var b:Bitmap = new Bitmap(loader);
			
			//b.height = this.height = 30;
			//b.width = this.width = 30;		
			b.smoothing = true;
			
			
			b.x = -b.width/2;
			b.y = -b.height/2;
			mc.addChild( b );
			mc.width = this.width;
			mc.height = this.height;
			mc.x = mc.width/2;
			mc.y = mc.height/2;
			
			mc.addEventListener(Event.ENTER_FRAME, cycle );
			this.addChild( mc )
		}
		protected function cycle( e:Event ) : void
		{
			e.target.rotation -=30;
			
		}
	}
}