package com.ryan.debug
{
	import com.ryan.global.Global;
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	/**
	 * 日志
	 * @author xr.zeng
	 *
	 */
	public class Log
	{
		
		public static var isSystem:Boolean = true;
		public static var isError:Boolean = true;
		public static var isDebug:Boolean = false; // 默认关闭调试信息
		public static var isWarn:Boolean = true;
		
		private static var MaxLogCount:int = 100;
		private static var logList:Array = [];
		private static var logTxt:TextField;
		
		public function Log()
		{
		
		}
		
		/**
		 *  系统测试信息
		 *
		 */
		public static function system(...rest):void
		{
			if (isSystem)
			{
				log.apply(null, rest);
			}
		}
		
		/**
		 * 错误信息
		 *
		 */
		public static function error(...rest):void
		{
			if (isError)
			{
				log.apply(null, rest);
			}
		}
		
		/**
		 * 调试信息
		 *
		 */
		public static function debug(...rest):void
		{
			if (isDebug)
			{
				log.apply(null, rest);
			}
		}
		
		/**
		 * 警告信息
		 *
		 */
		public static function warn(...rest):void
		{
			if (isWarn)
			{
				log.apply(null, rest);
			}
		}
		
		public static function closeAll():void
		{
			isDebug = false;
			isError = false;
			isSystem = false;
			isWarn = false;
		}
		
		public static function openAll():void
		{
			isDebug = true;
			isError = true;
			isSystem = true;
			isWarn = true;
		}
		
		public static function clearAll():void
		{
			logList.length = 0;
			if (logTxt)
			{
				logTxt.text = "";
			}
		}
		
		private static function log(...rest):void
		{
			CONFIG::debug
			{
				trace(rest);
				logList.push(rest.join(" "));
				if (logList.length > MaxLogCount)
				{
					logList.shift();
				}
				if (!logTxt)
				{
					logTxt = new TextField();
					logTxt.autoSize = "left";
					logTxt.textColor = 0xFFFFFF;
				}
				Global.stage.addChild(logTxt);
				logTxt.text = logList.join("\n");
			}
		}
	}
}