package com.ryan.core.frame
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * timer 时间计时帧  默认每 1秒一帧
	 * @author xr.zeng
	 */
	internal class TimerFrame extends Frame
	{
		static private const DELAY_CONST:int = 100;
		private var _timer:Timer;
		
		public function TimerFrame(delay:int = 1)
		{
			super(delay * 1000);
			_timer = new Timer(DELAY_CONST);
		}
		
		override public function play():void
		{
			super.play();
			_timer.addEventListener(TimerEvent.TIMER, onEnterFrameHandler);
			_timer.start();
		}
		
		override public function stop():void
		{
			super.stop();
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, onEnterFrameHandler);
		}
		
		override protected function renderer(expectFrame:int):void 
		{
			// 保证帧数
			for (var i:int = _frameCount + 1; i <= expectFrame; i++) 
			{
				renderOneDelay(i, i);
				renderMultiDelay(i, i);
			}
		}
	}
}