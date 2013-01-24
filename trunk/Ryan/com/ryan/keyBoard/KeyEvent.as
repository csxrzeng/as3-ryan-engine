package com.ryan.keyBoard
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	public class KeyEvent extends Event
	{
		public static const KEY_DOWN:String = "key_down";
		public static const KEY_UP:String = "key_up";
		public var keyEvent:KeyboardEvent;

		public function KeyEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
