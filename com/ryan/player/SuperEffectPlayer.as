package com.ryan.player
{
	import com.ryan.core.frame.FrameTimer;
	import com.ryan.utils.pools.ObjectPool;
	import flash.display.Bitmap;
	
	/**
	 * 位图序列帧播放器，按跳帧来播放
	 * @author xr.zeng
	 */
	public class SuperEffectPlayer extends FastEffectPlayer
	{
		protected var _interval:int = 2; // 默认24帧就按12帧来播放
		
		public function SuperEffectPlayer(s:Single)
		{
			super(s);
		}
		
		static public function create():SuperEffectPlayer
		{
			return ObjectPool.getObject(SuperEffectPlayer, Single.instance);
		}
		
		public function get interval():int 
		{
			return _interval;
		}
		
		public function set interval(value:int):void 
		{
			_interval = value;
		}
		
		override public function set swf(value:SwfDataVo):void 
		{
			super.swf = value;
			super.frameCount = !value ? 1 : int(value.totalFrames / _interval);
		}
		
		override public function dispose():void
		{
			super.dispose();
			_interval = 2;
		}
		
		override protected function getBap():BitAndPos 
		{
			return _swf.getBitAndPos(_index * _interval);
		}
	}
}