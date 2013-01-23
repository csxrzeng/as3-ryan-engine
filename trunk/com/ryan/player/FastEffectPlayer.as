package com.ryan.player
{
	import com.ryan.utils.pools.ObjectPool;
	import flash.events.Event;
	
	/**
	 * 基于位图序列帧方式的效率比较高的播放器
	 * @author xr.zeng
	 */
	public class FastEffectPlayer extends FastPlayer
	{
		public function FastEffectPlayer(s:Single)
		{
			super(s);
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		static public function create():FastEffectPlayer
		{
			return ObjectPool.getObject(FastEffectPlayer, Single.instance);
		}
		
		override public function set swf(value:SwfDataVo):void
		{
			super.swf = value;
			super.frameCount = !value ? 1 : value.totalFrames;
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