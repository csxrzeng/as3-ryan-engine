package com.ryan.global
{
	import com.ryan.core.call.Caller;
	import flash.display.Stage;
	import flash.events.Event;
	
	/**
	 * 全局变量
	 * @author xr.zeng
	 */
	public class Global
	{
		private static var _stage:Stage; //全局场景
		
		public static var isDebugModle:Boolean = false;
		
		public static var isActivate:Boolean = true;
		
		private var _caller:Caller = new Caller();
		private static const CallerType:String = "render";
		
		private static var _instance:Global;
		
		public function Global()
		{
			if (_instance != null)
			{
				throw new Error("Global 单例");
			}
		}
		
		public static function get instance():Global
		{
			if (_instance == null)
			{
				_instance = new Global();
			}
			return _instance;
		}
		
		public static function get stage():Stage
		{
			return _stage;
		}
		
		public function initStage(value:Stage):void
		{
			if (!_stage)
			{
				_stage = value;
				_stage.addEventListener(Event.RESIZE, onReSizeHandler, false, 99999, false);
				_stage.addEventListener(Event.ACTIVATE, onActivateHandler, false, 99999);
				_stage.addEventListener(Event.DEACTIVATE, onDeactivateHandler, false, 99999);
				_stage.addEventListener(Event.RENDER, onRenderHandler);
			}
		}
		
		private function onRenderHandler(event:Event):void
		{
			_caller.call(CallerType);
			_caller.removeCallByType(CallerType);
		}
		
		private function onActivateHandler(event:Event):void
		{
			//_stage.focus = stage;
			isActivate = true;
		}
		
		private function onDeactivateHandler(event:Event):void
		{
			isActivate = false;
		}
		
		private function onReSizeHandler(event:Event):void
		{
			if (event.target is Stage == false)
			{
				event.stopImmediatePropagation();
			}
		}
		
		public function callLater(callback:Function):void
		{
			_caller.addCall(CallerType, callback);
			_stage.invalidate();
		}
	
	}
}