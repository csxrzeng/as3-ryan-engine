package com.ryan.player
{
	import com.ryan.utils.pools.ObjectPool;
	
	/**
	 * 
	 * @author xr.zeng
	 */
	public class SwfPlayer extends BasePlayer
	{
		protected var _swf:SwfDataVo;
		
		public function SwfPlayer(s:Single)
		{
			super(s);
		}
		
		static public function create():SwfPlayer
		{
			return ObjectPool.getObject(SwfPlayer, Single.instance);
		}
		
		public function get swf():SwfDataVo
		{
			return _swf;
		}
		
		public function set swf(value:SwfDataVo):void
		{
			_swf = value;
			reset();
		}
		
		override public function dispose():void
		{
			super.dispose();
			_swf = null;
		}
	}
}