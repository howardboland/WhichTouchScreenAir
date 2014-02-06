package view.portfolio 
{
    import view.portfolio.Component3DVideo;
    import caurina.transitions.*;
    import com.which.utils.*;
    import flash.events.*;
    import flash.utils.*;
    import org.papervision3d.materials.*;
    import org.papervision3d.objects.primitives.*;

    public class Component3DVideo extends Component3D
    {
        private var materialImage:Image;
        private var showDelay:Number;
        private var popupVisible:Boolean;
        private var urlThumb:String;
        private var openInterval:Number;
        private var height:Number;
        private var width:Number;
        private var urlVideo:String;
        private var openDelay:Number;
        private var showInterval:Number;
        private var startTime:Number;
        private var format:Number;
        protected var hasLoaded:Boolean = false;

        public function Component3DVideo(childIndex:Array, application:Application, type:String, url:String, format:Number, id:Number)
        {
            super(childIndex, application, type, id);
            urlVideo = url;
            urlThumb = url.replace(new RegExp(new RegExp(".flv")), "thumb.jpg");
            this.format = format;
            if (this.format != 169)
            {
                width = 667;
                height = 500;
            }
            else
            {
                width = 889;
                height = 500;
            }
        }

        override public function init() : void
        {
            inited = true;
            showDelay = index[(index.length - 1)] * 0.1;
            showInterval = 0.6;
            openDelay = childs.length * 0.1 + 0.5;
            openInterval = 0.35;
            materialImage = new Image(urlThumb);
            startPopupTimeout();
            main.addEventListener( Event.ENTER_FRAME, enterFrameHandler);
        }

        private function hidePopup() : void
        {
            if (isOpen)
            {
                main.setPopupVisible();
            }
        }

        private function enterFrameHandler(e:Event) : void
        {
            if (getTimer() - startTime > 1000 && popupVisible)
            {
                popupVisible = false;
                hidePopup();
            }
        }

        private function startPopupTimeout() : void
        {
            startTime = getTimer();
            popupVisible = true;
        }

        override public function setAnimationDisappear(delay:Number = 0) : Number
        {
			var theExecutionDelay:Number = delay;
            var myDelay:* = showDelay + theExecutionDelay;
            setMouseListener(false);
            Tweener.addTween(displayobject, {delay:myDelay, time:showInterval, transition:"easeinoutquad", onStart:function () : void
            {
                displayobject.material.doubleSided = true;
                return;
            }
            , _bezier:[{x:x, y:y + 400, z:z, rotationX:0, rotationY:0, rotationZ:-45, scale:0.48}, {x:parent.x, y:parent.y + 400, z:(parent.z + z) / 2, rotationX:0, rotationY:90, rotationZ:-60, scale:0.48}, {x:parent.x, y:parent.y + 400, z:parent.z, rotationX:0, rotationY:180, rotationZ:-90, scale:0.48}], x:parent.x, y:parent.y, z:parent.z, rotationX:0, rotationY:180, rotationZ:-90, scale:0.48, onComplete:function () : void
            {
                main.scene.removeChild(displayobject);
                return;
            }
            });
            return myDelay + showInterval;
        }

        override public function setAnimationOpen() : Number
        {
            if (main.isZoomed)
            {
                main.setClosedOfDepth(depth);
            }
            isOpen = true;
            if (main.isZoomed)
            {
                main.setHighResolution(false);
            }
            main.setAnimationZoomIn(displayobject, 0, 5);
            Tweener.addTween(this, {time:0.7, onComplete:function () : void
            {
                main.addVideo(displayobject, urlVideo, format);
                return;
            }
            });
            return 0.7;
        }

        override public function rolloverHandler(e:MouseEvent) : void
        {
			if (isOpen) 
			{
				main.addEventListener( MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				main.setPopupVisible(Application.POPUP_2D_ZOOM_OUT);
				startPopupTimeout();
			} else 
			{
				if (main.isZoomed)
				{
					main.setPopupVisible(Application.POPUP_2D_PLAY, displayobject);
				}
				else 
				{
					main.setPopupVisible(Application.POPUP_3D_PLAY, displayobject);
				}
			}
        }

        override public function isLoaded() : Boolean
        {
            if (!hasLoaded)
            {
                if (materialImage && materialImage.loaded)
                {
                    displayobject = new Plane(new BitmapMaterial(materialImage.bitmap.bitmapData), width, height, 2, 2);
                    displayobject.material.smooth = true;
                    hasLoaded = true;
                }
                else
                {
                    Console.log("urlVideo loading: " + urlVideo, this);
                }
            }
            return hasLoaded;
        }

        override public function setAnimationClose() : Number
        {
            main.setClosedOfDepth(depth);
            main.setAnimationZoomOut();
            return 0.7;
        }

        override public function rolloutHandler(e:MouseEvent) : void
        {
            main.removeEventListener( MouseEvent.MOUSE_MOVE, mouseMoveHandler);
            main.setPopupVisible();
        }

        public function mouseMoveHandler(event:MouseEvent) : void
        {
            if (isOpen)
            {
                main.setPopupVisible(1);
                startPopupTimeout();
            }
            return;
        }

        override public function setClosed() : void
        {
            if (isOpen)
            {
                super.setClosed();
                main.removeVideo();
            }
            return;
        }

        override public function setAnimationAppear(delay:Number = 0) : Number
        {
			var theExecutionDelay:Number = delay;
            var myDelay:Number = showDelay + theExecutionDelay;
            Tweener.addTween(displayobject, {delay:myDelay, time:showInterval, transition:"EaseInOutQuad", onStart:function () : void
            {
                if (format != 169)
                {
                    main.video.height = 480;
                }
                else
                {
                    main.video.height = 368;
                }
                displayobject.x = parent.x;
                displayobject.y = parent.y;
                displayobject.z = parent.z;
                displayobject.rotationX = 0;
                displayobject.rotationY = 180;
                displayobject.rotationZ = -90;
                displayobject.material.doubleSided = true;
                displayobject.scale = 0.48;
                main.scene.addChild(displayobject);
                return;
            }
            , _bezier:[{x:parent.x, y:parent.y + 400, z:parent.z, rotationX:0, rotationY:180, scale:0.48}, {x:parent.x, y:parent.y + 400, z:(parent.z + z) / 2, rotationX:0, rotationY:90, rotationZ:-60, scale:0.48}, {x:x, y:y + 400, z:z, rotationX:0, rotationY:0, rotationZ:-45, scale:0.48}], x:x, y:y, z:z, rotationX:0, rotationY:0, rotationZ:0, scale:1, onComplete:function () : void
            {
                displayobject.material.doubleSided = false;
                setMouseListener(true);
                main.setPopupVisible(7, displayobject);
                return;
            }
            });
            return myDelay + showInterval;
        }

    }
}
