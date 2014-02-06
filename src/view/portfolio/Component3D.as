package view.portfolio 
{
    import com.which.utils.*;
    
    import flash.events.*;
    
    import org.papervision3d.objects.*;
    import view.portfolio.Component3D;

    public class Component3D extends Object
    {
        public var main:Application;
        public var depth:int;
        public var _displayobject:DisplayObject3D;
        public var type:String;
        public var index:Array;
        public var isOpen:Boolean;
        public var childs:Array;
        public var ID:Number;
        public var parent:Component3D;
        public var inited:Boolean;
        public var x:Number;
        public var y:Number;
        public var z:Number;
        public var loadingIndex:Number = 0;

        public function Component3D(childIndex:Array, application:Application, type:String, id:Number)
        {
            loadingIndex = 0;
            main = application;
            index = childIndex;
            depth = index.length - 1;
            this.type = type;
            isOpen = false;
            inited = false;
            ID = id;
        }

        public function set displayobject(_displayobject:DisplayObject3D) : void
        {
            this._displayobject = _displayobject;
            main.viewport.getChildLayer(this._displayobject, true, true);
        }

        public function get displayobject() : DisplayObject3D
        {
            return this._displayobject;
        }

        public function setAnimationOpen() : Number
        {
            return 0;
        }

        public function toStringType() : String
        {
            return "Component, type: " + type + ", ID: " + ID + ", childs: [" + childs.length + "], index: " + index + ", position: " + x + ", " + y + ", " + z;
        }

        public function init() : void
        {
        }

        public function rolloverHandler(e:MouseEvent) : void
        {
        }

        public function isLoaded() : Boolean
        {
            return true;
        }

        public function rolloutHandler(e:MouseEvent) : void
        {
        }

        public function setAnimationClose() : Number
        {
            return 0;
        }

        public function setAnimationDisappear(delay:Number = 0) : Number
        {
            return 0;
        }

		public function releaseHandler(e:Event=null):void
		{
			Console.log("releaseHandler", this);
			if (isOpen) 
			{
				setAnimationClose();
			} else
			{
				setAnimationOpen();
			}
		}


        public function setClosed() : void
        {
            isOpen = false;
        }

        public function setMouseEnabled(enable:Boolean) : void
        {
            if (displayobject.container)
            {
                displayobject.container.mouseEnabled = enable;
                displayobject.container.buttonMode = enable;
            }
        }

        public function loadingHandler(e:Event) : void
        {
        }

        public function setAnimationAppear(delay:Number = 0) : Number
        {
            return 0;
        }

        public function setMouseListener(enable:Boolean) : void
        {
           // Console.log("setMouseListener " + enable + " > displayobject:" + displayobject + " > displayobject.container:" + displayobject.container, this);
            if (displayobject.container)
            {
                if (enable)
                {
                    Console.log("event listeners added", this);
					displayobject.container.addEventListener(MouseEvent.MOUSE_UP, releaseHandler);
                  	displayobject.container.addEventListener(MouseEvent.ROLL_OVER, rolloverHandler);
                  	displayobject.container.addEventListener(MouseEvent.ROLL_OUT, rolloutHandler);
                }
                else
                {
					Console.log("event listeners removed", this);
                    displayobject.container.removeEventListener(MouseEvent.MOUSE_UP, releaseHandler);
                    displayobject.container.removeEventListener(MouseEvent.ROLL_OVER, rolloverHandler);
                    displayobject.container.removeEventListener(MouseEvent.ROLL_OUT, rolloutHandler);
                }
            }
        }

		public function getNextComponent(modula:Boolean = false) : Component3D
		{
			var i:int = findNextIndex();
			if (i != -1)
			{
				return this.parent.childs[i];
			}
			if (modula)
			{
				return this.parent.childs[0];
			}
			return null;
		}

		public function getPreviousComponent(modula:Boolean = false) : Component3D
		{
			var i:int = findPreviousIndex();
			if (i != -1)
			{
				return this.parent.childs[i];
			}
			if (modula)
			{
				return this.parent.childs[this.parent.childs.length-1];
			}
			return null;
		}

        protected function findNextIndex() : int
        {
            return findIndexOffset(1);
        }

        protected function findPreviousIndex() : int
        {
            return findIndexOffset(-1);
        }

		protected function findIndexOffset(offset:int) : int
		{
			var i:int = 0;
			var index:int = -1;
			while (i < this.parent.childs.length)
			{
				
				if (this.parent.childs[i] == this)
				{
					index = i;
					if (this.parent.childs.length > index + offset && offset > 0 || index + offset >= 0 && offset <= 0)
					{
						return index + offset;
					}
				}
				i++;
			}
			return -1;
		}

    }
}
