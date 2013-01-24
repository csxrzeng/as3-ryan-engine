package com.ryan.player
{
	import com.ryan.utils.pools.ObjectPool;
	import flash.events.Event;
	
	/**
	 * 基于MovieClip的效率一般的播放器
	 * @author xr.zeng
	 */
	public class SlowEffectPlayer extends MoviePlayer
	{
		public function SlowEffectPlayer(s:Single)
		{
			super(s);
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		static public function create():SlowEffectPlayer
		{
			return ObjectPool.getObject(SlowEffectPlayer, Single.instance);
		}
		
		override public function set swf(value:SwfDataVo):void
		{
			super.swf = value;
			super.frameCount = !value ? 1 : value.totalFrames; // 设置总帧数的。按需更改，这里只考虑了单方向的
			updateNow();
		}
		
		protected function onAdded(e:Event):void
		{
			loadSwf();
			start();
		}
		
		protected function onRemoved(e:Event):void
		{
			stop();
		}
	}
}