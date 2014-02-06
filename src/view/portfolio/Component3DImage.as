package view.portfolio 
{
    import caurina.transitions.*;
    import com.which.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.materials.*;
    import org.papervision3d.objects.primitives.*;

    public class Component3DImage extends Component3D
    {
        private var materialImage:Image;
        protected var OPEN_INTERVAL:Number;
        protected var url_highresolution:String;
        protected var SHOW_DELAY:Number;
        private var popupVisible:Boolean;
        protected var height:Number = 240;
        protected var OPEN_DELAY:Number;
        protected var width:Number = 320;
        protected var SHOW_INTERVAL:Number;
        protected var loading:Sprite;
        protected var image:Image;
        private var startTime:Number;
        public var url:String;
        protected var hasLoaded:Boolean = false;

        public function Component3DImage(childIndex:Array, application:Application, type:String, url:String, id:Number)
        {
            width = 320;
            height = 180;
            super(childIndex, application, type, id);
            this.url = url;
			
			//need to allow png + also using hr and normal
            var regex:RegExp = new RegExp("(.png|.jpg)");
            url_highresolution = this.url.replace(regex, "hr"+(url.indexOf(".png")>=0 ? ".png" : ".jpg") );
			Console.log("hires:"+url_highresolution, this);
        }

        override public function init() : void
        {
            inited = true;
            SHOW_DELAY = index[(index.length - 1)] * 0.1;
            SHOW_INTERVAL = 0.6;
            OPEN_DELAY = childs.length * 0.1 + 0.5;
            OPEN_INTERVAL = 0.35;
            materialImage = new Image(url);
            loading = new Sprite();
            var loadermc:LoaderMC = new LoaderMC();
            loading.addChild(loadermc);
			
        }

        private function hidePopup() : void
        {
            if (isOpen)
            {
                main.setPopupVisible();
            }
            return;
        }

		public function gotoNext() : void
		{
			Console.log("gotoNext", this);
			var component:Component3D = getNextComponent(true);
			if (component != null)
			{
				main.setClosedOfDepth(depth);
				setHighResolution(false);
				Console.log("Pan to component:" + component, this);
				if (component.type == "text" || component.type == "board")
				{
					(component as Component3DText).setAnimationOpen();
				}
				else if (component.type == "image")
				{
					(component as Component3DImage).setAnimationOpen();
				}
			}
		}

		public function gotoPrevious() : void
		{
			Console.log("gotoPrevious", this);
			var component:Component3D = getPreviousComponent(true);
			if (component != null)
			{
				main.setClosedOfDepth(depth);
				setHighResolution(false);
				Console.log("Pan to component:" + component, this);
				if (component.type == "text" || component.type == "board")
				{
					(component as Component3DText).setAnimationOpen();
				}
				else if (component.type == "image")
				{
					(component as Component3DImage).setAnimationOpen();
				}
			}
		}

        public function setHighResolution(enable:Boolean) : void
        {
            if (enable != true)
            {
                if (image && main.container2D.contains(image))
                {
                    main.stage.removeEventListener("resize", resize);
                    main.container2D.removeChild(image);
					main.setBackgroundOverlay(false);
                    main.setNextPreviousArrows(false);
                }
            }
            else
            {
                if (image == null)
                {
                    image = new Image(url_highresolution, true);
                }
                main.container2D.addChild(image);
               
				main.setBackgroundOverlay(true);
                main.setNextPreviousArrows(true);
                setMouseEnabled(false);
				main.stage.addEventListener("resize", resize);

                resize();
				
            }
            return;
        }

        private function enterFrameHandler(e:Event) : void
        {
		
            if (getTimer() - startTime > 1000 && popupVisible)
            {
				Console.log("enterFrameHandler: "+popupVisible, this);
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
            var myDelay:Number = SHOW_DELAY + theExecutionDelay;
            setMouseListener(false);
		
            Tweener.addTween(displayobject, {delay:myDelay, time:SHOW_INTERVAL, transition:"easeinoutquad", onStart:function () : void
            {
                displayobject.material.doubleSided = true;
                return;
            }
            , _bezier:[{x:x, y:y + 400, z:z, rotationX:0, rotationY:0, rotationZ:-45}, {x:parent.x, y:parent.y + 400, z:(parent.z + z) / 2, rotationX:0, rotationY:90, rotationZ:-60}, {x:parent.x, y:parent.y + 400, z:parent.z, rotationX:0, rotationY:180, rotationZ:-90}], x:parent.x, y:parent.y, z:parent.z, rotationX:0, rotationY:180, rotationZ:-90, onComplete:function () : void
            {
                main.scene.removeChild(displayobject);
                return;
            }
            });
            return myDelay + SHOW_INTERVAL;
        }

        override public function setAnimationOpen() : Number
        {
            main.setNextPreviousArrows(true);
            main.setClosedOfDepth(depth);
            isOpen = true;
            main.setHighResolution(false);
            Tweener.addTween(this, {time:0.7, onComplete:function () : void
            {
                setHighResolution(true);
                if (loading != null)
                {
                    loading.x = main.container3D.x + displayobject.screen.x;
                    loading.y = main.container3D.y + displayobject.screen.y;
                    main.container2D.addChild(loading);
                    main.addEventListener( Event.ENTER_FRAME, loadingHandler);
                }
                return;
            }
            });
            main.setAnimationZoomIn(displayobject, 0, 1);
            return 0.7;
        }

		private function resize(e:Event = null) : void
		{
			var left:Number		= 	(displayobject.geometry.vertices[1] as Vertex3D).vertex3DInstance.x  + main.container3D.x;
			var top:Number 		= 	(displayobject.geometry.vertices[1] as Vertex3D).vertex3DInstance.y  + main.container3D.y;
			var right:Number	= 	(displayobject.geometry.vertices[2] as Vertex3D).vertex3DInstance.x  + main.container3D.x;
			var bottom:Number 	= 	(displayobject.geometry.vertices[2] as Vertex3D).vertex3DInstance.y  + main.container3D.y;
			image.x = left;
			image.y = top;
			image.width = right - left;
			image.height = bottom - top;
		}

        override public function rolloverHandler(e:MouseEvent) : void
        {
			if (isOpen) 
			{
					main.setPopupVisible(Application.POPUP_2D_ZOOM_OUT);
					startPopupTimeout();
			} else {
					if (main.isZoomed)
					{
						
						main.setPopupVisible(Application.POPUP_2D_ZOOM_IN, displayobject);
					}
					else 
					{
						main.setPopupVisible(Application.POPUP_3D_ZOOM_IN, displayobject);
					}
			}
        }

        override public function isLoaded() : Boolean
        {
            if (!hasLoaded)
            {
                if (materialImage && materialImage.loaded)
                {
                    displayobject = new Plane(new BitmapMaterial(materialImage.bitmap.bitmapData), width, height);
                    displayobject.material.smooth = true;
                    hasLoaded = true;
                }
            }
            return hasLoaded;
        }

        override public function setAnimationClose() : Number
        {
            if (loading != null)
            {
                main.container2D.removeChild(loading);
                main.removeEventListener( Event.ENTER_FRAME, loadingHandler);
            }
            main.setClosedOfDepth(depth);
            setHighResolution(false);
            main.setAnimationZoomOut();
            return 0.7;
        }

        override public function rolloutHandler(e:MouseEvent) : void
        {
            main.setPopupVisible();
        }

        public function mouseMoveHandler(event:MouseEvent) : void
        {
			Console.log("mouseMove", this);
            if (isOpen)
            {
                main.setPopupVisible(1);
                startPopupTimeout();
            }
        }

        override public function loadingHandler(e:Event) : void
        {
            loading.rotation = loading.rotation - main.deltatime * 1000;
            loading.x = main.container3D.x + displayobject.screen.x;
            loading.y = main.container3D.y + displayobject.screen.y;
            if (image.loaded)
            {
                main.removeEventListener(Event.ENTER_FRAME, loadingHandler);
                main.container2D.removeChild(loading);
                loading = null;
                resize();
                setMouseEnabled(true);
                if (displayobject.container)
                {
					//displayobject.container.stage.addEventListener( MouseEvent.MOUSE_MOVE, mouseMoveHandler);
                    displayobject.container.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
                }
                startPopupTimeout();
                main.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
            }
        }

        override public function setAnimationAppear(delay:Number = 0) : Number
        {
			var theExecutionDelay:Number = delay;
            var myDelay:* = SHOW_DELAY + theExecutionDelay;
            main.scene.addChild(displayobject);
            displayobject.visible = false;
			
            Tweener.addTween(displayobject, {delay:myDelay, time:SHOW_INTERVAL, transition:"easeinoutquad", onStart:function () : void
            {
                displayobject.visible = true;
                displayobject.x = parent.x;
                displayobject.y = parent.y;
                displayobject.z = parent.z;
                displayobject.rotationX = 0;
                displayobject.rotationY = 180;
                displayobject.rotationZ = -90;
                displayobject.material.doubleSided = true;
            }
            , _bezier:[{x:parent.x, y:parent.y + 400, z:parent.z, rotationX:0, rotationY:180, rotationZ:-90}, {x:parent.x, y:parent.y + 400, z:(parent.z + z) / 2, rotationX:0, rotationY:90, rotationZ:-60}, {x:x, y:y + 400, z:z, rotationX:0, rotationY:0, rotationZ:-45}], x:x, y:y, z:z, rotationX:0, rotationY:0, rotationZ:0, onComplete:function () : void
            {
                displayobject.material.doubleSided = false;
                setMouseListener(true);
            }});
            return myDelay + SHOW_INTERVAL;
        }

    }
}
