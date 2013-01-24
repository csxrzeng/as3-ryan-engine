package com.ryan.player
{
	import com.ryan.core.frame.FrameTimer;
	import com.ryan.core.frame.TimerType;
	import com.ryan.utils.pools.ObjectPool;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * 播放器基类
	 * @author xr.zeng
	 */
	public class BasePlayer extends Sprite implements IBasePlayer
	{
		protected var _delay:Number = 1;
		protected var _frame:FrameTimer;
		protected var _frameCount:int = 1;
		protected var _index:int = 0;
		protected var _isPlayOnce:Boolean = false;
		protected var _isRemoved:Boolean = true; // 对播放一次的对象，播放完成是否自动移除
		public var onPlayComplete:Function; // 播放完成的回调，只当isPlayOnce为true的时候有效 function(p:BasePlayer):void
		
		public function BasePlayer(s:Single)
		{
			mouseEnabled = false;
			mouseChildren = false;
			_frame = new FrameTimer(1);
			reset();
		}
		
		static public function create():BasePlayer
		{
			return ObjectPool.getObject(BasePlayer, Single.instance);
		}
		
		public function get isPlay():Boolean
		{
			return _frame.running;
		}
		
		public function get currentIndex():int
		{
			return _index;
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
		
		/**
		 * 获取或设置是否只播放一次，如果为true，则播放完成会自动从舞台移除，并且回调
		 * 默认为false
		 */
		public function get isPlayOnce():Boolean
		{
			return _isPlayOnce;
		}
		
		public function set isPlayOnce(value:Boolean):void
		{
			_isPlayOnce = value;
		}
		
		public function get isRemoved():Boolean 
		{
			return _isRemoved;
		}
		
		public function set isRemoved(value:Boolean):void 
		{
			_isRemoved = value;
		}
		
		public function move(x:Number, y:Number):void
		{
			super.x = x;
			super.y = y;
		}
		
		public function moveToPoint(p:Point):void
		{
			move(p.x, p.y);
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
		
		public function updateNow():void
		{
			render();
		}
		
		public function dispose():void
		{
			stop();
			move(0, 0);
			_delay = 1;
			_frame.dispose();
			_frameCount = 1;
			_index = 0;
			_isPlayOnce = false;
			_isRemoved = true;
			onPlayComplete = null;
			ObjectPool.disposeObject(this); // 回收到内存池
		}
		
		protected function onEnterFrame(timer:FrameTimer):void
		{
			var index:int = int(timer.currentCount / _delay);
			if (_index != index)
			{
				if (_isPlayOnce && index >= _frameCount)
				{
					if (_index < _frameCount -1) // 中间跳帧了，始终要播放一下最后一帧
					{
						_index = _frameCount -1;
					}
					else
					{
						_index = index;
						stop();
						_frame.dispose(); // 只播放一次，播放完成销毁定时器
						if (onPlayComplete != null)
						{
							onPlayComplete(this); // 播放完成回调
						}
						if (_isRemoved && this.parent)
						{
							this.parent.removeChild(this);
						}
						return;
					}
				}
				_index = index % _frameCount;
				render();
			}
		}
		
		/**
		 * 子类需要重写此方法
		 */
		protected function render():void
		{
		}
	}
}