package com.ryan.resource
{
	import com.ryan.core.call.Caller;
	import com.ryan.debug.Log;
	import com.ryan.debug.ThrowError;
	import com.ryan.resource.info.ImageInfo;
	import com.ryan.resource.info.ResourceInfo;
	import com.ryan.resource.loader.BaseLoader;
	import com.ryan.resource.loader.DataLoader;
	import com.ryan.resource.loader.ImageLoader;
	import com.ryan.resource.loader.JTALoader;
	import com.ryan.resource.loader.LoaderErrorEvent;
	import com.ryan.resource.loader.MapDataLoader;
	import com.ryan.resource.loader.SWFLoader;
	import com.ryan.resource.loader.XMLLoader;
	import com.ryan.utils.pools.ObjectPool;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.utils.Dictionary;

	public class LoaderManager
	{
		private var _completeCaller:Caller;
		private var _progressCaller:Caller;
		private var _errorCaller:Caller;
		
		public var maxQueue:int = 4; //同时最多加载数量
		
		private var _queueMap:Dictionary; //队列MAP
		
		private var _currentCount:int=0; // 当前正在加载的数量
		
		private var _queueArray:Array;	// 加载 队列
		
		private var _highQueue:Array; //高级队列列表
		
		private var _cache:SharedManager; // 本地缓存
		
		private static var _instance:LoaderManager = new LoaderManager();
		
		public function LoaderManager()
		{
			if( _instance != null )
			{
				throw new Error("LoaderManager 单例  ");
			}
			_queueArray = [];
			_highQueue = [];
			
			_completeCaller = new Caller();
			_progressCaller = new Caller();
			_errorCaller = new Caller();
		}
		
		public static function get instance():LoaderManager
		{
			return _instance;
		}
		
		public function load(url:String, onLoaded:Function, loaderPriority:int = 3, extData:Object = null, onProgress:Function = null, onFailed:Function = null):void
		{
			if (!ResourceManager.hasInfoByName(url))
			{
				var filePath:String = url.split("?")[0];
				var type:String = filePath.substr(filePath.lastIndexOf(".")).toUpperCase();
				var infoClass:Class = FileType.getLoaderInfoByType(type);
				if (!infoClass)
				{
					Log.error("文件类型不正确：" + url);
					if (onFailed != null)
					{
						onFailed(null);
					}
					return;
				}
				var info:ResourceInfo = new infoClass(null);
				info.type = type;
				info.name = url;
				info.path = url;
				info.time = "0";
				ResourceManager.addResource(info);
			}
			loadImpl(url, onLoaded, loaderPriority, extData, onProgress, onFailed);
		}
		
		private function loadImpl( fileName:String,onLoaded:Function,loaderPriority:int = 3,extData:Object=null,onProgresse:Function = null, onFailed:Function = null ):void
		{
			var info:ResourceInfo = ResourceManager.getInfoByName(fileName);
			if( info == null )
			{
				Log.error( fileName + "==没有该文件" );
				if(onFailed is Function)
				{
					onFailed(info);
				}
				return ;
			}
			loadInfo( info,onLoaded,loaderPriority,extData,onProgresse,onFailed );
		}
		
		public function loadInfo(  info:ResourceInfo,onLoaded:Function,loaderPriority:int = 3,extData:Object=null,onProgresse:Function = null, onFailed:Function = null  ):void
		{
			if(extData)
			{
				info.extData = extData;
			}
			if( info.isLoaded )
			{
				onLoaded(info);
				info.addReference();
				return;
			}
			else if( info.isLoading )
			{
				_completeCaller.addCall(info.name,onLoaded);
				
				if( onProgresse is Function )
				{
					_progressCaller.addCall(info.name,onProgresse);
				}
				
				if( onFailed is Function)
				{
					_errorCaller.addCall(info.name,onFailed);
				}
			}
			else
			{
				_completeCaller.addCall(info.name,onLoaded);
				
				if( onProgresse is Function )
				{
					_progressCaller.addCall(info.name,onProgresse);
				}
				
				if( onFailed is Function)
				{
					_errorCaller.addCall(info.name,onFailed);
				}
				addLoader(info,loaderPriority);
			}
		}
		
		
		private function loadResource( info:ResourceInfo ):Boolean
		{
			if( _currentCount < maxQueue  )
			{
				var cls:Class = FileType.getLoaderByType(info.type);
				if( cls )
				{
					var loader:BaseLoader = ObjectPool.getObject(cls);
					loader.resourceInfo = info;
					loader.addEventListener(Event.COMPLETE,onCompleteHandler);
					loader.addEventListener(ProgressEvent.PROGRESS,onProgressHandler);
					loader.addEventListener(LoaderErrorEvent.LoaderError,onIOErrorHandler);
					loader.load( info.path); 
					_currentCount++;
					info.isLoading = true;
				}
				else
				{
					throw new Error("未知的文件类型");
					info.isLoading = false;
				}
				return true;
			}
			return false;
		}
		
		/**
		 * 添加一个加载处理器 
		 * @param loaderElement
		 * 
		 */		
		private function addLoader( info:ResourceInfo,loaderPriority:int = 3 ):void
		{
			if( loadResource(info) == false )
			{
				addQueue( info ,loaderPriority );
				info.isLoading = true;
			}
		}
		
		private function addQueue( info:ResourceInfo,loaderPriority:int=0 ):void
		{
			//最低级
			if( loaderPriority >= 3 )
			{
				_queueArray.push(info);
			}
			else if( loaderPriority == 0 ) //最高级
			{
				_highQueue.unshift(info);
			}
			else if( loaderPriority == 1)
			{
				_highQueue.push(info);
			}
			else if( loaderPriority == 2 )
			{
				_queueArray.unshift(info);
			}
		}
		
		private function shiftQueue():ResourceInfo
		{
			if( _highQueue.length > 0 )
			{
				return _highQueue.shift() as ResourceInfo;
			}
			else if( _queueArray.length > 0 )
			{
				return _queueArray.shift() as ResourceInfo;
			}
			return null;
		}
		
		/**
		 * 加载完成 
		 * @param event
		 * 
		 */		
		private function onCompleteHandler( event:Event ):void
		{
			_currentCount --;
			var loader:BaseLoader = event.target as BaseLoader;
			loader.removeEventListener(Event.COMPLETE,onCompleteHandler);
			loader.removeEventListener(ProgressEvent.PROGRESS,onProgressHandler);
			loader.removeEventListener(LoaderErrorEvent.LoaderError,onIOErrorHandler);
			
			if( loader.resourceInfo )
			{
				loader.resourceInfo.addReference();
				_completeCaller.call(loader.resourceInfo.name,loader.resourceInfo);
				_completeCaller.removeCallByType(loader.resourceInfo.name);
				_progressCaller.removeCallByType(loader.resourceInfo.name);
				_errorCaller.removeCallByType(loader.resourceInfo.name);
			}
			loader.resourceInfo = null;
			loader.dispose();
			ObjectPool.disposeObject(loader);
			
			loadNext();
		}
		
		/**
		 * 加载下一个资源 
		 * 
		 */		
		private function loadNext():void
		{
			if( _highQueue.length > 0 )
			{
				if(loadResource( _highQueue[0] as ResourceInfo ))
				{
					_highQueue.shift();
				}
			}
			else if( _queueArray.length > 0 )
			{
				if( loadResource( _queueArray[0] as ResourceInfo ))
				{
					_queueArray.shift();
				}
			}
		}
		/**
		 * 加载进度 
		 * @param event
		 * 
		 */		
		private function onProgressHandler( event:ProgressEvent ):void
		{
			var loader:BaseLoader = event.target as BaseLoader;
			if( loader.resourceInfo )
			{
				_progressCaller.call(loader.resourceInfo.name,event);
			}
		}
		/**
		 * 加载异常 
		 * @param event
		 * 
		 */		
		private function onIOErrorHandler( event:LoaderErrorEvent ):void
		{
			_currentCount --;
			var loader:BaseLoader = event.target as BaseLoader;
			loader.dispose();
			
			ObjectPool.disposeObject(loader);
			if( loader.resourceInfo )
			{
				loader.resourceInfo.path += "_1";
				loader.resourceInfo.unload();
				_errorCaller.call(loader.resourceInfo.name,event);
				_completeCaller.removeCallByType(loader.resourceInfo.name);
				_progressCaller.removeCallByType(loader.resourceInfo.name);
				_errorCaller.removeCallByType(loader.resourceInfo.name);
			}
			Log.error( "QueueLoader.onIOErrorHandler ->"+loader.url );
			loadNext();
		}
		
		public function disposeFile(fileName:String):void
		{
			var info:ResourceInfo = ResourceManager.getInfoByName(fileName)	;
			if( info )
			{
				info.dispose();
			}
		}	
		
	}
}