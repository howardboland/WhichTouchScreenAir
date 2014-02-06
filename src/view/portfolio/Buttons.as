package view.portfolio 
{
    import com.which.template.events.TemplateEvent;
    import com.which.utils.Console;
    
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.FullScreenEvent;
    import flash.events.MouseEvent;


    public class Buttons extends Sprite
    {
        private var components:Array;
        private var componentsActive:Array;
        private var image1:Image;
        private var image2:Image;
        private var image3:Image;
        private var image4:Image;
        private var image5:Image;
        private var image6:Image;
		private var image7:Image;
        private var main:Application;
		private var news:SimpleButton;
        private var fullscreen:SimpleButton;
        private var home:SimpleButton;
        private var back:SimpleButton;
        private var next:SimpleButton;
        private var previous:SimpleButton;
		private var widthLimit:Number=-1;
        public function Buttons(application:Application, childIndex:Array, activeComponents:Array)
        {
            main = application;
            components = childIndex;
            componentsActive = activeComponents;
            init();
            return;
        }// end function

        private function init() : void
        {
            image1 = new Image("resources/core/button_home.png", true);
            image2 = new Image("resources/core/button_back.png", true);
            image3 = new Image("resources/core/button_fullscreen.png", true);
            image4 = new Image("resources/core/button_exit.png", true);
            image5 = new Image("resources/core/button_previous.png", true);
            image6 = new Image("resources/core/button_next.png", true);
			image7 = new Image("resources/core/button_news.png", true);
            home = new SimpleButton(image1, image1, image1, image1);
            home.useHandCursor = true;
            home.addEventListener("mouseDown", homeHandler);
            back = new SimpleButton(image2, image2, image2, image2);
            back.useHandCursor = true;
            back.addEventListener("mouseDown", backHandler);
            fullscreen = new SimpleButton(image3, image3, image3, image3);
            fullscreen.useHandCursor = true;
            fullscreen.addEventListener("mouseDown", toggleFullScreen);
			
			news = new SimpleButton(image7, image7, image7, image7);
			news.useHandCursor = true;
			news.addEventListener("mouseDown", gotoNews);
			
            main.stage.addEventListener("fullScreen", fullScreenRedraw);
            previous = new SimpleButton(image5, image5, image5, image5);
            previous.useHandCursor = true;
            previous.addEventListener("mouseDown", previousHandler);
            next = new SimpleButton(image6, image6, image6, image6);
            next.useHandCursor = true;
            next.addEventListener("mouseDown", nextHandler);
            setNextPreviousArrows(false);
            addChild(home);
            addChild(back);
            addChild(fullscreen);
			addChild(news);
            addChild(previous);
            addChild(next);
            previous.x = 0;
            resize(1);
        }

        public function setNextPreviousArrows(show:Boolean, width:Number=-1) : void
        {
			this.widthLimit = width;
            var _loc_2:* = show;
            previous.visible = show;
            next.visible = show;
			if (widthLimit>0)
			{
				next.x = (this.stage.stageWidth/2) + (widthLimit/2);
				previous.x = (this.stage.stageWidth/2) - (widthLimit/2)-120;
				
			}
        }

        public function previousHandler(event:MouseEvent) : void
        {
            var _loc_2:* = getActiveComponent();
            if (_loc_2 != null)
            {
                Console.log("previousHandler c:" + _loc_2, this);
                if (_loc_2.type == "text" || _loc_2.type == "board")
                {
                    (_loc_2 as Component3DText).gotoPrevious();
                }
                else if (_loc_2.type == "image")
                {
                    (_loc_2 as Component3DImage).gotoPrevious();
                }
            }
        }

        public function nextHandler(event:MouseEvent) : void
        {
            var _loc_2:* = getActiveComponent();
            if (_loc_2 != null)
            {
                Console.log("nextHandler c:" + _loc_2 + " type:" + _loc_2.type, this);
                if (_loc_2.type == "text" || _loc_2.type == "board")
                {
                    (_loc_2 as Component3DText).gotoNext();
                }
                else if (_loc_2.type == "image")
                {
                    (_loc_2 as Component3DImage).gotoNext();
                }
            }
            return;
        }// end function

        protected function getActiveComponent() : Component3D
        {
            if (!main.isMoving && !main.isZooming)
            {
                for each (var m:Component3D in componentsActive)
                {
                    
                    if (!(m.depth == main.depth && m.isOpen))
                    {
                        continue;
                    }
                    return m;
                }
            }
            return null;
        }// end function

        public function backHandler(event:MouseEvent) : void
        {
            if (!main.isMoving && !main.isZooming)
            {
                if (main.isZoomed)
                {
                    main.zoomHandler(null);
                }
                else
                {
                    for each (var m:Component3D in componentsActive)
                    {
                        
                        if (!(m.depth == (main.depth - 1) && m.isOpen))
                        {
                            continue;
                        }
                        m.setAnimationClose();
                    }
                }
            }
            return;
        }// end function

		private function gotoNews(e:MouseEvent):void
		{
			this.main.dispatchEvent( new TemplateEvent( TemplateEvent.OPEN_NEWS ) );
		}
		private final function toggleFullScreen(arg1:flash.events.MouseEvent):void
		{
			switch (stage.displayState) 
			{
				case "normal":
					stage.displayState = "fullScreen";
					fullscreen.upState = image4;
					fullscreen.downState = image4;
					fullscreen.overState = image4;
					break;
				case "fullScreen":
					stage.displayState = "normal";
					fullscreen.upState = image3;
					fullscreen.downState = image3;
					fullscreen.overState = image3;
					break;
			}
		}

        private function homeHandler(event:MouseEvent) : void
        {
            if (!main.isMoving && !main.isZooming)
            {
                components[0].setAnimationClose();
            }
            return;
        }// end function

        private function fullScreenRedraw(event:FullScreenEvent) : void
        {
            if (event.fullScreen)
            {
                fullscreen.upState = image4;
                fullscreen.downState = image4;
                fullscreen.overState = image4;
            }
            else
            {
                fullscreen.upState = image3;
                fullscreen.downState = image3;
                fullscreen.overState = image3;
            }
            return;
        }// end function

        public function resize(param1:Number) : void
        {
            x = 16 * param1;
            y = x / 5 * 3;
            var _loc_2:* = param1 * 0.5;
            home.scaleX = param1 * 0.5;
            _loc_2 = _loc_2;
            home.scaleY = _loc_2;
            _loc_2 = _loc_2;
            back.scaleX = _loc_2;
            _loc_2 = _loc_2;
            back.scaleY = _loc_2;
			back.x = home.x + home.width;
            fullscreen.scaleX = _loc_2;
            fullscreen.scaleY = _loc_2;
            fullscreen.x = main.stage.stageWidth - fullscreen.width - x * 2;
			fullscreen.visible = false;			
			news.scaleX = _loc_2;
			news.scaleY = _loc_2;
			
			news.x = main.stage.stageWidth - fullscreen.width - x * 2;
			
			
            _loc_2 = (main.stage.stageHeight - next.height) / 2;
            next.y = _loc_2;
            previous.y = _loc_2;
			next.x = main.stage.stageWidth - next.width - x * 2;
			if (widthLimit>0)
			{
				next.x = (this.stage.stageWidth/2) + (widthLimit/2);
				previous.x = (this.stage.stageWidth/2) - (widthLimit/2)-previous.width;
				
			}
			
       
        }// end function

        public function isLoaded() : Boolean
        {
            if (image1.loaded && image2.loaded)
            {
                return true;
            }
            return false;
        }// end function

    }
}
