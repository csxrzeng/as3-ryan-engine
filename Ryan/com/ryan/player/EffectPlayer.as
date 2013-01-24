package com.ryan.player
{
	import com.ryan.utils.pools.ObjectPool;
	import flash.events.Event;
	import proxy.resource.MediaProxy;
	import proxy.resource.SMedia;
	
	/**
	 * 特效播放器，实体是一个位图。
	 * @author xr.zeng
	 */
	public class EffectPlayer extends BitmapPlayer
	{
		protected var _url:String;
		
		public function EffectPlayer()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		static public function create():EffectPlayer
		{
			return ObjectPool.getObject(EffectPlayer);
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
		
		override public function get swf():SwfDataVo
		{
			return super.swf;
		}
		
		override public function set swf(value:SwfDataVo):void
		{
			super.swf = value;
			super.frameCount = !value ? 1 : value.totalFrames;
			updateNow();
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function set url(value:String):void
		{
			if (_url != value)
			{
				_url = value;
				swf = null;
				if (isPlay)
				{
					loadSwf();
				}
			}
		}
		
		protected function loadSwf():void
		{
			if (!swf && url)
			{
				MediaProxy.Instance().PushArray([url]);
				MediaProxy.Instance().start(onLoadComplete);
			}
		}
		
		protected function onLoadComplete():void
		{
			if (url)
			{
				var media:SMedia = MediaProxy.Instance().load(url);
				if (media)
				{
					swf = media.GetSwfDataVo();
				}
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			_url = null;
		}
	}
}
