package resource
{
	import com.ryan.debug.Log;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author
	 */
	public class SMedia
	{
		static public const NOEXIST:int = 0; //不存在
		static public const UNINIT:int = 1; //未初始化
		static public const LOADING:int = 2; //加载中
		static public const FINISHED:int = 3; //资源已完成
		static public const TYPE_TEXT:int = 1;
		static public const TYPE_BITMAP:int = 2;
		static public const TYPE_SOUND:int = 3;
		static public const TYPE_BINARY:int = 4;
		static public const TYPE_MEDIA:int = 5;
		static public const TYPE_UNITE:int = 6;
		private var vUrlRequest:URLRequest; //请求配置
		private var vState:uint; //当前状态
		private var vType:int; //数据类型
		private var vLoader:*; //加载器
		private var vCopyList:Vector.<Loader>; //副件列表
		private var vData:*; //真实数据
		private var vUniteList:Vector.<String>; //合并列表
		private var vError:Boolean = false; //下载失败标志
		private var vRetryCount:int = 3; //加载失败重试次数
		private var vTimeoutDelay:uint = 15000; //15秒响应(如果10秒内无任何数据交互即报 EventIOError)
		private var vTimeoutId:uint = 0; //加载超时定时器id
		private var OnComplete:Function; //加载成功后回调
		private var OnProgress:Function; //加载过程回调
		
		public function SMedia(url:String, uinte_list:Vector.<String>, complete:Function, progress:Function)
		{
			vState = UNINIT;
			vUrlRequest = new URLRequest(url);
			vUniteList = uinte_list;
			OnComplete = complete;
			OnProgress = progress;
			if (uinte_list != null)
			{
				vType = TYPE_UNITE;
				vData = new Object;
			}
			else
			{
				vType = GetMeidaType(url);
			}
		}
		
		private function GetMeidaType(url:String):int
		{
			url = url.split('?')[0];
			var index:int = url.lastIndexOf('.');
			if (index != -1)
			{
				switch (url.substring(index).toLowerCase())
				{
					case '.txt': 
						return TYPE_TEXT;
					case '.bmp': 
					case '.png': 
					case '.gif': 
					case '.jpg': 
					case '.jpeg': 
						return TYPE_BITMAP;
					case '.mp3': 
					case '.wav': 
						return TYPE_SOUND;
					case '.swf': 
						return TYPE_MEDIA;
				}
			}
			return TYPE_BINARY;
		}
		
		private function CanUniteGC():Boolean
		{
			for each (var v:BitmapData in vData)
			{
				if (v != null)
					return false;
			}
			return true;
		}
		
		public function Release():void
		{
			if (vCopyList)
			{
				for each (var loader:Loader in vCopyList)
					loader.unloadAndStop();
				vCopyList.length = 0;
			}
			ClearLoader();
			vState = UNINIT;
			var bitmap:BitmapData = vData as BitmapData;
			bitmap && bitmap.dispose();
			var bytes:ByteArray = vData as ByteArray;
			bytes && bytes.clear();
			vUrlRequest = null;
			vData = null;
		}
		
		public function CreateLoader():Boolean
		{
			ClearLoader();
			switch (vType)
			{
				case TYPE_TEXT: 
					vLoader = new URLLoader;
					(vLoader as URLLoader).dataFormat = URLLoaderDataFormat.TEXT;
					AddEvent(vLoader);
					break;
				case TYPE_BINARY: 
					vLoader = new URLLoader;
					(vLoader as URLLoader).dataFormat = URLLoaderDataFormat.BINARY;
					AddEvent(vLoader);
					break;
				case TYPE_BITMAP: 
				case TYPE_MEDIA: 
				case TYPE_UNITE: 
					vLoader = new Loader;
					AddEvent((vLoader as Loader).contentLoaderInfo);
					break;
				case TYPE_SOUND: 
					vLoader = new Sound;
					AddEvent(vLoader);
					break;
			}
			switch (vType)
			{
				case TYPE_MEDIA: 
				case TYPE_UNITE: 
				{
					vLoader.load(vUrlRequest);
				}
					break;
				default: 
					vLoader.load(vUrlRequest);
					break;
			}
			ResetCheckTimeout();
			return true;
		}
		
		private function ResetCheckTimeout():void
		{
			ClearCheckTimeout();
			vTimeoutId = setTimeout(EventIOError, vTimeoutDelay, null);
		}
		
		private function ClearCheckTimeout():void
		{
			if (vTimeoutId != 0)
			{
				clearTimeout(vTimeoutId);
				vTimeoutId = 0;
			}
		}
		
		public function ClearLoader():void
		{
			if (vLoader == null)
				return;
			if (vState == LOADING && vLoader != null)
			{
				try
				{
					if (vLoader as Loader && vLoader.contentLoaderInfo.bytesLoaded != vLoader.contentLoaderInfo.bytesTotal)
						vLoader.close();
					else if (vLoader as URLLoader && vLoader.bytesLoaded != vLoader.bytesTotal)
						vLoader.close();
				}
				catch (e:*)
				{
				}
			}
			switch (vType)
			{
				case TYPE_TEXT: 
				case TYPE_BINARY: 
					RemoveEvent(vLoader);
					break;
				case TYPE_BITMAP: 
				case TYPE_MEDIA: 
				case TYPE_UNITE: 
				{
					RemoveEvent((vLoader as Loader).contentLoaderInfo);
					if (vState == FINISHED)
						vLoader.unloadAndStop();
				}
					break;
				case TYPE_SOUND: 
					RemoveEvent(vLoader);
					break;
			}
			vLoader = null;
			ClearCheckTimeout();
		}
		
		public function Download():void
		{
			CreateLoader();
			vState = LOADING;
		}
		
		public function UniteGC(name:String):Boolean
		{
			if (vState != FINISHED)
				return true;
			if (vError)
				return true;
			var class_name:String = name.substr(0, name.lastIndexOf("."));
			var bitmap:BitmapData = vData[class_name];
			if (bitmap != null)
			{
				vData[class_name] = null;
				bitmap = null;
			}
			return CanUniteGC();
		}
		
		private function GetErrorData():*
		{
			if (vData != null)
				return vData;
			switch (vType)
			{
				case TYPE_TEXT: 
					vData = '';
					break;
				case TYPE_BINARY: 
					vData = new ByteArray;
					break;
				case TYPE_BITMAP: 
				case TYPE_MEDIA: 
				case TYPE_UNITE: 
					vData = new BitmapData(1, 1, true, 0);
					break;
			}
			return vData;
		}
		
		public function GetData(name:String):*
		{
			if (vState != FINISHED)
				return null;
			if (vError)
				return GetErrorData();
			var offset:int = name.lastIndexOf("/") + 1;
			var class_name:String = name.substr(offset, name.lastIndexOf(".") - offset);
			var ext_name:String = name.substr(name.lastIndexOf(".") + 1);
			switch (vType)
			{
				case TYPE_TEXT: 
				case TYPE_BINARY: 
					vData ||= vLoader.data;
					break;
				case TYPE_BITMAP: 
					vData ||= vLoader.content.bitmapData;
					vData ||= vLoader.content.getChildAt(0).bitmapData;
					break;
				case TYPE_SOUND: 
					vData = vLoader;
					break;
				case TYPE_MEDIA: 
				{
					if (vData == null)
					{
						switch (ext_name)
						{
							case 'jpeg': 
							case 'jpg': 
							case 'png': 
							case 'gif': 
							case 'bmp': 
							{
								try
								{
									vData = (vLoader.contentLoaderInfo.content.getChildAt(0) as Bitmap).bitmapData;
								}
								catch (e:*)
								{
									//暂时兼容 swf图片加载
									vData = new BitmapData(vLoader.contentLoaderInfo.width, vLoader.contentLoaderInfo.height, true, 0);
									vData.draw(vLoader.content as DisplayObject);
									Log.error('不应该出现的swf图片资源: ' + vUrlRequest.url);
								}
							}
								break;
							case 'mp3': 
								vData = new (vLoader.contentLoaderInfo.applicationDomain.getDefinition(class_name) as Class);
								break;
						}
					}
				}
					break;
				case TYPE_UNITE: 
				{
					var data:* = vData[class_name];
					if (data == null)
					{
						switch (ext_name)
						{
							case 'jpeg': 
							case 'jpg': 
							case 'png': 
							case 'gif': 
							case 'bmp': 
								data = (vLoader.contentLoaderInfo.content.getChildAt(vUniteList.indexOf(class_name)) as Bitmap).bitmapData;
								break;
							case 'mp3': 
								data = new (vLoader.contentLoaderInfo.applicationDomain.getDefinition(class_name) as Class);
								break;
						}
						vData[class_name] = data;
					}
					return data;
				}
					break;
			}
			//if ( vType != TYPE_UNITE )
			//ClearLoader();
			return vData;
		}
		
		public function CopyLoader():*
		{
			if (vState != FINISHED)
				return null;
			var bytes:ByteArray = null;
			var copy_loader:Loader = null;
			switch (vType)
			{
				case TYPE_TEXT: 
				case TYPE_BINARY: 
					return null;
				case TYPE_BITMAP: 
				case TYPE_MEDIA: 
					copy_loader = new Loader;
					(vCopyList ||= new Vector.<Loader>).push(copy_loader);
					bytes = (vLoader as Loader).contentLoaderInfo.bytes;
					break;
				case TYPE_SOUND: 
					return null;
			}
			if (bytes != null && bytes.length != 0)
			{
				bytes.position = 0;
				//var context:LoaderContext = new LoaderContext(false, new ApplicationDomain());
				copy_loader.loadBytes(bytes /*,  context*/);
			}
			return copy_loader;
		}
		
		public function GetLoader(absolute:Boolean = false):*
		{
			if (absolute || vState == FINISHED)
				return vLoader;
			return null;
		}
		
		private function AddEvent(Target:EventDispatcher):void
		{
			Target.addEventListener(Event.COMPLETE, EventComplete);
			Target.addEventListener(ProgressEvent.PROGRESS, EventProgress);
			Target.addEventListener(IOErrorEvent.IO_ERROR, EventIOError);
		}
		
		private function RemoveEvent(Target:EventDispatcher):void
		{
			Target.removeEventListener(Event.COMPLETE, EventComplete);
			Target.removeEventListener(ProgressEvent.PROGRESS, EventProgress);
			Target.removeEventListener(IOErrorEvent.IO_ERROR, EventIOError);
		}
		
		private function EventComplete(e:Event):void
		{
			ClearCheckTimeout();
			vState = FINISHED;
			switch (vType)
			{
				case TYPE_MEDIA: 
				case TYPE_UNITE: 
					break;
			}
			var loader:Loader = vLoader as Loader;
			if (loader != null)
			{
				if (loader.content as MovieClip && vType == TYPE_MEDIA)
				{
					stop_moive(loader.content as MovieClip);
				}
			}
			OnComplete && OnComplete(this);
			OnComplete = null;
		}
		
		private function EventProgress(e:ProgressEvent):void
		{
			ResetCheckTimeout();
			OnProgress && OnProgress(this);
		}
		
		private function EventIOError(e:IOErrorEvent):void
		{
			if (--vRetryCount == 0 || e != null)
			{
				vData = null;
				vError = true;
				Log.error('资源下载失败: ' + vUrlRequest.url);
				ClearCheckTimeout();
				vState = FINISHED;
				OnComplete && OnComplete(this);
				OnComplete = null;
				return;
			}
			setTimeout(function():void
				{
					if (!CreateLoader())
					{
						Log.error('创建 Loader 失败: ' + vUrlRequest.url);
						return;
					}
				}, 1000);
		}
		
		private function stop_moive(moive:MovieClip):void
		{
			moive.stop();
			for (var i:int = 0; i < moive.numChildren; ++i)
			{
				var child:MovieClip = moive.getChildAt(i) as MovieClip;
				child && stop_moive(child);
			}
		}
		
		public function get type():uint
		{
			return vType;
		}
		
		public function get state():uint
		{
			return vState;
		}
		
		public function get url():String
		{
			return vUrlRequest.url;
		}
		
		public function get bytesLoaded():uint
		{
			if (vError)
				return 1;
			switch (vType)
			{
				case TYPE_TEXT: 
				case TYPE_BINARY: 
					return (vLoader as URLLoader).bytesLoaded;
				case TYPE_BITMAP: 
				case TYPE_MEDIA: 
				case TYPE_UNITE: 
					return (vLoader as Loader).contentLoaderInfo.bytesLoaded;
				case TYPE_SOUND: 
					return (vLoader as Sound).bytesLoaded;
			}
			return 1;
		}
		
		public function get bytesTotal():uint
		{
			if (vError)
				return 1;
			switch (vType)
			{
				case TYPE_TEXT: 
				case TYPE_BINARY: 
					return (vLoader as URLLoader).bytesTotal;
				case TYPE_BITMAP: 
				case TYPE_MEDIA: 
				case TYPE_UNITE: 
					return (vLoader as Loader).contentLoaderInfo.bytesTotal;
				case TYPE_SOUND: 
					return (vLoader as Sound).bytesTotal;
			}
			return 1;
		}
	}
}