package view.portfolio 
{
    import com.which.template.events.TemplateEvent;
    import com.which.utils.Console;
    
    import flash.display.BitmapData;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filters.BlurFilter;
    import flash.geom.Matrix;
    import flash.utils.getTimer;
    
    import caurina.transitions.Tweener;
    
    import org.papervision3d.core.geom.renderables.Vertex3D;
    import org.papervision3d.materials.BitmapMaterial;
    import org.papervision3d.objects.primitives.Plane;
    
    import view.portfolio.Component3DText;

    public class Component3DText extends Component3D
    {
        private var showDelay:Number;
        private var highresolutionText:SWF;
        private var popupVisible:Boolean;
        private var height:Number;
        private var openInterval:Number;
        private var width:Number;
        private var highresolution:Sprite;
        private var openDelay:Number;
        private var showInterval:Number;
        private var startTime:Number;
        private var url:String;
		private var dataURL:String;
        private var highresolutionPage:Image;
        private var internalActive:Boolean = false;
		private var isTemplateLoaded:Boolean = false;

        public function Component3DText(childIndex:Array, application:Application, type:String, url:String, id:Number, dataURL:String) 
        {
            super(childIndex, application, type, id);
            this.url = url;
			this.dataURL = dataURL;
			if (this.dataURL!=null)
			{
				//load with external data loading parameter
				this.url += "?dataURL="+escape(this.dataURL);
				
			}
        }

        override public function init() : void
        {
			Console.log("URL :"+ this.url + "?dataURL="+escape(this.dataURL), this);
			//Console.log("URL :"+ this.url, this);
            inited = true;
            if (type != "text" && type != "template")
            {
                if (type == "board")
                {
                    width = 180;
                    height = 320;
                }
            }
            else
            {
                width = 320;
                height = 180;
            }
            showInterval = 0.6;
            showDelay = index[(index.length - 1)] * 0.1;
            openInterval = 0.35;
            openDelay = childs.length * 0.1 + 0.5;
            highresolutionText = new SWF(url, true);
			if (this.dataURL!=null)	
			{
				isTemplateLoaded = false;
				highresolutionText.addEventListener("SWFLOADED", templateLoadListener);
			} else
			{
				isTemplateLoaded = true;
			}
            if (type != "text" && type != "template")
            {
                if (type == "board")
                {
                    highresolutionPage = new Image("resources/core/page2.jpg", true, false);
                }
            }
            else
            {
                highresolutionPage = new Image("resources/core/page.jpg", true, false);
            }
			Console.log("objectbreak 1 highresolutionPage && highresolutionText "+ highresolutionPage+" && "+highresolutionText, this)
            highresolution = new Sprite();
            highresolution.addChild(highresolutionPage); // background
            highresolution.addChild(highresolutionText); // swf
			
			
            highresolution.mouseEnabled = false;
            highresolutionPage.addEventListener( MouseEvent.MOUSE_UP, releaseHandler);
            highresolutionPage.addEventListener( MouseEvent.ROLL_OVER, rolloverHandler);
            highresolutionPage.addEventListener( MouseEvent.ROLL_OUT, rolloutHandler);
			if (this.dataURL==null)	
			{
	           	 highresolutionText.addEventListener( MouseEvent.MOUSE_UP, releaseHandler);
			}
            highresolutionText.addEventListener( MouseEvent.ROLL_OVER, rolloverHandler);
            highresolutionText.addEventListener( MouseEvent.ROLL_OUT, rolloutHandler);
            main.addEventListener( Event.ENTER_FRAME, enterFrameHandler);
            highresolution.addEventListener( MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			Console.log("objectbreak 2 highresolutionPage  && highresolutionText "+ highresolutionPage+" && "+highresolutionText, this)

        }

        private function hidePopup() : void
        {
            if (isOpen)
            {
                main.setPopupVisible();
            }
        }

        private function enterFrameHandler(event:Event) : void
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
            if (type != "text" && type != "template")
            {
                if (type == "board" )
                {
                    setMouseListener(false);
                    Tweener.addTween(displayobject, {delay:myDelay, time:showInterval, transition:"easeinoutquad", _bezier:[{x:x, y:(parent.y + y) / 2 - 600, z:parent.z}, {x:(parent.x + x) / 2, y:(parent.y + y) / 2 - 600, z:parent.z}], x:parent.x, y:parent.y, z:parent.z, onComplete:function () : void
		            {
		                main.scene.removeChild(displayobject);
		            }
		            });
                }
            }
            else
            {
                setMouseListener(false);
                Tweener.addTween(displayobject, {delay:myDelay, time:showInterval, transition:"easeinoutquad", onStart:function () : void
	            {
	                displayobject.material.doubleSided = true;
	            }
	            , _bezier:[{x:x, y:y + 400, z:z, rotationX:0, rotationY:0, rotationZ:-45}, {x:parent.x, y:parent.y + 400, z:(parent.z + z) / 2, rotationX:0, rotationY:90, rotationZ:-60}, {x:parent.x, y:parent.y + 400, z:parent.z, rotationX:0, rotationY:180, rotationZ:-90}], x:parent.x, y:parent.y, z:parent.z, rotationX:0, rotationY:180, rotationZ:-90, onComplete:function () : void
	            {
	                main.scene.removeChild(displayobject);
	            }
	            });
            }
            return myDelay + showInterval;
        }

		private function placeImage(event:Event) : void
		{
			Console.log("PLACE IMAGE", this);
			//highresolution.scaleX = highresolution.scaleY = Math.min(this.main.stage.stageWidth/1280, this.main.stage.stageHeight/720);
			highresolution.x = (this.main.stage.stageWidth-1280)/2;//(displayobject.geometry.vertices[1] as Vertex3D).vertex3DInstance.x  + main.container3D.x;
			highresolution.y = (this.main.stage.stageHeight-720)/2;//(displayobject.geometry.vertices[1] as Vertex3D).vertex3DInstance.y  + main.container3D.y;
			//Console.log("placeimage x" + 330 * Application.scale + " main.container3D.x" + main.container3D.x + "- highresolution.x" + highresolution.x, this);
			var w:Number = 1280/2;
			var h:Number = 720/2;
			
			if (width > height)
			{
				//highresolution.width =  main.container3D.x// - highresolution.x;
				//highresolution.height = main.container3D.y// - highresolution.y;
			}
			else
			{
			//	highresolution.width = h  + main.container3D.x - highresolution.x;
			//	highresolution.height = w  + main.container3D.y - highresolution.y;
			}
			
		}

        override public function setAnimationOpen() : Number
        {
            var myDelay:Number;
            if (type != "text" && type != "template")
            {
                if (main.depth != depth)
                {
                    myDelay = main.setChildsDisappearOfDepth(depth);
                }
                main.setClosedOfDepth(depth);
                isOpen = true;
                main.setHighResolution(false);
				main.addEventListener( "ZOOMIN_COMPLETE", this.zoomedIn)
				Tweener.addTween(this, {time: 0.7,delay: myDelay });
                main.setAnimationZoomIn(displayobject, myDelay, 1);
            }
            else
            {
                main.setClosedOfDepth(depth);
                isOpen = true;
                main.setHighResolution(false);
				main.addEventListener( "ZOOMIN_COMPLETE", this.zoomedIn)
                main.setAnimationZoomIn(displayobject, 0, 1);
				Tweener.addTween(this, {time: 0.7,delay: 0 });
            }
			
			
            return 0.7;
        }
		protected function zoomedIn( e:Event ):void
		{
			main.removeEventListener( "ZOOMIN_COMPLETE", this.zoomedIn);
			setHighResolution(true);
		}

        override public function rolloverHandler(e:MouseEvent) : void
        {
			switch (isOpen) 
			{
				case true:
					main.setPopupVisible(Application.POPUP_2D_ZOOM_OUT);
					startPopupTimeout();
					break;
				case false:
					if (main.isZoomed)
					{
						main.setPopupVisible(Application.POPUP_2D_ZOOM_IN, displayobject);
					}
					else 
					{
						main.setPopupVisible(Application.POPUP_3D_ZOOM_IN, displayobject);
					}
					break;
			}
        }
		protected function templateLoadListener( e:Event ):void
		{
			highresolutionText.removeEventListener("SWFLOADED", templateLoadListener);
			var template:MovieClip = (highresolutionText.loader.contentLoaderInfo.content as MovieClip) as MovieClip;
			
			Console.log("templateLoadListener "+template.width+"x"+template.height, template);
			template.addEventListener( TemplateEvent.LOADED, templateLoaded);
			template.addEventListener( TemplateEvent.ERROR, templateError);
			template.addEventListener( TemplateEvent.CLICK_BG, releaseHandler);
			template.addEventListener( TemplateEvent.OPEN_URL, openURL);
			
		}
		protected function openURL( e:TemplateEvent ):void
		{
			this.main.openURL( e );
		}
		
		protected function templateLoaded( e:Event ):void
		{
			var template:MovieClip = (highresolutionText.loader.contentLoaderInfo.content as MovieClip) as MovieClip;
			Console.log("template Loaded "+template.width+"x"+template.height,this);
			this.isTemplateLoaded = true;
		}
		
		protected function templateError( e:Event ):void
		{
			Console.log("template Error", this);
			this.isTemplateLoaded = true;
			//TODO: notify about the error
		}

		override public function isLoaded() : Boolean
		{
			//TODO:: Add special case for template
			if (highresolutionPage && highresolutionText)
			{
				highresolution.alpha = 1
				Console.log("isLoaded :"+highresolutionPage.loaded+" && "+highresolutionText.loaded+" && "+isTemplateLoaded, this);
				if (highresolutionPage.loaded && highresolutionText.loaded && isTemplateLoaded )
				{
					
					var matrix:Matrix = new Matrix();
					if (width > height)
					{
						matrix.scale(width / 1280, height / 720);
					}
					else
					{
						matrix.scale(width / 1280, height / 720);
					}
					var blurStrength:Number = 1.1;
					highresolutionText.filters = [new BlurFilter(blurStrength, blurStrength, 3)];
					var bd:BitmapData = new BitmapData(width, height);
					bd.draw(highresolution, matrix, null, null, null, true);
					highresolutionText.filters = null;
					highresolutionText.alpha = 1;
					displayobject = new Plane(new BitmapMaterial(bd), width, height);
					displayobject.material.smooth = true;
					return true;
				}
				return false;
			} else {
				//Console.log("objectbreak 3 highresolutionPage && highresolutionText "+ highresolutionPage+" && "+highresolutionText, this)
			}
			
			return false;
		}

        override public function setAnimationClose() : Number
        {
            if (!internalActive)
            {
                main.setClosedOfDepth(depth);
                setHighResolution(false);
                main.setAnimationZoomOut();
            }
            return 0.7;
        }

        override public function rolloutHandler(e:MouseEvent) : void
        {
            main.setPopupVisible();
        }

        public function mouseMoveHandler(e:MouseEvent) : void
        {
            if (isOpen)
            {
                main.setPopupVisible(1);
                startPopupTimeout();
            }
        }

        override public function setAnimationAppear(delay:Number = 0) : Number
        {
			var theExecutionDelay:Number = delay;
			var myDelay:int = showDelay + theExecutionDelay;
            if (index.length == 2)
            {
                var newIndex:int = (parent.loadingIndex + 1);
				parent.loadingIndex = newIndex;
            }
            if (type != "text"  && type != "template")
            {
                if (type == "board")
                {
                  
                    main.scene.addChild(displayobject);
                    displayobject.visible = false;
                    Tweener.addTween(displayobject, {delay:myDelay, time:showInterval, transition:"EaseinOutQuad", onStart:function () : void
		            {
		                displayobject.visible = true;
		                displayobject.x = parent.x;
		                displayobject.y = parent.y;
		                displayobject.z = parent.z;
		            }
		            , _bezier:[{x:(parent.x + x) / 2, y:(parent.y + y) / 2 - 600, z:parent.z}, {x:x, y:(parent.y + y) / 2 - 600, z:parent.z}], x:x, y:y, z:z, onComplete:function () : void
		            {
		                setMouseListener(true);
		            }});
                }
            }
            else
            {
				Console.log("displayobject:"+displayobject,this)
				main.scene.addChild(displayobject);
                displayobject.visible = false;
                Tweener.addTween(displayobject, {delay:myDelay, time:showInterval, transition:"EaseInOutQuad", onStart:function () : void
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
            }
            return myDelay + showInterval;
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
				if (component.type == "text" || component.type == "board" || component.type == "template")
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
				if (component.type == "text" || component.type == "board" || component.type == "template")
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
                if (main.container2D.contains(highresolution))
                {
                    main.container2D.removeChild(highresolution);
                    main.stage.removeEventListener("resize", placeImage);
                    main.setBackgroundOverlay(false);
                    main.setNextPreviousArrows(false);
                }
            }
            else
            {
				
                main.container2D.addChild(highresolution);
                main.setBackgroundOverlay(true);
                main.setNextPreviousArrows(true, 1280);
				
                main.stage.addEventListener("resize", placeImage);
                placeImage(null);
            }
        }

    }
}
