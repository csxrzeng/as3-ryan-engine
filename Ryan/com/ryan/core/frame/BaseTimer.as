package com.ryan.core.frame
{
	import flash.utils.Dictionary;
	
	/**
	 * 定时器模板类
	 * TimerType类的两种事件类型
	 * @author xr.zeng
	 */
	public class BaseTimer implements IBaseTimer
	{
		private static var _baseID:int = 0; //创建类的唯一标识 ID 的 开始编号
		private var _id:int = 0; //对象编号
		private var _isDelete:Boolean; //是否删除计时器
		private var _isTimerQueue:Boolean = false;
		private var _running:Boolean = false; //是否渲染
		private var _delay:int; //时间间隔
		private var _repeatCountCache:int; //缓存的重复次数
		private var _repeatCount:int; //重复次数
		private var _interval:int; //每帧时间间隔
		private var _enterFrameHandler:Function; //每帧触发的方法
		private var _completeHandler:Function; //完成时触发的方法
		public var currentCount:int //当前数量
		
		public function BaseTimer($delay:int, $repeatCount:int)
		{
			_id = ++_baseID;
			this.delay = $delay;
			this.repeatCount = $repeatCount;
			this._repeatCountCache = $repeatCount;
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function get isTimerQueue():Boolean
		{
			return _isTimerQueue;
		}
		
		public function set isTimerQueue(value:Boolean):void
		{
			_isTimerQueue = value;
		}
		
		/**
		 * type 为 TimerType
		 * @param type
		 * @param callback
		 */
		public function addListener(type:String, callback:Function):void
		{
			if (type == TimerType.COMPLETE)
			{
				_completeHandler = callback;
			}
			else if (type == TimerType.ENTERFRAME)
			{
				_enterFrameHandler = callback;
			}
		}
		
		/**
		 * 每次定时器执行的方法
		 * @param frameAdd
		 */
		public function renderer(frameAdd:int):void
		{
			//frameAdd = 1;
			currentCount += frameAdd;
			repeatCount -= frameAdd;
			if (_enterFrameHandler is Function)
			{
				_enterFrameHandler.call(null, this);
			}
			if (repeatCount <= 0)
			{
				_isDelete = true;
				isTimerQueue = false;
				if (_completeHandler is Function)
				{
					_completeHandler.call(null, this);
				}
			}
		}
		
		public function get interval():int
		{
			return _interval;
		}
		
		public function set interval(value:int):void
		{
			_interval = value;
		}
		
		public function start():void
		{
			_running = true;
		}
		
		public function stop():void
		{
			_running = false;
			currentCount = 0;
		}
		
		public function set isDelete(value:Boolean):void
		{
			_isDelete = value;
		}
		
		public function get isDelete():Boolean
		{
			return _isDelete;
		}
		
		public function get running():Boolean
		{
			return _running;
		}
		
		public function get delay():int
		{
			return _delay;
		}
		
		public function set delay(value:int):void
		{
			_delay = value;
		}
		
		public function get repeatCount():Number
		{
			return _repeatCount;
		}
		
		public function set repeatCount(value:Number):void
		{
			_repeatCount = value;
		}
		
		public function reset():void
		{
			repeatCount = _repeatCountCache;
			currentCount = 0;
			isDelete = false;
		}
		
		public function dispose():void
		{
			_completeHandler = null;
			_enterFrameHandler = null;
			_isDelete = true;
			_running = false;
			_repeatCount = 0;
			//isTimerQueue = false; // 不能在这里改是否在frame里面
			currentCount = 0;
		}
	}
}