package com.ryan.resource.loader
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	[Event(name = "complete", type = "flash.events.Event")]
	[Event(name = "progress", type = "flash.events.ProgressEvent")]
	[Event(name = "error", type = "flash.events.ErrorEvent")]
	public class StreamLoader extends EventDispatcher
	{
		private var _url:String;
		private var _urlLoader:URLLoader;
		private var _contentType:String;
		private var _loaderInfo:LoaderInfo;

		public function StreamLoader()
		{
		}

		/**
		 * 加载资源
		 * @param url
		 * @param context
		 *
		 */
		public function load(url:String):void
		{
			_url = url;
			initLoader();
		}

		private function initLoader():void
		{
			if (_urlLoader == null)
			{
				_urlLoader = new URLLoader();
				_urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			}
			else
			{
				_urlLoader.removeEventListener(Event.COMPLETE, onCompleteHandler);
				_urlLoader.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
				_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
				_urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onIOError);
			}
			_urlLoader.addEventListener(Event.COMPLETE, onCompleteHandler);
			_urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onIOError);
			_urlLoader.load(new URLRequest(_url));
		}

		private function onCompleteHandler(event:Event):void
		{
			_urlLoader.removeEventListener(Event.COMPLETE, onCompleteHandler);
			_urlLoader.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onIOError);
			initialize(URLLoader(event.target).data);
		}

		/**
		 * 进度事件
		 * @param event
		 *
		 */
		protected function onProgressHandler(event:ProgressEvent):void
		{
			dispatchEvent(event);
		}

		/**
		 * 加载器 异常
		 * @param event
		 *
		 */
		private function onIOError(event:ErrorEvent):void
		{
			_urlLoader.removeEventListener(Event.COMPLETE, onCompleteHandler);
			_urlLoader.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onIOError);
			onIOErrorHandler(event);
		}

		protected function onIOErrorHandler(event:ErrorEvent):void
		{
			trace(event.text);
			dispatchEvent(new LoaderErrorEvent(event.text));
		}
		private var _loader:Loader;

		public function initialize(data:*):void
		{
			if (!(data is ByteArray))
			{
				throw new Error("Default Resource can only process ByteArrays!");
			}
			//通过loder 转换成资源 
			if (_loader == null)
			{
				_loader = new Loader();
			}
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onChangeIOErrorHandler);
			_loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onChangeIOErrorHandler);
			_loader.loadBytes(data);
		}

		protected function onContentReady(content:*):Boolean
		{
			return true;
		}

		/**
		 * 加载 并 转换完成
		 * @param event
		 */
		private function onLoadComplete(event:Event):void
		{
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;
			_loaderInfo = loaderInfo;
			loaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onChangeIOErrorHandler);
			loaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onChangeIOErrorHandler);
			if (onContentReady(event ? event.target.content : null))
			{
//				_urlLoader.close();
				//_urlLoader = null;
				onLoadCompleteHandler();
			}
		}

		protected function onLoadCompleteHandler():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}

		/**
		 * 转换器 失败
		 * @param event
		 *
		 */
		private function onChangeIOErrorHandler(event:IOErrorEvent):void
		{
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;
			loaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onChangeIOErrorHandler);
			loaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onChangeIOErrorHandler);
			onIOErrorHandler(event);
		}

		/**
		 * 销毁
		 *
		 */
		public function dispose():void
		{
			_urlLoader.removeEventListener(Event.COMPLETE, onCompleteHandler);
			_urlLoader.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_urlLoader = null;
			_url = null;
			_loaderInfo = null;
		}

		public function get url():String
		{
			return _url;
		}

		public function get contentType():String
		{
			if (_loaderInfo)
			{
				return _loaderInfo.contentType;
			}
			return null;
		}

		public function get loaderInfo():LoaderInfo
		{
			return _loaderInfo;
		}
	}
}
