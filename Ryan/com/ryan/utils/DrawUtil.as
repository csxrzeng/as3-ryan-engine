package com.ryan.utils
{
	import com.ryan.player.BitAndPos;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 * 绘图，获取位图数据工具
	 * @author xr.zeng
	 */
	public class DrawUtil
	{
		
		public function DrawUtil()
		{
		}
		
		/**
		 * 绘制一个对象，或者获取位图数据
		 * @param	obj 要绘制的对象
		 * @param	childIndex 子对象的层次，只有子对象是位图的时候有效。
		 * @return
		 */
		static public function getBitAndPos(obj:DisplayObjectContainer, childIndex:int = -1):BitAndPos
		{
			if (obj.numChildren > 0)
			{
				var bmp:Bitmap;
				if (childIndex == -1)
				{
					if (obj.numChildren == 1)
					{
						bmp = obj.getChildAt(0) as Bitmap;
					}
				}
				else if (childIndex < obj.numChildren)
				{
					bmp = obj.getChildAt(childIndex) as Bitmap;
				}
				if (bmp)
				{
					return new BitAndPos(bmp.bitmapData, bmp.x, bmp.y);
				}
				var intRect:Rectangle = getBoundsInt(obj, obj);
				if (intRect.width > 0 && intRect.height > 0)
				{
					var bmd:BitmapData = new BitmapData(intRect.width, intRect.height, true, 0x0);
					bmd.draw(obj, new Matrix(1, 0, 0, 1, -intRect.x, -intRect.y));
					return new BitAndPos(bmd, intRect.x, intRect.y);
				}
			}
			return null;
		}
		
		/**
		 * 获取整数的矩形区域
		 * @param	obj
		 * @return
		 */
		static public function getBoundsInt(obj:DisplayObject, target:DisplayObject):Rectangle
		{
			var rect:Rectangle = obj.getBounds(target);
			if (rect.width > 0 && rect.height > 0)
			{
				var intRect:Rectangle = new Rectangle();
				intRect.x = Math.floor(rect.x);
				intRect.y = Math.floor(rect.y);
				intRect.right = Math.ceil(rect.right);
				intRect.bottom = Math.ceil(rect.bottom);
				return intRect;
			}
			return rect;
		}
		
		/**
		 * 镜像BitmapData
		 * @param	bmd
		 * @return
		 */
		static public function getMirror(bmd:BitmapData):BitmapData
		{
			var result:BitmapData = new BitmapData(bmd.width, bmd.height, bmd.transparent, 0x0);
			var matrix:Matrix = new Matrix(-1, 0, 0, 1, bmd.width, 0);
			result.draw(bmd, matrix);
			return result;
		}
	}
}