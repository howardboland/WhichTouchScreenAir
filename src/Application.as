package  
{
    import com.markuslerner.util.MTimer;
    import com.which.template.events.TemplateEvent;
    import com.which.utils.Console;
    
    import flash.display.Shape;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.AsyncErrorEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.MouseEvent;
    import flash.events.NetStatusEvent;
    import flash.events.SecurityErrorEvent;
    import flash.media.Video;
    import flash.net.NetConnection;
    import flash.net.NetStream;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.utils.getTimer;
    
    import caurina.transitions.Tweener;
    
    import org.papervision3d.cameras.Camera3D;
    import org.papervision3d.core.geom.renderables.Vertex3D;
    import org.papervision3d.core.render.sort.NullSorter;
    import org.papervision3d.materials.BitmapFileMaterial;
    import org.papervision3d.materials.BitmapMaterial;
    import org.papervision3d.materials.ColorMaterial;
    import org.papervision3d.materials.utils.MaterialsList;
    import org.papervision3d.objects.DisplayObject3D;
    import org.papervision3d.objects.parsers.Collada;
    import org.papervision3d.objects.primitives.Plane;
    import org.papervision3d.render.BasicRenderEngine;
    import org.papervision3d.scenes.Scene3D;
    import org.papervision3d.view.Viewport3D;
    import org.papervision3d.view.layer.ViewportLayer;
    
    import view.portfolio.Buttons;
    import view.portfolio.Component3D;
    import view.portfolio.Component3DBox;
    import view.portfolio.Component3DFolder;
    import view.portfolio.Component3DImage;
    import view.portfolio.Component3DText;
    import view.portfolio.Component3DVideo;
    import view.portfolio.Container3D;
    import view.portfolio.Image;
    import view.portfolio.XYZ;
    

    public class Application extends Sprite
    {
        private const POPUP_3D_SCALE:Number = 1;
        private const VIDEO_BAR_WIDTH_169:Number = 915;
        private const POPUP_TIMEOUT_DELAY:Number = 3;
        private const PLAYER_FADE_DURATION:Number = 0.5;
        private const PLAYER_FADEOUT_DELAY:Number = 4;
        private const POPUP_2D_SCALE:Number = 0.5;
        private const POPUP_TIMEOUT_FADE:Number = 0.7;
        private const VIDEO_BAR_WIDTH_43:Number = 585;
		
		
        public var material_folder_bottom:BitmapFileMaterial;
        private var cameraOldPosition:XYZ;
        private var loader:URLLoader;
        public var isMoving:Boolean = false;
        public var material_folder_top:BitmapFileMaterial;
        public var material_folder_left:BitmapFileMaterial;
        private var cameraSpeed:Number;
        public var material_loading:BitmapMaterial;
		
        public var model2:Collada;
        public var model1:Collada;
        private var image6:Image;
        private var image5:Image;
        private var image4:Image;
        private var image3:Image;
        private var image2:Image;
        private var image1:Image;
		
        private var videoFormat:int;
        private var imageShadow:Image;
        private var depthDifference:int;
        private var shapeLoading:Shape;
        private var lasttime:Number;
        private var videoTimeout:Number;
        public var video:Video;
        private var content:XML;
        public var deltatime:Number;
        public var container2D:Sprite;
        public var shapeBackground:Sprite;
        private var image_background:Image;
        private var buttonStop:SimpleButton;
        public var scene:Scene3D;
        public var viewport:Viewport3D;
        public var renderer:BasicRenderEngine;
        public var material_hot_right:BitmapFileMaterial;
        private var planeShadow:Plane;
        public var isZooming:Boolean = false;
        public var material_box:BitmapFileMaterial;
        public var imageZoomOut:Image;
        public var container3D:Container3D;
        public var depth:int;
        private var planeOpen:Plane;
        private var imagePlay2:Image;
        public var image_page:Image;
        private var shapeStatus:Shape;
        public var material_folder_back:BitmapFileMaterial;
        private var planeClose:Plane;
        private var conainer2DPlayer:Sprite;
        public var material_folder_hot:BitmapFileMaterial;
        private var cameraVelocity:XYZ;
        public var material_folder_right:BitmapFileMaterial;
        private var components:Array;
        public var camera:Camera3D;
        private var popupCurrent:int;
        private var videoDuration:Number;
        private var videoUrl:String;
        public var hover:XYZ;
        private var videoNetStream:NetStream;
        private var loading:Plane;
        private var timer:MTimer;
        public var material_hot_top:BitmapFileMaterial;
        public var hoverScale:Number;
        public var isZoomed:Boolean = false;
        private var buttons:Buttons;
        public var zoomExit:Plane;
        private var imageZoomIn:Image;
        private var videoNetConnection:NetConnection;
        public var material_glow:BitmapFileMaterial;
        private var planePlay:Plane;
        private var buttonPlay:SimpleButton;
        private var componentsActive:Array;
        private var planeZoomIn:Plane;
        public var material_sign:BitmapFileMaterial;
        private var buttonPause:SimpleButton;
        private var videoTarget:DisplayObject3D;
        private var layer:ViewportLayer;
        public static var ROOTPATH:String = "resources/";
        public static const POPUP_NONE:int = 0;
        public static const POPUP_3D_PLAY:int = 7;
        private static const STRUCTURE_STEP_Y:Number = 280;
        public static const STRUCTURE_STEP_Z:Number = 480;
        private static const CAMERA_HOVER_INTENSITY:Number = 1500;
        private static const CAMERA_VIEW_ZOOM:Number = 2;
        private static const CAMERA_ZOOM_ZOOM:Number = 4;
        private static const CAMERA_ZOOM_FOCUS:Number = 100;
        private static const CAMERA_HOVER_SPEED:Number = 1;
        public static const ANIMATION_SHOW_INTERVAL:Number = 0.6;
        private static const CAMERA_HOVER_SCALE:Number = 0.8;
        public static const POPUP_2D_ZOOM_IN:int = 2;
        public static const POPUP_HIDE_DELAY:Number = 1000;
        private static const CAMERA_VIEW_DISTANCE:Number = -1200;
        public static const POPUP_3D_OPEN:int = 5;
        public static const ANIMATION_OPEN_DELAY_ADDTION:Number = 0.5;
        private static const CAMERA_ZOOM_DISTANCE:Number = -100;
        public static const POPUP_2D_PLAY:int = 3;
        public static const POPUP_3D_ZOOM_IN:int = 4;
        public static const POPUP_2D_ZOOM_OUT:int = 1;
        public static const POPUP_3D_CLOSE:int = 6;
        public static const ANIMATION_SHOW_DELAY:Number = 0.1;
        public static const ANIMATION_TIME_ZOOM_HALF:Number = 0.35;
        public static const ANIMATION_OPEN_DELAY:Number = 0.1;
        public static const ANIMATION_TIME_ZOOM:Number = 0.7;
        private static const CAMERA_VIEW_FOCUS:Number = 300;
        public static const ANIMATION_OPEN_INTERVAL:Number = 0.35;
        public static var scale:Number = 1;
        public static var counter:int = 0;
		
        public function Application( )
        {
            Console.log("Application", this);
			if (stage==null)
			{
				this.addEventListener( Event.ADDED_TO_STAGE, init);
			} else 
			{
				init();
			}
          
		}
		//Called when instance is on stage
		public function init( e:Event = null ):void
		{
			Console.log("Stage created and application initated", this);
			this.removeEventListener( Event.ADDED_TO_STAGE, init);
			renderer = new BasicRenderEngine();
			viewport = new Viewport3D(this.stage.stageWidth/2, this.stage.stageHeight/2, true, false, true, true );
			
			viewport.mouseEnabled = true;
			scene = new Scene3D();
		
			layer = new ViewportLayer(viewport, null);
            layer.sortMode = "index";
            viewport.containerSprite.addLayer(layer);
            
			//can only be set once stage is ready
			stage.align = "TL";
            stage.scaleMode = "noScale";
            stage.quality = "medium";
			
			
            timer = new MTimer(30);
            container3D = new Container3D();
            container2D = new Sprite();
            container2D.mouseEnabled = false;
            hover = new XYZ(0, 0, -1200);
            hoverScale = 0.8;
            camera = new Camera3D(40, 2, 300);
            camera.z = (camera.target == null ? (0) : (camera.target.z)) + hover.z;
            cameraOldPosition = new XYZ(camera.x, camera.y, camera.z);
            cameraVelocity = new XYZ(0, 0, 0);
            components = [];
            componentsActive = [];
            depth = 0;
            depthDifference = 0;
            deltatime = 0;
			
            lasttime = getTimer();
            var loaderBitmap:LoaderBitmap = new LoaderBitmap();
            material_loading = new BitmapMaterial(loaderBitmap);
            material_loading.smooth = true;
            material_loading.doubleSided = true;
			
            image_background = new Image("resources/core/background.jpg", true, true);
            image_page = new Image("resources/core/page.jpg", true);
            material_box = new BitmapFileMaterial("resources/core/box.jpg", true);
            material_sign = new BitmapFileMaterial("resources/core/box_sign.png", true);
            material_folder_back = new BitmapFileMaterial("resources/core/folder_back.jpg", false);
            material_folder_top = new BitmapFileMaterial("resources/core/folder_top.jpg", false);
            material_folder_bottom = new BitmapFileMaterial("resources/core/folder_bottom.jpg", false);
            material_folder_left = new BitmapFileMaterial("resources/core/folder_left.jpg", false);
            material_folder_right = new BitmapFileMaterial("resources/core/folder_right.jpg", false);
            material_folder_hot = new BitmapFileMaterial("resources/core/folder_hot.png", true);
            material_hot_top = new BitmapFileMaterial("resources/core/hot_top.jpg", false);
            material_hot_right = new BitmapFileMaterial("resources/core/hot_right.jpg", false);
            material_glow = new BitmapFileMaterial("resources/core/glow.jpg", false);
            var materiallist:* = new MaterialsList();
            material_box.interactive = true;
            material_box.smooth = true;
            materiallist.addMaterial(material_box, "material1");
            model1 = new Collada("resources/core/box1.dae", materiallist, 0.1);
            model2 = new Collada("resources/core/box2.dae", materiallist, 0.1);
            initPopups();
            initVideo();
			
			
			
            loading = new Plane(material_loading, 114, 114);
			
            scene.addChild(loading);
			
			
			var contentURL:URLRequest = new URLRequest(Preferences.server+"/tree.php");
            loader = new URLLoader(contentURL);
			
            loader.addEventListener( Event.COMPLETE, function (event:Event) : void
            {
				Console.log("Content data - loaded:"+contentURL.url, this);
                content = new XML(event.target.data);
                Application.ROOTPATH = content.@root.toString();
                Console.log("ROOTPATH SET TO:" + Application.ROOTPATH, this);
            });
			loader.addEventListener( IOErrorEvent.IO_ERROR, function (event:IOErrorEvent) : void
			{
				Console.log("Error:"+event.text, this);
			});
			
            buttons = new Buttons(this, components, componentsActive);
            zoomExit = new Plane(new ColorMaterial(0xFF0000), 3000, 3000, 1, 1);
			
            viewport.getChildLayer(zoomExit, true, true);
            addChild(image_background);
            addChild(container3D);
            addChild(viewport);
			
			
			shapeBackground = new Sprite();
			shapeBackground.graphics.beginFill(0xffffff, 0.8);
			shapeBackground.graphics.drawRect(0, 0, this.stage.stageWidth, this.stage.stageHeight);
			shapeBackground.graphics.endFill();
			shapeBackground.mouseEnabled = false;
			shapeBackground.mouseChildren = false;
			addChild(shapeBackground);
			
			
			
            this.setBackgroundOverlay(false);
			
            addChild(container2D);
            stage.addEventListener( Event.RESIZE, resizeHandler);
            resizeHandler(null);
			
            this.addEventListener( Event.ENTER_FRAME, loadingHandler);
            renderer.renderScene(scene, camera, viewport);
			
        }
		public function openURL( e:TemplateEvent ):void
		{
			Console.log("openURL:"+e, this);
			this.dispatchEvent( new TemplateEvent(e.type, e.url) );
			
		}

        public function setNextPreviousArrows(bool:Boolean, width:Number = -1) : void
        {
            buttons.setNextPreviousArrows(bool, width);
        }

		public function setChildsDisappearOfDepth(_depth:int) : Number
		{
			var delay:Number = 0;
			for each (var m:Component3D in componentsActive)
			{
				
				if (!(m.depth == _depth && m.isOpen))
				{
					continue;
				}
				delay = m.setAnimationClose();
				break;
			}
			return delay;
		}

        public function onCuePoint(cue:Object) : void
        {
            return;
        }

        private function initApplication() : void
        {
            createComponent([0], null, 0);
            components[0].init();
            setAppear(components[0], 0);
            image_background.addEventListener( MouseEvent.MOUSE_DOWN, buttons.backHandler);
            addEventListener( Event.ENTER_FRAME, enterFrameHandler);
            addChild(buttons);
            resizeHandler(null);
            setCameraDepth(0);
            camera.target = (components[0] as Component3D).displayobject.clone();
        }

		private function enterFrameHandler(e:Event) : void
		{
			var xFactor:Number;
			var yFactor:Number;
			timer.loop();
			deltatime = timer.deltaTime;
			if (hoverScale == 0)
			{
				camera.x = camera.target == null ? (0) : (camera.target.x);
				camera.y = camera.target == null ? (0) : (camera.target.y);
				camera.z = (camera.target == null ? (0) : (camera.target.z)) + hover.z;
				if (isZooming)
				{
					renderer.renderScene(scene, camera, viewport);
				}
			}
			else
			{
				xFactor = container3D.mouseX / (stage.stageWidth / scale >> 1);
				yFactor = container3D.mouseY / (stage.stageHeight / scale >> 1);
				if (xFactor < -0.5)
				{
					xFactor = -0.5;
				}
				else if (xFactor > 0.5)
				{
					xFactor = 0.5;
				}
				if (yFactor < -0.5)
				{
					yFactor = -0.5;
				}
				else if (yFactor > 0.5)
				{
					yFactor = 0.5;
				}
				hover.x = hover.x - (hover.x - 1500 * xFactor) * deltatime * 1;
				hover.y = hover.y - (hover.y - 1500 * (-yFactor)) * deltatime * 1;
				camera.x = (camera.target == null ? (0) : (camera.target.x)) + hover.x * hoverScale;
				camera.y = (camera.target == null ? (0) : (camera.target.y)) + hover.y * hoverScale;
				camera.z = (camera.target == null ? (0) : (camera.target.z)) + hover.z;
				renderer.renderScene(scene, camera, viewport);
			}
			return;
		}

		public function setAnimationZoomIn(component:DisplayObject3D, delay:Number = 0, zoom:Number = 1) : void
		{
			var theDelay:Number=delay;
			var theTarget:DisplayObject3D=component;
			var theZoomFactor:Number=zoom;
			setClickable(false);
			var self = this;;
			Tweener.addTween(camera.target, {delay:theDelay, time:0.7, transition:"easeInOutquad", onStart:function () : void
			{
				isZooming = true;
				stage.quality = "low";
				return;
			}
				, _bezier:{x:theTarget.x, y:theTarget.y}, x:theTarget.x, y:theTarget.y, z:theTarget.z, onComplete:function () : void
				{
					setClickable(true);
					if (!isZoomed)
					{
						scene.addChild(zoomExit);
						zoomExit.container.alpha = 0;
						zoomExit.x = theTarget.x;
						zoomExit.y = theTarget.y;
						zoomExit.z = theTarget.z;
						zoomExit.container.addEventListener( MouseEvent.MOUSE_DOWN, zoomHandler);
						renderer.renderScene(scene, camera, viewport);
					}
					isZooming = false;
					stage.quality = "medium";
					isZoomed = true;
					Console.log("Zoom dispatch", this);
					self.dispatchEvent(new Event("ZOOMIN_COMPLETE"));
				}
			});
			Tweener.addTween(camera, {delay:theDelay, time:0.7, transition:"EaseInOutquad", focus:100, zoom:4});
			Tweener.addTween(hover, {delay:theDelay, time:0.7, transition:"EaseInOutquad", z:-100 * theZoomFactor});
			Tweener.addTween(this, {delay:theDelay, time:0.35, transition:"easeInOutquad", hoverScale:0});
		}

		private function getComponentXML(arr:Array) : XML
		{
			var xml:XML= content;
			var index:int = 0;
			var i:int = 0;
			while (i < arr.length)
			{
				
				index = arr[i];
				xml = xml.child("component")[index];
				i++;
			}
			return xml;
		}

        public function onMetaData(meta:Object) : void
        {
            videoDuration = meta.duration;
        }

        public function videoPlay(e:Event) : void
        {
            if (videoNetStream.time != 0)
            {
                videoNetStream.togglePause();
            }
            else
            {
                videoNetStream.play(videoUrl);
            }
            buttonPlay.visible = false;
            buttonPause.visible = true;
        }

        public function videoPause(e:Event) : void
        {
            videoNetStream.pause();
            buttonPlay.visible = true;
            buttonPause.visible = false;
        }

        public function addVideo(target:DisplayObject3D, url:String, format:int) : void
        {
            videoTarget = target;
            videoUrl = url;
            videoFormat = format;
            video = new Video(640, 360);
            video.smoothing = true;
            video.deblocking = 0;
			switch (videoFormat) 
			{
				case 169:  //16:9 widescreen
					video.height = 384;
					break;
				case 43:	// 4:3 older format
					video.height = 480;
					break;
			}
            buttonPlay.visible = false;
            buttonPause.visible = true;
            conainer2DPlayer.alpha = 1;
            container2D.addChild(video);
            container2D.addChild(conainer2DPlayer);
            videoResize();
            stage.addEventListener( Event.RESIZE, videoResize);
            addEventListener( Event.ENTER_FRAME, videoProgress);
            addEventListener( MouseEvent.MOUSE_MOVE, videoMouseMove);
            video.attachNetStream(videoNetStream);
            videoNetStream.play(videoUrl);
        }

        private function netStatusHandler(event:NetStatusEvent) : void
        {
			
			switch (event.info.code) 
			{
				case "NetConnection.Connect.Success":
					videoNetStream = new NetStream(videoNetConnection);
					videoNetStream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
					videoNetStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
					videoNetStream.client = this;
					videoNetStream.bufferTime = 5;
					video = new Video(640, 480);
					video.smoothing = true;
					video.deblocking = 0;
					break;
				case "NetStream.Play.Stop":
					setClosedOfDepth(depth);
					setAnimationZoomOut();
					break;
			}
        }

        public function loadingHandler(event:Event) : void
        {
			
            timer.loop();
            loading.rotationZ = loading.rotationZ + timer.deltaTimeMillis;
            renderer.renderScene(scene, camera, viewport);
			if (content != null && material_box.loaded && material_sign.loaded && material_folder_back.loaded 
				&& material_folder_top.loaded && material_folder_bottom.loaded && material_folder_left.loaded 
				&& material_folder_right.loaded && material_folder_hot.loaded && material_hot_top.loaded 
				&& material_hot_right.loaded && material_glow.loaded && image_background.loaded && image_page.loaded 
				&& model1.loaded && model2.loaded && arePopupsLoaded() && areVideoImagesLoaded() && buttons.isLoaded())
            {
				Console.log("Scene loaded", this);
                scene.removeChild(loading);
                loading = null;
                removeEventListener( Event.ENTER_FRAME, loadingHandler);
                loader.removeEventListener( Event.COMPLETE, initApplication);
                initApplication();
            }
        }

        public function removeVideo() : void
        {
            video.attachNetStream(null);
            video.clear();
            videoNetStream.close();
            container2D.removeChild(video);
            container2D.removeChild(conainer2DPlayer);
            stage.removeEventListener("resize", videoResize);
            removeEventListener("enterFrame", videoProgress);
        }

        private function initPopups() : void
        {
            popupCurrent = 0;
            imageZoomOut = new Image("resources/core/popup_zoomout.png", true);
            imageZoomIn = new Image("resources/core/popup_zoomin.png", true);
            imagePlay2 = new Image("resources/core/popup_play.png", true);
            imageShadow = new Image("resources/core/popup_shadow.png", false);
            planeZoomIn = new Plane(new BitmapFileMaterial("resources/core/popup_zoomin.png", true), 180, 38);
            planeOpen = new Plane(new BitmapFileMaterial("resources/core/popup_open.png", true), 180, 38);
            planeClose = new Plane(new BitmapFileMaterial("resources/core/popup_close.png", true), 180, 38);
            planePlay = new Plane(new BitmapFileMaterial("resources/core/popup_play.png", true), 180, 38);
            planeShadow = new Plane(new BitmapFileMaterial("resources/core/popup_shadow.png", false), 97, 28);
            viewport.getChildLayer(planeZoomIn, true, true);
            viewport.getChildLayer(planeOpen, true, true);
            viewport.getChildLayer(planeClose, true, true);
            viewport.getChildLayer(planePlay, true, true);
            viewport.getChildLayer(planeShadow, true, true);
        }

		public function setPreparedToClose(component:Component3D, delay:Number) : Number
		{
			var closeDelay:Number = setChildsDisappear(component);
			setCameraDepth((component.index.length - 1));
			setAnimationMove(closeDelay + delay);
			return closeDelay;
		}

		private function createComponentChildren(component:Component3D) : void
		{
			var childrenIndex:Array;
			var comp:Component3D;
			var numberOfChildren:int = getComponentXML(component.index).child("component").length();
			var i:int = 0;
			var j:int = 0;
			component.childs = [];
			while (i < numberOfChildren)
			{
				
				childrenIndex = [];
				j = 0;
				while (j < component.index.length)
				{
					
					childrenIndex.push(component.index[j]);
					j++;
				}
				childrenIndex.push(i);
				comp = createComponent(childrenIndex, component, i);
				component.childs.push(comp);
				i++;
			}
		}

        private function setAppear(component:Component3D, delay:Number) : void
        {
			//Console.log("setAppear "+component, this);
            componentsActive.push(component);
			component.setAnimationAppear(delay);
            Tweener.addTween(this, {time:delay});
			
        }

        public function setAnimationMove(delay:Number) : void
        {	
			var theTime:Number = delay;
            if (depthDifference != 0)
            {
                isMoving = true;
                setClickable(false);
                depthDifference = 0;
                Console.log("getCameraY(): " + getCameraY(), this);
                Tweener.addTween(camera.target, {time:theTime, transition:"easeInOutquad", y:(getCameraY() + depth * (-280)) / 2, z:depth * (-480), onComplete:function () : void
	            {
	                isMoving = false;
	                setClickable(true);
	            }});
            }
        }

        private function setClickable(enable:Boolean) : void
        {
            for each (var m:Component3D in componentsActive)
            {
                
                m.setMouseEnabled(enable);
            }
        }

        private function asyncErrorHandler(e:AsyncErrorEvent) : void
        {
            Console.log("asyncErrorHandler: " + e, this);
        }

        private function arePopupsLoaded() : Boolean
        {
            if (imageZoomOut && imageZoomIn && imagePlay2 && imageShadow && (planeZoomIn.material as BitmapFileMaterial).loaded && (planeOpen.material as BitmapFileMaterial).loaded && (planePlay.material as BitmapFileMaterial).loaded && (planePlay.material as BitmapFileMaterial).loaded && (planeShadow.material as BitmapFileMaterial).loaded)
            {
                return true;
            }
            return false;
        }

        private function areVideoImagesLoaded() : Boolean
        {
            if (image1.loaded && image2.loaded && image3.loaded && image4.loaded && image5.loaded && image6.loaded)
            {
                return true;
            }
            return false;
        }

        private function setChildsAppear(component:Component3D, delay:Number) : void
        {
			//Console.log("setChildsAppear", this);
            for each (var m:Component3D in component.childs)
            {
                setAppear(m, delay);
            }
        }

        public function setAnimationZoomOut() : void
        {
            setClickable(false);
            isZoomed = false;
            scene.removeChild(zoomExit);
            zoomExit.container.removeEventListener( MouseEvent.MOUSE_DOWN, zoomHandler);
            Tweener.addTween(camera.target, {time:0.7, transition:"easeInOutquad", x:0, y:depth * (-280), z:depth * (-480), onComplete:function () : void
            {
                setClickable(true);
            }});
            Tweener.addTween(camera, {time:0.7, transition:"easeInOutquad", focus:300, zoom:2});
            Tweener.addTween(hover, {time:0.7, transition:"easeInOutquad", z:-1200});
            Tweener.addTween(this, {delay:0.35, time:0.35, transition:"easeInOutquad", hoverScale:0.8});
        }

        public function setClosedOfDepth(_depth:int) : void
        {
            for each (var m:Component3D in componentsActive)
            {
                
                if (m.depth != _depth)
                {
                    continue;
                }
                m.setClosed();
            }
        }

        public function setHighResolution(enable:Boolean) : void
        {
            Console.log("set highres", this);
            for each (var m:Component3D in componentsActive)
            {
                
                if (m.type == "image")
                {
                    (m as Component3DImage).setHighResolution(enable);
                    continue;
                }
                if (!(m.type == "text" || m.type == "board" || m.type == "template"))
                {
                    continue;
                }
                (m as Component3DText).setHighResolution(enable);
            }
        }

        public function setPreparedToOpen(component:Component3D, delay:Number) : Number
        {
            var depth:int = setChildsDisappearOfDepth(component.depth);
            setChildsAppear(component, depth);
            setCameraDepth(component.index.length);
            setAnimationMove(depth + delay);
			//Console.log("setPreparedToOpen _depth:" + depth + " depth:" + depth + " delay: " + delay + " component.index: " + component.index, this);
            return depth;
        }

        public function setCameraDepth(_depth:int) : void
        {
            depthDifference = depth - _depth;
            depth = _depth;
        }

		private function videoResize(event:Event = null) : void
		{
			
			var left:Number = (videoTarget.geometry.vertices[2] as Vertex3D).vertex3DInstance.x * scale + container3D.x;
			var top:Number = (videoTarget.geometry.vertices[2] as Vertex3D).vertex3DInstance.y * scale + container3D.y;
			var right:Number = (videoTarget.geometry.vertices[6] as Vertex3D).vertex3DInstance.x * scale + container3D.x;
			var bottom:Number = (videoTarget.geometry.vertices[6] as Vertex3D).vertex3DInstance.y * scale + container3D.y;
			video.x = left;
			video.y = top;
			video.width = right - left;
			video.height = bottom - top;
			conainer2DPlayer.x = Math.round(left + 16 * scale);
			conainer2DPlayer.y = Math.round(bottom - 16 * scale / 5 * 3 - 18 * scale);
			var scaleFactor:Number = scale * 0.45;
			conainer2DPlayer.scaleY = scaleFactor;
			conainer2DPlayer.scaleX = scaleFactor;
			buttonStop.x = buttonPlay.x + buttonPlay.width - 1;
			image4.x = buttonStop.x + buttonStop.width - 1;
			image5.x = image4.x + image4.width - 1;
			if (videoFormat != 169)
			{
				image5.width = 585;
			}
			else
			{
				image5.width = 915;
			}
			image6.x = image5.x + image5.width - 1;
			shapeLoading.x = image5.x;
			shapeLoading.y = 14;
			shapeLoading.width = 1;
			shapeStatus.x = image5.x + 2;
			shapeStatus.y = 16;
		}

        public function videoStop(event:Event) : void
        {
            videoNetStream.pause();
            videoNetStream.seek(0);
            buttonPlay.visible = true;
            buttonPause.visible = false;
        }

        private function initVideo() : void
        {
            image1 = new Image("resources/core/button_play.png", true);
            image2 = new Image("resources/core/button_pause.png", true);
            image3 = new Image("resources/core/button_stop.png", true);
            image4 = new Image("resources/core/button_bar1.png", true);
            image5 = new Image("resources/core/button_bar2.png", true);
            image6 = new Image("resources/core/button_bar3.png", true);
            videoNetConnection = new NetConnection();
            videoNetConnection.addEventListener("netStatus", netStatusHandler);
            videoNetConnection.addEventListener("securityError", securityErrorHandler);
            videoNetConnection.connect(null);
            videoTimeout = 0;
            videoDuration = 1;
            buttonPlay = new SimpleButton(image1, image1, image1, image1);
            buttonPlay.useHandCursor = true;
            buttonPlay.addEventListener("mouseDown", videoPlay);
            buttonPlay.visible = false;
            buttonPause = new SimpleButton(image2, image2, image2, image2);
            buttonPause.useHandCursor = true;
            buttonPause.addEventListener("mouseDown", videoPause);
            buttonStop = new SimpleButton(image3, image3, image3, image3);
            buttonStop.useHandCursor = true;
            buttonStop.addEventListener("mouseDown", videoStop);
            shapeLoading = new Shape();
            shapeLoading.graphics.beginFill(0xA8C1C8);
            shapeLoading.graphics.drawRect(0, 0, 11, 12);
            shapeLoading.graphics.endFill();
            shapeStatus = new Shape();
            shapeStatus.graphics.beginFill(0XF6F7F8);
            shapeStatus.graphics.drawRect(0, 0, 20, 8);
            shapeStatus.graphics.endFill();
            conainer2DPlayer = new Sprite();
            conainer2DPlayer.addChild(buttonPlay);
            conainer2DPlayer.addChild(buttonPause);
            conainer2DPlayer.addChild(buttonStop);
            conainer2DPlayer.addChild(image4);
            conainer2DPlayer.addChild(image5);
            conainer2DPlayer.addChild(image6);
            conainer2DPlayer.addChild(shapeLoading);
            conainer2DPlayer.addChild(shapeStatus);
        }

        public function setBackgroundOverlay(show:Boolean) : void
        {
            Console.log("setBackgroundOverlay " + show, this);
			shapeBackground.alpha = 0;
            shapeBackground.visible = show;
			if (shapeBackground.visible)
			{
				Tweener.addTween(shapeBackground, {alpha:1, time: .5, transition:"easeinoutquad"});
				
			}
        }

		private function createComponent(childindex:Array, component:Component3D, id:Number):Component3D
		{
			var comp:Component3D;
			var xml:XML = getComponentXML(childindex);
			var type:String = xml.@type;
			
			
			// trace("Application.createComponent(): " + type);
			
		
			//Console.log( "Creating Component:" + type +" "+ xml, this);
			switch (type) 
			{
				case "box":
					comp = new Component3DBox(childindex, this, type, id);
					break;
				case "image":
					comp = new Component3DImage(childindex, this, type, xml.attribute("source").indexOf("http://")>=0 ? xml.attribute("source") : ROOTPATH + xml.attribute("source"), id);
					break;
				case "board":
					comp = new Component3DText(childindex, this, type, xml.attribute("source").indexOf("http://")>=0 ? xml.attribute("source") : ROOTPATH + xml.attribute("source"), id, (xml.attribute("data").length() > 0) ? xml.attribute("data") : null);
					break;
				case "text":
					comp = new Component3DText(childindex, this, type, xml.attribute("source").indexOf("http://")>=0 ? xml.attribute("source") : ROOTPATH + xml.attribute("source"), id, (xml.attribute("data").length() > 0) ? xml.attribute("data") : null);
					break;
				case "template":
					comp = new Component3DText(childindex, this, type, xml.attribute("source").indexOf("http://")>=0 ? xml.attribute("source") : ROOTPATH + xml.attribute("source"), id, (xml.attribute("data").length() > 0) ? xml.attribute("data") : null);
					break;
				//All same type
				case "folder":
				case "fresh":
				case "folder2":
				case "hot":
					comp = new Component3DFolder(childindex, this, type, xml.attribute("source").indexOf("http://")>=0 ? xml.attribute("source") : ROOTPATH + xml.attribute("source"), id);
					if (type == "hot")
					{
						(comp as Component3DFolder).isHot = true;
					}
					if (type == "folder2" || type == "hot")
					{
						(comp as Component3DFolder).isImage = true;
					}
					break;
				case "video":
					comp = new Component3DVideo(childindex, this, type, ROOTPATH + xml.source, xml.format, id);
					break;
			}
			comp.parent = component;
			
			//coordinates for visual setup provided by xml
			comp.x = xml.@x;
			comp.y = xml.@y;
			comp.z = xml.@z;
			if (component != null)
			{
				comp.y = comp.y + component.y - STRUCTURE_STEP_Y;
				comp.z = comp.z + component.z - STRUCTURE_STEP_Z;
			}
			components.push(comp);
			createComponentChildren(comp);
			return comp;
		}

        private function setDisappear(component:Component3D, delay:Number) : Number
        {
            componentsActive.splice(componentsActive.indexOf(component), 1);
            return component.setAnimationDisappear(delay);
        }

        private function securityErrorHandler(e:SecurityErrorEvent) : void
        {
            Console.log("securityErrorHandler: " + e, this);
        }

		private function getCameraY() : Number
		{
			var yPos:Number = 0;
			for each (var m:Component3D in componentsActive)
			{
				
				if (m.y >= yPos)
				{
					continue;
				}
				yPos = m.y;
			}
			return yPos / 2;
		}

		public function setPopupVisible(popup_type:int=0, component:DisplayObject3D=null):void
		{
			var scaleFactor:Number;
			var popup_component:*;
			var offsetX:Number;
			var offsetY:Number;
			
			if (!(popupCurrent == POPUP_NONE) || popup_type == POPUP_NONE)
			{
				if (popupCurrent == POPUP_2D_ZOOM_OUT || popupCurrent == POPUP_2D_ZOOM_IN)
				{
					if (imageShadow!=null)
					{
						if (container2D.contains(imageShadow))
						{
							container2D.removeChild(imageShadow);
						}
					}
					
				}
				else 
				{
					if (popupCurrent == POPUP_3D_CLOSE || popupCurrent == POPUP_3D_OPEN || popupCurrent == POPUP_3D_PLAY || popupCurrent == POPUP_3D_ZOOM_IN)
					{
						if (planeShadow!=null)
						{
							scene.removeChild(planeShadow);								
						}

					}
				}
				if (popupCurrent != POPUP_2D_ZOOM_OUT)
				{
					if (popupCurrent != POPUP_2D_ZOOM_IN)
					{
						if (popupCurrent != POPUP_2D_PLAY)
						{
							if (popupCurrent != POPUP_3D_ZOOM_IN)
							{
								if (popupCurrent != POPUP_3D_OPEN)
								{
									if (popupCurrent != POPUP_3D_CLOSE)
									{
										if (popupCurrent == POPUP_3D_PLAY)
										{
											if (planePlay!=null)
											{
												scene.removeChild(planePlay);	
											}
											
										}
									}
									else 
									{
										if (planeClose!=null)
										{
											scene.removeChild(planeClose);
										}
									}
								}
								else 
								{
									if (planeOpen!=null)
									{
										scene.removeChild(planeOpen);
									}
								}
							}
							else 
							{
								if (planeZoomIn)
								{
									scene.removeChild(planeZoomIn);
								}
							}
						}
						else 
						{
							if (imagePlay2)
							{
								container2D.removeChild(imagePlay2);	
							}
							
						}
					}
					else 
					{
						if (imageZoomIn!=null)
						{
							if (container2D.contains(imageZoomIn))
							{
								container2D.removeChild(imageZoomIn);
							}
						}
					}
				}
				else 
				{
					if (imageZoomOut!=null)
					{
						if (container2D.contains(imageZoomOut))
						{
						container2D.removeChild(imageZoomOut);
						}
					}
				}
				popupCurrent = POPUP_NONE;
			}
			
			if (popup_type != POPUP_NONE)
			{
				if (popup_type == POPUP_2D_ZOOM_OUT || popup_type == POPUP_2D_ZOOM_IN || popup_type == POPUP_2D_PLAY)
				{
					
					switch (popup_type) 
					{
						case POPUP_2D_ZOOM_IN:
							//popup_component = imageZoomIn;
							break;
						case POPUP_2D_PLAY:
							popup_component = imagePlay2;
							break;
						case POPUP_2D_ZOOM_OUT:
							//popup_component = imageZoomOut;
							break;
					}
					scaleFactor = scale * POPUP_2D_SCALE;
					offsetX = 0;
					offsetY = 0;
					if (component != null)
					{
						offsetX = component.screen.x * scale;
						offsetY = component.screen.y * scale;
					}
					if (popup_component != null)
					{
						popup_component.scaleX = scaleFactor;
						popup_component.scaleY = scaleFactor;
						popup_component.x = offsetX + container3D.x - popup_component.width / 2;
						popup_component.y = offsetY + container3D.y - popup_component.height / 2;
						imageShadow.scaleY = imageShadow.scaleX = scale;
						imageShadow.x = offsetX + container3D.x - imageShadow.width / 2;
						imageShadow.y = offsetY + container3D.y - imageShadow.height / 2 + 15 * scaleFactor;
						container2D.addChild(imageShadow);
						container2D.addChild(popup_component);
					}
					
				}
				else 
				{
					if (popup_type == POPUP_3D_CLOSE || popup_type == POPUP_3D_OPEN || popup_type == POPUP_3D_PLAY || popup_type == POPUP_3D_ZOOM_IN)
					{
						
						switch (popup_type) 
						{
							case POPUP_3D_ZOOM_IN:
								//popup_component = planeZoomIn;
								break;
							case POPUP_3D_OPEN:
								//popup_component = planeOpen;
								break;
							case POPUP_3D_CLOSE:
								//popup_component = planeClose;
								break;
							case POPUP_3D_PLAY:
								popup_component = planePlay;
								break;
						}
						if (popup_component!=null)
						{
							popup_component.x = component.x;
							popup_component.y = component.y;
							popup_component.z = component.z - 25;
							popup_component.scale = POPUP_3D_SCALE;
							planeShadow.x = component.x;
							planeShadow.y = component.y - 15 * POPUP_3D_SCALE;
							planeShadow.z = component.z - 0.0001;
							planeShadow.scale = POPUP_3D_SCALE * 2;
							scene.addChild(popup_component);
							scene.addChild(planeShadow);
							popup_component.container.mouseEnabled = false;
							planeShadow.container.mouseEnabled = false;
						}
					}
				}
				popupCurrent = popup_type;
			
			}
			
		}


		private function setChildsDisappear(component:Component3D) : Number
		{
			var delayAppear:Number = 0;
			var delayClose:Number = 0;
			for each (var n:Component3D in component.childs)
			{
				
				if (!n.isOpen)
				{
					continue;
				}
				delayClose = n.setAnimationClose();
				break;
			}
			for each (var m:Component3D in component.childs)
			{
				
				delayAppear = setDisappear(m, delayClose);
			}
			return delayAppear;
		}

		public final function videoProgress(e:Event):void
		{
			if (videoTimeout <= PLAYER_FADEOUT_DELAY)
			{
				videoTimeout = videoTimeout + deltatime;
				if (videoTimeout >= PLAYER_FADEOUT_DELAY)
				{
					Tweener.addTween(conainer2DPlayer, {alpha:0, timeå:PLAYER_FADE_DURATION});
				}
			}
			var bytesloaded:Number = videoNetStream.bytesLoaded;
			var bytestotal:Number = videoNetStream.bytesTotal;
			var percentage:Number = bytesloaded / bytestotal;
			var percentageTime:Number = videoNetStream.time / videoDuration;
			switch (videoFormat) 
			{
				case 169: //16:9 - widescreen
					shapeLoading.width = percentage * VIDEO_BAR_WIDTH_169;
					shapeStatus.x = percentageTime * (VIDEO_BAR_WIDTH_169 - 24) + image5.x;
					break;
				case 43: //4:3 - older standards
					shapeLoading.width = percentage * VIDEO_BAR_WIDTH_43;
					shapeStatus.x = percentageTime * (VIDEO_BAR_WIDTH_43 - 24) + image5.x;
					break;
			}
		}

        private function videoMouseMove(event:MouseEvent) : void
        {
            videoTimeout = 0;
            if (conainer2DPlayer.alpha < 1)
            {
                Tweener.removeTweens(conainer2DPlayer);
                Tweener.addTween(conainer2DPlayer, {alpha:1, time:0.5});
            }
        }

        public function zoomHandler(event:Event) : void
        {
            if (!isZooming)
            {
                setClosedOfDepth(depth);
                setHighResolution(false);
                setAnimationZoomOut();
            }
        }

		public function resizeHandler(e:Event=null) : void
		{
			
			//scale = stage.stageHeight / 720;
			var w:Number = 1280;
			var h:Number = 720;
			var scaleFactor:Number = Math.min(1920 / w, 1080/ h);
			scale = scaleFactor
			Console.log("scale:" + scale+" "+scaleFactor, this);
			container3D.resize(scale);
			//TODO:: Review scaling in fullscreen
			image_background.scaleY = image_background.scaleX = .76;
			//image_background.y = (this.stage.stageHeight - image_background.height )/ 2;
			//image_background.x = (this.stage.stageHeight - image_background.height) / 2;
			buttons.resize(scale);
			
		}

    }
}
