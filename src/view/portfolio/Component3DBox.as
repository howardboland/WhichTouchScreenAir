package view.portfolio 
{
    import view.portfolio.Component3DBox;
    import caurina.transitions.*;
    import com.which.utils.*;
    import flash.events.*;
    import org.papervision3d.materials.utils.*;
    import org.papervision3d.objects.*;
    import org.papervision3d.objects.parsers.*;
    import org.papervision3d.objects.primitives.*;

    public class Component3DBox extends Component3D
    {
        private var glow:Plane;
        private var OPEN_INTERVAL:Number;
        private var model2:Collada;
        private var OPEN_DELAY:Number;
        private var loading:Plane;
        private var sign:Plane;
        private var currentChildLoadingIndex:Number = 0;

        public function Component3DBox(childIndex:Array, application:Application, type:String, id:Number)
        {
            currentChildLoadingIndex = 0;
            super(childIndex, application, type, id);
        }

        override public function init() : void
        {
            Console.log("init", this);
            var materialList:MaterialsList = new MaterialsList();
			materialList.addMaterial(main.material_box, "material1");
			
            OPEN_DELAY = childs.length * 0.1 + 0.5;
            OPEN_INTERVAL = 0.35;
            displayobject = main.model1 as DisplayObject3D;
            model2 = main.model2;
			
            sign = new Plane(main.material_sign, 114, 128);
            glow = new Plane(main.material_glow, 800, 800, 2, 2);
            loading = new Plane(main.material_loading, 114, 114);
			main.viewport.getChildLayer(sign, true, true);
            main.viewport.getChildLayer(glow, true, true);
            main.viewport.getChildLayer(loading, true, true);
            inited = true;
        }

        override public function setAnimationOpen() : Number
        {
            Console.log("setAnimationOpen", this);
            main.setPreparedToOpen(this, OPEN_DELAY);
            main.scene.addChild(glow);
            glow.container.mouseEnabled = false;
            glow.container.blendMode = "screen";
            glow.container.alpha = 0;
            glow.z = -0.1;
            main.addEventListener( Event.ENTER_FRAME, glowHandler);
            Tweener.addTween(glow.container, {time:OPEN_INTERVAL, transition:"easeoutquad", alpha:1});
            Tweener.addTween(displayobject, {time:OPEN_INTERVAL, transition:"easeinoutquad", z:z - 120});
            Tweener.addTween(sign, {time:OPEN_INTERVAL, transition:"easeinoutquad", z:z - 160});
            isOpen = true;
            return OPEN_INTERVAL;
        }
        override public function rolloverHandler(e:MouseEvent) : void
        {
            Console.log("rolloverHandler", this);
			if (isOpen)
			{
					main.setPopupVisible(Application.POPUP_3D_CLOSE, displayobject);
			} else 
			{
				    main.setPopupVisible(Application.POPUP_3D_OPEN, displayobject);
			}
        }

        override public function setAnimationClose() : Number
        {
            Console.log("setAnimationClose", this);
            var myDelay:* = main.setPreparedToClose(this, OPEN_INTERVAL);
            Tweener.addTween(glow.container, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeinquad", alpha:0, onComplete:function () : void
            {
                main.removeEventListener( Event.ENTER_FRAME, glowHandler);
                main.scene.removeChild(glow);
            }
            });
            Tweener.addTween(displayobject, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeinoutquad", z:-0.001});
            Tweener.addTween(sign, {delay:myDelay, time:OPEN_INTERVAL, transition:"easeinoutquad", z:-40});
            isOpen = false;
            return myDelay + OPEN_INTERVAL;
        }

        override public function rolloutHandler(e:MouseEvent) : void
        {
            Console.log("rolloutHandler", this);
            main.setPopupVisible();
        }

        override public function loadingHandler(e:Event) : void
        {
            Console.log("loadingHandler", this);
			Console.log("childs[currentChildLoadingIndex].isLoaded()"+childs[currentChildLoadingIndex].isLoaded(), this);
			
            var isLoaded:Boolean = false;
            loading.rotationZ = loading.rotationZ + main.deltatime * 1000;
            if (childs[currentChildLoadingIndex].isLoaded() && currentChildLoadingIndex < (childs.length - 1))
            {
				currentChildLoadingIndex = (currentChildLoadingIndex + 1);
                childs[currentChildLoadingIndex].init();
            }
			isLoaded = false;
            if ( currentChildLoadingIndex == (childs.length - 1) && childs[currentChildLoadingIndex].isLoaded() )
            {
				isLoaded = true;
            }
            if (isLoaded)
            {
                Console.log("Add Listeners", this);
                main.removeEventListener( Event.ENTER_FRAME, loadingHandler);
                main.scene.removeChild(loading);
                loading = null;
                setMouseListener(true);
                setMouseEnabled(true);
				//releaseHandler();
            }
        }
		
        override public function setAnimationAppear(delay:Number = 0) : Number
        {
            Console.log("setAnimationAppear", this);
            main.scene.addChild(model2);
            main.scene.addChild(displayobject);
            Console.log("model2: " + model2 + " container: " + model2.container, this);
            main.scene.addChild(sign);
            model2.x = x;
            model2.y = y;
            model2.z = z;
            displayobject.x = x;
            displayobject.y = y;
            displayobject.z = z - 0.001;
            sign.x = x + 97;
            sign.y = y + 195;
            sign.z = z - 40;
            loading.x = displayobject.x;
            loading.y = displayobject.y;
            loading.z = displayobject.z - 20;
            main.scene.addChild(loading);
            childs[currentChildLoadingIndex].init();
            main.addEventListener( Event.ENTER_FRAME, loadingHandler);
            return 0;
        }

        private function glowHandler(event:Event) : void
        {
            glow.rotationZ = glow.rotationZ + main.deltatime * 5;
        }
    }
}
