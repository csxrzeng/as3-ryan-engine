package resource.proxy 
{
	import com.ryan.resource.info.ImageInfo;
	import com.ryan.resource.info.SWFInfo;
	import com.ryan.resource.LoaderManager;
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class SwfFileVo 
	{
		public var onComplete:Function;
		public var onError:Function;
		public var extData:Object;
		public var url:String;
		
		public function SwfFileVo(url:String = null) 
		{
			this.url = url;
		}
		
		public function start():void
		{
			LoaderManager.instance.load(url, onLoaded, 3, null, null, onFailed);
		}
		
		private function onLoaded(info:SWFInfo):void 
		{
			if (info && info.data)
			{
				Convertor.convert(info.data.bytes, onConverterComplete, onError);
			}
			else
			{
				dealError("加载的不是图片");
			}
		}
		
		private function onConverterComplete(display:DisplayObject):void 
		{
			if (display)
			{
				if (onComplete != null)
				{
					if (extData)
					{
						onComplete(display, extData);
					}
					else
					{
						onComplete(display);
					}
				}
			}
			else
			{
				dealError("加载失败");
			}
		}
		
		private function onFailed(info:ImageInfo):void 
		{
			dealError("加载失败");
		}
		
		private function dealError(text:String):void
		{
			if (onError != null)
			{
				onError(text);
			}
		}
	}
}