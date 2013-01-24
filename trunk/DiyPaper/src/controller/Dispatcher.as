package controller 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * 事件派发器
	 * @author xr.zeng
	 */
	public class Dispatcher
	{
		static private var dispatcher:EventDispatcher = new EventDispatcher();
		
		static public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		static public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			dispatcher.addEventListener(type, listener, useCapture);
		}
		
		static public function dispatchEvent(event:Event):Boolean 
		{
			return dispatcher.dispatchEvent(event);
		}
		
		static public function hasEventListener(type:String):Boolean 
		{
			return dispatcher.hasEventListener(type);
		}
		
		static public function willTrigger(type:String):Boolean 
		{
			return dispatcher.willTrigger(type);
		}
	}

}