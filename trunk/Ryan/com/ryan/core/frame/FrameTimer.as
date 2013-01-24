package com.ryan.core.frame
{
	/**
	 * frame 计时器  每帧运行一次 最小化的时候会减帧
	 * @author xr.zeng
	 */
	public class FrameTimer extends BaseTimer
	{
		public function FrameTimer(delay:int = 1, repeatCount:int = int.MAX_VALUE)
		{
			super(delay, repeatCount);
		}
		
		override public function start():void
		{
			super.start();
			if (!isTimerQueue)
			{
				isTimerQueue = true;
				FrameManager.flashFrame.addTimer(this);
			}
		}
	}
}