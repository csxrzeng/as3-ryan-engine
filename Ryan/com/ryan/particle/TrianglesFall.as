package com.ryan.particle
{
	import com.ryan.core.IDispose;
	import com.ryan.utils.pools.ObjectPool;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * 切块坠落粒子效果
	 * 用法：
	 * 	var rt = ObjectPool.getObject(TrianglesFall); // 从对象池获取对象
		rt.onComplete = completeHandler; // completeHandler(tf:TrianglesFall);
		rt.start(bmd);
		private function completeHandler(tf:TrianglesFall):void
		{
			if (tf.parent == this)
			{
				removeChild(tf);
				tf.dispose();
				ObjectPool.disposeObject(tf, TrianglesFall); // 归还对象池
			}
		}
	 * @author 曾宪荣
	 */
	public class TrianglesFall extends Sprite implements IDispose
	{
		static private var vPinto:Array = [0.3086, 0.6094, 0.0820, 0, 0, 
											0.3086, 0.6094, 0.0820, 0, 0, 
											0.3086, 0.6094, 0.0820, 0, 0, 
											0, 0, 0, 1, 0];
		private var srcBmd:BitmapData;
		private var size:int = 30;
		private var range:int = 20; // +-
		private var rect:Rectangle;
		private var pointMap:Vector.<Vector.<Point>>;
		private var triangles:Vector.<Particle> = new Vector.<Particle>();
		private var o:Sprite;
		private var totalCount:int;
		private var completeCount:int = 0;
		private var center:Point;
		/**
		 * 完成回调，参数为this
		 */
		public var onComplete:Function;
		
		public function TrianglesFall() 
		{
			super();
		}
		
		
		public function start(bmd:BitmapData):void 
		{
			dispose(); // 先清空
			filters = [new ColorMatrixFilter(vPinto)]; // 设置滤镜
			srcBmd = bmd;
			rect = new Rectangle(0, 0, bmd.width, bmd.height);// srcBmd.getColorBoundsRect(0xffffffff, 0x0, false);
			center = new Point(rect.x + int(rect.width >> 1), rect.y + int(rect.height >> 1));
			generatePoints();
			//drawPoints();
			drawTriangles();
			//graphics.lineStyle(1, 0xff0000);
			//graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			doStart();
		}
		
		/* INTERFACE com.ryan.core.IDispose */
		
		public function dispose():void 
		{
			while (numChildren > 0)
			{
				var p:Particle = removeChildAt(0) as Particle;
				if (p)
				{
					p.dispose();
					ObjectPool.disposeObject(p, Particle);
				}
			}
		}
		
		private function doStart():void
		{
			completeCount = 0;
			totalCount = triangles.length;
			for (var i:int = 0; i < totalCount; ++i) 
			{
				triangles[i].start();
			}
			triangles.length = 0; // 只是临时用的变量，清空
		}
		
		private function drawTriangles():void 
		{
			var len:int = pointMap.length;
			for (var i:int = 1; i < len; ++i)
			{
				var line0:Vector.<Point> = pointMap[i - 1];
				var line1:Vector.<Point> = pointMap[i];
				var len0:int = line0.length;
				var len1:int = line1.length;
				var j:int;
				for (j = 1; j < len0; ++j)
				{
					drawTriangle(line0[j - 1], line0[j], line1[j <= len1 ? j - 1 : len1 - 1]);
				}
				for (j = 1; j < len1; ++j)
				{
					drawTriangle(line0[j < len0 ? j : len0 - 1], line1[j - 1], line1[j]);
				}
			}
		}
		
		private function drawTriangle(p0:Point, p1:Point, p2:Point):void
		{
			if (p0.x == p1.x && p1.x == p2.x) // 不构成3角形
			{
				return;
			}
			if (p0.y == p1.y && p1.y == p2.y)
			{
				return;
			}
			var triangle:Particle = ObjectPool.getObject(Particle);
			//triangle.graphics.lineStyle(1, 0xff0000);
			triangle.graphics.beginBitmapFill(srcBmd, null, false, false);
			triangle.graphics.moveTo(p0.x, p0.y);
			triangle.graphics.lineTo(p1.x, p1.y);
			triangle.graphics.lineTo(p2.x, p2.y);
			triangle.graphics.lineTo(p0.x, p0.y);
			triangle.graphics.endFill();
			triangles.push(triangle);
			triangle.onComplete = onParticleComplete;
			var centerX:int = (p0.x + p1.x + p2.x) /3;
			var centerY:int = (p0.y + p1.y + p2.y) / 3;
			triangle.x += centerX - center.x >> 5;
			triangle.y += centerY - center.y >> 5;
			triangle.delay = Math.max(0, (rect.bottom + size - centerY) / 5);
			triangle.targetX = triangle.x;
			triangle.targetY = rect.bottom + size - centerY;
			triangle.targetAlpha = 0;
			triangle.totalFrame = Math.max(1, (rect.bottom + size - centerY) / 5);
			addChild(triangle);
		}
		
		private function onParticleComplete(p:Particle):void 
		{
			completeCount++;
			if (p.parent == this)
			{
				removeChild(p);
				p.dispose();
				ObjectPool.disposeObject(p, Particle);
			}
			if (completeCount >= totalCount)
			{
				onComplete && onComplete(this);
			}
		}
		
		private function drawPoints():void 
		{
			graphics.clear();
			graphics.beginFill(0xff0000, 1);
			var len:int = pointMap.length;
			for (var i:int = 0; i < len; ++i)
			{
				var line:Vector.<Point> = pointMap[i];
				var column:int = line.length;
				for (var j:int = 0; j < column; ++j) 
				{
					var p:Point = line[j];
					graphics.drawCircle(p.x, p.y, 2);
				}
			}
			graphics.endFill();
		}
		
		private function generatePoints():void
		{
			pointMap = new Vector.<Vector.<Point>>();
			var bottom:int = rect.height;
			for (var i:int = 0; i < bottom; i += size)
			{
				var rowLock:Boolean = i == 0;
				if (i >= rect.height - size)
				{
					i = rect.height;
					rowLock = true;
				}
				var row:int = rect.y + i;
				var right:int = rect.width;
				var line:Vector.<Point> = new Vector.<Point>();
				pointMap.push(line);
				for (var j:int = 0; j < right; j += randSize)
				{
					var column:int = rect.x + j;
					line.push(new Point(column, rowLock ? row : row + Math.random() * range));
				}
				line.push(new Point(right, rowLock ? row : row + Math.random() * range));
				if (i >= rect.height)
				{
					break;
				}
			}
		}
		
		private function get randSize():int
		{
			return Math.random() * range + size;
		}
	}

}