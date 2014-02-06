package view.portfolio 
{
    import caurina.transitions.*;
    
    import com.which.utils.*;
    
    import flash.events.*;
    import flash.utils.*;
    
    import org.papervision3d.materials.*;
    import org.papervision3d.objects.*;
    import org.papervision3d.objects.primitives.*;
    
    import view.portfolio.Component3DFolder;

    public class Component3DFolder extends Component3D
    {
        private var materialImage:Image;
        private var handlerbottom:DisplayObject3D;
        public var isHot:Boolean = false;
        private var glow:Plane;
        private var handlerright:DisplayObject3D;
        private var OPEN_INTERVAL:Number;
        private var SHOW_DELAY:Number;
        public var isLoaderInited:Boolean = false;
        private var material:BitmapFileMaterial;
        private var OPEN_DELAY:Number;
        private var border:DisplayObject3D;
        private var loading:Plane;
        private var materialImage2:Image;
        private var SHOW_INTERVAL:Number;
        private var handlertop:DisplayObject3D;
        private var hot:Plane;
        private var handlerleft:DisplayObject3D;
        private var image:Plane;
        public var isImage:Boolean = false;
        private var back:Plane;
        private var material2:BitmapFileMaterial;
        private var url:String;
        private var startTime:Number;

        public function Component3DFolder(childIndex:Array, application:Application, type:String, url:String, id:Number)
        {
            isHot = false;
            isImage = false;
            isLoaderInited = false;
            super(childIndex, application, type, id);
            this.url = url;
        }

		override public function init() : void
		{
			Console.log("init", this);
			inited = true;
			SHOW_DELAY = index[(index.length - 1)] * 0.1;
			SHOW_INTERVAL = 0.6;
			OPEN_DELAY = childs.length * 0.1 + 0.5;
			OPEN_INTERVAL = 0.35;
			materialImage = new Image(url);
			border = new DisplayObject3D();
			back = new Plane(main.material_folder_back, 240, 320);
			var planeTop:Plane = new Plane(main.material_folder_top, 240, 25);
			planeTop.y = 12.5;
			handlertop = new DisplayObject3D();
			handlertop.y = 160;
			handlertop.z = -25;
			handlertop.rotationX = 90;
			handlertop.addChild(planeTop);
			var planeBottom:Plane = new Plane(main.material_folder_bottom, 240, 25);
			planeBottom.y = -12.5;
			handlerbottom = new DisplayObject3D();
			handlerbottom.addChild(planeBottom);
			handlerbottom.y = -160;
			handlerbottom.z = -25;
			handlerbottom.rotationX = -90;
			var planeLeft:Plane = new Plane(main.material_folder_left, 25, 320);
			planeLeft.x = -12.5;
			handlerleft = new DisplayObject3D();
			handlerleft.addChild(planeLeft);
			handlerleft.x = -120;
			handlerleft.z = -25;
			handlerleft.rotationY = 90;
			var planeRight:Plane = new Plane(main.material_folder_right, 25, 320);
			planeRight.x = 12.5;
			handlerright = new DisplayObject3D();
			handlerright.addChild(planeRight);
			handlerright.x = 120;
			handlerright.z = -25;
			handlerright.rotationY = -90;
			if (isHot)
			{
				handlerright.removeChild(planeRight);
				handlertop.removeChild(planeTop);
				hot = new Plane(main.material_folder_hot, 114, 128);
				hot.x = 97;
				hot.y = 195;
				hot.z = z - 65;
				hot.material.smooth = true;
				planeTop = new Plane(main.material_hot_top, 240, 30);
				planeTop.y = 15;
				handlertop = new DisplayObject3D();
				handlertop.y = 160;
				handlertop.z = -25;
				handlertop.rotationX = -90;
				handlertop.addChild(planeTop);
				planeRight = new Plane(main.material_hot_right, 30, 320);
				planeRight.x = 15;
				handlerright = new DisplayObject3D();
				handlerright.x = 120;
				handlerright.z = -25;
				handlerright.rotationY = -90;
				handlerright.addChild(planeRight);
			}
			border.addChild(handlerleft);
			border.addChild(handlerright);
			border.addChild(handlertop);
			border.addChild(handlerbottom);
			if (isImage)
			{
				var j:int = 0;
				var i:int = 0;
				while (i < childs.length)
				{
					
					var component:Component3D = childs[i];
					if (component.type == "image")
					{
						if (j == 0)
						{
							materialImage2 = new Image((component as Component3DImage).url);
						}
						j = j + 1;
					}
					i = i + 1;
				}
			}
			glow = new Plane(main.material_glow, 800, 800, 1, 1);
			main.viewport.getChildLayer(glow, true, true);
			loading = new Plane(main.material_loading, 114, 114);
			main.viewport.getChildLayer(loading, true, true);
			loading.x = x;
			loading.y = y;
			loading.z = z - 25.002;
			loading.visible = false;
		}

        override public function setAnimationDisappear(delay:Number = 0) : Number
        {
			
			var theExecutionDelay:Number = delay;
            var myDelay:* = SHOW_DELAY + theExecutionDelay;
            setMouseListener(false);
            setMouseEnabled(false);
            Tweener.addTween(border, {delay:myDelay, time:SHOW_INTERVAL, transition:"easeInOutQuad", _bezier:[{x:x, y:(parent.y + y) / 2 - 600, z:parent.z}, {x:(parent.x + x) / 2, y:(parent.y + y) / 2 - 600, z:parent.z}], x:parent.x, y:parent.y, z:parent.z, onStart:function () : void
            {
                if (loading)
                {
                    loading.visible = false;
                }
            }
            , onUpdate:function () : void
            {
                displayobject.x = border.x;
                displayobject.y = border.y;
                displayobject.z = border.z - 25.001;
            }
            , onComplete:function () : void
            {
                main.scene.removeChild(border);
                main.scene.removeChild(displayobject);
            }
            });
            if (isHot)
            {
                Tweener.addTween(hot, {delay:myDelay, time:SHOW_INTERVAL, transition:"easeInOutQuad", _bezier:[{x:x + 97, y:(parent.y + y) / 2 - 600 + 195, z:parent.z - 30 - 25}, {x:(parent.x + x) / 2 + 97, y:(parent.y + y) / 2 - 600 + 195, z:parent.z - 30 - 25}], x:parent.x, y:parent.y, z:parent.z, onComplete:function () : void
            {
                main.scene.removeChild(hot);
            }
            });
            }
            return myDelay + SHOW_INTERVAL;
        }

        private function glowRotationHandler(event:Event) : void
        {
            glow.rotationZ = glow.rotationZ + main.deltatime * 10;
            return;
        }

        override public function setAnimationOpen() : Number
        {
            var myDelay:Number = main.setPreparedToOpen(this, OPEN_DELAY);
            Tweener.addTween(border, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeInOutQuad", onStart:function () : void
            {
                main.scene.addChild(back);
                back.x = border.x;
                back.y = border.y;
                back.z = border.z;
                displayobject.x = border.x;
                displayobject.y = border.y;
                displayobject.z = border.z - 25.001;
            }
            , z:z - 480 / 2, onUpdate:function () : void
            {
                displayobject.x = border.x;
                displayobject.y = border.y;
                displayobject.z = border.z - 25.001;
            }
            , onComplete:function () : void
            {
                displayobject.x = border.x;
                displayobject.y = border.y;
                displayobject.z = border.z - 25.001;
            }
            });
            main.scene.addChild(glow);
            glow.visible = false;
            Tweener.addTween(glow, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeInOutQuad", onStart:function () : void
            {
                glow.x = x;
                glow.y = y;
                glow.z = z;
                glow.scale = 0.5;
                glow.visible = true;
                main.addEventListener( Event.ENTER_FRAME, glowRotationHandler);
            }
            , scale:1, z:z - 480 / 4});
            Tweener.addTween(glow.container, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeOutQuad", onStart:function () : void
            {
                glow.container.blendMode = "screen";
                glow.container.mouseEnabled = false;
                glow.container.alpha = 0;
            }
            , alpha:1});
            Tweener.addTween(handlertop, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeInOutQuad", rotationX:-15});
            Tweener.addTween(handlerbottom, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeInOutQuad", rotationX:15});
            Tweener.addTween(handlerleft, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeInOutQuad", rotationY:15});
            Tweener.addTween(handlerright, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeInOutQuad", rotationY:-15});
            if (isHot)
            {
                Tweener.addTween(hot, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeInOutQuad", z:z - 480 / 2 - 30 - 25});
            }
            isOpen = true;
            return myDelay + OPEN_INTERVAL;
        }

        override public function rolloverHandler(e:MouseEvent) : void
        {
			Console.log("rolloverHandler", this);
			if (isOpen)
			{
				main.setPopupVisible(6, displayobject);
			} else
			{
				main.setPopupVisible(5, displayobject);
			}
        }

		override public function isLoaded() : Boolean
		{
			
			if (isImage)
			{
				if (materialImage2 && materialImage2.loaded && materialImage && materialImage.loaded)
				{
					trace("isImage");
					var component:Component3D;
					var j:int = 0;
					var i:int = 0;
					while (i < childs.length)
					{
						
						component = childs[i];
						if (component.type == "image")
						{
							if (j == 0)
							{
								image = new Plane(new BitmapMaterial(materialImage2.bitmap.bitmapData), 320, 240);
								image.rotationZ = image.rotationZ + 90;
								image.z = -25;
								image.material.smooth = true;
								border.addChild(image);
								Console.log("image loaded", this);
								break;
							}
							j = j + 1;
						}
						i = i + 1;
					}
					displayobject = new Plane(new BitmapMaterial(materialImage.bitmap.bitmapData), 240, 320);
					displayobject.material.smooth = true;
					return true;
				}
				return false;
			}
			if (materialImage && materialImage.loaded)
			{
				displayobject = new Plane(new BitmapMaterial(materialImage.bitmap.bitmapData), 240, 320);
				displayobject.material.smooth = true;
				return true;
			}
			return false;
		}

        override public function setAnimationClose() : Number
        {
            var myDelay:Number;
            myDelay = main.setPreparedToClose(this, OPEN_INTERVAL);
            Tweener.addTween(border, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeInOutQuad", z:z, onUpdate:function () : void
            {
                displayobject.x = border.x;
                displayobject.y = border.y;
                displayobject.z = border.z - 25.001;
                return;
            }
            , onComplete:function () : void
            {
                main.scene.removeChild(back);
                displayobject.x = border.x;
                displayobject.y = border.y;
                displayobject.z = border.z - 25.001;
                return;
            }
            });
            Tweener.addTween(glow.container, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeInQuad", alpha:0, onComplete:function () : void
            {
                main.removeEventListener( Event.ENTER_FRAME, glowRotationHandler);
                main.scene.removeChild(glow);
            }});
            Tweener.addTween(glow, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeInOutQuad", z:z, scale:0.5});
            Tweener.addTween(handlertop, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeInOutQuad", rotationX:-90});
            Tweener.addTween(handlerbottom, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeInOutQuad", rotationX:90});
            Tweener.addTween(handlerleft, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeInOutQuad", rotationY:90});
            Tweener.addTween(handlerright, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeInOutQuad", rotationY:-90});
            if (isHot)
            {
                Tweener.addTween(hot, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeInOutQuad", z:z - 30});
            }
            isOpen = false;
            return myDelay + OPEN_INTERVAL;
        }

        override public function rolloutHandler(e:MouseEvent) : void
        {
            main.setPopupVisible();
        }

		override public function loadingHandler(e:Event) : void
		{
			var i:int = 0;
			var loadedIndex:int = 0;
			var loadingDone:Boolean = false;
			loading.rotationZ = loading.rotationZ + main.deltatime * 1000;
			setMouseEnabled(false);
			//Console.log(" initiating child ", this);
			//if (index.length == 3 && getTimer() - startTime > parent.childs.length * 0.1 * 1000)
			{
				if (parent.loadingIndex == ID)
				{
					i = 0;
					while (i < childs.length)
					{
						if (!childs[i].inited)
						{
							childs[i].init();
							//Console.log(i+" initiating child "+ childs[i], this);

						}
						i++;
					}
				}
			}
			
			loadingDone = true;
			for each (var m:Component3D in childs)
			{
				
				if (!m.isLoaded())
				{
					//Console.log("Still loading:"+m, m);
					loadingDone = false;
				} 
				
			}
			
			//Console.log("isLoaded :"+ loadingDone +" && "+displayobject.container+" && "+(!main.isMoving), this);
			if (loadingDone && displayobject.container && !main.isMoving)
			{
				loadedIndex = parent.loadingIndex + 1;
				parent.loadingIndex = loadedIndex;
				main.removeEventListener( Event.ENTER_FRAME, loadingHandler);
				main.scene.removeChild(loading);
				loading = null;
				setMouseListener(true);
				setMouseEnabled(true);
			} else 
			{
				
			}
		}

        override public function setAnimationAppear(delay:Number = 0) : Number
        {
			var theExecutionDelay:Number = delay;
            //Console.log("setAnimationAppear isLoaderInited:" + isLoaderInited, this);
            var myDelay:Number = SHOW_DELAY + theExecutionDelay;
            Tweener.addTween(border, {delay:myDelay, time:SHOW_INTERVAL, transition:"easeInOutQuad", onStart:function () : void
            {
                main.scene.addChild(border);
                main.scene.addChild(displayobject);
                border.x = parent.x;
                border.y = parent.y;
                border.z = parent.z;
				displayobject.x = border.x;
                displayobject.y = border.y;
                displayobject.z = border.z - 25.001;
            }, _bezier:[{x:(parent.x + x) / 2, y:(parent.y + y) / 2 - 600, z:parent.z}, {x:x, y:(parent.y + y) / 2 - 600, z:parent.z}], 
				x:x, y:y, z:z, 
				onUpdate:function () : void
	            {
	                displayobject.x = border.x;
	                displayobject.y = border.y;
	                displayobject.z = border.z - 25.001;
	            }, onComplete: this.AnimateInComplete});
			
            if (isHot)
            {
                Tweener.addTween(hot, {delay:myDelay, time:SHOW_INTERVAL, transition:"easeInOutQuad", onStart:function () : void
            	{
	                main.scene.addChild(hot);
	                hot.x = parent.x;
	                hot.y = parent.y;
	                hot.z = parent.z + 20 - 25;
            	}, _bezier:[{x:(parent.x + x) / 2 + 97, y:(parent.y + y) / 2 - 600 + 195, z:parent.z - 30 - 25}, {x:x + 97, y:(parent.y + y) / 2 - 600 + 195, z:parent.z - 30 - 25}], x:x + 97, y:y + 195, z:z - 30 - 25});
			}
            return myDelay + SHOW_INTERVAL;
        }

		protected function AnimateInComplete() : void
		{
			var i:int = 0;
			displayobject.x = border.x;
			displayobject.y = border.y;
			displayobject.z = border.z - 25.001;
			Console.log("isLoaderInited:" + isLoaderInited, this);
			if (!isLoaderInited)
			{
				isLoaderInited = true;
				main.scene.addChild(loading);
				if (index.length == 2)
				{
					i = 0;
					while (i < childs.length)
					{
						
						if (!childs[i].inited)
						{
							try
							{
								childs[i].init();
							}
							catch (e:Error)
							{
								Console.log("Error: " + e.message, childs[i]);
							}
						}
						i = i + 1;
					}
				}
				startTime = getTimer();
				main.addEventListener( Event.ENTER_FRAME, loadingHandler);
			}
			if (loading)
			{
				loading.visible = true;
			}
			if (!loading)
			{
				setMouseListener(true);
			}
		}

    }
}
