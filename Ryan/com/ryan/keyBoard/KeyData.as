package com.ryan.keyBoard
{
	import flash.events.Event;
	
	public class KeyData
	{
		//是否按下
		public var isKeyDown:Boolean = false;
		//按键对应的数值
		public var keyCode:uint;		
		public var keyEvent:Object;
		public function KeyData(keyCode:uint,keyEvent:Object = null)
		{
			this.keyCode = keyCode;
			this.keyEvent = keyEvent;
		}

	}
}