package com.ryan.core.frame
{
	/**
	 * 秒计时器  每秒运行一次
	 * @author xr.zeng
	 */
	public class SecTimer extends BaseTimer
	{
		public function SecTimer(delay:int = 1, repeatCount:int = int.MAX_VALUE)
		{
			super(delay, repeatCount);
		}
		
		override public function start():void
		{
			super.start();
			if (!isTimerQueue)
			{
				isTimerQueue = true;
				FrameManager.timerFrame.addTimer(this);
			}
		}
	}
}