package view.portfolio 
{
    import com.which.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;

    public class Image extends Sprite
    {
        public var loaded:Boolean = false;
        private var loader:Loader;
        public var bitmap:Bitmap;
        private var smoothing:Boolean;
        private var url:String;

        public function Image(url:String, smooth:Boolean = true, enabled:Boolean = false)
        {
            loaded = false;
            this.url = url;
            var lc:LoaderContext = new LoaderContext();
            lc.checkPolicyFile = true;
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.INIT, this.completeHandler);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.errorHandler);
            loader.load(new URLRequest(this.url), lc);
            smoothing = smooth;
            mouseEnabled = enabled;
        }

        private function errorHandler(e:IOErrorEvent) : void
        {
            Console.log("error " + e.text, this);
            Console.log("tried to load url:" + url, this);
			removeListeners();
		}
        private function completeHandler(e:Event) : void
        {
			try 
			{
				
			
            bitmap = Bitmap(e.target.loader.content);
            bitmap.smoothing = true;
            addChild(bitmap);
			removeListeners();
            this.loaded = true;
			Console.log("loaded: " + url, this);
			} catch( error:Error)
			{
				Console.log(error.message, this);
				
			}
			
        }
		private function removeListeners():void
		{
			loader.contentLoaderInfo.removeEventListener(Event.INIT, completeHandler);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader = null;
			
		}

    }
}
