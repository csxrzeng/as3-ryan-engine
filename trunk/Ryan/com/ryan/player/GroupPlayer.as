package com.ryan.player
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * 组合播放器（未完成）
	 * @author xr.zeng
	 */
	public class GroupPlayer extends Sprite implements IBasePlayer
	{
		protected var _delay:Number = 1;
		protected var _isPlay:Boolean = false;
		protected var _playerList:Vector.<IBasePlayer>;
		
		public function GroupPlayer()
		{
			list = new Vector.<IBasePlayer>();
		}
		
		/**
		 * 相对的如果没有外部直接控制子Player的情况是准确的
		 */
		public function get isPlay():Boolean
		{
			return _isPlay;
		}
		
		/**
		 * 总是只有一帧
		 */
		public function get frameCount():int
		{
			return 1;
		}
		
		public function set frameCount(value:int):void
		{
		}
		
		public function get delay():Number
		{
			return _delay;
		}
		
		public function set delay(value:Number):void
		{
			if (_delay != value)
			{
				_delay = value;
				for each (var item:IBasePlayer in _playerList)
				{
					item.delay = value;
				}
			}
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
			if (!_isPlay)
			{
				_isPlay = true;
				for each (var item:IBasePlayer in _playerList)
				{
					item.start();
				}
			}
		}
		
		public function stop():void
		{
			if (_isPlay)
			{
				_isPlay = false;
				for each (var item:IBasePlayer in _playerList)
				{
					item.stop();
				}
			}
		}
		
		public function reset():void
		{
			for each (var item:IBasePlayer in _playerList)
			{
				item.reset();
			}
		}
		
		public function dispose():void
		{
			for each (var item:IBasePlayer in _playerList)
			{
				item.dispose();
			}
			while (numChildren > 0)
			{
				removeChildAt(0);
			}
			_delay = 1;
			_isPlay = false;
			_playerList.length = 0;
		}
		
		public function addPlayer(player:IBasePlayer):void
		{
			list.push(player);
			addChild(player as DisplayObject);
		}
		
		public function removePlayer(player:IBasePlayer):void
		{
			var index:int = list.indexOf(player);
			if (index != -1)
			{
				var player:IBasePlayer = list.splice(index, 1)[0];
				removeItem(player as DisplayObject);
			}
		}
		
		protected function removeItem(item:DisplayObject):void
		{
			if (item && item.parent == this)
			{
				removeChild(item);
			}
		}
	}
}