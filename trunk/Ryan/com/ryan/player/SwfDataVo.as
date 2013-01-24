package com.ryan.player
{
	import com.ryan.utils.DrawUtil;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	/**
	 * 缓存一个swf，外部根据帧标签与序列来获取BitmapData与x,y
	 * @author zxr
	 */
	public class SwfDataVo
	{
		protected var _swf:MovieClip;
		protected var _count:int = 0; // 已经draw过的帧数
		protected var _totalFrames:int = 0;
		protected var _dic:Dictionary = new Dictionary;
		
		public function SwfDataVo(mc:MovieClip)
		{
			this.swf = mc;
		}
		
		public function get swf():MovieClip
		{
			return _swf;
		}
		
		public function set swf(value:MovieClip):void
		{
			_swf = value;
			_totalFrames = getTotalFrames();
		}
		
		public function get dic():Dictionary
		{
			return _dic;
		}
		
		public function set dic(value:Dictionary):void
		{
			_dic = value;
		}
		
		public function get totalFrames():int
		{
			return _totalFrames;
		}
		
		public function set totalFrames(value:int):void
		{
			_totalFrames = value;
		}
		
		public function getFrameBap(index:int):BitAndPos
		{
			return getBitAndPos(index);
		}
		
		public function getChildBap(childIndex:int):BitAndPos
		{
			return getBitAndPos(0, childIndex);
		}
		
		/**
		 * 获取某帧的指定子对象的位图数据
		 * @param	index 从0开始的帧索引
		 * @param	childIndex 子对象的索引，-1表示如果是所有子对象
		 * @return BitmapData与x,y
		 */
		public function getBitAndPos(index:int, childIndex:int = -1):BitAndPos
		{
			var bap:BitAndPos;
			if (_dic[index] == null)
			{
				if (gotoFrame(index))
				{
					bap = DrawUtil.getBitAndPos(_swf, childIndex);
					if (bap)
					{
						_dic[index] = bap;
						return bap;
					}
				}
				_dic[index] = true; // 已经读取过
			}
			return _dic[index] as BitAndPos;
		}
		
		/**
		 * 跳转到指定帧
		 * @param	index 从0开始的索引
		 * @return	是否成功，true成功，false失败
		 */
		public function gotoFrame(index:int):Boolean
		{
			if (index < totalFrames)
			{
				gotoFrameInt(_swf, index);
				return true;
			}
			return false;
		}
		
		protected function getTotalFrames():int
		{
			return _swf ? swf.totalFrames : 1;
		}
		
		protected function gotoFrameInt(mc:MovieClip, index:int):void
		{
			mc.gotoAndStop(index + 1);
		}
	}
}