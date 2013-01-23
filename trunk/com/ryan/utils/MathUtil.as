package com.ryan.utils
{
	import flash.geom.Point;

	public class MathUtil
	{
		/**
		 * 一弧度的角度数
		 */
		public static const ONE_RADIANS:Number = 180 / Math.PI;
		/**
		 * 一角度的弧度数
		 */
		public static const ONE_ANGLE:Number = Math.PI / 180;

		public function MathUtil()
		{
		}

		/**
		 * 获取p1到p2的弧度
		 * @param p1
		 * @param p2
		 * @return
		 */
		public static function getRadiansByPoint(p1:Point, p2:Point):Number
		{
			return Math.atan2(p2.y - p1.y, p2.x - p1.x);
		}

		/**
		 * 获取两点角度  x1 到 x2的弧度
		 * @param x1
		 * @param y1
		 * @param x2
		 * @param y2
		 * @return
		 */
		public static function getRadiansByXY(x1:int, y1:int, x2:int, y2:int):Number
		{
			return Math.atan2(y2 - y1, x2 - x1);
		}
		
		/**
		 * 获取两点的角度 p1到p2的角度
		 * @param	p1
		 * @param	p2
		 * @return
		 */
		public static function getAngleByPoint(p1:Point, p2:Point):Number
		{
			return getAngle(getRadiansByXY(p1.x, p1.y, p2.x, p2.y));
		}
		
		/**
		 * 获取两点的角度 p1 到 p2的角度
		 * @param	x1
		 * @param	y1
		 * @param	x2
		 * @param	y2
		 * @return
		 */
		public static function getAngleByXY(x1:int, y1:int, x2:int, y2:int):Number
		{
			return getAngle(getRadiansByXY(x1, y1, x2, y2));
		}

		/**
		 * 角度转换成弧度
		 * @param radians
		 * @return
		 */
		public static function getRadians(angle:Number):Number
		{
			return angle * ONE_ANGLE;
		}

		/**
		 * 弧度转换成角度
		 * @param degrees
		 * @return
		 */
		public static function getAngle(radians:Number):Number
		{
			return radians * ONE_RADIANS;
		}

		/**
		 * 获取两点之间的距离
		 * @param x1
		 * @param x2
		 * @param y1
		 * @param y2
		 * @return
		 */
		public static function getDistance(x1:Number, x2:Number, y1:Number, y2:Number):Number
		{
			var x:Number = x2 - x1;
			var y:Number = y2 - y1;
			return Math.sqrt(x * x + y * y);
		}

		/**
		 * 随机 min 到 max 的数
		 * @param min
		 * @param max
		 * @return
		 */
		public static function random(min:int, max:int):int
		{
			var num:int = max - min;
			return Math.round(Math.random() * num) + min;
		}
	}
}
