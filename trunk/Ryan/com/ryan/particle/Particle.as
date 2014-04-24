package com.ryan.particle
{
	import com.ryan.core.frame.FrameTimer;
	import com.ryan.core.frame.TimerType;
	import com.ryan.core.IDispose;
	import com.ryan.utils.pools.ObjectPool;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 曾宪荣
	 */
	public class Particle extends Sprite implements IDispose
	{
		public var delay:int;
		public var onComplete:Function;
		public var targetX:Number;
		public var targetY:Number;
		public var targetAlpha:Number;
		public var totalFrame:int;
		private var srcX:Number;
		private var srcY:Number;
		private var srcAlpha:Number;
		private var timer:FrameTimer;
		
		public function Particle() 
		{
			super();
		}
		
		//public function reset():void
		//{
			//isNaN(srcX) || (x = srcX);
			//isNaN(srcY) || (y = srcY);
			//isNaN(srcAlpha) || (alpha = srcAlpha);
		//}
		
		public function start():void 
		{
			if (!timer)
			{
				srcX = x;
				srcY = y;
				srcAlpha = alpha;
				isNaN(targetX) && (targetX = x);
				isNaN(targetY) && (targetY = y);
				isNaN(targetAlpha) && (targetAlpha = alpha);
				timer = ObjectPool.getObject(FrameTimer);
				timer.delay = 1;
				timer.addListener(TimerType.ENTERFRAME, onEnterFrame);
				timer.start();
			}
		}
		
		public function stop():void
		{
			x = targetX;
			y = targetY;
			alpha = targetAlpha;
			if (timer)
			{
				timer.stop();
				timer.dispose();
				timer = null;
				onComplete && onComplete(this);
			}
		}
		
		/* INTERFACE com.ryan.core.IDispose */
		
		public function dispose():void 
		{
			graphics.clear();
			x = 0;
			y = 0;
			alpha = 1;
			delay = 0;
			onComplete = null;
			targetX = NaN;
			targetY = NaN;
			targetAlpha = NaN;
			totalFrame = 0;
			srcX = NaN;
			srcY = NaN;
			srcAlpha = NaN;
			if (timer)
			{
				timer.stop();
				timer.dispose();
				ObjectPool.disposeObject(timer, FrameTimer);
				timer = null;
			}
		}
		
		private function onEnterFrame(t:FrameTimer):void 
		{
			if (t.currentCount > delay)
			{
				var frame:int = t.currentCount - delay;
				if (frame > totalFrame)
				{
					stop();
					return;
				}
				var ratio:Number = frame / totalFrame;
				x = srcX + (targetX - srcX) * ratio;
				y = srcY + (targetY - srcY) * ratio;
				alpha = srcAlpha + (targetAlpha - srcAlpha) * ratio;
			}
		}
	}
}