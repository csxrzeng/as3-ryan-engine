package com.ryan.player
{
	import flash.display.BitmapData;
	
	/**
	 * 表示一个位图数据与位置
	 * @author zxr
	 */
	public class BitAndPos
	{
		public var bit:BitmapData;
		public var x:int;
		public var y:int;
		
		public function BitAndPos(bit:BitmapData = null, x:int = 0, y:int = 0)
		{
			this.bit = bit;
			this.x = x;
			this.y = y;
		}
	}
}
