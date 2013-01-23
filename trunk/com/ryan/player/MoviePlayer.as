package com.ryan.player
{
	import com.ryan.utils.pools.ObjectPool;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	/**
	 * 影片剪辑播放器
	 * @author xr.zeng
	 */
	public class MoviePlayer extends UrlPlayer
	{
		protected var _movie:MovieClip;
		
		public function MoviePlayer(s:Single)
		{
			super(s);
		}
		
		static public function create():MoviePlayer
		{
			return ObjectPool.getObject(MoviePlayer, Single.instance);
		}
		
		override public function set swf(value:SwfDataVo):void
		{
			super.swf = value;
			removeItem(_movie);
			if (value && value.swf)
			{
				_movie = value.swf;
				_movie.x = _movie.y = 0;
				addChild(_movie);
			}
			else
			{
				_movie = null;
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			removeItem(_movie);
			_movie = null;
		}
		
		override protected function render():void
		{
			if (_swf)
			{
				_swf.gotoFrame(_index);
			}
		}
		
		protected function removeItem(item:DisplayObject):void
		{
			if (item && item.parent == this)
			{
				removeChild(item);
			}
		}
	}
}