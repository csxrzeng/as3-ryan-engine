package com.ryan.core.call
{
	import com.ryan.utils.ArrayUtil;
	import flash.utils.Dictionary;
	
	public class Caller implements ICaller
	{
		private var _callerMap:Dictionary;
		
		public function Caller()
		{
			_callerMap = new Dictionary();
		}
		
		/**
		 * 添加一个call
		 * @param type
		 * @param value
		 *
		 */
		public function addCall(type:Object, value:Function):void
		{
			var list:Array = getlistByType(type);
			list.push(value);
		}
		
		/**
		 * 删除一个call
		 * @param type
		 * @param value
		 *
		 */
		public function removeCall(type:Object, value:Function):void
		{
			var list:Array = getlistByType(type);
			ArrayUtil.removeItem(list, value);
		}
		
		/**
		 * 执行一个call
		 * @param type
		 * @param rect
		 *
		 */
		public function call(type:Object, ... rect):Boolean
		{
			var list:Array = getlistByType(type);
			for each (var fun:Function in list)
			{
				if (fun != null)
				{
					fun.apply(null, rect);
				}
			}
			return true;
		}
		
		/**
		 *  销毁
		 *
		 */
		public function dispose():void
		{
			var list:Array;
			for (var key:String in _callerMap)
			{
				list = _callerMap[key] as Array;
				list.length = 0;
				delete _callerMap[key];
			}
		}
		
		private function getlistByType(type:Object):Array
		{
			if (type in _callerMap)
			{
				return _callerMap[type];
			}
			var ary:Array = new Array();
			_callerMap[type] = ary;
			return ary;
		}
		
		public function removeCallByType(type:Object):void
		{
			delete _callerMap[type];
		}
		
		public function hasCall(type:Object):Boolean
		{
			return type in _callerMap;
		}
	}
}