package com.ryan.resource.loader
{
	import flash.events.Event;

	public class LoaderErrorEvent extends Event
	{
		public static const LoaderError:String = "LoaderError";
		private var _text:String;

		public function LoaderErrorEvent(text:String)
		{
			super(LoaderError, false, false);
			_text = text;
		}

		public function get text():String
		{
			return _text;
		}
	}
}
