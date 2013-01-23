package com.ryan.player
{
	import com.ryan.core.frame.FrameTimer;
	import com.ryan.core.frame.TimerType;
	import com.ryan.player.BitAndPos;
	import com.ryan.player.IBasePlayer;
	import com.ryan.player.SwfDataVo;
	import com.ryan.utils.pools.ObjectPool;
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	/**
	 * 位图播放器，自身是一个位图
	 */
	public class BitmapPlayer extends Bitmap implements IBasePlayer
	{
		protected var _baseX:Number = 0;
		protected var _baseY:Number = 0;
		protected var _delay:Number = 1;
		protected var _frame:FrameTimer;
		protected var _frameCount:int = 1;
		protected var _index:int = 0;
		protected var _isPlayOnce:Boolean = false;
		protected var _swf:SwfDataVo;
		public var onPlayComplete:Function; // 播放完成的回调，只当isPlayOnce为true的时候有效 function(swfplayer):void
		
		public function BitmapPlayer()
		{
			_frame = new FrameTimer(1);
			reset();
		}
		
		static public function create():BitmapPlayer
		{
			return ObjectPool.getObject(BitmapPlayer);
		}
		
		override public function get x():Number
		{
			return _baseX;
		}
		
		override public function set x(value:Number):void
		{
			move(value, _baseY);
		}
		
		override public function get y():Number
		{
			return _baseY;
		}
		
		override public function set y(value:Number):void
		{
			move(_baseX, value);
		}
		
		public function moveToPoint(p:Point):void
		{
			move(p.x, p.y);
		}
		
		public function move(x:Number, y:Number):void
		{
			super.x = super.x - _baseX + x;
			super.y = super.y - _baseY + y;
			_baseX = x;
			_baseY = y;
		}
		
		public function get isPlay():Boolean
		{
			return _frame.running;
		}
		
		public function start():void
		{
			if (!isPlay)
			{
				_frame.start();
				render(); // 开始播放，强制渲染
			}
		}
		
		public function stop():void
		{
			if (isPlay)
			{
				_frame.stop();
			}
		}
		
		public function reset():void
		{
			_frame.reset();
			_frame.addListener(TimerType.ENTERFRAME, onEnterFrame);
			_index = 0;
		}
		
		public function dispose():void
		{
			stop();
			_baseX = 0;
			_baseY = 0;
			_delay = 1;
			_swf = null;
			_frame.dispose();
			_frameCount = 1;
			_index = 0;
			_isPlayOnce = false;
			onPlayComplete = null;
			ObjectPool.disposeObject(this);
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
		
		public function get frameCount():int
		{
			return _frameCount;
		}
		
		public function set frameCount(value:int):void
		{
			_frameCount = value;
		}
		
		public function get delay():Number
		{
			return _delay;
		}
		
		public function set delay(value:Number):void
		{
			_delay = value;
		}
		
		public function get isPlayOnce():Boolean
		{
			return _isPlayOnce;
		}
		
		public function set isPlayOnce(value:Boolean):void
		{
			_isPlayOnce = value;
		}
		
		public function updateNow():void
		{
			render();
		}
		
		protected function onEnterFrame(timer:FrameTimer):void
		{
			var index:int = int(timer.currentCount / _delay);
			if (_index != index)
			{
				_index = index;
				if (_isPlayOnce && _index >= _frameCount)
				{
					stop();
					_frame.dispose(); // 只播放一次，播放完成销毁定时器
					if (onPlayComplete != null)
					{
						onPlayComplete(this); // 播放完成回调
					}
					if (this.parent)
					{
						this.parent.removeChild(this);
					}
				}
				else
				{
					_index = _index % _frameCount;
					render();
				}
			}
		}
		
		private function render():void
		{
			if (_swf)
			{
				var bap:BitAndPos = _swf.getBitAndPos(_index);
			}
			if (bap)
			{
				if (bitmapData != bap.bit)
				{
					bitmapData = bap.bit;
					super.x = _baseX + bap.x;
					super.y = _baseY + bap.y;
				}
			}
			else if (bitmapData != null)
			{
				bitmapData = null;
			}
		}
	}
}