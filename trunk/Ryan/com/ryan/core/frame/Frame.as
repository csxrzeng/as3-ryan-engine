package com.ryan.core.frame
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	/**
	 * 帧基类 模板 不能直接实例化
	 * @author xr.zeng
	 */
	public class Frame implements IFrame
	{
		private var _oneFrameMap:Dictionary; //保存一帧的队列
		private var _frameSortMap:Dictionary; //保存大于一帧的队列
		private var _count:int; // 所有计时器个数
		private var _isPlay:Boolean;
		private var _delay:Number; // 每一帧需要的时间
		private var _startTime:int = 0;
		protected var _frameCount:int = 0;
		
		public function Frame(delay:Number)
		{
			_frameSortMap = new Dictionary();
			_oneFrameMap = new Dictionary();
			_isPlay = false;
			_delay = delay;
		}
		
		public function play():void
		{
			_isPlay = true;
			_frameCount = 0;
			_startTime = getTimer();
		}
		
		public function stop():void
		{
			_isPlay = false;
		}
		
		/**
		 * 添加帧
		 * @param value
		 */
		public function addTimer(value:IBaseTimer):void
		{
			if (!_isPlay)
			{
				play();
			}
			if (value.delay == 1)
			{
				_oneFrameMap[value.id] = value;
			}
			else
			{
				pushFrameSort(value, _frameCount + value.delay);
			}
			_count++;
		}
		
		protected function onEnterFrameHandler(event:Event = null):void
		{
			var curTime:int = getTimer();
			var curFrame:int = int((curTime - _startTime) / _delay);
			if (curFrame > _frameCount)
			{
				renderer(curFrame);
				_frameCount = curFrame;
			}
		}
		
		protected function renderer(expectFrame:int):void
		{
			renderOneDelay(_frameCount + 1, expectFrame); // 对于单帧
			for (var i:int = _frameCount + 1; i <= expectFrame; i++) // 多帧
			{
				renderMultiDelay(i, expectFrame);
			}
		}
		
		/**
		 * 单帧的情况
		 * @param	currentFrame 当前帧
		 * @param	expectFrame 期望帧
		 */
		protected function renderOneDelay(currentFrame:int, expectFrame:int):void
		{
			var frameAdd:int = expectFrame - currentFrame + 1;
			for each (var tempframe:IBaseTimer in _oneFrameMap)
			{
				if (tempframe.isDelete)
				{
					_count--;
					delete _oneFrameMap[tempframe.id];
					tempframe.isTimerQueue = false; // 标记已经从frame里面删除
				}
				else if (tempframe.running)
				{
					tempframe.renderer(frameAdd);
				}
			}
		}
		
		/**
		 * 多帧的情况
		 * @param	currentFrame 当前帧
		 * @param	expectFrame 期望帧
		 */
		protected function renderMultiDelay(currentFrame:int, expectFrame:int):void
		{
			var frameSortAry:Vector.<IBaseTimer> = _frameSortMap[currentFrame] as Vector.<IBaseTimer>;
			if (frameSortAry)
			{
				var deltaFrame:int = expectFrame - currentFrame;
				for each (var tempframe:IBaseTimer in frameSortAry)
				{
					if (tempframe.isDelete)
					{
						_count--;
						tempframe.isTimerQueue = false; // 标记已经从frame里面删除
					}
					else
					{
						var frameAdd:int = int(deltaFrame / tempframe.delay) + 1;
						if (tempframe.running)
						{
							tempframe.renderer(frameAdd);
						}
						pushFrameSort(tempframe, currentFrame + tempframe.delay * frameAdd);
					}
					frameSortAry.length = 0;
					delete _frameSortMap[currentFrame];
				}
			}
		}
		
		private function pushFrameSort(value:IBaseTimer, expectCount:int):void
		{
			var tempAry:Vector.<IBaseTimer> = _frameSortMap[expectCount] as Vector.<IBaseTimer>;
			if (!tempAry)
			{
				tempAry = new Vector.<IBaseTimer>();
				_frameSortMap[expectCount] = tempAry;
			}
			tempAry.push(value);
		}
	}
}