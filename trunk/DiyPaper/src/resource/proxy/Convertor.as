package resource.proxy 
{
	import flash.display.AVM1Movie;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.utils.ByteArray;
	/**
	 * 把二进制数据转成显示对象
	 * @author xr.zeng
	 */
	public class Convertor 
	{
		private var loader:Loader;
		private var onComplete:Function;
		private var onError:Function;
		public var display:DisplayObject;
		
		public function Convertor(bytes:ByteArray, onComplete:Function, onError:Function = null) 
		{
			this.onComplete = onComplete;
			this.onError = onError;
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			try
			{
				loader.loadBytes(bytes);
			}
			catch (e:Error)
			{
				dealError(e.message);
			}
		}
		
		static public function convert(bytes:ByteArray, onComplete:Function, onError:Function = null):Convertor
		{
			return new Convertor(bytes, onComplete, onError);
		}
		
		private function completHandler(e:Event):void 
		{
			clearEvents();
			display = loader.content is AVM1Movie ? loader : loader.content; // 兼容as2
			if (onComplete != null)
			{
				onComplete(display);
			}
		}
		
		private function errorHandler(e:IOErrorEvent):void 
		{
			dealError("文件已损坏");
		}
		
		private function dealError(text:String):void
		{
			clearEvents();
			if (onError != null)
			{
				onError(text);
			}
		}
		
		private function clearEvents():void
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completHandler);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		}
	}

}