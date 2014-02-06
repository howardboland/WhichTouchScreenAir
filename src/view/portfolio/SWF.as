package view.portfolio 
{
    import com.which.utils.Console;
    
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    

    public class SWF extends Sprite
    {
        public var loaded:Boolean = false;
        public var loader:Loader;
		public var url:String;

        public function SWF(url:String, enabled:Boolean = false)
        {
			this.url = url;
            var lc:LoaderContext = new LoaderContext();
			lc.checkPolicyFile = true;
            loaded = false;
            loader = new Loader();
			//Console.log("Loading:"+url, this);	
            loader.contentLoaderInfo.addEventListener( Event.COMPLETE, completeHandler);
            loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, errorHandler);
            loader.load(new URLRequest(this.url), lc);
            mouseEnabled = enabled;
        }

        private function errorHandler(event:IOErrorEvent) : void
        {
            Console.log("Error: "+loader.loaderInfo.url, this);
            loader = null;
        }

        private function completeHandler(event:Event) : void
        {
			//swf loaded
			
            addChild(loader);
            loaded = true;
			Console.log("Loaded: "+loader.contentLoaderInfo.url, this);
			this.dispatchEvent( new Event("SWFLOADED") );
        }

    }
}
