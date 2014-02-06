package com.markuslerner.util
{
    import flash.utils.*;

    final public class MTimer extends Object
    {
        public var deltaTimeMillis:Number = 0;
        public var framerate:Number = 0;
        private var deltaTimeLast:Number = 0;
        public var deltaTime:Number = 0;
        private var timeMillisLast:Number = 0;
        private var deltaTimeAveraged:Array;
        private var deltaTimeAveragedSummed:Number = 0;
        private var deltaTimeAveragedPointer:Number = 0;
        private var deltaTimeMin:Number = 0;
        private var deltaTimeMax:Number;

        public function MTimer(param1:Number)
        {
            deltaTimeMin = 0;
            deltaTimeAveraged = [];
            deltaTimeAveragedSummed = 0;
            deltaTimeAveragedPointer = 0;
            timeMillisLast = 0;
            deltaTimeLast = 0;
            deltaTime = 0;
            deltaTimeMillis = 0;
            framerate = 0;
            deltaTimeAveraged = new Array(param1);
            reset();
            return;
        }// end function

		public function reset():void
		{
			var loc1:*;
			
			loc1 = undefined;
			deltaTime = 0;
			deltaTimeLast = 0;
			deltaTimeAveragedSummed = 0;
			loc1 = 0;
			while (loc1 < deltaTimeAveraged.length) 
			{
				deltaTimeAveraged[loc1] = 1 / 60;
				deltaTimeAveragedSummed = deltaTimeAveragedSummed + deltaTimeAveraged[loc1];
				loc1 = (loc1 + 1);
			}
			timeMillisLast = getTimer();
			return;
		}

        public function setMaxDeltaTime(param1:Number) : void
        {
            this.deltaTimeMax = param1;
            return;
        }// end function

        public function loop() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = NaN;
            _loc_1 = getTimer();
            if (_loc_1 >= timeMillisLast)
            {
                deltaTimeMillis = _loc_1 - timeMillisLast;
                deltaTime = deltaTimeMillis / 1000;
                if (deltaTime > deltaTimeMax)
                {
                    if (deltaTimeLast > deltaTimeMax)
                    {
                        deltaTime = deltaTimeMax;
                        deltaTimeMillis = deltaTimeMax * 1000;
                    }
                    else
                    {
                        deltaTime = deltaTimeLast;
                        deltaTimeMillis = deltaTimeLast * 1000;
                    }
                }
                else if (deltaTime < 0)
                {
                    deltaTime = 0;
                    deltaTimeMillis = 0;
                }
                deltaTimeLast = deltaTime;
            }
            else
            {
                deltaTime = deltaTimeLast;
                deltaTimeMillis = deltaTimeLast * 1000;
            }
            calculateAveragedDeltaTime(deltaTime);
            timeMillisLast = _loc_1;
            deltaTime = deltaTimeAveragedSummed / deltaTimeAveraged.length;
            framerate = 1 / deltaTime;
            return;
        }// end function

        public function setMinDeltaTime(param1:Number) : void
        {
            deltaTimeMin = param1;
            return;
        }// end function

        private function calculateAveragedDeltaTime(param1:Number) : void
        {
            var _loc_3:* = undefined;
            var _loc_2:* = undefined;
            (deltaTimeAveragedPointer + 1);
            deltaTimeAveragedPointer = deltaTimeAveragedPointer % deltaTimeAveraged.length;
            deltaTimeAveragedSummed = deltaTimeAveragedSummed - deltaTimeAveraged[deltaTimeAveragedPointer];
            deltaTimeAveraged[deltaTimeAveragedPointer] = param1;
            deltaTimeAveragedSummed = deltaTimeAveragedSummed + param1;
            return;
        }// end function

    }
}
