package com.ryan.core.frame
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * 毫秒计时帧
	 * @date	2012-12-15
	 * @author xr.zeng
	 */
	internal class MTimerFrame extends Frame
	{
		private var _timer:Timer;
		
		public function MTimerFrame($delay:Number = 1)
		{
			super($delay);
			_timer = new Timer($delay);
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
	}
}
