package com.ryan.player
{
	import com.ryan.utils.pools.ObjectPool;
	import flash.display.Bitmap;
	
	/**
	 * 位图序列帧播放器
	 * @author xr.zeng
	 */
	public class FastPlayer extends UrlPlayer
	{
		protected var _bitmap:Bitmap;
		
		public function FastPlayer(s:Single)
		{
			super(s);
			_bitmap = new Bitmap();
			addChild(_bitmap);
		}
		
		static public function create():FastPlayer
		{
			return ObjectPool.getObject(FastPlayer, Single.instance);
		}
		
		override public function dispose():void
		{
			super.dispose();
			_bitmap.bitmapData = null;
		}
		
		override protected function render():void
		{
			if (_swf)
			{
				var bap:BitAndPos = getBap();
			}
			if (bap)
			{
				if (_bitmap.bitmapData != bap.bit)
				{
					_bitmap.bitmapData = bap.bit;
					_bitmap.x = bap.x;
					_bitmap.y = bap.y;
				}
			}
			else if (_bitmap.bitmapData != null)
			{
				_bitmap.bitmapData = null;
			}
		}
		
		protected function getBap():BitAndPos
		{
			return _swf.getBitAndPos(_index);
		}
	}
}