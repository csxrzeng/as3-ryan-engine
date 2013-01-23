package com.ryan.core.frame
{
	
	/**
	 * 所有帧的管理  也有叫心跳 管理
	 * @author xr.zeng
	 *
	 */
	public class FrameManager
	{
		static private var _flashFrame:IFrame;
		static private var _timerFrame:IFrame;
		static private var _mTimerFrame:IFrame;
		
		public function FrameManager()
		{
		}
		
		static public function get flashFrame():IFrame
		{
			if (_flashFrame == null)
			{
				_flashFrame = new FlashFrame();
			}
			return _flashFrame;
		}
		
		static public function get timerFrame():IFrame
		{
			if (_timerFrame == null)
			{
				_timerFrame = new TimerFrame();
			}
			return _timerFrame;
		}
		
		static public function get mTimerFrame():IFrame
		{
			if (_mTimerFrame == null)
			{
				_mTimerFrame = new MTimerFrame();
			}
			return _mTimerFrame;
		}
	}
}
