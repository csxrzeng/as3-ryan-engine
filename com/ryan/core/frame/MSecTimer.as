package com.ryan.core.frame
{
	/**
	 * 毫秒
	 * @author xr.zeng
	 */
	public class MSecTimer extends BaseTimer
	{
		public function MSecTimer(delay:int = 1, repeatCount:int = int.MAX_VALUE)
		{
			super(delay, repeatCount);
		}
		
		override public function start():void
		{
			super.start();
			if (!isTimerQueue)
			{
				isTimerQueue = true;
				FrameManager.mTimerFrame.addTimer(this);
			}
		}
	}
}