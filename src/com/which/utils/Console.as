package com.which.utils
{
    import com.demonsters.debugger.*;
    import flash.display.*;
    import flash.external.*;

    public class Console extends Object
    {
        private static var simpleSprite:Sprite;

        public function Console()
        {
            return;
        }// end function

        public static function log(message:String, target:*) : void
        {
            if (simpleSprite == null)
            {
                simpleSprite = new Sprite();
                MonsterDebugger.initialize(simpleSprite);
            }
            trace("[" + target + "] " + message);
            if (ExternalInterface.available)
            {
                ExternalInterface.call("console.log", "[" + target + "] " + message.toString());
            }
            MonsterDebugger.trace(target == null ? (simpleSprite) : (target), "[" + target.toString().split(".")[(target.toString().split(".").length - 1)] + "] " + message.toString());
            return;
        }// end function

    }
}
