package com.ryan.resource
{
	import com.ryan.resource.loader.DataLoader;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	[Event(name = "complete", type = "flash.events.Event")]
	[Event(name = "progress", type = "flash.events.ProgressEvent")]
	[Event(name = "error", type = "flash.events.ErrorEvent")]

	public class ConfigManager extends EventDispatcher
	{
		private static var _instance:ConfigManager;

		private var _isLoaded:Boolean = false;

		private var _configDic:Dictionary;

		public function ConfigManager()
		{
			if (_instance != null)
			{
				throw new Error("ConfigManager 单例");
			}
			_isLoaded = false;
		}

		public static function get instance():ConfigManager
		{
			if (_instance == null)
			{
				_instance = new ConfigManager();
			}
			return _instance;
		}

		public function load(url:String):void
		{
			var dataLoader:DataLoader = new DataLoader();
			dataLoader.addEventListener(Event.COMPLETE, onLoadCompleteHandler);
			dataLoader.addEventListener(ProgressEvent.PROGRESS, onLoadProgressHandler);
			dataLoader.addEventListener(ErrorEvent.ERROR, onErrorHandler);
			dataLoader.load(url);
		}

		private function onLoadCompleteHandler(event:Event):void
		{
			_isLoaded = true;
			var loader:DataLoader = event.target as DataLoader;
			var byteArray:ByteArray = loader.bytesData;
			byteArray.position = 0;
			byteArray.uncompress();
			_configDic = byteArray.readObject() as Dictionary;

			dispatchEvent(event);
		}

		private function onLoadProgressHandler(event:ProgressEvent):void
		{
			dispatchEvent(event);
		}

		private function onErrorHandler(event:ErrorEvent):void
		{
			_isLoaded = false;
			dispatchEvent(event);
		}

		/**
		 * 获取XML文件转成的对象，根标签是res，百炼，神魔斗的格式，去掉了 type, name, content的结构
		 */
		public function getObjectByFileName(fileName:String):Object
		{
			if (hasFile(fileName))
			{
				return _configDic[fileName].res;
			}
			return null;
		}

		public function getStringByFileName(fileName:String):String
		{
			if (hasFile(fileName))
			{
				return _configDic[fileName];
			}
			return null;
		}

		public function getJSONByFileName(fileName:String):Object
		{
			if (hasFile(fileName))
			{
				return _configDic[fileName];
			}
			return null;
		}

		public function hasFile(fileName:String):Boolean
		{
			if (_isLoaded == false)
				return false;
			return _configDic[fileName] != null;
		}

		public function getByteArrayByFileName(fileName:String):ByteArray
		{
			if (hasFile(fileName))
			{
				return _configDic[fileName] as ByteArray;
			}
			return null;

		}

	}
}
