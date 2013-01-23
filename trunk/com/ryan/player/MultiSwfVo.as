package com.ryan.player
{
	import flash.display.MovieClip;
	
	/**
	 * 有多个子对象，并且子对象有多帧，自己也可能是多帧
	 * @author xr.zeng
	 */
	public class MultiSwfVo extends SwfDataVo
	{
		
		public function MultiSwfVo(mc:MovieClip)
		{
			super(mc);
		}
		
		/**
		 * 获取总帧数，只遍历一层子对象。原则上要求越深层次的子对象帧数越少
		 * @return
		 */
		override protected function getTotalFrames():int
		{
			var total:int = 0;
			if (_swf)
			{
				total = _swf.totalFrames;
				for (var i:int = 0; i < _swf.numChildren; i++)
				{
					var mc:MovieClip = _swf.getChildAt(i) as MovieClip;
					if (mc)
					{
						total = Math.max(total, mc.totalFrames);
					}
				}
			}
			return total;
		}
		
		override protected function gotoFrameInt(mc:MovieClip, index:int):void
		{
			mc.gotoAndStop(index % mc.totalFrames + 1);
			for (var i:int = 0; i < mc.numChildren; i++)
			{
				var child:MovieClip = mc.getChildAt(i) as MovieClip;
				if (child)
				{
					gotoFrameInt(child, index);
				}
			}
		}
	}
}