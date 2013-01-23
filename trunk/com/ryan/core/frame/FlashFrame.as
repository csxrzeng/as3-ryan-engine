package com.ryan.core.frame
{
	import flash.display.Shape;
	import flash.events.Event;
	
	/**
	 * flash帧频计时
	 * @author xr.zeng
	 */
	public class FlashFrame extends Frame
	{
		private var _shape:Shape;
		
		/**
		 * 目前游戏设置为60帧
		 * @param	frameRate
		 */
		public function FlashFrame(frameRate:int = 60)
		{
			super(1000 / frameRate); // 每帧耗时
			_shape = new Shape();
		}
		
		override public function play():void
		{
			super.play();
			_shape.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		override public function stop():void
		{
			super.stop();
			_shape.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
	}
}