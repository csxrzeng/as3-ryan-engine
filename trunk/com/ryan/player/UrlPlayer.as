package com.ryan.player
{
	import com.ryan.utils.pools.ObjectPool;
	import proxy.resource.MediaProxy;
	import proxy.resource.SMedia;
	
	/**
	 * 可以设置url的播放器，需要根据不同的架构修改不同的加载方式
	 * @author xr.zeng
	 */
	public class UrlPlayer extends SwfPlayer
	{
		protected var _url:String;
		protected var _autoStart:Boolean = false;
		
		public function UrlPlayer(s:Single)
		{
			super(s);
		}
		
		static public function create():UrlPlayer
		{
			return ObjectPool.getObject(UrlPlayer, Single.instance);
		}
		
		override public function start():void 
		{
			if (swf)
			{
				super.start();
			}
			else
			{
				_autoStart = true;
			}
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
				if (stage)
				{
					loadSwf();
				}
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			_url = null;
			_autoStart = false;
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
					if (_autoStart)
					{
						_autoStart = false;
						start();
					}
				}
			}
		}
	}
}