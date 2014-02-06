package view.portfolio 
{
    import flash.display.*;

    public class Container3D extends Sprite
    {

        public function Container3D()
        {
            return;
        }// end function

        public function resize(param1:Number) : void
        {
            x = stage.stageWidth >> 1;
            y = stage.stageHeight >> 1;
            scaleY = param1;
            scaleX = param1;
            return;
        }// end function

    }
}
